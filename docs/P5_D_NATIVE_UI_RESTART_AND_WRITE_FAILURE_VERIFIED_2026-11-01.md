# P5-D | Native Qt Booking, Separate-Process Restart and Write-Failure UX
**Verified:** 1 November 2026. **Status:** exact source CI passed; P5 full milestone still open.

## Outcome

The user requested actual software development without repeated Windows owner-led PowerShell tests. The existing P5-C cross-process checks had already proven fictional storage and file reload in two independent C++ executable invocations, but did not drive the **real Qt Quick user interface**. The new [source `18e5c6eaff9ad13f2a8811ef5054504a577e5ac6`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/18e5c6eaff9ad13f2a8811ef5054504a577e5ac6) makes the original UI execute the persisted booking in one application process and render the saved booking in another.

## Actual implementation and safeguards

Only `spikes/qtquick_p2/main.cpp` and `spikes/qtquick_p2/CMakeLists.txt` changed in this source commit:

1. **Persistent fictional Qt UI booking:** test-only `--p5-ui-session-seed-test` launches the actual QQuickWindow in a unique Qt test-mode application data root, opens the real modal with a native keyboard event, fills fictional Corolla ID C001/3 days, previews the domain-authoritative R450/day/R1350 quote, and confirms using the persistent mode's fixed fictional contact. It verifies **R003 saved receipt** on the real Rentals screen, changed domain and on-disk ledger, and captures a real Qt window screenshot `p5-qt-persistent-booking-receipt.png`.
2. **Separate application process, real UI recovery:** `--p5-ui-session-reopen-test` starts a *new* native executable process, reopens the same fixed Qt test-mode synthetic directory, displays real Qt Overview with **Active rentals = 2** and **Active booked contract value = R2750** (not collected revenue), and verifies C001 occupancy and R003 presence. In the actual QML modal it tries another C001 quote: **`Vehicle is not available.`**, Confirm remains disabled, booking ledger is byte-identical, and no new success receipt appears. It captures `p5-qt-persistent-reopened-overview.png`.
3. **Cleanup:** `--p5-ui-session-clean-test` runs in a third executable, confined to the specifically identified Qt test-only directory, and cleans only known files with matching marker. It does not reset a user's real persistent demonstration session.
4. **Failed write UX:** Wide and compact `--p5-ui-write-failure-test` use the same native Qt booking modal with an injected `P5RejectWriteStorage` that reads the original temporary fictional fixture but rejects durable writes. The existing C++ `RentalSystem` rollback path keeps C001 available and R003 nonexistent, leaves the on-disk ledger byte-identical, and emits **`Booking was not saved. No rental confirmed.`** inside the still-open dialog. Tests verify zero success receipt, unchanged models and no false committed record.

The application’s production-domain/storage abstractions and QML controls were **not** modified by this increment. Opt-in fake data stays inside the versioned app-owned path, while normal preview continues to use disposable SHA-pinned fictional source copies. There is no new arbitrary data-directory argument, PII, payments, SQLite, real customers, installer or release.

## Executed independent CI

| Platform | Exact source workflow | Result |
|---|---|---|
| Core / legacy C++ | [41293924663](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41293924663) | **13/13 CTests PASS** |
| Linux GCC Qt 6.8.3 (native QQuickWindow) | [41293924623](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41293924623) | **54/54 native CTests PASS**, including all five new QML cases |
| Windows Server 2022 MSVC Qt 6.8.3 | [41293924623](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41293924623) | **54/54 native CTests PASS**, same five new QML cases |
| Windows relocated review EXE | Same workflow | Packaged accessibility/motion/focus P4 four checks PASS in both PowerShell 7 and Windows PowerShell 5.1 |
| Windows SHA protection | Same workflow | Intentionally altered non-demo vehicles fixture rejected, original file restored |
| Native visual evidence | UI process tests | `p5-qt-persistent-booking-receipt.png` and `p5-qt-persistent-reopened-overview.png` created; subsequent CI screenshot upload patterns added in the docs/workflow commit |

Actual Linux and Windows job logs were inspected, including individual CTest case names and `100% tests passed, 0 tests failed out of 54`. This is test evidence, **not owner aesthetic/UX approval**.

## Accurate milestone accounting and next priority

**P5 stays formally 0/8** until the entire P5 rubric is independently accepted and complete negative/failure behavior is documented. This increment substantially advances the persisted booking/relaunch and failed-write criteria but does not resolve every P5 acceptance requirement or physical Windows owner signoff. P4 remains 5/7, programme 28/74, evidence-weighted 40.6%, not overall release readiness. Existing P1/P2 physical items remain separate.

Next: review and close other negative flow gaps (cancellation, stale quote and failure after explicit return) using the existing C++ services and tested temporary files. Polish only a meaningful operator-facing scenario and avoid duplicating manual owner tests. Maintain draft PR #12 stacked on unmerged P4 PR #10; never merge or alter stable `main` without owner approval.
