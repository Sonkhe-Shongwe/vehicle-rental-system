# UX-Q6 | Truthful Gallery and Inspector media status, native verified

**Date:** 3 November 2026, Africa/Johannesburg. **Exact compiled source:** [`087c923fcde13f8a5515c22e53e7883a15b6d5b4`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/087c923fcde13f8a5515c22e53e7883a15b6d5b4) on development branch `feature/p7-sqlite-sandbox-20261102`; [draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) targeting the P6 development branch, not `main`. **Native CI:** [Actions run 41637857962](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962), completed **SUCCESS**.

## Defect / user impact

The real Fleet Gallery showed photos and neutral illustrations without an explicit visible provenance label. The selected Fleet Inspector displayed its "Illustrative" badge only when its Image was Ready; when a selected Honda/Yamaha had no authorised photo, or an invalid/corrupt image fell back, the neutral drawing had no adjacent media-status label. This could make the status of model reference imagery ambiguous to the operator. This was a presentation issue, not a change to media licensing or the C++ business domain.

## Implemented solution

- Added a compact, accessible `fleetGalleryMediaStatus` overlay to **each real Gallery vehicle card**; shows **Reference image** only when decoded media is actually displayed, otherwise **Illustration**. The UI does not use the existence of a file/path alone to claim an image is loaded.
- Updated the existing `fleetPhotoDisclaimer` Inspector overlay to be visible for selected fallback artwork as well as decoded media, with matching **Reference image / Illustration** status and truthful accessibility descriptions.
- Preserved protected generated-fictional data, unchanged photo-provider permissions, existing preview/replace/reset workflows, Qt compact geometry, C++ booking and return authority, atomic persistence and rollback safeguards. No media downloaded, approved or bundled by this change.

## Test evidence and limitations

| Job | Exact source, OS / toolchain | Actual result |
|---|---|---|
| Native Linux Qt | `087c923`, Ubuntu 24.04 / GCC / Qt 6.8.3 | **117/117 CTests PASS**, including `rental_studio_fleet_photo_wide` and `_compact` |
| Native hosted Windows Qt | same SHA, Windows Server 2022 / MSVC / Qt 6.8.3 | **117/117 CTests PASS**, including both photo tests |
| Windows portable package checks | same hosted Windows run, PowerShell 7 and Windows PowerShell 5.1 | **PASS**; scripts themselves state physical scaling/Narrator still NOT TESTED |
| Native screenshot artifacts | [Linux](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962/artifacts/13232086999) and [Windows](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962/artifacts/13232021763) | Real QML wide and compact screenshot artifacts uploaded; **not independently pixel-inspected in this session** |

The existing full photo smoke, not a weakened or replacement test, now checks seeded car media labels; selected motorcycle Inspector illustration and Gallery filter illustration; rejected oversized sidecar reverting to "Illustration"; and recovered valid sidecar returning to "Reference image". The original photo replacement/cancellation/stale selection/byte-equality/unsafe image regression coverage remains in the same suite.

This is **hosted native automation**, **not** physical Windows Qt Creator/MinGW, real OS 100/125/150% scaling or Microsoft Narrator acceptance. No new approved motorcycle photograph or five-vehicle photo set, owner visual acceptance, commercial data, installer, release, `main` modification or PR merge occurred.

## Formal status and next priority

P5 8/8 and P6 9/9 remain owner accepted, but this narrow UX improvement does **not** satisfy remaining P1 photography/visual/physical accessibility criteria or the P7–P9 commercial/release gates. **Formal total 45/74 criteria, weighted 70.6%, unchanged** (not product completeness or launch readiness).

Next: continue compliant five-model image sourcing/crop/owner visual approval without automatically repeating [Wikimedia HTTP 429 image downloads](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379). Consolidated physical Windows keyboard/scale/Narrator tests and P7 real-data policy remain independent gates.
