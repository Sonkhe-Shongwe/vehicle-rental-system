# P7-M | Fail-closed historical return-date reads

**2 November 2026. Exact source:** [`9d8a063`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9d8a063c78ce0a5d5ab0d7d742e98535334c80c5). This code changes **only** the OFF-by-default generated-fictional SQLite candidate in `src/application/p7_sandbox`. It neither changes normal Qt Quick QSaveFile business storage nor authorizes real/customer data.

## Actual defect

The v1 synthetic normalized SQLite table requires `actual_date IS NOT NULL` for RETURNED/ARCHIVED records, but does **not** enforce `actual_date >= start_date` in its SQL CHECK. The C++ typed read path `Repository::rentalRows()` checked presence, well-formed dates and rate*days agreement, but not actual return chronology. A database changed by another tool could pass `PRAGMA integrity_check` while exposing a logically impossible returned/archived contract in the shared Rentals model or Fleet occupancy projection.

## Implemented correction

- The typed SQLite read rejects the entire collection if an actual return date precedes the start date. Future *legitimate* returns beyond expected due dates remain supported.
- The combined `fleetRows()` read already fails closed if its rental collection is invalid, so this guards **both** Rentals and Fleet presentation without partial publication.
- A new fixed generated-fictional native `invalid_return_date` scenario first books and returns R001 correctly, then uses a separate SQLite connection to inject an actual date one day before start. It verifies that SQLite structural integrity can remain OK but **both** typed rental and combined Fleet reads return no verified snapshot.
- No SQL schema rewrite, silent repair, auto-migration, production import, file permission or contact handling was introduced. Existing business transactions, counters, return/archive rules and tests remain intact.

## Exact-source CI evidence

- [Core C++ job](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41483914359): 13/13 PASS on Linux.
- [Native Qt 6.8.3 workflow](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41483914095): Linux GCC and hosted Windows MSVC, both **113/113 PASS**; new CTest `rental_studio_p7_normalized_invalid_return_date`. Windows PowerShell 7/5.1 packaged checks PASS.

## Boundaries

Native CTest does not replace owner Qt Creator 6.10.2 MinGW, actual monitor 100/125/150% scaling, Narrator, physical keyboard review or security/privacy authorization. This patch protects only the candidate read path and does not make SQLite a commercial runtime. [P7 owner decision brief](P7_OWNER_DECISION_BRIEF_2026-11-02.md) remains **proposed and unapproved**. Historical storage ADR and acceptance matrix remain authoritative.

Formal score **unchanged**: 28/74, 40.6% weighted; P5 0/8, P6 0/9, P7 0/8; P8/P9 not started. All draft PRs remain unmerged; main untouched.
