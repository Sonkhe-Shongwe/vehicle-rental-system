# P7-Q | Fictional SQLite Fleet search in actual Qt Quick Lab

**Final P7-Q verified source:** [260794b](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/260794bdc33dd4d3807dc9e953527ad4732a8ee9), 2 November 2026. Automated native verification complete, owner acceptance still pending.

## Bounded source change

- `FictionalFleetSnapshot` now exposes a C++-owned, maximum-80-character `searchText` query. Verified, value-only vehicle IDs, display name, type and details are case-insensitive search fields. Search and All/Available/Unavailable status filters are conjunctive.
- A search change clears any selected vehicle no longer present in the visible result. Hidden or invalid vehicle IDs cannot be selected through `selectById`. Initial full verified Fleet snapshot and authoritative total/available metrics do not change.
- The actual opt-in fourth `P7FictionalSqlLab.qml` includes a labelled Fleet search `TextField`, with a larger record-explorer area. No SQL, data mutation, arbitrary file access, customer/contact fields or paid booking operations were added.
- Both previously existing real-application wide/compact native scenarios have new assertions for an unmatched query, no stale selection, invalid hidden-ID refusal, a mixed-case Corolla query restoring the right record and read-failure/retry while the query remains active. The test count is not increased.

## Exact-source test status

- **Core:** [run 41504648730](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41504648730), Linux C++ **13/13 PASS**, confirmed from test job logs at final source `260794b`.
- **Native Qt 6.8.3:** [P7-Q final run 41504648806](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41504648806), **115/115 PASS each on Linux GCC and hosted Windows MSVC** at exact final source `260794b`. Packaged Windows P4 PowerShell 7/5.1 checks PASS; not physical owner signoff.
- **Earlier native verified baseline:** [P7-P source `31d1ce3`](P7_P_SQLITE_LAB_RECORD_EXPLORER_NATIVE_VERIFIED_2026-11-02.md): 115/115 each Linux and Windows, not evidence for this later search implementation.

## Authorization and remaining gates

D1 remains limited to generated-fictional opt-in SQLite integration. Main Overview/Fleet/Rentals remain protected fictional QSaveFile, and `BUILD_P7_SQLITE_SANDBOX` remains OFF by default. No D2–D8 commercial privacy, rates, ID, retention, backup, migration or acceptance decision is inferred. No physical Windows Qt Creator 6.10.2 MinGW, OS scaling, Narrator or owner acceptance performed. P5 0/8, P6 0/9, P7 0/8 and 28/74 overall accepted, 40.6% evidence-weighted; P8/P9 not started. All PRs remain draft, `main` unchanged.
