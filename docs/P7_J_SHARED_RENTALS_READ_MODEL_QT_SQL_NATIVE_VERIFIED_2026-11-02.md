# P7-J | Reuse the existing Rental Studio read model with fictional normalized SQLite

**Date:** 2 November 2026. **Exact compiled code:** [`6224a0f`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6224a0fcdf7c879f64d677472e073d3037bcd7a8). **Verified:** [core **13/13**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41471605002), [Qt 6.8.3 Linux native **111/111** and hosted Windows native **111/111**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41471604730); Windows packaged PowerShell 7 and 5.1 checks PASS. This is an **OFF-by-default, generated-fictional-only Qt Quick/SQLite read compatibility proof**. **It is NOT the normal Rental Studio database, production customer workflow, or P7 approval.**

## New integration seam, without replacing the working app

The actual Rental Studio P5/P6 application already uses `RentalReadService` and the shared `RentalListModel` for Rentals lists, status filters, active/due KPIs, recent contracts and purpose-limited selected contract details. Prior P7-I Qt Quick preview used its own minimal booking stage labels. **P7-J integrates the same shared `RentalListModel` into the P7-I compiled fictional Qt Quick window**, fed by validated P7-H SQLite read snapshots through a new provider:

1. `src/application/p7_sandbox/sqlite_repository.h`: read-only typed `VehicleRow` and `RentalRow` collections with `std::optional` on invalid/unavailable read, explicit columns and validation of status, dates, amount and 1–365-day multiplication. No external paths or mutable entity pointer exposed. Canonical SQL money is int64 cents.
2. `src/application/p7_sandbox/sqlite_read_projection.h`: converts **validated** normalized SQL rows into the existing value-only `FleetVehicleSummary` and `RentalRecordSummary` C++ contracts, with real domain-status precedence and due-state calculations. For compatibility the read-only QML amount is formatted via cents / 100.0 double; **no double is written back** into commercial SQL. Fleet `available` excludes retired and currently active-rented vehicles. No customer/contact/licence data in read snapshots.
3. `src/application/rental_list_model.h/.cpp`: a backward-compatible **`SnapshotProvider`** constructor added to the actual existing model. The default `RentalReadService` constructor continues using its original domain source. A failed provider read (`nullopt`) preserves the last valid list and **does not emit false model reset or metrics-changed**. Valid snapshots remain value-only and refresh post-commit.
4. `src/application/p7_sandbox/repository_preview_controller.h`: opt-in preview now emits a distinct `committed()` signal **only after successfully committed** fictional booking, return, archive or retirement, not quote-only or rejected writes.
5. `tests/p7_sandbox/p7_fictional_preview.qml`: displays shared `RentalListModel.activeCount`, `.historyCount`, `.activeBookedValue` bindings through the same QML model contract as the product, alongside explicit fake receipt and asset status.
6. `tests/p7_sandbox/p7_qml_preview_tests.cpp` and CMake: compile shared model with original domain dependencies; drive actual QML buttons, verify false-receipt rejection, model signal counts, active/rented/history transitions, selected contract status, SQL restart, visible shared metrics and Fleet read projection. New `rental_studio_p7_qml_read_model` CTest #111 exercises status-filter + history lookup and retired vehicle view. Earlier P7-I journey/rollback tests #109–110 now also assert shared model behavior.

## Exact compiled-source verification

| Source-verified case | Linux Qt 6.8.3 GCC | Windows Qt 6.8.3 MSVC |
|---|---|---|
| P7-I expanded real-QML journey #109 | PASS | PASS |
| P7-I expanded failed-write/no receipt/retry #110 | PASS | PASS |
| **P7-J `rental_studio_p7_qml_read_model` #111** | **PASS** | **PASS** |
| Entire regression including prior P5/P6 and P7-A–I | **111/111 PASS** | **111/111 PASS** |
| Separate core C++ regression | **13/13 PASS** | Part of separate CI workflow |

[Exact native source CI](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41471604730) and [core CI](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41471605002); **no physical device MinGW/Narrator/OS-scale acceptance inferred**. Windows packaged PowerShell 7 / Windows PowerShell 5.1 both PASS.

## Scope, acceptance and next product gate

- Normal polished Overview/Fleet/Rentals **`spikes/qtquick_p2/Main.qml`** still runs its prior protected generated-fictional **`RentalSystem` + QSaveFile** text. It does not use the P7-J provider or QtSql. P7-J's compatibility constructor is available to the project but is only called from the **separate opt-in P7 synthetic Qt Quick test executable**.
- No customer name/phone/licence/identity fields, real-data import, external arbitrary path, paid processing, production cutover or general backup/restore. Fictional C001/R001 only under disposable temporary path with exact generated marker.
- Neither the commercial pricing/ID caps nor customer privacy/retention/archive policies nor owner P7 architecture ADR and 8/8 rubric are ratified. The model's UI double fields remain display-only, not a commercial money policy.
- **Formal P5 0/8, P6 0/9, P7 0/8, programme 28/74 accepted, 40.6% weighted unchanged.** All draft PRs remain unmerged, stable main unchanged, P8/P9 not started.
- **Next:** consolidate the outstanding owner P7 business, security and migration decisions, then carefully integrate the typed SQL repository with the **actual** application-level command/read services behind an explicitly safe fictional-only runtime switch; prove default behavior preserved and no historic ID/record loss before any real customer data or installer release.
