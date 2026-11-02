# Rental Studio 2.0 | Canonical current product state

**Reconciled 2 November 2026.** GitHub live state outranks this dated snapshot. [Latest checkpoint](LATEST_CHECKPOINT.md), [full 2 Nov audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md), [programme ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md), [source-level P7-H report](P7_H_NORMALIZED_SQLITE_REPOSITORY_NATIVE_VERIFIED_2026-11-02.md).

## Product definition and visual direction

Offline-first Windows vehicle-rental desktop application, rental-business rules owned by C++ and user interface in Qt Quick/QML. Owner-selected palette is Midnight Navy #17324D, Emerald Teal #0F766E, Cloud White #F6F8FA, Ice Blue #EAF0F4 and Soft Mint #E8F5F0. Overview is operational, Fleet manages Gallery/Table/Inspector and current occupancy, Rentals provides a guided quote and explicit confirmed fictional booking, return, history and archive. **Active booked contract value is not cash received.** Generic original vehicle silhouette illustrations are not licensed/model-matched vehicle photographs; final brand/imagery and whole-product design signoff remain open.

## Repository and authority

Public repo [Sonkhe-Shongwe/vehicle-rental-system](https://github.com/Sonkhe-Shongwe/vehicle-rental-system). Stable **main** was not changed by this development work. Active branch at audit start feature/p7-sqlite-sandbox-20261102, draft [#17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) stacked on draft [#14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), [#12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12), [#10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10). Latest **compiled** P7-H code [74fb9b3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/74fb9b39086215390dabe32ce4c422d5bffb6285), with subsequent docs-only head 4e46dd5 before this audit. Check actual heads, no inferred merge or signoff.

## Real implementation, clearly separated

**Current Qt Quick fictional application:** verified Overview/Fleet/Rentals C++-owned snapshot and commands, typed quote and explicit persistence confirmation, stale quote/duplicate/no-write guards, Fleet add/remove under disposable fiction, return/archive/history, independent process restart and compact/wide layouts. P6-P polished presentation uses generic originally authored vehicle silhouettes. Workspaces use domain-generated temporary or protected pinned fictional text files: the existing RentalSystem and QSaveFile storage still have two independent files, double monetary representation and max-existing-ID risks. They are not approved for live business records.

**P7 candidate, not activated:** P7-G proves existing domain service calls over fictional SQLite blob transport; P7-H proves a separate normalized typed SQLite repository; [P7-I](P7_I_QTQUICK_NORMALIZED_REPOSITORY_PREVIEW_NATIVE_VERIFIED_2026-11-02.md) proves real opt-in QML buttons and normalized SQL commands; [P7-J shared read-model verification](P7_J_SHARED_RENTALS_READ_MODEL_QT_SQL_NATIVE_VERIFIED_2026-11-02.md) reuses the **existing RentalListModel** and value-only Fleet/Rental summary contracts for fictional SQL snapshots, with post-commit model refresh. The normal `Main.qml` and `RentalSystem` still use **QSaveFile text**, without a commercial migration/backup/contact policy.

**Latest compiled exact source CI:** [P7-J 6224a0f](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6224a0fcdf7c879f64d677472e073d3037bcd7a8), [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41471605002), [native Qt 6.8.3 Linux 111/111 and hosted Windows MSVC 111/111](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41471604730); Windows PS7/PS5.1 checks PASS. No owner physical MinGW, Narrator or OS-scaling acceptance.

## Fixed accepted programme ledger

| P | Weight | Formally accepted | Work/open gate |
|---|---:|---:|---|
| P0 | 5% | 5/5 | Closed baseline |
| P1 | 12% | 7/10 | Physical/imagery/whole-product approval |
| P2 | 10% | 4/6 | Local owner acceptance |
| P3 | 12% | 7/7 | Accepted source boundary |
| P4 | 12% | 5/7 | Owner physical accessibility |
| P5 | 16% | 0/8 | 8 source/automation-covered expectations, not signed |
| P6 | 14% | 0/9 | Bounded nine-group review, not signed |
| P7 | 9% | 0/8 | Test-only candidate; owner policy/actual integration open |
| P8 | 5% | 0/6 | Installer not started |
| P9 | 5% | 0/8 | Release QA not started |

**Total 28/74, weighted 40.6%.** Not an estimate of code completion or market readiness.

## Outstanding decisions and authorized next work

Ratify P7 SQLite ADR and eight-criterion rubric, exact money cap, nonreusable C/M/R identity/legacy ID handling, non-destructive retirement and legally controlled archive disposal, purpose-limited authorized customer contact and older licence treatment, local data path/backup/restore, migration and failure/cutover semantics. Until explicit authorization, do not enable real data, import files, link production QtSql, merge, tag, release or present packaged CI artifact as installer. P8 requires offline installer and privacy/licence audit; P9 requires exact-source CI, real Windows local Qt Creator MinGW, 100/125/150% supported scaling, keyboard/Narrator/performance and owner signoff.

**Audit and history:** The 30 October [full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md), dated milestone reports, [historical docs](archive/README.md) and prior Git revisions retain traceability. This concise file is for the CURRENT state, not an ever-growing chronological ledger.
