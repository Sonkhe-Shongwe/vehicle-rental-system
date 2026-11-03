# P7-H | Normalized C++ SQLite repository, test-gated and native-verified

**Date:** 2 November 2026. **Exactly verified source:** [`74fb9b3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/74fb9b39086215390dabe32ce4c422d5bffb6285). **Status:** off-by-default, generated-fictional C++ repository **engineering candidate**, not owner-ratified business storage or Qt Quick runtime integration. The original protected fictional text app remains unchanged. No real customer records, SQLite production cutover, merge or release.

## 1. What changed in product architecture

- A reusable typed **header-only C++ repository** now lives at `src/application/p7_sandbox/sqlite_repository.h`. This is the first normalized storage code placed under `src/application`, rather than opaque legacy text blobs in `tests/p7_sandbox/p7_domain_bridge_tests.cpp`.
- Still compiled exclusively by `rental_studio_p7_normalized_repository` under `tests/p7_sandbox/CMakeLists.txt`, which is included **only when `BUILD_P7_SQLITE_SANDBOX` is explicitly ON**. The Qt Quick `RentalStudioP2Review` and existing `RentalSystem`/QSaveFile are unaffected and do not link QtSql.
- Three normalized SQLite tables: `counters(kind, next_id)` for transactional C/M/R issued-ID high-water, `vehicles` with kind/brand/model/specification/exact int64 `rate_cents` and `ACTIVE|RETIRED` state, and `rentals` with immutable vehicle FK, ISO dates, 1–365 days, daily/total `int64 cents`, `ACTIVE|RETURNED|ARCHIVED` state and partial uniqueness of one active rental per vehicle. **No customer name, contact, driver's licence or real personal data fields** exist in the candidate schema.
- The external entry-point is a typed C++ `Repository` with `vehicle`, `quote`, `book`, `returnRental`, `archive`, `retire` and read-only count/lookup. Every mutation uses **`BEGIN IMMEDIATE` → bound SQL → `COMMIT`**, with `ROLLBACK` if a statement or commit fails. A rental booking rechecks occupancy, current cents and duration **inside its immediate transaction**, and publishes its rental ID **only after successful COMMIT**. A rejected transaction does not consume its identifier counter.
- Both foreign-key enforcement (`PRAGMA foreign_keys=ON`) and future-schema refusal (`PRAGMA user_version=1`) are explicitly checked. Tests only create generated temporary SQLite under a unique OS temp directory and an exact `.fictional-only` marker; they accept no user-selected file path. SQL values are bound. No import, migration or backup endpoint is created.
- The original [P7-G actual `RentalSystem` and `RentalConfirmService` integration proof](P7_G_CPP_DOMAIN_SQLITE_TRANSPORT_NATIVE_VERIFIED_2026-11-02.md) is **separate**: it demonstrates the existing C++ storage seam using an opaque synthetic blob transport. P7-H demonstrates an actual normalized candidate repository. **Neither proves that the current Qt Quick booking controller is wired into P7-H**. Such integration requires owner-approved storage, contact and migration policy.

## 2. Exact native test evidence

| New CTest | Source-grounded validation |
|---|---|
| `rental_studio_p7_normalized_lifecycle` (#104) | Fictional C001 at 45000 cents/day; 3-day quote 135000 cents; R001 committed, active duplicate refused, rented vehicle retirement refused; independent SQLite reopen; return, archive, then non-destructive retirement, historic rental preserved after second reopen |
| `rental_studio_p7_normalized_rollback` (#105) | Test-induced rejection **just before COMMIT** after tentative DML, not claimed to simulate disk failure: no receipt/row/high-water change, retry succeeds with R001; failed archive rolls back then succeeds on retry |
| `rental_studio_p7_normalized_money_ids` (#106) | Strict decimal grammar, int64 overflow/zero/bad syntax denial; invalid new vehicle/stale booking quote consume no C/R ID; new C002 survives reopen with counter C003 next |
| `rental_studio_p7_normalized_future_schema` (#107) | Simulated SQLite v2 schema refuses opening/mutation in old v1 candidate |
| `rental_studio_p7_normalized_contention` (#108) | Separate SQLite writer holds `BEGIN IMMEDIATE`; attempt fails without advancing C counter; successful retry after lock release |

**Exact source passed:**
- [C++/core run **13/13**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622337)
- [Native Qt 6.8.3 Linux GCC **108/108** and hosted Windows MSVC **108/108**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622338)
- Hosted Windows packaged PowerShell 7 and 5.1 checks also PASS. Existing P5/P6 UI and prior P7-B…G tests included. Tests #104–108 individually passed in both native logs. This is hosted Windows, not the owner's physical Qt Creator **6.10.2 MinGW**, Narrator or 100/125/150% OS-scale evidence.

## 3. Remaining architectural limitations and decisions

1. **Commercial SQLite activation not approved.** P7-H must **not** silently replace the currently working C++ `RentalSystem`/QSaveFile runtime or become a general local database importer.
2. **Money business caps not ratified:** exact int64 cents and overflow are mechanical proofs, not an agreed business maximum or settlement/payment design. Existing Qt Quick display still uses legacy double until separately migrated.
3. **ID policy provisional:** counters demonstrate durable C/M/R IDs in a synthetic database, but legacy deleted IDs/opaque historical high-water, human-readable formatting and approved import IDs require owner policy.
4. **Retirement/retention provisional:** history-preserving `RETIRED` is a candidate; actual rental retention, de-identification and legal constraints remain under owner review.
5. **Contact/privacy unresolved:** candidate P7-H intentionally has no customer PII; this does not solve authorized customer-contact use, access/retention, backup security or the old 14-field licence policy. Do not infer a commercial product can operate without a lawful contact workflow.
6. **Cutover and real integration open:** no live Qt Quick controller using P7-H, no real migration, no production backup/restore, physical Windows kit approval, P7 eight-row rubric ratification or P8/P9 release. The app's existing text-ledger source remains fully protected.
7. **Test scope bounded:** the test-only COMMIT rejection is deterministic, not proof of physical power loss, disk-full behavior or cryptographic resilience. Earlier P7-F covers selected process crash/lock conditions separately; no single test suite establishes production recoverability.

## 4. Next practical milestone

Before another infrastructure expansion, obtain a **consolidated owner decision** on the [P7-A storage ADR](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md): SQLite strategy, exact money limits, C/M/R lifetime, retirement/archive, customer/contact/licence privacy and retention, local path + backup/migration rules. Then integrate a typed repository at the application command/read boundary in a **separate off-by-default, fictional-only runtime experiment** before any commercial activation. Keep the P5/P6/P4 owner device testing batched into one future manual acceptance session.

**Formal ledger unchanged:** P5 0/8, P6 0/9, P7 0/8; total 28/74 accepted and weighted evidence progress 40.6%. This is not the code completion percentage or commercial-readiness measurement. Draft #17 unmerged, main untouched.
