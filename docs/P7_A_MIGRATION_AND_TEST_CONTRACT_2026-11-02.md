# P7-A | Candidate P7 verification matrix and decision ledger

**Prepared:** 2 November 2026. **Not a formal rubric.** The [programme matrix](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) says P7 is **"Stable IDs, money, storage, backup/migration hardening"**, weight **9%**, **eight** acceptance units, but does **not** individually name them. These are candidate groupings for future owner ratification, not eight new approved requirements. All formal P7 acceptance remains **0/8**.

## 1. Provisional eight criteria, with explicit negative tests

| Candidate | Scope and strict synthetic-only test plan | Evidence necessary for a later PASS |
|---|---|---|
| **P7-01** | Immutable and nonreusable C/M/R public IDs, case-insensitive uniqueness, gap/deletion/retirement and cross-process interleaving | Independent create/delete/restart, collision, high-water and counter rollback tests |
| **P7-02** | Exact integer-cent money and overflow/decimal validation; mismatch between legacy booked total and rate×days | Commutative exact-cent quote tests, cents roundtrip, bounds, malformed decimal, overflow and migration anomaly refusal |
| **P7-03** | Versioned schema, exact state constraints, relational FK and one active booking per vehicle | New schema creation/integrity checks, invalid FK/state/overlap rejected, concurrent booking refusal, future schema read-only refusal |
| **P7-04** | One transaction across ID allocation, booking/return/archive and occupancy reconstruction; no optimistic receipt | Actual rollback and rejected COMMIT, disk-full/locked/driver-error injection, independent restart; rollback must leave exact counts and IDs |
| **P7-05** | Non-destructive vehicle RETIRED state and historical reference policy; archived contract not silently hard-deleted | Retired vehicle retains links, unavailable for new booking, historical read works, failed retirement rolls back, owner approves retention |
| **P7-06** | Backup and tested restore of versioned data with integrity/foreign-key checks | Backup while another read is active; checksum, restore into clean isolated directory, verify counts and money, damaged backup refused |
| **P7-07** | Explicit read-only inventory and fail-closed, owner-gated legacy 7/13/14-column import without silent data loss | Malformed/duplicate, 14-field licence, no actual return date, orphan history, conflict-active, masked PII, CRLF, invalid amount; zero source writes and reconciliation report |
| **P7-08** | Offline local app storage location, single-writer/locked-process safety, app-version compatibility, privacy and rollback/cutover | Windows Qt6.10.2 MinGW owner acceptance, cross-process busy/lock denial, alternate DB path refusal, no real data until privacy/retention decision |

**All eight rows currently: PROPOSED, NOT RATIFIED, NOT IMPLEMENTED, NOT ACCEPTED.** Source P6 scope remains the original synthetic app. Do not relabel existing P5/P6 tests as P7 proofs.

## 2. Staged work with clearly bounded risk

- **P7-A (this turn, docs-only):** source audit, proposed SQLite ADR, candidate tests, legacy anomaly taxonomy. State: **COMPLETED SOURCE RESEARCH; NO TECHNICAL P7 GATE PASSED**.
- **P7-B proposed:** add a **test-only** SQLite repository prototype in a separate, unmerged branch or `tests/p7_sandbox` target OFF by default, with an entirely generated fictional dataset and OS-temporary root. No Qt Quick runtime wiring; require QSQLITE availability on Linux/MSVC/MinGW. Check foreign keys and rollback, int64 cents, issued ID counters; test corrupted and duplicate rows. P7-B is not commercial storage activation.
- **P7-C proposed:** independent raw-text legacy read-only analyser using synthetic 7/13/14-field samples and explicit anomaly manifest, no implicit import.
- **P7-D proposed:** adapter integration only after owner architecture/retention/PII decisions and passing sandbox proof, preserve prior P5/P6 tests.
- **P7-E and later:** backup, restore, failure injection, real Windows Qt kit acceptance, constrained user-initiated migration and P7 acceptance review. Release gated to P8/P9.

## 3. Owner decision register, intentionally unresolved

| Decision | Proposed default | Owner status | Blocked until decided |
|---|---|---|---|
| Storage engine | SQLite QSQLITE, single local offline store | **PENDING** | Production adapter/cutover |
| Monetary policy | Exact int64 cents and owner-approved price limits | **PENDING** | Commercial rates and historical anomalies |
| Vehicle lifecycle | Retire instead of permanent delete, maintain rental reference | **PENDING** | Commercial Fleet deletion/retention |
| Rental history | Archive read-only; hard delete not automatically allowed | **PENDING** | Retention/deletion and privacy |
| Customer/contact and old licence | Strict minimization, no legacy licence auto-import, no PII QML role | **PENDING** | Real booking/import/storage |
| Store root and backups | App-local, backup API, explicit restore and restrictive permissions | **PENDING** | Portable installer and protected local records |
| Migration | Offline explicit preflight, all-or-nothing staged copy, fail closed | **PENDING** | User file import UI |
| P7 candidate rubric | Provisional eight rows only | **PENDING** | Formal P7 acceptance count |

## 4. Guardrail and check gate

Any follow-on change claiming SQLite support must pass **both** core C++ and real Qt Quick native regression suites at the **same exact source SHA**, not a docs-only follow-up SHA; preserve the existing 3-process synthetic P6-M proof and identity of original demo fixtures. No real contacts, arbitrary `--data-dir`, payments, external/cloud storage, auto-migration, Qt Quick SQL or root `main` merges. Mark synthetic tests PASS only when real logs prove it.

**Current score:** P7 **0/8**, P6 **0/9**, P5 **0/8**, programme **28/74 accepted; weighted 40.6% unchanged**. Physical Windows 100%, 125%, 150% scale, Narrator and final owner acceptance still NOT TESTED.
