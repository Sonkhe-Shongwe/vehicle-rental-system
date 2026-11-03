# P7-T | Generated-fictional SQLite restore-to-new-database recovery verified

**3 November 2026, exact tested source:** [`aac703fd`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/aac703fd85b2c143d7e45286eec9dc2a1b3c6a47), [GitHub Actions 41695631979](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41695631979). **Scope:** isolated opt-in SQLite test harness only. The owner has approved D1's generated-fictional engine choice, not P7 D2–D8 production backup, operational data, or commercial cutover.

## Implemented

- [Source `741a5e64`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/741a5e64ea65cfa692be8ff2702ab600b8331cde) adds a *test-only* `restoreVerified(backupPath,destination)` path to `tests/p7_sandbox/p7_sqlite_backup_tests.cpp`: reject missing/symlinked/empty snapshot, pre-existing destination or staging files, and backup sidecar files; make a separate staging copy in the same temporary directory; independently open with QtSql/QSQLITE and require schema/version, `PRAGMA integrity_check`, `PRAGMA foreign_key_check` and the exact fixed fictional business baseline; rename only after validation, refusing destination overwrite. Never modify source snapshot bytes. No arbitrary command-line paths, UI controls, real records, or replacement of the protected QSaveFile default.
- Three extra CTest cases: `rental_studio_p7_backup_restore_roundtrip` checks independently writable restored copy and unchanged backup/live source; `rental_studio_p7_backup_restore_damaged` corrupts a disposable candidate and confirms no partial output then a good recover; `rental_studio_p7_backup_restore_refuse_overwrite` protects existing destination and stage sentinel bytes, then proves a clean retry.
- [CI workflow source `aac703fd`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/aac703fd85b2c143d7e45286eec9dc2a1b3c6a47) adds `tests/p7_sandbox/**` and `src/application/p7_sandbox/**` to the existing P7 feature-branch push triggers; otherwise these test-only changes would not have automatically started the full native hosted jobs. The workflow already retains CTest and Windows packaged functional checking.

## Native verification, exact commit

[Run 41695631979](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41695631979) **COMPLETED SUCCESS**:
- **Ubuntu 24.04 GCC / Qt 6.8.3:** **123/123 CTests passed**, zero failed; three new restore cases #103, #104, #105 PASS; native test duration 155.49 sec.
- **Hosted Windows Server 2022 MSVC / Qt 6.8.3:** **123/123 CTests passed**, zero failed; three restore cases #103, #104, #105 PASS; test duration 177.26 sec.
- **Deployed Windows package:** existing **8/8 actual executable fictional functional checks PASS**, PowerShell 7 and 5.1 checks PASS.
- Artifacts: [Windows portable acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41695631979/artifacts/13261752226), [Windows native screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41695631979/artifacts/13261537303), [Linux native screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41695631979/artifacts/13260373658).

## Limits and next gates

This tests a copy of an **already consistent synthetic VACUUM INTO snapshot** using exact fictional contents and no application operator restore UI. It is **not** a production-safe backup and disaster-recovery product: no operational directory selection, cross-volume restore, encryption/retention, arbitrary schema/data migration, user permissions, power-loss/disk-full tolerance, antivirus locking, hostile filesystem race resistance or real customer data approval. No claim of physical owner Windows Qt Creator 6.10.2 MinGW, 100/125/150% OS scaling or Narrator. Formal P7 stays **0/8**, overall **45/74 criteria, weighted 70.6%** unchanged; P5/P6 owner approvals remain intact. PR #17 is draft on P6 #14, `main` remains untouched, final Fleet Population/Photos LAST.

**Next step:** owner physical Windows UX-S1 scroll retest and separately approve necessary P7 D6 storage/backup/retention policy before any operational recovery UI or data cutover.
