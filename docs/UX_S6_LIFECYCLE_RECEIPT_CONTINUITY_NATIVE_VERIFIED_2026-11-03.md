# UX-S6 | Return and archive receipt continuity across filtered Rentals

**Date:** 3 November 2026  
**Exact compiled and native-verified source:** [`911b73cf222a028527da717d9e5ecb7cefdf32f1`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/911b73cf222a028527da717d9e5ecb7cefdf32f1)  
**GitHub Actions:** [run 41725515284](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41725515284), **COMPLETED SUCCESS**.  
**Development branch:** `feature/p7-sqlite-sandbox-20261102`, stacked draft PR #17 on P6 draft #14. No merge.

## Operator workflow problem

Previously, a successful return could leave its now-Returned contract invisible and unselected in the Active, Overdue or DueToday filter from which the operator invoked the action. Similarly, successfully archiving a returned contract could hide it from a Returned-only filter. The domain commit and status persisted correctly, but the operator had to manually change filters and relocate the transaction receipt. This was a post-commit discoverability gap rather than a new business or storage rule.

## Smallest bounded correction

- `src/application/rental_return_controller.cpp`: after the authoritative successful domain return and rental/Fleet read-model refresh, invoke the existing read-only `RentalListModel::locateById(result.rentalId)`. An excluding filter safely changes to `All` and selects the **persisted Returned** contract. A non-excluding filter remains unchanged. Return eligibility is recalculated and a second return remains blocked. No lookup runs for a rejected operation.
- `src/application/rental_archive_controller.cpp`: after confirmed persisted archive and rental-model refresh, use the same existing read-only lookup to reveal/select the **persisted Archived** contract when Returned-only would hide it. Historical and All filters continue to retain visible selection. Repeated archive remains disallowed; the archive action does not modify fleet availability.
- `tests/p3_rental_return_controller_tests.cpp`: retain write-failure rollback tests and verify a failed return preserves current selection/filter, then a successful Active-only return reveals R001 as Returned in All with no enabled repeat return and unchanged protected Fleet bytes.
- `tests/p3_rental_archive_controller_tests.cpp`: retain initial rejected and History archive checks; an independent temporary fictional dataset exercises an actual Returned-only R200 archive, requires All reset, stable selected archived receipt, no repeat eligibility, unchanged Fleet bytes, and History selection retention.
- `spikes/qtquick_p2/main.cpp`: strengthen existing real native Qt wide/compact return and archive workflows. Keyboard confirmation now verifies that a returned contract appears selected in All and cannot return twice; a Returned-filter archive similarly verifies visible Archived receipt and disabled repeat action. Existing lifecycle, cancellation, protected-fixture and current-window smoke coverage stays intact.

No QML layout, C++ quote/calculation, customer data exposure, storage schema, SQLite Lab, or domain save path was altered. No new CTests were counted or existing tests removed.

## Exact-source verification

[Native workflow 41725515284](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41725515284) finished **SUCCESS**:
- **Ubuntu 24.04 GCC / Qt 6.8.3:** **123/123 CTests PASS**, zero failures, total **150.65 seconds**. `vehicle_rental_p3_return_controller` #9, `vehicle_rental_p3_archive_controller` #11, return real-QML wide/compact #49-50, and archive real-QML wide/compact #53-54 individually PASS.
- **Hosted Windows Server 2022 MSVC / Qt 6.8.3:** **123/123 CTests PASS**, zero failures, total **178.17 seconds**. Same six targeted tests individually PASS.
- **Windows relocated portable app:** **8/8 genuine fictional functional executable checks PASS**. Packaged P2/P4 PowerShell 7 and Windows PowerShell 5.1 checks PASS. Windows screenshots and the self-contained fictional acceptance kit were generated and uploaded.
- [Windows acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41725515284/artifacts/13275411366), [hosted Windows actual Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41725515284/artifacts/13274421826), and [Linux Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41725515284/artifacts/13275476515). These artifacts do not constitute a physical owner Qt Creator/MinGW or Narrator test.

## Release and acceptance limits

**Formal owner acceptance remains 45/74 criteria, weighted 70.6%; P7 remains 0/8.** P5 8/8 and P6 9/9 remain owner-approved in bounded fictional scope, not general business-data permission. Physical owner Windows UX-S1 page scrolling retest, MinGW, 100/125/150% OS scaling, Narrator, P7 D2-D8 storage/PII/backup/retention decisions, P8 installer, P9 release, final fleet population and photo/rights review remain OPEN. All PRs stay draft/unmerged, stable `main` untouched, no real customer records or operational backup/release created.

A following documentation-only HEAD must not be cited as a separately tested compiled application.
