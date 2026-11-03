# P7-C | Generated legacy-record read-only preflight, exact-source verified

**Date:** 2 November 2026 (Africa/Johannesburg). **Source verified:** [`a5bbcaadd05f4afe4c4b94b4db2010fed36972d1`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a5bbcaadd05f4afe4c4b94b4db2010fed36972d1), on `feature/p7-sqlite-sandbox-20261102`, [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) stacked on unmerged P6 [Draft #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14). **This is a Qt Core-only synthetic-data test instrument, not an import command or approved live-data parser.**

## 1. What was added

- Added `tests/p7_sandbox/p7_legacy_preflight_tests.cpp` in the already **OFF-by-default** `BUILD_P7_SQLITE_SANDBOX` test-only target directory; extended `tests/p7_sandbox/CMakeLists.txt` with six named `rental_studio_p7_preflight_*` CTests. The scanner executable itself needs only **Qt6::Core**, is distinct from the P7-B QtSql test executable and is never linked to Qt Widgets or Qt Quick application targets.
- The binary accepts exactly **one fixed test name** (`clean`, `duplicates`, `legacy`, `amounts`, `malformed`, `encoding`). It accepts **no general filename, directory, real text, database or migration argument**.
- The test harness creates only fictional `vehicles.fake.txt` and `rentals.fake.txt` under its own disposable `QTemporaryDir`, reads them via `QIODevice::ReadOnly`, executes source validation, reopens them read-only and compares **original and final complete bytes and SHA256 hashes**. It does not read any repository `demo/*.txt` or fixed P5 session files.
- Validation operates on **raw bytes**, not on the permissive `RentalSystem::loadVehiclesFromFile` / `loadRentalsFromFile` snapshots. Both clean LF and Windows CRLF are accepted without rewriting, while invalid UTF-8, NUL/control bytes, odd CR, blank extra record and excessive size/line length are flagged. If raw framing is unsafe, it refuses to reconcile a partial parsed dataset.
- Original 7-field Car/Motorcycle vehicle format and 13-field newer / 14-field older rental formats are recognized. The older driver's-licence column always emits `LEGACY_LICENCE_REVIEW` and is **never printed, copied to a database or accepted for automatic import**.
- The report is structured as source kind (`vehicles` / `rentals`), **1-based line number** and **fixed issue code**, with summary counts only. It never writes customer, phone, licence, complete row content, raw IDs or actual user paths into diagnostics. Every issue makes `eligible()==false`; the preflight does **not** automatically fix or migrate even one row.
- Cross-file checks flag duplicate C/M/R identifiers ignoring case, invalid/unparseable date, duration/date mismatch, returned contract with unknown actual-return date, an actual return before start, archive without prior return, orphan active/historical vehicle references and two simultaneously active contracts on one vehicle. Money checks parse **strict ASCII two-decimal** into checked `qint64` cents, refuse invalid/overflowed values and distinguish rate × duration total disagreements.
- Current legacy vehicle rented bit is **not** taken as an independent occupancy authority. The active rental ledger is the source of occupancy, consistent with the P6-M independently reopened operator test.

## 2. Actual test evidence at exact implementation source

| Gate | Verified outcome |
|---|---|
| [C++ legacy/core CI 41404424637](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41404424637) | **13/13 PASS**, default P7 sandbox still OFF |
| [Native Qt6.8.3 Linux GCC 41404424477](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41404424477) | **85/85 PASS**, new six cases test #80-85 all PASS, prior 79 P5/P6/P7-B tests retained |
| [Native Qt6.8.3 hosted Windows MSVC 41404424477](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41404424477) | **85/85 PASS**, same six new cases test #80-85 all PASS |
| Hosted Windows relocated Qt packaging | P2 packaged checks and P4 PowerShell **7 and 5.1 PASS**; actual owner MinGW and physical 100/125/150% display / Narrator **NOT TESTED** |

### Six precise P7-C case groups

| Name | Verified synthetic examples |
|---|---|
| `rental_studio_p7_preflight_clean` | Correct fictional 7-field Fleet and 13-field active+returned records, exact amounts, counts and ISO dates, **LF and CRLF accepted**, scanner eligible and source bytes unchanged |
| `rental_studio_p7_preflight_duplicates` | Case-insensitive duplicate Fleet and rental IDs; overlapping active rental for the same vehicle; migration eligibility refused |
| `rental_studio_p7_preflight_legacy` | 14-field historical driver's-licence presence, returned rental with **missing actual return date**, active and returned records pointing to missing vehicles; all flagged; no fictional licence text disclosed |
| `rental_studio_p7_preflight_amounts` | Rate × days differs from booked total, inconsistent expected-return date vs duration, excessive decimal amount rejected before int64 conversion |
| `rental_studio_p7_preflight_malformed` | Unknown vehicle kind, invalid flags/specification, archived-but-active invalid state and wrong rental field count |
| `rental_studio_p7_preflight_encoding` | Invalid UTF-8, embedded NUL and a blank data row refused; all fixture bytes and hashes unchanged |

The 85 native tests include the preceding 74 P5/P6 native tests, five P7-B QSQLITE tests and six P7-C Core-only preflight tests, **at the same checked source SHA**. No tests were skipped or marked passing based on a documentation-only commit.

## 3. Important non-claims and remaining hazards

This preflight is deliberately a **bounded characterization**, not a trustworthy general file importer. It cannot be used from the product UI, cannot open arbitrary files, and has no route to create or update SQLite tables. It does not guarantee coverage for every possible legacy file anomaly, encoding variant, Unicode normalization, historical identity reuse after deleted records, legitimate owner-approved rounding exception, all contact-field privacy rules or legally approved retention periods. It does not audit actual customer files, provide a backup, export a redacted machine-readable import manifest or prove crash-safe cutover.

Most importantly, flagged `MISSING_ACTUAL_RETURN` does **not** authorize inventing an actual date from the expected date, and `LEGACY_LICENCE_REVIEW` does **not** authorize storing older driver's-licence data. `ORPHAN_HISTORY` requires an approved identity/retirement resolution, not an invented car record. Migration of identifiable records remains **strictly disabled**.

**Next safe increment P7-D (candidate only):** extend generated-only preflight into an immutable, **machine-readable issue-code report with line provenance and deterministic reconciliation totals**, test synthetic mutations/double-active history and exact no-write behavior, or research a backup/restore prototype. A runtime SQLite cutover, general-purpose file picker and real personal-data migration are **not** authorized without owner choice of SQLite, stable-ID policy, money bounds, retirement, contact privacy and backups.

**Formal acceptance unchanged:** P7 **0/8**, P6 **0/9**, P5 **0/8**, programme **28/74 accepted** and **40.6% evidence-weighted**. P7-C technical PASS is not formal P7 signoff, physical Qt Creator acceptance or commercial release readiness. Draft PRs #17, #14, #12 and #10 remain unmerged; stable `main` untouched.
