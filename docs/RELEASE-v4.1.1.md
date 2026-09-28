# v4.1.1 - Stable modern compiler compatible version

Released and updated September 28, 2026. The owner confirmed the corrected generated BASIC program runs successfully in Virtual Aquarius.

**Download the ZIP again if you obtained v4.1.1 before this DATA-output correction.** The updated package is revision 3 in `BUILD-INFO.txt`. At the owner's explicit request, this fix updates the existing v4.1.1 release and tag rather than creating a new version.

## Corrected BASIC output

The earlier build ended DATA lines after individual value/count pairs, leaving most of the data on unnumbered lines that Aquarius BASIC could not load correctly. The writer now assembles each complete numbered DATA statement before writing its newline.

The same fix keeps line numbers increasing across the character and color sections, handles the final run without reusing a previous value, and writes each section's `999,999` terminator on a numbered DATA line. The character-matching and dithering algorithms are unchanged.

## Verification

- Fresh Windows executable built with FreeBASIC 1.10.0 (2023-05-14), Win32, using `-s gui` and the source's `deprecated` dialect.
- Five automated regression cases compile the production writer with runtime checks, then independently decode its output and compare all 2,880 screen-data cells. Cases cover constant data, changing values, a different final cell, full-line boundaries and mixed data.
- An Ariel conversion with Full Set and no dithering produces 127 numbered BASIC lines. Its character, foreground and background sections each decode to exactly 960 cells.
- The owner ran the corrected output in Virtual Aquarius and reported that it worked perfectly on September 28, 2026.
- The existing compiler warning 47 for the legacy `cs` symbol remains; it does not prevent linking.

## Download and run

Download `Aquarius-Image-Converter-v4.1.1-win32.zip`, extract all files into a writable folder, and run `run.cmd`. No compiler is required to run the executable. Keep `customchar.txt` beside it. Select a 320x192 BMP; its `.AQ` output is written beside the input and may replace an existing listing of the same name.

The ZIP includes the corrected executable, matching `BMP2AQV41.bas` and `aq_output.bi`, `customchar.txt`, build scripts, regression tests, documentation, `BUILD-INFO.txt`, and `SHA256SUMS.txt`. A separate SHA-256 file identifies the ZIP itself.

Four original 320x192 test BMPs are included in `samples/`: `ariel.bmp`, `bart.bmp`, `sqtitle.bmp` (Space Quest), and `sonic3.bmp`. Ariel was specifically requested; the other three were randomly selected from suitable images in the owner's test collection. No compiler distribution or historical executable is bundled.

To rebuild, keep `aq_output.bi` beside the main source and run `build_converter.cmd`, supplying the path to a compatible `fbc32.exe` if necessary. Close any converter running from the build output path first. `run_rebuilt_converter.cmd` rebuilds and launches the program. With Python installed, `python tests/test_aq_output.py` runs the DATA-writer regressions; an optional compiler path is accepted.

## Release history and remaining scope

The same v4.1.1 release was first published as a modern compiler compatibility snapshot, then refreshed to add four sample images. This third package revision replaces the faulty output writer with the emulator-confirmed fix. Its source tag now points to the corrected commit, and `BUILD-INFO.txt` records the matching commit and file hashes. Historical `archive-*` tags and original release ZIPs remain unchanged.

The emulator result confirms the owner's tested output. It is not a claim that every conversion mode has had a complete regression pass or that a new physical Aquarius test has been performed. Other compiler versions, 64-bit builds, legacy input-error handling and pixel-array bounds remain outside this fix.

The original project announcement credits a GW-BASIC bitmap reader linked through VOGONS. Detailed historical attribution and redistribution terms remain under review; this release does not introduce a new license.
