# Historical release recovery

Import/recovery date: September 28, 2026. GitHub releases are archival republications of the owner-approved original ZIPs. No Git commits or publication timestamps are backdated.

| Collection | Preserved package/source evidence | State |
| --- | --- | --- |
| AQGraph | AQGraph.zip contains AQGraph/RESOURCE/AQBMP.BAS and examples | Original November 27, 2010 announcement; exact package correspondence still under review |
| BMPAQ / V1 | BMPAQV1.zip and BMPAQ/BMP2AQV1.zip | Same V1 source and binary hashes in differently arranged packages |
| V2 | BMPAQV2.zip has binary and README; local BMPAQ2/OldV has V2 source | Source-to-binary match not yet established |
| V3 | BMPAQV3.zip has binary and README; BMPAQ2/BMP2AQV3.zip contains source | Both packages recovered; build correspondence not yet verified |
| V4 | BMPAQV4/BMPAQV4.zip contains V4 and V4.1 binaries and source | Both source names have identical bytes, while the binaries differ |
| V4.1 | BMPAQV4/BMPAQV41.zip contains source, binary and custom character list | Active source exactly matches this package; latest identified local candidate |

Historical BASIC files extracted from ZIPs are under history/packages. The eight original ZIPs are attached unchanged to six public archival releases. Local preservation copies remain in ../Releases/Original-Packages (relative to the repository root). The entry-by-entry catalog in ../Notes/release-catalog.json remains private because it contains local paths.

Before a GitHub release: establish the correct source and binary pair, retain acknowledgements, review the contents of the original ZIP, choose appropriate downloadable files, and verify any claimed historical release date against the original announcement. Release creation happens now; notes can separately identify an evidence-supported original date. Do not infer a release from a folder name or silently count duplicate source copies as new versions. Do not attach whole legacy folders or unreviewed original packages automatically.

## Public archive tags

The tags archive-aqgraph, archive-v1, archive-v2, archive-v3, archive-v4 and archive-v4.1 mark the present-day recovered source collection. They do not pretend to be original historical development commits. GitHub-generated Source code archives contain that recovered collection, not a version-specific historical tree. Use the explicitly attached original ZIPs for the corresponding historical release. No fresh compilation or complete hardware regression is claimed.
