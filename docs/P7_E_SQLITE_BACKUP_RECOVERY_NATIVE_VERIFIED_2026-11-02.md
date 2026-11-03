# P7-E | Native-verified, synthetic-only SQLite backup and recovery
**Date:** 2 November 2026. **Exact tested source:** [d81b723](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/d81b723edb5b0236b4c4303cc71f9c40bba64a47). **Branch:** `feature/p7-sqlite-sandbox-20261102`, stacked [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) on P6 #14; main untouched.

## What was implemented
Added `tests/p7_sandbox/p7_sqlite_backup_tests.cpp` and six cases in `tests/p7_sandbox/CMakeLists.txt`, guarded by existing default-OFF `BUILD_P7_SQLITE_SANDBOX`. Qt6 Core/Sql only, separate executable, generated fictional data within `QTemporaryDir` and fixed case names only. There is **no general file path interface**, no real customer fields, no import/migration, no runtime storage or QML/Widgets change.

The proof uses SQLite `VACUUM INTO ?` to create a consistent private `.stage` snapshot, validates schema version, `integrity_check` and `foreign_key_check` in a separate connection, then uses non-overwriting same-directory rename. Synthetic baseline contains two vehicles, two contracts, 219000 cents booked contract value (not payments/revenue), and high-water C/R ID counters. A test computes SHA-256 of the backup. No user content or private paths are logged.

## Exact new test cases
| Test | Verified behavior |
|---|---|
| `rental_studio_p7_backup_snapshot` | Independently restored schema/counts/status/219000 cents/counters; later source edit does not alter restored snapshot |
| `rental_studio_p7_backup_readers` | Backup works with separate live reader; cursor and source remain intact |
| `rental_studio_p7_backup_uncommitted` | Snapshot excludes concurrent uncommitted insert; writer rolls back |
| `rental_studio_p7_backup_damaged` | Deliberately corrupted copied SQLite header rejected; intact original backup SHA and recovery preserved |
| `rental_studio_p7_backup_refuse_overwrite` | Existing destination never overwritten; no partial stage; original database unchanged |
| `rental_studio_p7_backup_locked` | Rollback-journal exclusive source lock blocks backup with no artifact; retried backup/restoration succeeds after unlock |

## Real exact-source CI
- [Core C++ run 41415603674](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41415603674): **13/13 PASS**, default P7 sandbox OFF.
- [Linux GCC Qt 6.8.3 and hosted Windows MSVC Qt 6.8.3 run 41415603672](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41415603672): **95/95 native CTests PASS on each OS**, six P7-E tests numbered 90–95 PASS on both.
- Relocated hosted Windows app safeguards and P4 automation under PowerShell 7 and Windows PowerShell 5.1: **PASS**. Genuine job logs examined. No test failure or weakened assertion in the accepted source run.

## Boundaries and decisions
This is **test-only feasibility**, not a commercial SQLite store, production backup/restore feature, migration tool, secure encryption, user-selected path workflow or clean Windows installer. No disk-full, power loss, full corruption corpus, permission/antivirus behavior, production retention or real-data restore is certified. Owner's physical Qt Creator 6.10.2 MinGW, Narrator and 100/125/150% OS scaling are NOT TESTED. Before runtime cutover: owner must decide QtSql/SQLite architecture, storage root, customer/phone/old driving-licence handling, privacy/retention/retirement, exact cents/rate bounds, ID policy, safe migration, backup security and formal P7 eight-row rubric.

**Acceptance remains unchanged:** P7 0/8, P6 0/9, P5 0/8, total **28/74 formally accepted**, **40.6% evidence-weighted**, neither meaning release readiness. No PR merge to main.

**Next priority:** consolidate P7 owner decisions and then design the runtime repository adapter safely, rather than activate production records or rework tested P5/P6 flows.
