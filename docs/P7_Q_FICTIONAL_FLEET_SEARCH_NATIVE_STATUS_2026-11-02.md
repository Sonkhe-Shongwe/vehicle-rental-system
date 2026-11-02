# P7-Q | Fictional SQLite Fleet search in actual Qt Quick Lab

**Engineering source:** [`6259155671041b40d43d2cb118613680d6890dab`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6259155671041b40d43d2cb118613680d6890dab). **Date:** 2 November 2026. **Status:** Implemented, core regression PASS; native Qt Linux/Windows result PENDING at this checkpoint. This report must not be read as formal owner acceptance.

## Bounded source change

- `FictionalFleetSnapshot` now exposes a C++-owned, maximum-80-character `searchText` query. Verified, value-only vehicle IDs, display name, type and details are case-insensitive search fields. Search and All/Available/Unavailable status filters are conjunctive.
- A search change clears any selected vehicle no longer present in the visible result. Hidden or invalid vehicle IDs cannot be selected through `selectById`. Initial full verified Fleet snapshot and authoritative total/available metrics do not change.
- The actual opt-in fourth `P7FictionalSqlLab.qml` includes a labelled Fleet search `TextField`, with a larger record-explorer area. No SQL, data mutation, arbitrary file access, customer/contact fields or paid booking operations were added.
- Both previously existing real-application wide/compact native scenarios have new assertions for an unmatched query, no stale selection, invalid hidden-ID refusal, a mixed-case Corolla query restoring the right record and read-failure/retry while the query remains active. The test count is not increased.

## Exact-source test status

- **Core:** [run 41503684951](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41503684951), Linux C++ **13/13 PASS**, confirmed from test job logs at source `6259155`.
- **Native Qt 6.8.3:** [run 41503684810](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41503684810), Linux GCC and hosted Windows MSVC: **PENDING** at report creation. Do not inherit the preceding P7-P 115/115 result. Inspect final build and CTest logs and correct any actual failures before declaring P7-Q native verified.
- **Earlier native verified baseline:** [P7-P source `31d1ce3`](P7_P_SQLITE_LAB_RECORD_EXPLORER_NATIVE_VERIFIED_2026-11-02.md): 115/115 each Linux and Windows, not evidence for this later search implementation.

## Authorization and remaining gates

D1 remains limited to generated-fictional opt-in SQLite integration. Main Overview/Fleet/Rentals remain protected fictional QSaveFile, and `BUILD_P7_SQLITE_SANDBOX` remains OFF by default. No D2–D8 commercial privacy, rates, ID, retention, backup, migration or acceptance decision is inferred. No physical Windows Qt Creator 6.10.2 MinGW, OS scaling, Narrator or owner acceptance performed. P5 0/8, P6 0/9, P7 0/8 and 28/74 overall accepted, 40.6% evidence-weighted; P8/P9 not started. All PRs remain draft, `main` unchanged.
