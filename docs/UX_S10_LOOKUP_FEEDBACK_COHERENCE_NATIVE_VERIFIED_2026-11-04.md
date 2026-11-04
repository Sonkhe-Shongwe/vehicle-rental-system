# UX-S10 | Lookup-feedback coherence after selection, filter and refresh

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled native-verified source:** [`55ee240aed1aa0c474752252b0a5629cdfcbdaa5`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/55ee240aed1aa0c474752252b0a5629cdfcbdaa5)  
**Native GitHub Actions:** [run 41766475280](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41766475280), **COMPLETED SUCCESS**  
**Active branch:** `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked on P6 PR #14; no merge.

## Reproducible operator issue

The Qt Quick Rentals screen retained `window.rentalLookupFeedback` after a new C++-owned rental selection, lifecycle filter change or authoritative rental model refresh. For example, a successful **Find rental** action could display "Selected R001" after a subsequent pointer/keyboard or C++ selection changed the actual contract to R002. Similarly, a previous "Rental ID not found" could remain visible after a filter change. An **active return lookup** success message could remain after filtering while the same active ID remained selected.

This is stale *presentation feedback*, not a discovered incorrect persisted rental or unexpected domain write. Existing C++ identity and action validation stay authoritative.

## Bounded fix

- In `spikes/qtquick_p2/Main.qml`, the existing `Connections { target: rentalsModel }` now clears **both** rental lookup and active-return lookup feedback on `selectionChanged`. This makes separate pointer, keyboard, overview or direct C++ navigation remove the result of a prior lookup rather than claiming an old ID remains the current deliberate lookup result.
- `modelReset` now clears both feedback strings even if `selectedRentalId` remains unchanged. A domain refresh or local calendar rollover can change selected-record status or other data.
- `statusFilterChanged` also clears both feedback strings, handling filter changes that preserve the selected ID and would not otherwise trigger `selectionChanged`.
- After explicit `findRentalById()` / `findActiveReturn()` operations, existing QML functions still show the outcome **at the end of the lookup operation**. This preserves meaningful success, unknown-ID and blank-input messages until another context change or the operator edits the query field.
- No modification of C++ `RentalListModel`, read service, quote/return/archive controller, transaction boundary, permission, SQLite schema or protected fictional fixture.

## Strengthened native Qt regression coverage

The existing `--rentals-filter-smoke` wide/compact native QML scenarios now:
1. Exercise a successful *Find rental R002* through the actual keyboard-activated button, then independently select R001 through the C++ model and check old success feedback is removed.
2. Find R002 again and call a genuine `RentalListModel::refresh()`; selection remains R002 but the stale feedback disappears.
3. Submit an unknown R999 via the real control (feedback correctly reports not found), switch the lifecycle filter to Active, and verify stale failure feedback disappears and the Archived R002 selection is no longer visible.
4. Preserve the existing full-file byte-for-byte source fixture check and legitimate C++ filtering, read-only history and archive behavior.

The existing `--rentals-return-smoke` wide/compact native QML scenarios additionally verify the **Locate return by vehicle ID** message for R001, then switch from Active to All without changing the selected ID and verify the old success text is cleared. Existing failed lookup disarming, Cancel, explicit return confirmation, no duplicate return and protected fixture checks remain.

No tests were disabled or removed. Suite size stays **123**, not larger.

## Exact-source verification

[Actions 41766475280](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41766475280) was **COMPLETED SUCCESS** for `55ee240aed1aa0c474752252b0a5629cdfcbdaa5`.
- **Ubuntu 24.04 GCC, Qt 6.8.3:** **123/123 CTests PASS**, zero failures, total **158.50 seconds**. The real wide/compact `rental_studio_p3_filter_qml` #47-48 and `rental_studio_p3_return_qml` #49-50 all passed.
- **Hosted Windows Server 2022 MSVC, Qt 6.8.3:** **123/123 CTests PASS**, zero failures, total **179.41 seconds**, including the same four real native QML tests #47-50.
- **Hosted relocated Windows portable executable:** **8/8 genuine fictional-app functional checks PASS**; P2/P4 packaged automation and both PowerShell 7 and Windows PowerShell 5.1 checks PASS.
- Evidence artifacts expire **11 November 2026**: [Windows physical acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41766475280/artifacts/13293585273), [hosted Windows Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41766475280/artifacts/13292129778), [Linux Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41766475280/artifacts/13292644165).

These are hosted automated native/QML runs, **not** physical Windows owner acceptance, Qt Creator MinGW validation, on-device scaling/Narrator or actual-release certification.

## Gates preserved

**Formal acceptance unchanged: 45/74 criteria, weighted 70.6%; P7 0/8.** Physical owner Windows UX-S1 scrolling and keyboard/focus retest; Qt Creator/MinGW; physical 100/125/150% scaling and Narrator; P7 D2-D8 real-data, privacy, retention, backup and security decisions; P8 installer; P9 release; all PR merges; and final Fleet Population/Photos remain OPEN.

Only two QML source/test files were changed for UX-S10. No production customer data, live storage, financial transactions, operational backup UI or licence-dependent images introduced. The documentation-only commit that follows this verified source **is not separately compiled**.
