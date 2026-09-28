# v4.1.1 — Stable modern compiler compatible version

Released September 28, 2026. This is a new compatibility snapshot of the active V4.1 source, distinct from the historical `archive-v4.1` package.

## What is locked down

The exact BASIC source confirmed working by the owner is preserved without further conversion-algorithm changes during release preparation. It selects the FreeBASIC `deprecated` dialect, uses a `start_program` subroutine and explicit shared declarations, and includes the current dithering and custom-character choices. Build and launch scripts identify the exact source and executable paths.

The release tag is `v4.1.1`. Future code fixes should receive a new version rather than replace this tag. On September 28, 2026, the owner requested a packaging refresh to add four test images to the existing v4.1.1 ZIP. Its BASIC source, executable and release tag remain unchanged; the ZIP and its checksums have been refreshed. Historical source snapshots, tags and original ZIPs are unchanged.

## Verified configuration

- Windows, 32-bit executable built with FreeBASIC 1.10.0 (2023-05-14), as bundled with WinFBE.
- Command: `fbc32.exe BMP2AQV41.bas -s gui -x build\BMP2AQV41.exe`.
- Successful compilation, desktop launch and visible BMP file picker; the owner confirmed the working source.
- Warning 47 for the legacy `cs` symbol remains. It does not prevent this build from linking.
- Other FreeBASIC versions and 64-bit compilation are not covered by this verification.

## Download and run

Download `Aquarius-Image-Converter-v4.1.1-win32.zip` from the GitHub release, extract all files into a writable folder, and run `run.cmd`. No compiler is required to run the packaged executable. Keep `customchar.txt` in the same folder. Use a working copy of a 320×192 BMP in a writable location; the `.AQ` output is written alongside the input.

The ZIP includes the freshly compiled executable, the exact source, `customchar.txt`, build scripts, these notes, acknowledgements in the README, `BUILD-INFO.txt`, `SHA256SUMS.txt`, and four 320×192 test BMPs in `samples/`: `ariel.bmp`, `bart.bmp`, `sqtitle.bmp` (Space Quest), and `sonic3.bmp`. Ariel was specifically requested; the other three were randomly selected from suitable images in the owner's test collection. The samples retain their original bytes. No compiler distribution or historical executable is bundled. A separate SHA-256 file identifies the refreshed ZIP itself.

After extracting the ZIP, select a BMP from its `samples` folder in the converter's file picker. These are input examples, not claims that generated output has passed a regression test.

To rebuild, run `build_converter.cmd` with the path to a compatible `fbc32.exe` if the default local WinFBE installation is absent. Close a running rebuilt converter before compiling to the same output path. `run_rebuilt_converter.cmd` builds and then launches the new executable.

## Scope and inherited limitations

“Stable” identifies the owner-selected working compiler compatibility baseline. It does not certify every conversion mode or generated Aquarius BASIC listing. No complete emulator or real-hardware regression test was performed for this release.

Legacy input-error handling, pixel-array bounds and generated DATA-line formatting still need review. These behaviors are retained in this frozen source rather than silently changed while packaging it. Use working copies of input files; generated output may replace an existing listing of the same name.

The original project announcement credits a GW-BASIC bitmap reader linked through VOGONS. Detailed historical attribution and redistribution terms remain under review; this release does not introduce a new license or claim new hardware validation.
