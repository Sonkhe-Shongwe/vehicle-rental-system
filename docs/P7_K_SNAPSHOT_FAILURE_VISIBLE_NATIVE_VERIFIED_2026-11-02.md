# P7-K | Visible failed Rentals snapshot and verified native Qt Quick retry

**2 November 2026. Exact compiled source:** [P7-K `5785020`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/5785020bc6eb95ed23b63bfc16768db712143cff). **Evidence:** [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41474440150) PASS; [native Qt 6.8.3 Linux/hosted Windows 111/111 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41474440071) PASS; hosted Windows packaged PowerShell 7 / Windows PowerShell 5.1 checks PASS. The enhanced scenario is **#111 of 111**, not a new test count.

## What was improved

The P7-J shared `RentalListModel` already kept previous valid values when its optional SQLite snapshot provider failed, but it had no observable read-availability state. This allowed stale figures to look current in a future UI.

P7-K exposes the read-only Q_PROPERTY `snapshotAvailable` with `snapshotAvailabilityChanged`. A successful empty or populated first load is considered verified. A failed `refresh()` preserves cached rows, selected ID and previous KPI values, but changes availability to false and emits **no** model reset or `metricsChanged`. A successful retry changes availability back to true, updates the authoritative snapshot, and emits normal successful refresh signals.

In the **separate opt-in fictional Qt Quick test window**, active/history/booked value figures are hidden while unavailable. The operator sees "Read unavailable. Figures hidden until a verified refresh." and an explicit "Retry Rentals read" button. A real QML button click after the test provider recovers restores verified figures. This is transparent recovery behavior, not a hidden auto-retry.

## Exact source and test evidence

- C++ core workflow [run 41474440150](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41474440150): 13/13 passing on Linux.
- Native Qt [run 41474440071](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41474440071): Qt 6.8.3 Linux GCC 111/111 and hosted Windows MSVC 111/111; expanded #111 checks failed-read availability signal, no false metrics, preserved archival selection, hidden stale KPI, retry click and recovery. Existing #109–110 and earlier suites remain enabled.
- Windows packaged PowerShell 7 and Windows PowerShell 5.1 checks: PASS on hosted Windows, not physical owner hardware.

Only the fixed synthetic test harness injects a `nullopt` provider result; no files, credentials, contacts, licence data or real records are read or modified.

## Limits and acceptance

Normal polished `Main.qml` still uses existing protected fictional QSaveFile text storage, **not** this SQLite preview. P7 SQL is compiled only under OFF-by-default `BUILD_P7_SQLITE_SANDBOX=ON`. The shared model has the new availability property, but normal application failure handling and any future production write blocking need separate policy and integration approval.

No owner physical Windows Qt Creator 6.10.2 MinGW, real 100/125/150% OS scaling, Narrator, commercial data migration, authorized contact storage, money cap, permanent IDs, retention, security or real installed offline product were verified. **P5 0/8, P6 0/9, P7 0/8, total 28/74 accepted, weighted 40.6% unchanged; P8/P9 not started.** Keep all draft PRs unmerged and main unchanged.

Next meaningful gate: approve the outstanding P7 owner architecture/privacy/retention/ID/money/backup/migration policy before normal-app storage integration.
