# UX-S11 | Fail-closed rental read snapshots with retained recovery

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled and native-verified source:** [`159efc55860ab860d481d2a477283c7db6a135c7`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/159efc55860ab860d481d2a477283c7db6a135c7)  
**Native GitHub Actions:** [run 41770412467](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41770412467) **COMPLETED SUCCESS**  
**Working branch:** `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked on P6 #14, no merge.

## Functional defect and intended boundary

The P7 fictional SQLite Lab already represents an unsuccessful rental provider read using `RentalListModel::snapshotAvailable == false` and hides unverifiable records in its Qt Quick UI. But the C++ `RentalListModel` deliberately retains the last verified buffer and previously still allowed external calls to read cached per-row roles, read the selected contract projection, read recent activity, and navigate/select cached rental IDs when the provider had failed. Its Return/Archive controllers also did not check snapshot availability before deriving eligibility from an independently healthy domain read. This gap could allow actions or direct C++/QML consumers to treat unverified, potentially stale data as current if reused in a future connected UI.

This increment closes those operations without changing the fictional-only storage architecture, without replacing a failed read with an empty business ledger and without deleting the buffered snapshot.

## Exact bounded fix

- `src/application/rental_list_model.cpp`: when the last provider snapshot is unavailable, `data()` returns an invalid `QVariant`, `selectedContract()` an empty map, `recentActivities()` an empty list and `oldestOverdueRentalId()` an empty ID, while `rowCount()` and internal buffers remain retained for recovery.
- The same unavailable-state guard rejects `selectById`, `selectVisibleRow`, `locateById`, `locateActiveReturn`, and `selectOldestOverdue`. A failed `locateActiveReturn` caused by the read outage does not erase the saved selection, which can reappear after a newly validated snapshot. Read-only status filters remain an operator presentation setting and are not domain mutations.
- On the first transition from available to unavailable, `refresh()` still emits `snapshotAvailabilityChanged`, with an added `selectedContractChanged` so dependent detail views can revoke their prior displayed contract. No false `modelReset`, `countChanged`, or `metricsChanged` is emitted on read failure. Repeated failed reads are idempotent. A successful retry rehydrates the buffer, emits the existing Qt model reset and metrics signals and exposes verified data again.
- `src/application/rental_return_controller.cpp` and `rental_archive_controller.cpp`: `canReturnSelected` / `canArchiveSelected` return false on unavailable snapshots. Both direct commands refuse to dispatch to the domain service while unavailable, emit their existing typed `MissingRental` rejection, and report a specific retry-read message. Both controllers subscribe to `snapshotAvailabilityChanged` so Qt command enabled state rebinds. Existing UX-S7 exact-ID guards remain present.
- `src/application/rental_list_model.h` documents the difference between a buffered previous snapshot and verified exposed data.
- No QML layout, domain persistence code, booking quote, P7 policy, installer, image, protected source fixture or release API changed.

## Native regression evidence

- `tests/p3_rental_model_tests.cpp`: an injected fictional provider failure preserves the last count and selected ID but exposes no contract, roles, due routing, activity, or lookups; verifies no protected disk writes and no false model reset/metrics signals. Repeated failure is idempotent; a verified retry restores the selected receipt and C++ navigation with exactly the appropriate availability signals.
- `tests/p3_rental_return_controller_tests.cpp`: a selected eligible active fictional rental becomes ineligible on refused reads; guarded return cannot dispatch or write, and successful retry re-enables eligibility **without auto-return**.
- `tests/p3_rental_archive_controller_tests.cpp`: analogous returned rental is denied archive on failed read; no domain or fleet mutation; successful retry only restores eligibility.
- The first source commit [`06d9d0de`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/06d9d0de846351da688f4e1e90504137dd31df76) triggered [initial Actions run 41770111830](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41770111830), which failed to compile on both platforms because a new test-local counter named `signals` conflicted with Qt's C++ macro. The test identifier was corrected in [`159efc55`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/159efc55860ab860d481d2a477283c7db6a135c7); the **corrected source** alone is the native green evidence, with no skipped tests or ignored test failures.

[Exact-source GitHub Actions 41770412467](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41770412467) **COMPLETED SUCCESS**:
- **Ubuntu 24.04 GCC, Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failures, **158.63 seconds**. `vehicle_rental_p3_rental_model` #7, `vehicle_rental_p3_return_controller` #9, and `vehicle_rental_p3_archive_controller` #11 all PASS, including new failed-read assertions.
- **Hosted Windows Server 2022 MSVC, Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failures, **178.17 seconds**. The same three targeted tests PASS. Existing native Qt QML smoke tests also remained green.
- **Hosted Windows relocated portable executable:** **8/8 real fictional-app functional checks PASS**. P2/P4 packaged automation and both PowerShell 7 / Windows PowerShell 5.1 verification PASS.
- Artifacts (expire 11 November 2026): [portable fictional Windows physical acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41770412467/artifacts/13294304283), [hosted Windows Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41770412467/artifacts/13294588433), [Linux Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41770412467/artifacts/13293859682).

## Formal gates preserved

**Formal owner acceptance remains 45/74 criteria, weighted 70.6%; P7 0/8.** A hosted CI pass is not an actual physical Windows Qt Creator/MinGW run or owner acceptance. Physical owner UX-S1 scroll/focus retest, 100/125/150% scaling, Narrator, P7 D2–D8 real-data/privacy/security/retention/backup decisions, P8 installer, P9 release, final Fleet Population/Photos and licensing, all draft PR merges and public release remain OPEN.

No commercial data, contact information, new operational storage/backup, installer or production approval introduced. The subsequent documentation-only HEAD is not a separately compiled source.
