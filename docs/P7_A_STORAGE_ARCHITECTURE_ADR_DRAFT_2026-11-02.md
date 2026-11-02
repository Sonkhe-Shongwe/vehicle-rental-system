# P7-A | Commercial storage architecture ADR, DRAFT / NO IMPLEMENTATION AUTHORIZATION

**Date:** 2 November 2026. **Decision state:** **PROPOSED / OWNER APPROVAL REQUIRED**. Existing Rental Studio remains strictly **fictional-only**. Source evidence: [P7-A hazards](P7_A_SOURCE_STORAGE_AND_MIGRATION_RISK_AUDIT_2026-11-02.md); existing [P6-M native 3-process evidence](P6_M_THREE_PROCESS_INTEGRATED_NATIVE_VERIFIED_2026-11-02.md); [final product spec draft](RENTAL_STUDIO_FINAL_PRODUCT_SPEC_DRAFT_2026-11-01.md). This ADR does not switch storage, enable any real record or add QtSql to the build.

## 1. Target and recommendation

**Candidate choice: local SQLite via Qt SQL / QSQLITE**, behind a narrowly typed C++ repository/UoW adapter, for a single-operator offline Windows desktop application. **Not accepted yet.** Reasons: one local transactional ledger across Fleet and Rentals; well-supported constraint, backup and integrity APIs; no database server; Qt's SQLite SQL driver fits the existing toolchain. Do not infer a cloud service, login, payments, multiuser synchronization or production file import.

**Alternatives considered:**

| Option | Advantage | Main tradeoff | Status |
|---|---|---|---|
| Two existing text files, independent QSaveFile | No new dependency; preserves old code | No atomic joint Fleet/rental state, versioned migration or constraint engine; ID reuse must be solved externally | Retain **only as historical and protected fictional demo** |
| Custom JSON plus journal/event log | Human-readable, schema extensible | Significant bespoke transactional, recovery and backup complexity; more bug surface than the domain requires | Not preferred |
| **SQLite single local database** | ACID transactions, indexed stable IDs, FK/unique constraints, backup/integrity facilities, Qt 6 driver | Need explicit schema/migration, lock handling, OS permissions, contact policy, packaging and crash testing | **Preferred PROPOSAL** pending decision |

**External technology references, checked 2 Nov 2026:** [SQLite FK documentation](https://www.sqlite.org/foreignkeys.html) requires per-connection explicit `PRAGMA foreign_keys=ON`; [SQLite transaction semantics](https://www.sqlite.org/lang_transaction.html) describes `BEGIN IMMEDIATE` and `SQLITE_BUSY`; [SQLite Backup API](https://www.sqlite.org/backup.html) describes consistent online snapshots; [SQLite PRAGMA integrity/foreign_key_check](https://www.sqlite.org/pragma.html) are distinct; [Qt6 QSQLITE driver](https://doc.qt.io/qt-6.8/sql-driver.html) and [Qt SQL transactions](https://doc.qt.io/qt-6/qsqldatabase.html) support the adapter approach. Pin to actual Qt **6.8.3 hosted and Qt Creator 6.10.2 MinGW owner kit**, verify bundled plugin/runtime before selecting implementation; no assumption from docs alone that the exact app is already linked to QtSql.

## 2. Architectural seam and invariant rules

```text
Qt Quick / QML (presentation, no SQL or contact bypass)
  → Typed application command / read services
    → Domain validation (Vehicle, Car, Motorcycle, Rental lifecycle)
      → IUnitOfWork / repository adapter (PROPOSED)
         ├─ current protected legacy text RentalStorage (demo unchanged)
         └─ future approved P7 isolated SQLite adapter (NOT REGISTERED IN RUNTIME)
```

A production adapter must make **one authoritative commit** encompass allocation of new ID, vehicle active validation, rental insert, history event (if authorized), and any necessary version counters. Read models refresh **only after COMMIT succeeds**; no optimistic receipt, no QML-owned availability decision. A failed COMMIT/constraint/restart must not leave a C++ success notice or half-updated Overview. Keep the existing invariant **at most one active rental per vehicle** at the DB layer. Vehicle occupancy is derived from the authoritative active rental query, not a separately writable rented flag that can drift. Return `actual_return_date` must not precede start or be future; archive only returned; retirement cannot lose historical references. Creation must remain same-day 1–365 rental days unless separately approved.

**Single operator:** one app-owner connection/writer strategy with explicit busy response, begin/write/commit/rollback, not silent retry or lock deletion. A `QLockFile` may supplement DB coordination but cannot substitute for SQLite locking. Never force-delete potentially live locks; test independent process contention. No arbitrary open/import paths in current P2/P5/P6 UI. `QStandardPaths::AppLocalDataLocation` is a **candidate P7 location** in the future, with directory identity, permissions and safe overwrite-denial checks. No real data store is created by this ADR.

## 3. Candidate schema contract, **illustrative**, not executable migration

- `schema_metadata`: explicit schema version, install/storage identity, migration provenance, created-at. Enforce version compatibility before any writes. Refuse newer schemas on older binaries.
- `id_counters` or `issued_identifiers`: three monotonically nondecreasing C/M/R ID sequences, allocated **within the same transaction as business insert**. Import every historical issued ID, including retired/deleted ones where reconstructable. **If past deleted IDs are unknowable, flag the limitation and owner must choose an initial namespace/high-water policy.** Current `max(existing)+1` is not sufficient.
- `vehicles`: immutable public ID with case-folded uniqueness; known type `Car|Motorcycle`; brand/model; strictly positive `daily_rate_cents` (signed int64 within approved upper limit); doors or engine cc with type-specific constraint; `operational_state=ACTIVE|RETIRED`, optional retirement timestamp/reason. A vehicle can be RETIRED and still referenced historically. **Do not auto-delete when referencing rental exists**.
- `rentals`: immutable rental ID; vehicle FK `ON DELETE RESTRICT`; ISO start/expected/nullable actual dates; rental days 1–365; `daily_rate_cents` immutable booking price snapshot and `total_cents` immutable quote total; state `ACTIVE|RETURNED|ARCHIVED`; migration anomaly provenance when applicable. Status transitions must satisfy domain rules; use a partial uniqueness guard on `vehicle_id` for **ACTIVE** contracts.
- `rental_events` **candidate** append-only audit: event kind, rental/vehicle ID, UTC timestamp and transaction correlation; distinguish a real return/archive timestamp recorded later from the historic contract `startDate`. This is new proposed history, **not** proof that existing P6-J has an event stream. Decide retention/clock semantics before implementation.
- **Customer/contact data not decided:** in the real app booking already expects a customer name/phone in legacy text. A production database cannot be approved until field purpose, access, display, retention, backup encryption, deletion and migration treatment are approved. A separately permissioned contact table is an architectural *option*, not an authorization or promise to import licence/phone fields. No staging of identifiable real records in test databases.
- **Legacy missing historical vehicle:** do not simply discard returned/orphan rows. Owner must choose a documented, nonfabricated retired placeholder policy or explicit migration-block/manual reconciliation. A required FK means an unknown vehicle cannot silently be referenced.

Schema checks must include positive int64 money, duration/date consistency verified in C++ and SQLite where practical, known lifecycle states, case-normalized public IDs, foreign keys, and a uniqueness constraint for active occupancy. Never put raw PII into trace logs, screenshots, test failure hashes that could be trivially reversed or preview tables.

## 4. Decimal cents and ID migration policy

**Money conversion:** Take the raw decimal field from 7/13/14-field text, not `double` reconstructed by `RentalSystem`. Parse with strict ASCII grammar `^[0-9]+\\.[0-9]{2}$` (for *legacy* strings; a separately approved display parser may accept other input). Compute `cents = major*100 + twoDecimalDigits` in checked signed 64-bit arithmetic; require `cents>0` and cap prices/totals to business-approved bounds before import. Multiply `daily_rate_cents * days` with overflow checks. A mismatch with serialized `total` becomes **REVIEW_NEEDED**, not an automatic edit. On historical rounding anomalies, the real legally documented contract total may take precedence only by explicit approved reconciliation, never by silent recomputation.

**ID allocation:** Preserve the literal case-insensitive C/M/R public IDs on accepted import, normalize for unique lookup and reject colliding source records. On new booking allocate from durable counter/table transaction, never reuse deleted high IDs. Imported IDs with unusual widths/format require an explicit mapping report, immutable original display ID and retained cross-reference; no silent renumbering. A unique DB constraint alone prevents *current* duplicates but **does not prevent reuse after hard deletion**, thus keep issued-ID history/high-water separately.

## 5. Import and cutover: fail closed, two-phase

1. **Inspect only:** explicit user-chosen location after approval; identify and hash exact legacy file bytes, metadata and access permissions without altering source. Do not reuse the permissive legacy loader; independently parse every line and report 7/13/14-field cases, invalid UTF-8, CRLF/LF, empty records, duplicate or colliding IDs, missing referenced vehicles, missing actual dates, legacy driver licences, inconsistent amounts, overlapping active rentals and overlong fields. Report line number/issue code and masked provenance, **never log contact content**.
2. **Review and backup:** the user receives a totals/anomaly report; require **zero unresolved fatal anomalies**, a verified source backup, owner-approved handling of each review-needed case and a deliberate record-retention/contact decision. No "automatically repair" toggle.
3. **Stage into a new database in a separate temporary directory:** versioned schema, transaction; zero unapproved data loss and no source mutation. Run `PRAGMA integrity_check` **and** `PRAGMA foreign_key_check`, count and amount reconciliation, active-occupancy consistency and ID high-water verification. Keep staging isolated, with no live app connected.
4. **Commit to new app-local storage only after approval and full validation:** close handles, ensure no active conflicting writer, atomic filesystem placement using a defined platform strategy, restore/backup path and rollback procedure. First launch is explicitly **not** an automatic import. For a failed cutover, the previous store remains untouched and the app refuses to proceed with incomplete staging.
5. **Reopen independently:** verify exact schema version and counts, sample IDs, active/returned/archived, old licence-case disposition, date anomalies, money, backup restore and independent process crash recovery. **Never delete the original files after a successful import as an automatic cleanup.**

**Disaster recovery:** a versioned, independently readable backup snapshot using the verified SQLite Online Backup API or a proven consistent `VACUUM INTO` strategy, with retention, restore-to-new-directory, integrity checks and a controlled reactivation decision. Do not assume copying only the main `.db` while WAL mode is active is safe. The selected journal mode, durability policy, checkpoint/backup handling and disk-full behavior must be tested on Windows. Local storage != encrypted storage: encryption-at-rest, device access, backup encryption and PII handling are explicitly unapproved decisions.

## 6. Boundary and signoff

This ADR is **not** a production feature requirement approval, commercial-legal interpretation, personal-data processing authorization or formal P7 criterion acceptance. Next safe engineering increment, **P7-B**, is an **independently built synthetic-only repository/storage spike** behind a new test-only target, with Qt6 QSQLITE plugin availability verified and representative transaction/constraint/restore tests; NOT wired into the working QML runtime, not using arbitrary imported files, and not replacing the protected fixed fictional session. Proceed incrementally only with explicit architecture approval when production-directed behavior is implicated.

**Owner choices still OPEN:** (1) SQLite vs remain on text vs alternate; (2) vehicle retirement and rental history/data retention; (3) contact/legacy licence privacy/retention policy; (4) path/backup/encryption/restore model; (5) 8 P7 criterion interpretation and release signoff. **P7 0/8 formal, P6 0/9, total programme 28/74 accepted, weighted 40.6% unchanged.**
