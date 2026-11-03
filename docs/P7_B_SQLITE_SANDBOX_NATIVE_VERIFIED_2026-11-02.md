# P7-B | Isolated synthetic QtSql/QSQLITE proof, exact-source verified

**Date:** 2 November 2026 (Africa/Johannesburg). **Last fully tested source:** [`cbbca7bd101e540896e2cf6eb12699c11627373c`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/cbbca7bd101e540896e2cf6eb12699c11627373c). **Branch:** `feature/p7-sqlite-sandbox-20261102`; [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) is stacked directly on the still-draft P6 [PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), above P5 #12 and P4 #10. No merge, no real contacts, no customer/driver-licence migration or production data activation.

## 1. Implemented scope, and the non-negotiable isolation

- Added `tests/p7_sandbox/p7_sqlite_sandbox_tests.cpp` and `tests/p7_sandbox/CMakeLists.txt`. The **standalone** `rental_studio_p7_sqlite_sandbox` test executable links `Qt6::Core` and **`Qt6::Sql`**. It does **not** link the existing `VehicleRentalSystem_A3` or Qt Quick `rental_studio_qtquick_spike` target to QtSql.
- Top-level `CMakeLists.txt` introduces `BUILD_P7_SQLITE_SANDBOX`, **OFF by default**, requires `BUILD_TESTING=ON` and Qt6 when explicitly enabled. Normal local builds are unchanged.
- Five independent CTests write **only generated fictional records** into `QTemporaryDir` within their own process. The CLI accepts exactly one of five fixed case names and **does not accept file paths, import arguments or user data**. No SQL is bound into QML. None of the existing protected `demo/vehicles.txt`, `demo/rentals.txt`, fixed fictional session files or real input paths are read or modified.
- The draft schema, **not an approved commercial schema**, contains a durable `issued` high-water counter for C/M/R IDs, case-insensitive IDs, Fleet `ACTIVE|RETIRED`, Rental `ACTIVE|RETURNED|ARCHIVED`, positive integer-cent prices, restricted rental historical FK, and a partial index enforcing **at most one active rental per vehicle**. Test connections turn `PRAGMA foreign_keys=ON` on explicitly, request `journal_mode=DELETE`, `synchronous=FULL`, and `busy_timeout=0`. These are experimental settings, not a selected production durability/lock policy.
- A strict ASCII 2-decimal `QString` → `qint64` cents parser with checked multiplication rejects zero, negative, arbitrary extra precision, locale comma, exponent notation, 64-bit overflow and invalid 1–365-day duration.
- New [native CI workflow wiring](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/feature/p7-sqlite-sandbox-20261102/.github/workflows/p2-qtquick-review.yml) includes the P6 base branch in pull-request triggers and enables the opt-in target **only for that full native review build**. Full older QML/Widgets P5/P6 regressions and Windows P4 packaging tests still run alongside it. Core CI exercises the pre-existing default-off build as a separate gate.

## 2. Real tests at the exact source SHA

| Gate | Exact source evidence |
|---|---|
| [Core C++ run **41399843563**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41399843563) | **13/13 PASS**, default P7 option OFF |
| [Native Qt6.8.3 Linux GCC **41399843603**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41399843603) | **79/79 PASS** (former 74 + new five independent P7 SQLite CTests) |
| [Native Qt6.8.3 hosted Windows MSVC **41399843603**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41399843603) | **79/79 PASS**, all five P7 cases |
| Windows relocated package scripts | **PASS** under hosted PowerShell 7 and Windows PowerShell 5.1; no physical scaling/Narrator signoff |

Five named P7 tests **#75–79**, each PASS on both OSes:
1. `rental_studio_p7_sqlite_money`: strictly parsed cents, exact multiplication and overflow/domain boundary refusal.
2. `rental_studio_p7_sqlite_constraints`: SQLite driver opens, FK enabled per connection, case-insensitive public IDs, invalid money, duplicate active vehicle and historical vehicle deletion refused, state constraint enforced.
3. `rental_studio_p7_sqlite_rollback`: failed synthetic transaction restores both Fleet data and C/R ID counter, no phantom booked rental.
4. `rental_studio_p7_sqlite_restart`: **three separate database connections** across sequential scopes verify booking, persisted exact cents, return/archive, vehicle retirement and historical foreign-key integrity; high-water counter survives reopening.
5. `rental_studio_p7_sqlite_corrupt`: unsupported future schema version is refused; malformed database file is not validated as healthy.

**This source compiled successfully with the Qt6 QSQLITE driver on both hosted Linux and hosted Windows.** It was not compiled or run on the owner's physical Qt 6.10.2 MinGW kit. No physical hardware, release installer, backup policy, data protection or operating-system scale/Narrator assertions are inferred from this.

## 3. What this demonstration does NOT prove

This is a **pre-production storage architecture feasibility test**, not a new durable production backend. No adapter is inserted beneath existing Fleet/Booking/Return controllers; their actual sources and storage paths are unchanged. The experimental QtSql target does **not** cover live general-data migration, crash/power-cut resilience, encrypted backups, customer/phone/legacy licence privacy, multiwriter safe concurrency, legacy 7/13/14-field anomalies, real Windows file permissions or commercial record-retention periods.

Further source-specific limitations: the test deliberately exercises the `issued` counter and retirement persistence, but **not** historical ID reconstruction after all previous high IDs were deleted or unrecorded; the production cutover needs a documented migration high-water policy. It verifies SQL constraints and application-driven lifecycle steps but **does not** encode all legal date/amount and cross-table retirement rules inside DB constraints. A future adapter must validate these commands and commit failure boundaries. It checks `PRAGMA integrity_check` for current tiny synthetic DB and foreign keys but does **not** implement/verify an online backup restore. The test uses invented dates and no real customer fields; it is deliberately not a rental accounting report.

## 4. Next safe increment and owner gates

**P7-C recommended:** an independent **raw-text, read-only migration preflight/anomaly classifier** against generated synthetic 7-, 13- and 14-field files in temporary folders. It should report every line and reject malformed UTF-8, duplicate/colliding IDs, missing actual return dates, 14-field licence presence, orphan history, overlapping active rentals, money mismatch and overflows **without logging source PII, rewriting records, or creating general import access**. This must remain test-only and not infer operator-approved privacy treatment.

**Before any P7 adapter/application storage switch**, explicit owner decisions remain pending: SQLite selection, price bounds/cent conversion and historical total reconciliation, never-reuse ID policy on legacy import, vehicle retirement/history retention, sensitive customer and licence handling, app-local root/backups/encryption, and eight P7 rubric approval. Do not merge draft PR stack or enable any real personal data.

**Formal acceptance frozen:** P7 **0/8**, P6 **0/9**, P5 **0/8**, programme **28/74 accepted**, **40.6% evidence-weighted**. The P7-B technical PASS is not formal P7 acceptance or evidence of release readiness. Subsequent documentation-only head hashes are not substitutes for this exact source/run evidence.
