# P7-F | SQLite cross-process transaction and crash safety, native verified
**Date:** 2 November 2026. **Exact source:** [`72c7979`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/72c79794d377080bcae0bfe602859e70c32750d4), [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) on `feature/p7-sqlite-sandbox-20261102`. The earlier [P7-E backup proof](P7_E_SQLITE_BACKUP_RECOVERY_NATIVE_VERIFIED_2026-11-02.md) remains intact.

## Implementation and isolation
- Added independent `tests/p7_sandbox/p7_sqlite_process_tests.cpp` and five CTests registered in `tests/p7_sandbox/CMakeLists.txt`, behind existing default-**OFF** `BUILD_P7_SQLITE_SANDBOX`. No changes to C++ domain, Qt Quick, legacy Qt Widgets or application production storage.
- Tests spawn genuine child executables using `QProcess` against a `QTemporaryDir` generated SQLite v1 synthetic database. Child access is restricted to a named temp-root pattern with a matching fictional-only marker token; parent uses fixed cases, no UI import or customer path. No PII, driver's-licence, commercial data or payment records.
- Synthetic rows: fictional Car C001, illustrative 45000-cent rate, active rental R001 with booked total 135000 cents, and an R identifier counter that advances from 1 to 2 only on successful commit. This simplified schema does not model booking duration or return dates. Value is test booked contract amount, **not revenue/cash**. Foreign keys, active-rental uniqueness, fail-closed schema version and bounded SQLite writes remain in test scope.

## Five actual independent process CTests
| Test | Mechanism | Verified |
|---|---|---|
| `rental_studio_p7_process_recovery` | Child begins immediate transaction, allocates R001 + writes rental, signals precommit; parent forcibly kills it. New connection sees **no row and unchanged R counter**. A fresh child then commits successfully. | PASS Linux + Windows |
| `rental_studio_p7_process_contention` | Parent holds `BEGIN IMMEDIATE`; competing child fails promptly without consuming ID. After parent `ROLLBACK`, independent retry succeeds once. | PASS Linux + Windows |
| `rental_studio_p7_process_restart` | Child commits fictional R001; separate child process checks it, then parent independent connection verifies status, total and counter. | PASS Linux + Windows |
| `rental_studio_p7_process_duplicate` | A second process booking already-active C001 is rejected; count and next ID remain correct. | PASS Linux + Windows |
| `rental_studio_p7_process_future_schema` | Schema version changed to future v2; separate writer refuses before mutation and original counter/rows remain. | PASS Linux + Windows |

**Exact-source CI:** [Core C++ 41418463061](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41418463061): **13/13 passed** with P7 sandbox OFF. [Native Qt 41418463218](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41418463218): **100/100 on Linux GCC Qt6.8.3 and 100/100 on hosted Windows Server 2022 MSVC Qt6.8.3**; new P7-F tests #96–100 PASS in both genuine job logs. Hosted Windows relocated package, fake-fixture safeguards and P4 PowerShell 7/5.1 checks PASS. No source-level test weakening or failed final runs.

## Limits
- The parent **forcibly terminates a child process before COMMIT**; this is **not** proof against power failure, disk-full, storage-controller failure, corruption or malicious file tampering.
- SQLite schema is simplified and fictional; tests do **not** implement approved commercial Fleet/Rentals repository, real contacts, migration, backup retention or a release installer. Same-day booking, legal retention and financial policy remain governed by existing C++ runtime.
- The tested lock case is an immediate writer collision with busy timeout zero, not multiuser synchronization, cross-PC concurrency or every possible OS lock mode.
- Physical owner Windows Qt Creator **6.10.2 MinGW**, Narrator, actual 100/125/150% scaling and final UX acceptance remain NOT TESTED.

## Owner and follow-on gate
The [P7 draft SQLite ADR](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md) still requires explicit owner decision on engine, data root, integer-cent bounds, permanent IDs, vehicle retirement and rental-history retention, customer/contact and old licence minimization, backup encryption and restore controls, owner-gated legacy migration and provisional eight-criterion acceptance. No commercial adapter/runtime cutover should be merged, enabled or tested on genuine customer records before these are resolved.

**Formal status remains:** P7 0/8, P6 0/9, P5 0/8, programme 28/74 accepted; 40.6% evidence-weighted, not commercial readiness. Keep PR stack DRAFT and `main` untouched.

**Recommended next:** resolve owner decisions in one compact architecture approval, then implement a gated runtime repository seam using only synthetic data and preapproved transaction/retention contracts. Avoid repeated expansion of test infrastructure without a specific uncovered risk.
