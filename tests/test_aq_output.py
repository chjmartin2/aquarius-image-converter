"""Compile the production DATA writer and decode its output independently.

Run: python tests/test_aq_output.py [path-to-fbc32.exe]
"""
from pathlib import Path
import random
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
COMPILER = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(
    r"C:\WinFBE_Suite\toolchains\FreeBASIC-1.10.0-winlibs-gcc-9.3.0\fbc32.exe"
)
WORK = ROOT / "build" / "test-aq-output"
WORK.mkdir(parents=True, exist_ok=True)


def decode_listing(path):
    planes, values, numbers = [], [], []
    for line in path.read_text().splitlines():
        match = re.fullmatch(r"(\d+) DATA (\d+(?:,\d+)*)", line)
        assert match, f"Unnumbered or malformed DATA line: {line!r}"
        assert len(line) < 80, f"Unexpectedly long BASIC line: {line!r}"
        numbers.append(int(match[1]))
        data = [int(token) for token in match[2].split(",")]
        assert len(data) % 2 == 0
        for value, count in zip(data[::2], data[1::2]):
            if value == 999:
                assert count == 999
                assert len(values) == 960, f"Plane contains {len(values)} cells"
                planes.append(values)
                values = []
            else:
                assert 0 <= value <= (255 if not planes else 15)
                assert 1 <= count <= 960
                values.extend([value] * count)
    assert numbers == list(range(30, 30 + len(numbers))), "Repeated/skipped line number"
    assert len(planes) == 3 and not values, "Missing plane or terminator"
    return planes


harness = '''#lang "deprecated"
#include once "../../aq_output.bi"
dim chars(1 to 960) as integer, foreground(1 to 960) as integer, background(1 to 960) as integer
dim idx as integer, next_line as integer = 30
open "fixture.txt" for input as #1
for idx = 1 to 960
    input #1, chars(idx), foreground(idx), background(idx)
next idx
close #1
open "result.AQ" for output as #2
write_aq_data(2, chars(), next_line, 9)
write_aq_data(2, foreground(), next_line, 10)
write_aq_data(2, background(), next_line, 10)
close #2
'''
(WORK / "writer.bas").write_text(harness)
subprocess.run([str(COMPILER), "writer.bas", "-exx", "-x", "writer.exe"], cwd=WORK, check=True)

rng = random.Random(411)
cases = {
    "one run per plane": [[255] * 960, [15] * 960, [0] * 960],
    "every final value differs": [[i % 256 for i in range(960)],
                                  [i % 16 for i in range(960)],
                                  [15 - i % 16 for i in range(960)]],
    "single different last cell": [[127] * 959 + [253], [3] * 959 + [7], [8] * 959 + [1]],
    "sentinels at full-line boundaries": [[min(i // 96, 8) for i in range(960)],
                                         [i // 96 for i in range(960)],
                                         [i // 96 for i in range(960)]],
    "mixed image data": [[rng.randrange(256) for _ in range(960)],
                         [rng.randrange(16) for _ in range(960)],
                         [rng.randrange(16) for _ in range(960)]],
}
for name, expected in cases.items():
    (WORK / "fixture.txt").write_text("".join(
        f"{a},{b},{c}\n" for a, b, c in zip(*expected)
    ))
    subprocess.run([str(WORK / "writer.exe")], cwd=WORK, check=True, timeout=10)
    assert decode_listing(WORK / "result.AQ") == expected, name
    print(f"PASS: {name}")
print("All 5 DATA-writer regressions passed (2,880 decoded cells each).")
