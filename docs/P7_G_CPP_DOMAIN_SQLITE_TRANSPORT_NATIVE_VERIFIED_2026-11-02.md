# P7-G | Real C++ domain service to experimental SQLite transport, native verified

**2 November 2026 | Exact compiled source:** [`0990d67`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0990d6741c3500ce8e03a3abfe74e7c799618deb) | **Status: SYNTHETIC TEST-ONLY PROOF, NOT COMMERCIAL SQLITE STORAGE OR PRODUCTION APP INTEGRATION.**

## Why this work is different from earlier SQLite-only feasibility

The current Rental Studio C++ application uses **real** `RentalSystem` for Fleet/Rental business rules, `RentalQuoteService` for an authoritative quote and `RentalConfirmService` for confirmed booking and receipt. The original `RentalSystem` already supports injection of a `RentalStorage` instance for its text-ledger reads and writes. This P7-G experiment uses the **actual business objects and actual C++ command services** with a new strictly-test-only `FictionalSqliteTransport`, verifying their real calls travel through a SQLite connection. P7-B/F tested SQLite constraint/recovery behavior in isolation; P7-G tests **application-domain interoperation**. It is not a relational commercial repository and was **not linked into the Qt Quick executable**.

## Source and isolation

- `tests/p7_sandbox/p7_domain_bridge_tests.cpp`: contains the test-only adapter and test cases, including the actual compiled `rentalsystem.cpp`, `RentalQuoteService`, `RentalConfirmService`, Vehicle/Car/Motorcycle and Rental sources.
- `tests/p7_sandbox/CMakeLists.txt`: three more CTests registered inside the existing **`BUILD_P7_SQLITE_SANDBOX=OFF` by-default** subtree. Normal GUI/legacy executables do not link QtSql or create `fictional.sqlite`.
- Every execution creates a unique `QTemporaryDir` path under the OS temp root and must first create and verify exact `.fictional-only` marker contents. The adapter recognizes **only** `vehicles.txt` and `rentals.txt` logical keys inside this known temp directory. Never exposes a CLI/GUI open-file path, never reads a real user folder or filesystem migration source.
- The database contains two **generated fictional UTF-8 ledger byte blobs** with SHA-256 digests, each updated within its own `BEGIN IMMEDIATE`/COMMIT transaction; this is a **transport prototype** for the existing legacy storage interface, not a proposed commercial database schema. `PRAGMA user_version=1`; new adapters refuse a future version. Customer input is exclusively `Fictional Demo Session` with `0000000000` test contact.
- Changes do not modify `RentalSystem`, `RentalBookingController`, any QML view, Qt Quick build linkage, P5/P6 application behavior or source fixtures. No archived real data or contact export.

## Exactly what passed

| CTest (test only, generated fictional) | Verifies |
|---|---|
| `rental_studio_p7_bridge_booking` | Real 450.00/day Corolla, 3-day C++ quote (1350.00), `RentalConfirmService` returns saved R001 receipt; duplicate refused; closed and reopened independent QSQLITE connection with reconstructed C++ RentalSystem, active occupancy and next visible ID R002 |
| `rental_studio_p7_bridge_lifecycle` | Real C++ book → return → reject second return → archive; after adapter destruction and independent reopen, preserved archived history and available vehicle |
| `rental_studio_p7_bridge_failure` | Test-injected **refused write before transaction** returns `CommitFailed`, no receipt, no in-memory rental/occupancy change, no consumed visible R001 ID and no persisted rental; retry succeeds; future `user_version=2` refused on fresh adapter open |

**Native verification on the exact source:** [Core 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41456877624), [Qt 6.8.3 Linux GCC **103/103** and hosted Windows MSVC **103/103** PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41456877600). Windows packaged P4 PowerShell 7 and 5.1 checks also PASS. The three new cases are tests **#101–103** in both native logs. The `failure` case does not claim to inject a *SQLite COMMIT failure* or a power cut; prior P7-F handles independent process kill/lock. Qt GUI runs remain on fictional text files.

## Limitations and the actual next product gate

This bridge **does not** resolve eight open P7 commercial requirements: (1) permanent nonreusable ID policy, (2) exact bounded int64 cents and legacy rounding adjudication, (3) normalized relational constraints rather than opaque text blobs, (4) true all-field transaction boundary and owner-approved operation semantics, (5) non-destructive vehicle retirement and rental-history retention, (6) secure backup/restore operational permissions, (7) 7/13/14-field customer/licence import/migration consent and issue handling, (8) approved local storage privacy, path and owner physical Windows device. The test adapter is deliberately disposable, with opaque copied fictional bytes, legacy doubles/ID generation and no production privacy/role model. Do **not** mistake `103/103` for commercial readiness or formal P7 acceptance.

**Next useful step:** agree the P7 SQLite ADR and business/storage/privacy decisions with the owner, then implement a domain-facing *normalized, transactionally consistent* repository in the application command layer using generated fictional data first, with commercial activation separately prohibited until explicit owner go-ahead. Avoid endlessly extending isolated infrastructure tests as a substitute for real product integration. Preserve one consolidated manual Windows acceptance milestone rather than repeated screenshots after every commit.

**Unchanged formal program score:** P5 **0/8**, P6 **0/9**, P7 **0/8**, total **28/74** formally accepted, **40.6%** evidence-weighted. Draft PR #17 stacked on Draft P6 #14; both unmerged, `main` untouched, P8/P9 not begun.
