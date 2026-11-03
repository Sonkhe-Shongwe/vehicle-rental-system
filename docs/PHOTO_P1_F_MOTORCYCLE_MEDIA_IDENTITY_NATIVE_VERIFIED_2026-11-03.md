# PHOTO-P1-F | Model-specific text on neutral motorcycle fallback, native verified

**3 November 2026, South Africa. Engineering result: VERIFIED. Photo rights/art approval: OPEN.**

**Exact executable source:** [`d2d494f6b1337b9bb17e24eabf189e506ffc324d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/d2d494f6b1337b9bb17e24eabf189e506ffc324d), development branch `feature/p7-sqlite-sandbox-20261102`, draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), stacked onto P6 development branch, not `main`. **Native GitHub Actions:** [run 41649565389](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41649565389) **SUCCESS**.

## Defect and bounded correction

Before this change, fictional **M001 Honda CB500F** and **M002 Yamaha MT-07** both displayed the exact same original make-neutral motorcycle silhouette. Their Gallery names below the image differentiated the records, but the image stages themselves appeared identical. With no authorised model-accurate photos, drawing different imaginary brand-specific shapes would risk misleading the operator.

The real Qt Quick `Main.qml` Gallery and selected Inspector now show each actual **C++ model name** within its fallback image stage. The vector is nudged upward slightly to make room for the clear bottom pill. The new label is present **only** when the motorcycle is represented by an illustration; it is not shown over a successfully decoded photo. Labels bind to `vehicleCard.displayName` and `fleet.selectedName`, not recycled ID aliases or duplicated hardcoded mappings, and have accessible descriptions explaining that the drawing itself is generic.

The existing **Illustration** or **Reference image** status, camera/photo permission boundary, generated-fictional fixtures, Qt keyboard actions, compact Book/Remove controls, C++ authority, persistence/rollback and `assets/` files remain unchanged. Neither motorcycle receives a new model-specific drawing or stock photo.

## Independent exact-source native verification

| Environment | Verifiable result |
|---|---|
| Linux Ubuntu 24.04 GCC + Qt 6.8.3 | **117/117 CTests PASS**, 0 failed; `rental_studio_fleet_photo_wide` and `_compact` pass |
| Hosted Windows Server 2022 MSVC + Qt 6.8.3 | **117/117 CTests PASS**, 0 failed; same two genuine QML tests pass |
| Hosted Windows portable acceptance preflight | Windows PowerShell 7 and Windows PowerShell 5.1 **PASS** |
| Exact source check | Both Linux and Windows job logs fetch SHA `d2d494f6b1337b9bb17e24eabf189e506ffc324d`; CI run 41649565389 completed SUCCESS |
| Source screenshots | [Linux screenshot artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41649565389/artifacts/13236248960) and [Windows screenshot artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41649565389/artifacts/13237057813) uploaded |
| Independent visual inspection | Opened real Qt Linux **Honda compact**, **Yamaha compact** and **Yamaha wide** screens, plus Windows **Honda compact** and **Yamaha wide** screens; labels distinguish models and fit within the image stage. No Book/action/button clipping found in these viewed frames. This is not an exhaustive pixel review of every screenshot. |

The existing five-model photographic smoke now checks that Gallery and Inspector fallback-model labels display the current selected C++ name for **both** motorcycles, remain onscreen, and are absent for all **three** existing photo-backed cars; all prior image-rejection, replacement/reset, stale selection, screenshot and negative domain cases remain in the full 117-test suite.

## Formal outcome and next dependency

This is a **temporary readability improvement**, not the owner-requested five-model 10/10 photography. Existing Hyundai i20 imagery still contains competing adjacent vehicles, Ford Ranger has a busy showroom and Corolla a distracting/dark exterior. The two motorcycles still share original generic art. No legally approved photo set was installed and Wikimedia HTTP 429/400 acquisition is not retried.

The independently verified [PHOTO-P1-E offline preflight](PHOTO_P1_E_OFFLINE_CANDIDATE_PREFLIGHT_VERIFIED_2026-11-03.md) (12/12 synthetic Python tests each hosted OS) remains available for lawfully obtained source images and exact photo-hash/crop review. **Next:** obtain a rights-documented, correctly identified regular Hyundai i20 original, run the offline preflight, compare actual Qt source/crop, and request owner visual approval before integrating any final photos; then extend to the other four models.

**Acceptance**: P5 8/8 and P6 9/9 owner-approved fictional functionality remain intact. Overall **45/74 formally accepted; weighted 70.6%, unchanged**. P1 lawful final photography/owner visual acceptance, physical owner Windows Qt Creator/MinGW/OS scaling/Narrator P2/P4, P7 D2-D8 customer data policies, P8/P9 installer/release and PR merge are still OPEN. No customer records, release or `main` changed.
