# Rental Studio 2.0 | Fleet source-specific photo attribution and native visual repair

**6 November 2026. Exact verified executable:** [`db005e21e426a19932ff1afc708b7ba2c0239b46`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/db005e21e426a19932ff1afc708b7ba2c0239b46), [completed successful GitHub Actions #42199989157](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42199989157). **Branch:** `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked on P6. No merge, protected main unchanged.

## Work performed

The real Qt Quick Fleet Gallery/Inspector previously labelled model-reference images generically, while original author, source and licence information lived only in the repository. Six pre-existing source manifests (five catalogue batches and the portfolio manifest) are now embedded as offline Qt resources. The existing C++ FleetPhotoStore resolves attribution against the **actual photo resource chosen** for a selected live fictional vehicle, not a guessed or stale vehicle ID. It provides creator, licence and original Wikimedia Commons link. The three original demo CC0 photographs reuse authors and links already documented in `assets/README.md`. The selected Fleet Inspector shows a concise credit; its existing read-only full-photo dialog shows author/licence and original source. A generated fictional custom replacement explicitly reports unverified rights and does not inherit the previous licence; silhouette fallbacks carry no fake photo attribution.

No image acquisition, data import, photo mapping change, rental pricing, lifecycle controller or storage modification occurred. Repo metadata was independently checked: **48/48 active catalogue image mappings** matched existing creator/licence/source manifest records, and **11/11 portfolio photo mappings** matched existing manifest entries. This is internal provenance consistency, not final owner visual or legal approval of media.

## Initial green tests exposed a visual failure

The first implementation, [source `b3625f5`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/b3625f5704e00711d011da1fcd2f3ddf9b3c83bf), passed [CI #42198599734](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42198599734), **140/140 native CTests each** on Linux GCC and Windows MSVC, packaged Windows **8/8** and PS5.1 PASS. But genuine **1280×720 Linux and Windows screenshots** revealed that the added author/licence badge covered the existing top-left Reference image badge. This is a **visual defect despite CI success**, not a failed CTest. It was not concealed or accepted.

The corrective [source `db005e2`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/db005e21e426a19932ff1afc708b7ba2c0239b46) moves the attribution above the existing **View full** action, clear of the Reference badge, without adding a new screen or layout row. The actual Qt Fleet photo wide/compact tests were strengthened to assert that both badge/action rectangles are separate, the credit is visible and it remains contained inside the selected image stage. No test was removed or weakened.

## Verified exact-source evidence

| Test | Linux GCC Qt 6.8.3 | Hosted Windows MSVC Qt 6.8.3 |
|---|---|---|
| Complete native Qt CTests | **140/140 PASS** | **140/140 PASS** |
| `rental_studio_fleet_photo_wide/compact` (#41/#42) | **PASS** | **PASS** |
| `rental_studio_portfolio_catalog_wide/compact` (#24/#25) | **PASS** | **PASS** |
| Windows packaged fictional lifecycle | Not applicable | **8/8 PASS** |
| Packaged PowerShell 5.1 verification | Not applicable | **PASS** |

Real application screenshot archives: [Linux #13492809629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42199989157/artifacts/13492809629), [Windows #13494905785](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42199989157/artifacts/13494905785). **Actual compiled 1500×860 and 1280×720** Fleet Inspector/gallery screenshots inspected on both platforms. Corrected badge, author/licence, View full, image, selected model identity, booking and remove controls are present and separated. The full-photo modal shows a proper Commons source, author/licence and honest non-actual-unit disclosure. Synthetic custom-photo test captures are intentionally fictional and unlicensed for commercial use.

## Remaining restrictions and next action

Hosted CI does **not** sign off the owner's physical Windows Qt Creator 6.10.2 MinGW, 100/125/150% DPI scaling, keyboard/Narrator, final image suitability, or owner-selected Editorial Automotive Light visual acceptance. P7 SQLite Lab is experimental opt-in generated-fictional-only. **P5/P6 previous owner acceptance is preserved; formal 45/74 criteria, frozen-weight 70.6%, P7 0/8 remain unchanged.** No merge, release, real customer data or production SQLite permission.

**Next authorized action:** owner GitHub Desktop pull on the existing P7 branch, physical Qt Creator Build/Run and three-workspace Overview/Fleet/Rentals review, including photo credits, Full View and actual keyboard/scale/Narrator observations. Record specific issues before any further scoped fixes or acceptance changes.

See [live handoff](LIVE_HANDOFF_STATE.md), [latest checkpoint](LATEST_CHECKPOINT.md), [native testing](TESTING.md), [roadmap](ROADMAP.md) and [Direction A selection contract](../design/r1/DIRECTION_A_EDITORIAL_LIGHT_SELECTION_AND_IMPLEMENTATION_CONTRACT_2026-11-05.md).
