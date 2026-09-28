# Aquarius Image Converter

Static bitmap conversion for the original Mattel Aquarius. AQGraph, BMPAQ and the V1–V4.1 iterations belong to this project. The later flicker converter is separate.

## Working copy

This is the new master repository. BMP2AQV41.bas and customchar.txt were copied from the existing V4.1 folder without changes. The source also matches the BASIC file in the preserved BMPAQV41.zip package. This import is dated September 28, 2026; it does not reconstruct a historical Git commit timeline.

- BMP2AQV41.bas: active FreeBASIC source.
- customchar.txt: original custom character list.
- history/: recovered BASIC source grouped by original location or package. Identical files retain their provenance.
- samples/: selected Bugs and Ariel input bitmaps.
- docs/: recovery, release and attribution notes.
- bin/: local preserved V4.1 executable, ignored by Git.

## Run the preserved Windows converter

Open run_converter.cmd in this local checkout. It starts the preserved executable from bin with this repository as its working directory. Choose a 320×192 BMP, choose dithering and a character set, and wait for the completion message. Output is an .AQ BASIC listing next to the selected input file, so use the samples here or a working copy rather than an original archive image.

The V4.1 interface offers Full Set, 80×72 Blocks, Graphics Characters and Custom Character Set. A September 28, 2026 screenshot shows a completed Bugs conversion. This is evidence of a run of the preserved binary, not proof that this source has been rebuilt or that all output options have been tested on hardware.

## Building

The source uses FreeBASIC, windows.bi and fbgfx.bi. The exact original compiler version and dialect/options have not yet been verified. No new build command or executable is presented as validated. The historical executable is preserved locally so toolchain restoration can proceed without replacing it.

## History and releases

The original announcement is [Aquarius Bitmap Graphics Tool on AtariAge](https://forums.atariage.com/topic/173033-aquarius-bitmap-graphics-tool/#comment-2145562). The start remains approximately November 2010. V4.1 is the latest identified local release candidate, with a January 23, 2011 package timestamp; that alone is not a verified publication date.

Read docs/RELEASE-RECOVERY.md before constructing historical GitHub releases. No GitHub remote or historical release has been created for this repository.

## Credits and archive

The original announcement credits a GW-BASIC bitmap reader linked through VOGONS. Exact source attribution and redistribution terms remain to be established; no new license is asserted by this import. Third-party utilities and unreviewed test media are kept outside this repository.

Complete copies of both discovered source collections, original packages, private review material and manifests are in the sibling Legacy, Releases, Misc and Notes folders. All original folders remain untouched.
