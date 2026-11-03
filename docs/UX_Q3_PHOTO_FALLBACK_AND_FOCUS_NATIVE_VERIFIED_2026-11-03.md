# UX-Q3 | Decoded Fleet photo fallback and keyboard focus | 3 November 2026

**Status: EXACT-SOURCE VERIFIED on hosted native Linux and Windows.** The scope is generated-fictional Fleet UX only. No P0-P9 formal acceptance criterion is being added by this technical change.

## Source provenance

- Development branch: `feature/p7-sqlite-sandbox-20261102`.
- **Source commit:** [`3c8291e4dd51cb52af5f10dd4b2f312c72e07be3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3c8291e4dd51cb52af5f10dd4b2f312c72e07be3), parent `2168bd7c7b66e556bafcfea97c9ef7eb21d5efe8`.
- Draft review stack: [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) based on draft P6 #14; upstream P5 #12 and P4 #10 remain draft. Stable `main` not changed.
- Code files: `spikes/qtquick_p2/Main.qml`, `FleetAddDialog.qml`, `main.cpp`.

## User-facing change and failure mode

Earlier `Image.visible` meant only that a file/provider appeared available, not that Qt successfully decoded a frame. A broken/loading image could therefore hide the neutral fallback and leave empty Gallery or Inspector space. Source selection was also tied to `visible`, making failure-state handling brittle.

- Both real Fleet Gallery and Inspector photos retain independent source bindings and are visible only when the image reports `Image.Ready`. The original `VehicleSilhouette` remains visible on absent, rejected, loading or decoding-failed images.
- The optional Add Vehicle preview follows the same decoded-image policy; unselected and failed previews remain hidden.
- Returning from the replacement file picker focuses the existing available action; closing the reset-confirmation dialog focuses the reset control on cancellation, or the still-visible replacement action if successful removal hides Reset.
- Source and automated assertions preserve all C++ vehicle booking/return/archiving logic, storage guardrails, protected fictional fixture bytes, existing photo-replacement validation and the distinction between illustrative imagery and real stock photos.

## Actual exact-commit CI

[GitHub Actions run 41628559156](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41628559156), triggered by source push on 3 November 2026, completed **success** for `3c8291e4dd51cb52af5f10dd4b2f312c72e07be3`.

| Job | Host / toolchain | Measured result |
|---|---|---|
| Native Qt Quick Linux | Ubuntu 24.04, GCC, Qt 6.8.3 | **117/117 CTests passed**, 0 failed; 139.24 s CTest time |
| Native Qt Quick Windows | Hosted Windows Server 2022, MSVC, Qt 6.8.3 | **117/117 CTests passed**, 0 failed; 164.07 s CTest time |
| Windows portable kit | Same hosted Windows job, PowerShell 7 and Windows PowerShell 5.1 | Packaged verification **PASS** in both hosts |
| Changed-path classifier | GitHub Actions | PASS |

Real Qt wide and compact photo tests `rental_studio_fleet_photo_wide` and `_compact` passed on both hosts. Their enhanced native assertions check an oversized on-disk image is rejected with Inspector silhouette visibly restored, that a valid replacement recovers image rendering, and that keyboard focus returns to usable controls after cancelling/completing photo reset. Existing native tests remained enabled.

Both platform workflows uploaded actual native screenshot artifacts. Hosted Windows is evidence of **MSVC under CI**, not the owner's physical Qt Creator 6.10.2 MinGW, OS 100/125/150% scaling, Windows Narrator or formal visual acceptance. No assertion is made about those unperformed tests.

## Follow-up visual QA and limitations

The earlier **separate** successful [native Windows run 41618236689](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41618236689) supplied real Fleet screenshots at 1500×860 and 1280×720. Inspection shows the remaining two motorcycles represented by bicycle-like generic outlines and the existing three car photographs with inconsistent settings/backgrounds. These are real issues for the owner's five-vehicle photography-quality mission, but **not changes or new aesthetic acceptance from this commit**.

Next: review visually coherent, model-appropriate motorcycle and car photographs from [PHOTO-P1-B candidate shortlist](../design/PHOTO_P1_B_SOURCE_SHORTLIST_2026-11-03.md), verify exact reuse/derivative licences, crops and native QML presentation, and obtain owner P1 artwork/design acceptance. Do not bundle unapproved photography automatically.

**Acceptance remains 45/74 formally accepted, weighted 70.6%**, not product completeness. P1 final photo/design, P2/P4 physical Windows access, P7 D2-D8 production policy, P8 installer and P9 release gates remain open. No real customer data, deployment, merge, release or `main` modification authorised.
