# Historical release recovery

Import/recovery date: September 28, 2026. No backdated Git commits or public releases have been made.

| Collection | Preserved package/source evidence | State |
| --- | --- | --- |
| AQGraph | AQGraph.zip contains AQGraph/RESOURCE/AQBMP.BAS and examples | Original November 27, 2010 announcement; exact package correspondence still under review |
| BMPAQ / V1 | BMPAQV1.zip and BMPAQ/BMP2AQV1.zip | Same V1 source and binary hashes in differently arranged packages |
| V2 | BMPAQV2.zip has binary and README; local BMPAQ2/OldV has V2 source | Source-to-binary match not yet established |
| V3 | BMPAQV3.zip has binary and README; BMPAQ2/BMP2AQV3.zip contains source | Both packages recovered; build correspondence not yet verified |
| V4 | BMPAQV4/BMPAQV4.zip contains V4 and V4.1 binaries and source | Both source names have identical bytes, while the binaries differ |
| V4.1 | BMPAQV4/BMPAQV41.zip contains source, binary and custom character list | Active source exactly matches this package; latest identified local candidate |

Historical BASIC files extracted from ZIPs are under history/packages. Full unmodified ZIPs remain private in ../Releases/Original-Packages (relative to the repository root), and a private entry-by-entry SHA-256 catalog is in ../Notes/release-catalog.json. It includes original paths; do not publish it unchanged.

Before a GitHub release: establish the correct source and binary pair, retain acknowledgements, review the contents of the original ZIP, choose appropriate downloadable files, and verify any claimed historical release date against the original announcement. Release creation happens now; notes can separately identify an evidence-supported original date. Do not infer a release from a folder name or silently count duplicate source copies as new versions. Do not attach whole legacy folders or unreviewed original packages automatically.
