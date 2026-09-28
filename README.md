# Aquarius Image Converter

Static bitmap conversion for the original Mattel Aquarius. AQGraph, BMPAQ and the V1–V4.1 iterations belong to this project. The later flicker converter is separate.

## Stable modern compiler compatible version — v4.1.1

[Download the Windows ZIP](https://github.com/chjmartin2/aquarius-image-converter/releases/download/v4.1.1/Aquarius-Image-Converter-v4.1.1-win32.zip) or read the [release notes](docs/RELEASE-v4.1.1.md). This September 28, 2026 release contains the corrected BASIC DATA writer and a fresh 32-bit Windows build using FreeBASIC 1.10.0. The owner confirmed the corrected output runs successfully in Virtual Aquarius. At the owner's request, the existing `v4.1.1` release and tag were updated in place to include this fix; historical release tags and packages are unchanged.

If you downloaded v4.1.1 before the DATA-line fix, download the ZIP again. The corrected package is revision 3 in `BUILD-INFO.txt`; it includes four 320×192 BMP inputs in `samples/`: Ariel, Bart, Space Quest and Sonic.

Extract the whole ZIP into a writable folder and run `run.cmd`. Keep `customchar.txt` beside the executable. Select a 320×192 BMP from a writable working folder; the converter writes its `.AQ` listing beside that input. Close the converter before rebuilding, since Windows locks a running executable.

Compiler compatibility, Windows operation and the owner's Virtual Aquarius output test are verified. Five automated DATA-writer regression cases also pass. A complete conversion-mode matrix and a fresh physical Aquarius test remain outside this validation; see the release notes for details.

## Working copy

This is the master repository. BMP2AQV41.bas and customchar.txt were originally imported unchanged from the existing V4.1 folder on September 28, 2026. The active BASIC source now contains the modern compiler compatibility changes. The initial import and historical snapshots preserve the recovered source; this does not reconstruct a historical Git commit timeline.

- BMP2AQV41.bas: active FreeBASIC source.
- aq_output.bi: numbered BASIC DATA output writer; keep beside the main source when rebuilding.
- customchar.txt: original custom character list.
- history/: recovered BASIC source grouped by original location or package. Identical files retain their provenance.
- samples/: selected Bugs and Ariel input bitmaps.
- docs/: recovery, release and attribution notes.
- bin/: local preserved V4.1 executable, ignored by Git.

## Run the preserved Windows converter

For an original downloadable program, use an attached ZIP from the [releases page](https://github.com/chjmartin2/aquarius-image-converter/releases), rather than GitHub’s automatically generated source archives. V4.1 includes BMP2AQV41.exe and customchar.txt. Extract the ZIP into a working folder and run its executable.

In the owner’s local master checkout, open run_converter.cmd. It starts the preserved executable from bin with this repository as its working directory. Choose a 320×192 BMP, choose dithering and a character set, and wait for the completion message. Output is an .AQ BASIC listing next to the selected input file, so use the samples here or a working copy rather than an original archive image.

The V4.1 interface offers Full Set, 80×72 Blocks, Graphics Characters and Custom Character Set. A September 28, 2026 screenshot shows a completed Bugs conversion. This is evidence of a run of the preserved binary, not proof that this source has been rebuilt or that all output options have been tested on hardware.

## Building

The corrected v4.1.1 source builds with WinFBE's bundled FreeBASIC 1.10.0 32-bit compiler and `-s gui`. The owner confirmed its generated output in Virtual Aquarius on September 28, 2026. The exact historical compiler version remains unknown.

Run `build_converter.cmd` to compile the active `BMP2AQV41.bas` into `build\BMP2AQV41.exe`. The script prints the exact compiler, source and output paths. It defaults to the local compiler at `C:\WinFBE_Suite\toolchains\FreeBASIC-1.10.0-winlibs-gcc-9.3.0\fbc32.exe`; pass a different compiler path as its first argument if needed.

Run `run_rebuilt_converter.cmd` to rebuild and launch that executable only if compilation succeeds. `run_converter.cmd` still launches the preserved historical executable in `bin`, not the rebuilt program. The historical binary is not replaced.

The equivalent compiler invocation is `fbc32.exe BMP2AQV41.bas -s gui -x build\BMP2AQV41.exe` (create `build` first). The source selects the `deprecated` dialect. The tested compiler emits warning 47 for the legacy `cs` name but links successfully. Other compiler versions and 64-bit builds are not validated by this release.

Run `python tests/test_aq_output.py` to compile the production DATA writer with runtime checks and verify five round-trip cases. An optional first argument selects another `fbc32.exe` path. Tests check line numbering, line endings, end-of-section markers and exact reconstruction of all 960 cells in each of the three screen-data sections.

## History and releases

The original announcement is [Aquarius Bitmap Graphics Tool on AtariAge](https://forums.atariage.com/topic/173033-aquarius-bitmap-graphics-tool/#comment-2145562). The start remains approximately November 2010. V4.1 is the latest identified local release candidate, with a January 23, 2011 package timestamp; that alone is not a verified publication date.

Read docs/RELEASE-RECOVERY.md before constructing historical GitHub releases. The public repository is [chjmartin2/aquarius-image-converter](https://github.com/chjmartin2/aquarius-image-converter). The [archival releases](https://github.com/chjmartin2/aquarius-image-converter/releases) preserve the original ZIP downloads, with V4.1 selected as the latest historical package.

## Credits and archive

The original announcement credits a GW-BASIC bitmap reader linked through VOGONS. Exact source attribution and redistribution terms remain to be established; no new license is asserted by this import. Third-party utilities and unreviewed test media are kept outside this repository.

Complete copies of both discovered source collections, original packages, private review material and manifests are in the sibling Legacy, Releases, Misc and Notes folders. All original folders remain untouched.
