> **P7-D CROSS-PLATFORM-VERIFIED GENERATED-ONLY REPORT (2 NOV 2026):** [Exact source `fca2616`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fca261607d61af708a5f976960b06e8044262f68) passed [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41407613482) and [Linux native 89/89 + Windows native 89/89](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41407613556), plus Windows PS7/PS5.1 packaged checks. [P7-D schema, deterministic issue ordering, exact cents and failure/repair report](P7_D_DETERMINISTIC_MIGRATION_REPORT_NATIVE_VERIFIED_2026-11-02.md). Machine-readable JSON exists **in memory in the test-only executable**, with masked issue codes+line numbers, synthetic counts, string-valued booked total cents; no exported customer file, general UI import, real contact storage, production database or migration. P7-B/C continue tested, P7-D adds four CTests; formal P7 0/8, total 28/74 accepted and 40.6% evidence-weighted unchanged. Owner/privacy/retention/migration/physical Windows approval remain open. Next safe P7-E backup and restore synthetic-only feasibility.

# P7-B/P7-C disposable storage research tests

**TEST-ONLY.** This target is `BUILD_P7_SQLITE_SANDBOX=OFF` by default. It is not wired into the Qt Quick app, legacy Qt Widgets app or real storage.

```sh
cmake -S . -B build-p7 -DBUILD_TESTING=ON -DBUILD_P7_SQLITE_SANDBOX=ON
cmake --build build-p7 --parallel 2
ctest --test-dir build-p7 -R 'rental_studio_p7_(sqlite|preflight)_' --output-on-failure
```

For multi-config Windows Visual Studio builds, use `cmake --build build-p7 --config Release` and `ctest --test-dir build-p7 -C Release -R 'rental_studio_p7_(sqlite|preflight)_' --output-on-failure`. Actual QtSQL/QSQLITE must be present in the opted-in kit.

- **P7-B:** `rental_studio_p7_sqlite_sandbox` links Qt6 Core/Sql, only creates generated temporary SQLite files and runs five constrained transaction/constraint/money/reopen/error tests.
- **P7-C:** `rental_studio_p7_legacy_preflight` links Qt6 Core only, creates invented legacy text under a private `QTemporaryDir` and runs six fixed checks for raw-byte framing, row validation, duplicates, historical anomalies, strict cents, dates and protected source nonmutation. It has **no file-path arguments and no import operation**.

[Verified P7-B evidence](../../docs/P7_B_SQLITE_SANDBOX_NATIVE_VERIFIED_2026-11-02.md), [verified P7-C evidence](../../docs/P7_C_READ_ONLY_LEGACY_PREFLIGHT_NATIVE_VERIFIED_2026-11-02.md), [storage architecture proposal](../../docs/P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md). No real PII, external file imports, production DB cutover or migration authorization. P7 formal acceptance 0/8.


### P7-D: in-memory JSON issue report (test-only)

The same `rental_studio_p7_legacy_preflight` executable now accepts four additional **fixed case names**: `manifest_clean`, `manifest_blocked`, `manifest_incomplete`, `manifest_overflow`. Its `Report::manifest()` produces **in-memory JSON**, not a disk export or general-file importer. Schema `p7.synthetic.preflight.v1` includes aggregate counts, sorted fixed issue codes with source kind/line and string-valued exact cents, or `null` when reconciliation cannot complete. Clean sample booked value is `"102000"` cents (fictional contracts only). `BLOCKED` can still expose fictional comparable but mismatched amounts; no real contact is ever emitted. [P7-D exact-source native PASS and known test fixes](../../docs/P7_D_DETERMINISTIC_MIGRATION_REPORT_NATIVE_VERIFIED_2026-11-02.md). Still OFF by default, no production activation.
