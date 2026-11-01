# P6-F | Rental ID lookup in the native Qt Quick Rentals workspace

**Date:** 1 November 2026. **Product:** Rental Studio. **Verified source commit:** [`04289fc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/04289fcaf439cfd054bd6619295f57f4bdd684cf). **Branch:** `feature/p6-fleet-create-disposable-20261101`. **Review:** [Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), based on unmerged P5 Draft #12; P4 Draft #10 is an ancestor. `main` untouched.

## Actual parity gap and bounded change

The legacy Qt Widgets `MainWindow::createRentalRecordsPage` provides a rental-record ID entry field for finding a contract to archive or delete. Prior Qt Quick Rentals provided `All`, `Active` and `History` filters with row selection, but no direct ID lookup. In a long rental list, operators could not reliably jump to a known ID without locating a row manually.

- Added `RentalListModel::locateById` as an explicit read-only, case-insensitive, whitespace-trimmed search over the existing C++ authoritative rental summary snapshot. A successful hidden match resets the presentation filter to `All` and selects the canonical rental ID; a visible match leaves the current filter intact.
- Unknown or blank IDs preserve filter, selection, and all storage bytes. Neither the new method nor the QML control initiates a rental/fleet write.
- Added an accessible ID field, Find rental button and inline status feedback to the existing Qt Quick Rentals filter row. A successful lookup scrolls the chosen record into view and returns keyboard focus to the list; failures explain the missing/empty ID without optimistic success.
- Added core regression assertions and expanded the existing *real QQuickWindow* `rental_studio_p3_filter_qml_wide` and `_compact` CTests to keyboard-activate Find, locate a filtered-out ID, reject unknown and blank IDs, and confirm protected fictional files remain unchanged.

## Exact-source automated verification

| Gate | Result | Evidence |
|---|---|---|
| Ubuntu 24.04 C++ Qt Core/Widgets | **13/13 PASS** | [Run 41349482344](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41349482344), including `vehicle_rental_p3_rental_model` |
| Qt 6.8.3 Linux GCC native UI | **68/68 PASS** | [Run 41349482338](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41349482338), including wide/compact Qt Quick rental filter and lookup assertions |
| Qt 6.8.3 Windows Server 2022 MSVC native UI | **68/68 PASS** | [Same native run](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41349482338), including real Qt native-window interaction |
| Hosted Windows relocated P4 checks | **PASS** | [Native run](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41349482338), PowerShell 7 and Windows PowerShell 5.1 |

The original checked-in fictional fixtures remain protected. No customer records were made accessible to QML. Windows hosted CI is not equivalent to physical Qt Creator, Microsoft Narrator or real 100%/125%/150% OS scaling acceptance. No clean production installer or general-purpose storage is authorized.

## Bounded legacy-to-Qt Quick parity inventory

| Legacy operator capability | Qt Quick evidence/state | Gap or follow-up |
|---|---|---|
| Add Car/Motorcycle, vehicle lookup, available/all views | P2/P3 Fleet gallery/table search/status/sort and P6-A Add | Verified scoped synthetic functionality; owner physical review separate |
| Remove vehicle, protect referenced rentals | P6-B exact confirmation, P6-D historical-reference C++ rejection | Production requires approved non-destructive retirement and historical record retention |
| Start rental, confirm price, cancel without write | P3 guided quote/confirm; P5 persistent fictional flow and no-write guards | Production customer/financial storage still P7 |
| Locate rental by ID to support lifecycle actions | **P6-F now verifies rental ID find/reveal/select** | Legacy also permits entering a vehicle ID for returns; native operator equivalent not yet established |
| Return, archive, permanently delete allowed archived records | P3 Return/Archive and P6-C archived-only delete, authoritative C++ | Need complete source-to-QML edge-case parity and physical operator review |
| Filter Active, Returned, Archived separately | Qt Quick filters `All`, `Active`, combined `History` | **Open:** distinct Returned-only and Archived-only operator views not yet offered |
| Rental-record customer/contact display | Qt Quick intentionally exposes *no* customer/phone roles | Purpose-limited privacy/authorization policy must be designed before general commercial data |
| Reopen real native application processes | P5 fictional session and P6-E three-process disposable restart | General storage/migration, recovery and power-loss gates remain P7/P9 |

**This is a focused source-to-UI parity increment, not a full P6 #9 closure.** The original nine-group P6 interpretation remains **provisional 8 automated-covered / 0 partial / 1 full-parity open** until the owner ratifies the rubric. Formally **P4 5/7, P5 0/8, P6 0/9; overall 28/74 and weighted 40.6%** remain unchanged. These are milestone acceptance metrics, not percentage of software finished or commercial release readiness.

**Next technical priority:** Close the remaining operator lifecycle parity gaps without weakening C++ domain permissions, especially separate Returned/Archived views and an explicitly reviewed rental-or-vehicle ID return path. Complete a consolidated owner visual/physical review and resolve commercial retirement/retention policy before broader production changes.
