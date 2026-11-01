# P4 Workspace and Rental Row Accessibility | Verified 1 November 2026

## Actual defects and bounded correction

The Overview/Fleet/Rentals workspace sidebar previously conveyed active navigation only by visual styling; it did not expose current selection through Qt's accessible checked state. The rental list row accessible name omitted visually visible due-state, rental total and whether that record was selected, although it already included the rental ID, status and vehicle ID.

[UI change `969f9d8e7e41062691ac7112a4c4a5ce185f988d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/969f9d8e7e41062691ac7112a4c4a5ce185f988d) updates only the Qt Quick presentation and native regression:

- `spikes/qtquick_p2/WorkspaceNavButton.qml` exposes QAccessible `RadioButton` role and a `checked` state bound directly to the existing `currentWorkspace` value. It preserves native Space/Enter activation and group-local Up/Down navigation.
- `spikes/qtquick_p2/Main.qml` binds rental row accessible names to C++ model rental ID, status, vehicle ID, due-state, total and the current C++ stable selection. Only fictional non-contact summary properties are spoken. No customer names, phone numbers or live customer records are exposed.
- The existing `--p4-a11y-smoke` native Qt test checks that Overview, Fleet and Rentals checked states change after keyboard activation, and that an instantiated rental row provides status/due/value details and updates its spoken selected state on C++ select/clear.

## Failed test, diagnosis and corrective action

First implementation CI: [native Qt run 41286212406](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41286212406). Linux **41/43 passed**; only `rental_studio_p4_accessibility_wide` and `_compact` **FAILED** with `P4 rental row missing from accessible tree`. A separate review of `RentalListModel` and the SHA-pinned demo rental ledger verified the Active view contains a real fictional rental. The test had queried the QML `ListView` delegate immediately after changing its History/Active filter, while Qt was still recreating its row delegates. This was a **test synchronization defect**, not evidence to skip the check.

[Test correction `cd673187af3f1c49bfe4354d72fbcbcb262734f2`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/cd673187af3f1c49bfe4354d72fbcbcb262734f2) gives Qt a short render turn (`QTest::qWait(130)`), and keeps strict assertions: model count must be nonzero, the visible ListView must exist, and a valid row `QAccessibleInterface` must exist; otherwise the test still fails with count/view/row diagnostic output. No test was removed or bypassed.

## Independently executed source verification

| Environment | Actual run | Result |
|---|---|---|
| Linux Ubuntu Core/legacy Qt application | [41286466730](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41286466730) | **13/13 CTests PASS** |
| Linux GCC Qt6.8.3 native Qt Quick | [41286466766](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41286466766) | **43/43 CTests PASS**, both new wide and compact accessibility cases |
| Windows Server 2022 MSVC Qt6.8.3 native Qt Quick | [41286466766](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41286466766) | **43/43 CTests PASS**, same tests |
| Windows portable review artifact, real relocated EXE | Same Windows job | **4/4 P4 checks PASS**: native roles/states, keyboard/modal focus, ordinary/reduced motion injection |
| Windows tampered fictional-file safeguard | Same Windows job | **PASS**: intentionally altered non-demo file rejected |
| Artifacts | Same native run | Linux/Windows screenshots and `p2-windows-physical-acceptance-kit` uploaded (retention limited) |

Job logs were independently inspected; both platforms reported `100% tests passed, 0 tests failed out of 43`. All input is SHA-256-pinned fictional `demo` content copied into a temporary folder. No real rental input paths or account storage were introduced.

## Open acceptance limits and next owner decision

Qt accessible names and checked states have software-level test evidence, but **actual Windows Narrator speech, app rendering at real OS 100/125/150% display scales where supported, native Qt Creator 6.10.2 MinGW, motion preferences and final owner design approval** remain NOT TESTED for this revision. P4 criterion **#4** full screen-reader/keyboard accessibility and **#7** owner physical/aesthetic signoff remain OPEN. P1/P2 other owner items and P5–P9 remain pending. Formal P4 **5/7**, programme **28/74**, weighted **40.6% accepted-evidence coverage**, not product release readiness. Draft PR #10 remains unmerged, `main` unchanged.

Next action for owner: use the verified Windows kit from [run 41286466766](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41286466766), inspect and run `Verify-P4-Windows.ps1 -VerifyOnly`, then test **Overview/Fleet/Rentals selected announcements and rental due/total/selection** using actual Microsoft Narrator and safely supported physical display scales, recording exact source/Qt kit and sanitized evidence. A failed or unknown spoken state is **FAIL / NOT TESTED**, not approval.
