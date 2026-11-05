# Rental Studio: free vehicle-photo acquisition overview

**Last updated:** 5 November 2026. **Project:** R0 offline C++/Qt Quick portfolio. **Catalogue target:** at least 60, preferably 70 distinct models. **Current catalogue list:** 39 existing + 31 proposed, **not yet changed inside the app**.

## Progress

| Measure | Verified status |
|---|---|
| Newly downloaded, licence-checked model-photo candidates | **20/20** across first two batches |
| Free individual source images with unique SHA256s | **20** (10 + 10; no identical hashes) |
| Existing wrong-image model assignments now covered by sourced candidates | **16 of 25** |
| Existing wrong-image model assignments needing research | **9** |
| New showcase model candidates with acquired photos | **4 of 31** |
| New showcase models still needing a photo | **27** |
| New photos visually approved by owner | **0** |
| New photos integrated into the Fleet photo map | **0** |
| Model-image approval target | **60 minimum / 70 stretch** |

These acquisition totals are separate from the **12 previously embedded Commons CC0 assets plus 3 legacy demonstration photos**. Do not double-count old files as newly obtained model-photo approvals.

## Actual acquired galleries

| Batch | Models | Verified files | Contact sheet | Sources |
|---|---|---:|---|---|
| 01 | Creta, Polo, Jolion, Navara, D-Max, CX-5, CBR500R, Ninja 400, G-Class, Golf GTI | 10/10 | [Batch 01](batch01/PREVIEW.md) | [Source metadata](batch01/source_manifest.json) |
| 02 | Jimny, Tiggo 4, Wrangler, Caddy, Almera, Starlet, C-Class, EcoSport, M4, RS6 Avant | 10/10 | [Batch 02](batch02/PREVIEW.md) | [Source metadata](batch02/source_manifest.json) |

**Download evidence:** [Batch 01 Actions #42007433964](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42007433964), [Batch 02 Actions #42010192161](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42010192161), both SUCCESS. Contact sheets were rendered from the acquired local files using SHA256 checks.

## The review and integration boundary

Acquisition confirms a real file and machine-readable free-use licence, not beautiful photography or perfect model matching. Each batch needs human visual review for brand/model identity, clipping, angle and background. **No photo is accepted by the app until the staging list is reviewed and an independent Qt resource mapping change is tested.** Preserve the old five-vehicle test fixture and never insert an unrelated make/model stock photo just to fill an image card.

**No production data, payments, paid API, automatic image downloads in the application, or protected main branch changes.** Formal score remains 45/74, weighted 70.6%; P7 D2-D8 still unapproved.
