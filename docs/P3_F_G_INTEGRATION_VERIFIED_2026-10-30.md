# P3-F/G | Native Read-only Qt Quick Rentals and Fleet Synchronization | Verified

**Date:** 30 October 2026. **Private source:** Sonkhe-Shongwe/vehicle-rental-system. **Branch:** feature/p3-rental-confirm-20261030, unmerged draft PR #9 stacked on #8 / #7 / #6.

## Production-source revisions

- P3-F [`f454619`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f45461954c5b248d55e7a102b9a2864bfeb460d8) adds native Qt Quick Rentals read-only ListView bound to P3-E RentalListModel and injects the C++ read model after SHA-pinned demo fixture verification and temporary copying.
- P3-G [`1fdbf58`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/1fdbf588b14602d50d9e5d40f55251bf8e47f6b9) adds explicit FleetModel reset/re-snapshot and FleetController count/selection notifications after a **test-only** successful C++ rental confirmation, in the same event turn as Rentals model refresh. It tests that pre-refresh views are unchanged and post-refresh Fleet availability/filters match Rentals.
- The later docs-only commit [`38e6c98`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/38e6c98d19e5cc8ecb0a12270716037d9fe17699) preserves identical compiled application/test source from P3-G. That exact Git revision is the final fully checked cross-platform source for this report.

## Executed evidence

| Revision / environment | Native test or safety verification | Evidence and result |
| --- | --- | --- |
| F `f454619` Ubuntu Qt Core | CMake + CTest | [Run 41100628875](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41100628875): **7/7 PASS** in job log |
| F `f454619` Linux GCC and Windows MSVC Qt6.8.3 | CMake, native Qt Widgets + QML CTest | [Run 41100628888](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41100628888): **17/17 per OS PASS** in independent job logs |
| G `1fdbf58` Ubuntu Core | CMake + CTest | [Run 41101432181](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41101432181): **7/7 PASS** job log |
| G `1fdbf58` Linux GCC Qt6.8.3 | Native Qt CTest | [Run 41101431978](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41101431978): **17/17 PASS** job log |
| G `1fdbf58` hosted Windows | CI canceled **during MSVC build** due to native workflow `cancel-in-progress: true` on subsequent PR commit | No Windows failure assertion and **no PASS claim** for this intermediate job |
| Latest equivalent G source `38e6c98` Ubuntu Core | Full CTest | [Run 41101676959](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41101676959): **7/7 PASS** job log |
| Latest equivalent G source `38e6c98` Linux GCC / Windows MSVC native Qt6.8.3 | Full CTest including wide/compact Rentals actual-QML smoke | [Run 41101676963](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41101676963): **17/17 PASS on both OS**, independently inspected job logs |
| Latest equivalent G source `38e6c98` Windows packaging | windeployqt plus disposable portable acceptance checks | Same run: **Packaged automatic checks PASSED**; real Windows physical scaling remains untested |

Some GitHub workflow list/status responses lagged behind accessible completed job logs. Test claims above rely on the actual per-job CTest and packaging output rather than inferred run status. The canceled older Windows compilation is distinct from the later passing Windows compilation and native test.

## Verified behavior and boundaries

- A native visible QML Rentals ListView shows actual C++ typed rental IDs, statuses, due states and totals from known fictional SHA-256 fixtures copied into QTemporaryDir, without QML pricing or booking rules.
- Real QQuickWindow tests at both 1500×860 and 1280×720 assert visible rental delegates, actual keyboard Space selection and selected ID text, QQuickWindow screenshot, and unchanged read model before authoritative C++ confirmation.
- Test harness alone invokes RentalQuoteService and RentalConfirmService to create fictional R003 for previously available Corolla C001 at the domain rate; no user-facing booking action exists.
- After committed success, explicit rental and Fleet refresh produce QML record R003, available Fleet count 3 instead of 4, unavailable selected Corolla and Available filter with no stale Inspector. Archive status for historical R002 appears only after domain archive plus explicit rental model refresh; previous selected rental ID stays stable.
- Original repository `demo/vehicles.txt` and `demo/rentals.txt` fixture bytes are unchanged. No customer contacts exposed to QML, no production storage path, and no SQLite/money/ID migration.

## Remaining gaps and screenshot retention correction

- Existing upload-artifact workflow previously matched only `p2-qt-*.png` while the new real QML Rentals smoke saved `p3-qt-rentals-*.png`. This is an evidence-retention defect, **not a failing rendering test**. The next review commit expands both Linux/Windows artifact globs to include P3 screenshots. **Do not claim those new screenshot artifacts uploaded successfully until the new commit's CI finishes.**
- No owner-operated QML booking/return/archive command, live Active vs History filtering, automatic domain refresh notifications, independent injectable persistence repository, full user flow or physical Qt Creator Windows approval. The application remains a read-only proof with test-only command setup.
- P3 criteria 4 (complete operational rental model) and 5 (end-user QML rental pricing authority) remain **PARTIAL/OPEN**. P3 **3/7**, total **19/74**, weighted evidence **25.2%** (not release readiness). Stable main untouched; all stacked PRs draft and unmerged.

**Next narrow priority after artifact retention proof:** implement minimal C++-owned Active/History filtering of Qt Rentals read model with real QML keyboard/selection coverage, then reassess criterion 4 conservatively. Avoid premature P4/P5 workflows.
