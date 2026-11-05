# Catalogue photo acquisition | Batch 03

**Objective:** address the nine original Fleet models still assigned unrelated photos, and add the Porsche 911 showcase candidate. Source names are pinned to individual Wikimedia Commons file titles in `sources.json`.

**Before workflow:** these are research candidates, not already downloaded/accepted files. The workflow uses the approved official Commons imageinfo API to validate photo URLs, original creator and individual CC0 / CC BY / CC BY-SA metadata. It downloads each eligible original-file thumbnail, pads/resizes without stretching, records exact SHA256s, generates a contact sheet, and commits accepted files in this isolated folder.

**After workflow:** downloaded and licence-confirmed ≠ visually owner-approved. Check [PREVIEW.md](PREVIEW.md) before integrating any photos. A failure to source one model must be reported explicitly rather than filled with an unrelated car image.

**No application code, compiled image mapping, protected five-vehicle fixture, P7 production storage, paid API or stable main modification.** Project scope is the free offline portfolio.
