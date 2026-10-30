# P3-D | Typed Read-only Rental Summary | Exact-source Verification

**Date:** 30 October 2026. **Repository:** Sonkhe-Shongwe/vehicle-rental-system.
**Branch:** feature/p3-rental-confirm-20261030, Draft PR #9 stacked on #8 / #7 / #6.
**Verified source:** [4927e15e1dcd6599a7f97cfa9c68e99cb83664f0](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/4927e15e1dcd6599a7f97cfa9c68e99cb83664f0).

## Implemented

- New src/application/rental_read_service.h and .cpp use a borrowed const RentalSystem reference and return independent-by-value RentalRecordSummary snapshots. A service must not outlive its domain; returned copies survive domain mutation/destruction.
- Snapshot data includes rental and vehicle ID, actual/start/due dates, number of days, legacy double daily rate/total, and mutually exclusive Active, Returned and Archived statuses. Archived takes precedence over Returned.
- Deterministic injected date callback gives NotDue, DueToday, Overdue, NotApplicable and Unknown due-state. Invalid date yields Unknown for active, not a misleading NotDue. Due-state does not change lifecycle status.
- Records, status-filtered records and case-insensitive trimmed ID lookup all read existing authoritative C++ data. No customer name/phone exposed through general summaries.
- Qt Core-only vehicle_rental_p3_rental_read CTest added to CMakeLists.txt. No production UI, persistence schema, booking rules, photographs, payments or network features introduced.

## Actual independent GitHub CI

| Environment | Command / validation | Result |
| --- | --- | --- |
| Ubuntu Qt Core + legacy | ctest --test-dir build --output-on-failure | [Run 41096617593](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41096617593): **6/6 PASS** |
| Ubuntu GCC Qt6.8.3 native QML + legacy | ctest --test-dir build-p2 --output-on-failure | [Run 41096617754](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41096617754): **14/14 PASS** |
| Hosted Windows MSVC Qt6.8.3 native QML + legacy | ctest --test-dir build-p2 -C Release --output-on-failure | [Run 41096617754](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41096617754): **14/14 PASS** |
| Windows portable app and fictional fixture protection | Existing packaged native smoke workflow | **PASS** |

## Regression scenarios executed

- Empty and missing rental collection; four fictional rentals persisted through real domain commands: two active, one returned, one archived.
- Status filters 2/1/1; archived record does not leak into returned-only filter; active overdue and not-yet-due are distinct.
- Injected clock checks overdue, due today, invalid-clock Unknown and NotApplicable for returned/archived; no hidden clock-driven booking mutation.
- ID lookup trims and compares case-insensitively; verified expected returns, actual return dates, rates, totals and statuses.
- Byte-exact fleet and rental ledger comparison before/after all reads; no source-adjacent operational records used.
- Domain return changes a subsequent snapshot while a previously copied snapshot stays intact even after domain destruction.
- Real restart reconstructs Active/Returned/Archived states. After removing a returned vehicle, its historical rental remains readable without recreating the vehicle or modifying persisted data.

## Formal acceptance and limits

**P3 remains 3/7 (42.9%), 19/74 accepted across programme, weighted 25.2%.** Criterion 4 is PARTIAL, not accepted: a typed C++ read service exists, but live Qt/QML Rentals list model, refresh and selection are absent. Neither complete rental workflow nor owner physical Windows QA nor full design accessibility/signoff is claimed.

**Next P3 slice:** minimal operational Qt model adapter and explicit refresh/selection for Rentals based solely on this typed C++ service, with no unrelated P4/P5/P7 implementation. Draft PRs stay unmerged, stable main unchanged.
