# Rental Studio 2.0 | Direction A Fleet custom-photo controls: verified

**Date:** 6 November 2026  
**Status:** Completed exact-source native automated verification; physical owner Windows and design acceptance still open.  
**Development branch:** `feature/p7-sqlite-sandbox-20261102`, draft PR [#17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), stacked on P6. Do not merge.  
**Tested executable source:** [`deb1103b30255f3876fe620f60e2b39971a2cf95`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/deb1103b30255f3876fe620f60e2b39971a2cf95)  
**Exact CI:** [#42194446906](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42194446906), completed **SUCCESS**, source SHA matches `deb1103b30255f3876fe620f60e2b39971a2cf95`. Documentation commits after it are not recompiled source.

## Problem and reversible correction

In the existing Fleet selected-vehicle inspector, `fleetViewFullPhotoButton` (**View full**) and `fleetRestoreDefaultPhotoButton` (**Restore default**) both occupied the photo stage's lower-right corner when a disposable fictional custom image was installed. This created overlapping hit targets, especially difficult to use in the 1280×720 layout.

The narrowly scoped QML change places the existing View full action at **bottom-left** and retains Restore default at **bottom-right**. The existing read-only full-photo dialog, keyboard focus restoration, guarded fictional photo replacement, selected C++ vehicle identity and all booking/return, financial and persistence policies were untouched.

Changed executable files: `spikes/qtquick_p2/Main.qml` and `spikes/qtquick_p2/main.cpp`. The existing `--fleet-photo-smoke` checks now use actual `QQuickItem::mapRectToScene` geometry for both actions after synthetic custom-photo installation. They refuse invisible, out-of-window, intersecting or out-of-stage controls and capture `ux-q3-custom-photo-actions-1280x720.png` and `ux-q3-custom-photo-actions-1500x860.png`. No test was removed, bypassed or weakened.

## Exact CI evidence

| Check | Environment | Result |
|---|---|---|
| Native CTest full suite | Linux GCC, Qt 6.8.3 | **140/140 PASS**, 0 failed |
| Native CTest full suite | Hosted Windows MSVC, Qt 6.8.3 | **140/140 PASS**, 0 failed |
| `rental_studio_fleet_photo_wide` (#41) | Each OS, 1500×860 | **PASS**, includes custom-action scene assertions |
| `rental_studio_fleet_photo_compact` (#42) | Each OS, 1280×720 | **PASS**, includes custom-action scene assertions |
| Relocated packaged Windows fictional lifecycle | Windows Server 2022 | **8/8 PASS**, original fixture integrity before/after |
| Packaged accessibility/keyboard/motion checks | Windows PowerShell 5.1 | **PASS** |

Actual compiled Qt screenshots collected as CI output: [Windows screenshot archive #13492086318](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42194446906/artifacts/13492086318) and [Linux screenshot archive #13490638712](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42194446906/artifacts/13490638712). Both resolutions' new custom-photo images were inspected visually. View full and Restore default are visibly separated within the inspector, and the C++ smoke assertions confirm their geometry. The synthetic colored image used for the control test is **not** a licensed candidate photograph or evidence of final visual quality.

Source attribution and media boundaries were preserved: real Gallery/Inspector images are **illustrative model references, not images of a particular rental unit**; missing or unsuitable images continue to use a neutral silhouette. The existing 48 model-photo mappings in `catalogue_acquisition/model_photo_map.tsv` and the `assets/portfolio/IMAGE_CREDITS.md` catalogue were read, not edited. No new third-party image downloads or licensing approvals were made.

## Outstanding gates and next exact action

The native hosted Windows CI result is **not** signoff on the owner's physical Windows Qt Creator 6.10.2 MinGW kit, OS 100/125/150% scaling, Narrator/keyboard experience or final photo and premium Direction A aesthetics. Do not grant additional P0-P9 formal acceptance; current **45/74 criteria, frozen weighted 70.6%, P7 0/8** remains unchanged.

Next authorized bounded work: review existing exact-model photographic attribution and Gallery-to-Inspector visual continuity in genuine 1500×860 and 1280×720 Qt screenshots, without a new photo-sourcing cycle or changes to typed C++ operations. Then request physical owner full three-workspace Windows/DPI/accessibility and aesthetic review. Draft PR #17 remains open, `main` remains untouched, and experimental P7 SQLite is still opt-in generated-fictional-only.

**Continuity:** [Live current status](LIVE_HANDOFF_STATE.md) | [Verified checkpoint](LATEST_CHECKPOINT.md) | [Native testing](TESTING.md) | [AI handoff](AI_HANDOFF_CURRENT.md).
