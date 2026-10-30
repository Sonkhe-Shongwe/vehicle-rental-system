# P3-F / P3-G | Read-only Qt Quick Rentals Binding and Fleet Consistency

**Checkpoint:** 30 October 2026, GitHub source implementation exists, all new exact-source CI jobs **QUEUED**, no runtime verification claimed.

**Repo:** `Sonkhe-Shongwe/vehicle-rental-system`
**Draft source branch:** `feature/p3-rental-confirm-20261030`, PR #9 stacked on P3-B #8, P3-A #7, P2 #6; `main` unchanged.

## Code changes (candidate, not verified)

- [P3-F source f454619](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f45461954c5b248d55e7a102b9a2864bfeb460d8): existing Qt Quick P2 `spikes/qtquick_p2/Main.qml` Rentals placeholder becomes a real read-only `ListView` of C++ `RentalListModel`; displays IDs, C++ statuses, due state and total, with accessible row selection. No QML write/button or contact PII roles.
- P3-F `spikes/qtquick_p2/main.cpp` injects `RentalReadService` and `RentalListModel` into QML only after SHA-256 verification of bundled fictional fixture data and copying into `QTemporaryDir`. Integrates `RentalQuoteService` and `RentalConfirmService` into **test harness only**.
- P3-F `spikes/qtquick_p2/CMakeLists.txt` adds genuine `--rentals-smoke` Qt Quick wide 1500x860 and compact 1280x720 checks. Tests assert actual delegates, keyboard selection, screenshot, no optimistic model change, explicit read-model refresh after C++ `createRental` successful commit, archive display after refresh and untouched source-demo fixture bytes.
- [P3-G source 1fdbf58](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/1fdbf588b14602d50d9e5d40f55251bf8e47f6b9): `FleetModel` now can re-snapshot its authoritative `FleetReadService` with native reset; `FleetController::refreshAfterCommit()` emits refreshed counts and re-evaluates hidden selection on filter. It is called **only by the test-only C++ commit-success path** alongside RentalListModel::refresh, so Fleet availability and selected vehicle can reflect C001's new rental rather than showing stale availability.
- No real user-facing transaction controls or production data-directory option were added. Existing P2 Fleet navigation, Qt Widgets app, QSaveFile ownership and P7 gated migrations are untouched.

## Live CI status at checkpoint

| Revision | Run | Observed status |
| --- | --- | --- |
| P3-F f454619 | [Core 41100628875](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41100628875) | **QUEUED**, not PASS/FAIL |
| P3-F f454619 | [Native Linux + Windows 41100628888](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41100628888) | **QUEUED**, not PASS/FAIL |
| P3-G 1fdbf58 | [Core 41101431978](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41101431978) | **QUEUED**, not PASS/FAIL |
| P3-G 1fdbf58 | [Native Linux + Windows 41101432181](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41101432181) | **QUEUED**, not PASS/FAIL |

**Last independently verified earlier source:** P3-E [238761d](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/238761d191f9b45100c23decf4913bd6d1fad004) at [Linux Core 41098537217](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41098537217) 7/7 PASS and [Linux/Windows native 41098537453](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41098537453) 15/15 each PASS. The prior results **cannot** certify the new QML binding or Fleet refresh.

## Next test and acceptance gate

1. Wait for GitHub job allocation; inspect CMake, moc, QML engine, actual delegate/property, hosted Windows packaging and full CTest logs at **exact** P3-G source SHA. On failure, make only a targeted reversible change and re-test.
2. Keep all four P3 criterion gaps open until evidence. Even if these new real QML tests pass, proof covers a read-only demonstration and **test-harness-only** successful booking, not the owner-facing P5 rental journey, native hardware approval, or automatically synchronized business commands.
3. Only after green hosted native tests and separate owner signoffs, revisit whether P3 criterion 4 (real C++ models and read-only QML binding) can be accepted. Do not auto-increment 3/7.

**Progress unchanged:** P0 5/5, P1 7/10, P2 4/6, P3 3/7, P4-P9 0; **19/74 accepted and 25.2% weighted criteria coverage**, not release readiness.
