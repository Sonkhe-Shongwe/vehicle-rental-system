# Rental Studio 2.0 | Free vehicle-photo acquisition index

**Research checkpoint: 5 November 2026.** **Portfolio-only R0 offline images.** Actual vehicle model target: **at least 60, stretch 70**. Research shortlist: 70 make/model entries comprising 39 existing and 31 proposed. The app still contains the original 100 fictional inventory records and 39 distinct models.

## Acquisition progress

| Measurement | Current state |
|---|---:|
| Free model-specific photographs downloaded into separate staging | **30** |
| Unique downloaded photographs / image file hashes | **30 / 30** |
| Existing incorrect vehicle photo assignments with acquired replacement candidates | **25 / 25** |
| Existing wrong-photo models still lacking sourced candidate | **0** |
| New proposed showcase models with staged photo candidates | **5 / 31** |
| Proposed showcase models without acquired candidate | **26** |
| Staged photos visually approved by the owner | **0** |
| New model-specific photos integrated into Qt Fleet gallery | **0** |

Acquired photos are **candidates**, not approved image assignments. The 25 existing model-photo mismatches are **NOT FIXED YET IN THE APP**. Do not conflate sourcing with visually verifying actual make/model, composition or the mapping implementation.

## Review all three contact sheets

| Batch | Model coverage | Licence-verified acquired images | Visual review |
|---|---|---:|---|
| [01](batch01/PREVIEW.md) | Creta, Polo, Jolion, Navara, D-Max, CX-5, CBR500R, Ninja 400, G-Class, Golf GTI | 10/10 | Open |
| [02](batch02/PREVIEW.md) | Jimny, Tiggo 4, Wrangler, Caddy, Almera, Starlet, C-Class, EcoSport, BMW M4, Audi RS6 Avant | 10/10 | Open |
| [03](batch03/PREVIEW.md) | Renault Kiger, Mazda3, Grand i10, Magnite, Urban Cruiser, T-Cross, V-Strom 650, G 310 R, Tenere 700, Porsche 911 | 10/10 | Open |

**Evidence:** [Batch 01 workflow](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42007433964), [Batch 02 workflow](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42010192161), [Batch 03 workflow](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42011389574), all completed successfully. [Batch 01 manifest](batch01/source_manifest.json), [Batch 02 manifest](batch02/source_manifest.json), [Batch 03 manifest](batch03/source_manifest.json) record source photo, photographer, licence, adaptation notice and SHA256 per acquired file.

These **30 newly acquired image files** are additional research assets; the previously embedded **12 Commons CC0 plus 3 earlier demonstration photos** are separate and already remain in the app, with 3 earlier images' reuse permissions still subject to audit.

## Next steps

1. **Review the 30 acquired images visually** for corresponding make/model identity and acceptable crop/quality. Reject bad photos before mapping.
2. Fix the **25 existing inaccurate assignments** in a separate Qt resource/map implementation, only after image review and native tests. Multiple fictional units of exactly the same model may reuse the same suitable photo.
3. Continue acquiring images for **26 proposed new models**, with selection guided by free licensed sources and quality, not an arbitrary number.
4. After gallery mapping work, run real Linux GCC and hosted Windows MSVC Qt tests, then owner Qt Creator / actual gallery review.

No paid APIs, runtime photo downloads, commercial rollout, live operational data, SQLite production cutover, installer or main-branch modifications. Owner acceptance remains 45/74, weighted 70.6%, P7 0/8.
