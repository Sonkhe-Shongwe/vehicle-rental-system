# P3-E | Qt Core Rental List Model, Stable Selection and Explicit Refresh

**Date:** 30 October 2026. **Repo:** Sonkhe-Shongwe/vehicle-rental-system.
**Source tested:** [238761d191f9b45100c23decf4913bd6d1fad004](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/238761d191f9b45100c23decf4913bd6d1fad004), Draft PR #9, branch `feature/p3-rental-confirm-20261030` stacked on P3-B #8 / P3-A #7 / P2 #6.

## Actual implementation

- `src/application/rental_list_model.h/.cpp` defines `RentalListModel` derived from Qt Core `QAbstractListModel`, consuming P3-D `RentalReadService` snapshots and never holding mutable `Rental*` or writing ledger files.
- Exposed Qt model roles are only `rentalId`, `vehicleId`, start/expected/actual date, days, legacy daily rate, total, lifecycle `status` and domain-computed `dueState`; name/phone/personal contact data is deliberately absent.
- `refresh()` performs native model reset and re-reads authoritative C++ snapshots. `countChanged` only signals true count changes; `selectionChanged` signals selection identity or its current row shift. There is no optimistic refresh on uncommitted domain action and no hidden observer pretending to track external writes.
- `selectById()` normalizes trimmed, case-insensitive rental IDs, stores actual canonical ID, retains selection when another row is deleted, and ignores unknown IDs. `clearSelection()` is idempotent; a deleted selected rental clears selection on refresh.
- Existing `CMakeLists.txt` includes a `vehicle_rental_p3_rental_model` Qt Core-only CTest target with automatic Qt moc; all pre-existing tests remain enabled. No QML Rentals page or P4 components were added.

## Independently executed exact-source results

| Workflow | Test command / scope | Result |
| --- | --- | --- |
| Ubuntu Qt Core + legacy | `ctest --test-dir build --output-on-failure` | [41098537217](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41098537217): **7/7 PASS** |
| Linux Qt6.8.3/GCC native QML+legacy | `ctest --test-dir build-p2 --output-on-failure` | [41098537453](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41098537453): **15/15 PASS** |
| Hosted Windows Qt6.8.3/MSVC native QML+legacy | `ctest --test-dir build-p2 -C Release --output-on-failure` | [41098537453](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41098537453): **15/15 PASS** |
| Hosted Windows portable runtime / fictional fixture integrity | Existing package and smoke steps | **PASS** |

## Model/test cases

- Empty model, missing/unknown IDs, read-only item flags, no contact information in role map.
- A C++ domain change requires an explicit refresh; no optimistic re-render before the authoritative domain operation.
- Three fictional rentals produce model roles with actual typed dates, prices and domain-calculated NotDue, DueToday and Overdue labels.
- Native Qt `modelReset`, `countChanged` and `selectionChanged` are actually observed and asserted in the CTest; repeated selection and redundant clear do not spuriously signal.
- Returning and archiving another rental are reflected after refresh without dislodging the stable selected rental ID.
- Removing a preceding archived rental changes the selected row but keeps the same rental ID, emitting a selection notification for its new index.
- Returning a selected rental changes its status/dates without changing the selected ID; historical record survives vehicle removal.
- Deleting the selected archived rental clears its ID and row exactly once on explicit refresh; cancellation/invalid lookup does not mutate it.
- Independent `RentalSystem` restart correctly reconstructs the remaining returned rental, and all read-only model operations preserve fictional rental and fleet file bytes.

## Explicit limits and next action

**P3 criterion 4 still PARTIAL:** this is a tested native Qt Core model, not a live Qt Quick Rentals UI. The model borrows the read service, which borrows `RentalSystem`; caller must preserve lifetimes. The authoritative command controller must call `refresh()` only after real commit and decide how Gallery, Overview and active/history views are updated. Full end-to-end price/availability authority in QML remains unverified.

**P3 3/7 accepted, 19/74 programme-wide checks, weighted 25.2%**, not release readiness. Qt Creator owner Windows MinGW, physical DPI/focus, P1 imagery/a11y/final full-product design and P3 remaining typed commands/repository seam remain OPEN. Main stays unchanged, PRs Draft/unmerged.

**Next scope:** review a minimal domain-command integration contract and QML Rentals model consumption without creating a second pricing/availability truth or premature P7 storage migration.
