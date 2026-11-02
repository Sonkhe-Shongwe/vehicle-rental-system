# P7-B fictional-only SQLite test sandbox

This is **not** Rental Studio's storage backend. It is a separate, opt-in C++17 Qt6 Core/Sql executable linked only into a test target; it never loads existing demo files or customer details.

Run with a Qt6 kit that includes QSQLITE:

```sh
cmake -S . -B build-p7 -DBUILD_TESTING=ON -DBUILD_P7_SQLITE_SANDBOX=ON
cmake --build build-p7 --parallel 2
ctest --test-dir build-p7 -R rental_studio_p7_sqlite_ --output-on-failure
```

For Windows multi-config Visual Studio use `cmake --build build-p7 --config Release` and `ctest --test-dir build-p7 -C Release -R rental_studio_p7_sqlite_ --output-on-failure`. This target is **OFF** in the normal app build. Its five cases use only their own `QTemporaryDir` and a fixed case argument. The native Linux/Windows PR workflow runs the full P5/P6 suite with this option ON.

Review [P7-B source evidence](../../docs/P7_B_SQLITE_SANDBOX_NATIVE_VERIFIED_2026-11-02.md) and [P7-A draft architecture](../../docs/P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md). Do not substitute this sandbox for production storage, migration, real contact records or backups. P7 formal 0/8 until authorized owner acceptance.
