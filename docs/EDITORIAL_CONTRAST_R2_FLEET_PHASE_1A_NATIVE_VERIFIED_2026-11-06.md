# Rental Studio 2.0 | Editorial Contrast R2 Fleet Phase 1A | Verified native checkpoint

**Date:** 6 November 2026. **Passing executable:** [`9a8200417a64d102265f27c74f102e9ddc7f97e8`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9a8200417a64d102265f27c74f102e9ddc7f97e8). **Native run:** [#42254221304 SUCCESS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42254221304). Active `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked on P6. Protected main unchanged.

## Implementation

The Fleet gallery/table and selected inspector now use an approximately 60/40 workspace split at 1500x860 and 1280x720. Selected Inspector has evergreen `#072A28` photo header and actual C++ vehicle name/ID/type/status, with the existing white source-backed description, daily rate, Book, history-blocked Remove and explicit empty selection. Gallery uses photo-led cropped thumbnails; the uncropped View full, image credits, optional local photo change/reset and silhouette fallback remain. Search, status filters, sort, Gallery/Table, selection ID, focus navigation, C++ booking/availability/pricing and rollback/persistence are unchanged.

Native Fleet smoke tests were strengthened to assert source-backed selected name and status, dark header, actual C001 available with enabled Book, C002 rented with Book disabled, roughly 60/40 geometry and original white detail controls.

## Failed attempt retained and repaired

Initial source [`2268818`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2268818bf01ab7ca8d585307712c5ca4f9b3ee36) failed [native #42252227907](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42252227907): **Linux 140/142**, failing Fleet wide overlap and historic P2 focus-edges; **Windows 141/142**, failing historic P2 focus-edges. Linux logged gallery width 789px overlapping a 488px inspector, a Qt recursive-layout warning and two instead of three wide Gallery columns. The original source, failed logs and screenshots remain in GitHub.

Repair `9a82004` suppresses redundant decorative wide toolbar counts at normal desktop sizes, while preserving exactly the same **authoritative C++ Fleet snapshot counts** below. It uses 3 Gallery columns at 1500 and 2 at 1280, matching original P2 keyboard directional expectations. Tests were not removed, weakened or skipped.

## Exact-source results

| Check | Linux GCC Qt 6.8.3 | Windows MSVC Qt 6.8.3 |
|---|---|---|
| Full native CTest | **142/142 PASS** | **142/142 PASS** |
| Fleet wide and compact #16/#17 | PASS / PASS | PASS / PASS |
| Legacy focus-edges #42 | PASS | PASS |
| Fleet photos, lifecycle, focus and C++ safety regression | PASS | PASS |
| Packaged fictional functional checks | N/A | **8/8 PASS** |
| Packaged PowerShell 5.1 | N/A | **PASS** |

Screenshot artifacts: [Linux #13522171572](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42254221304/artifacts/13522171572), [Windows #13522975671](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42254221304/artifacts/13522975671). [Windows hosted QA kit #13522007175](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42254221304/artifacts/13522007175) is not physical owner approval.

## Real Qt visual inspection

Downloaded screenshot archives and directly inspected actual compiled Gallery and Table screenshots for **both** 1500x860 and 1280x720 **on both Windows and Linux**. Wide shows three photo-led cards, no overlapping inspector, and correctly selected Toyota Corolla C001, **Available**, **R450.00/day**. Ford Ranger C002 remains **Rented**, **R700.00/day** in the fixture. Compact shows two columns and visible white inspector booking and remove actions. Table selection remains mint and linked to C++ identity. No fabricated availability, rate or new product capability was observed.

The following visual issues are **not yet accepted**: compact Gallery starts scrolled to keep selected C001 in view, partly cropping the first row at top; the long pale source-credit bar overlays the selected photograph; the selected white details body has excessive empty space compared with approved editorial concept. These warrant Fleet Phase 1B. Source-controlled design master supports the qualitative composition, but the original owner full-resolution R2 PNG ZIP is unavailable for pixel-level comparison.

## Formal and physical constraints

This is a verified implementation increment, **not final Fleet owner visual acceptance**. Physical Windows Qt Creator 6.10.2 MinGW, actual 100%,125%,150% scaling, Narrator, keyboard/mouse and final photography approval remain OPEN. Overview/Fleet/Rentals each still require visual owner approval. Segoe/system stays default; Inter is an opt-in verified experiment. P7 remains fictional/opt-in, no main merge/release/payment/cloud/customer import. Formal P0-P9 acceptance stays **45/74, weighted 70.6%, P7 0/8**, retaining accepted P5 and P6.

**Next sensible task:** Fleet Phase 1B compact gallery startup scroll, restrained photo-credit placement and denser factual white inspector body. Honor a newer owner request over this historical next action.
