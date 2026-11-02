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
