# P6-Q | Modal-safe Ctrl+F Fleet search in the normal fictional Qt Quick app

**2 November 2026. Exact compiled source:** [UX P6-Q source `6c74ad9`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c74ad9028b27cb21781bd34906ed4aeb6f10a4c). **Native tests:** [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41480936517) PASS and [native Linux/hosted Windows Qt 6.8.3 112/112 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41480936245) PASS. Windows PowerShell 7/5.1 hosted packaged checks PASS. This is a real operator-workflow improvement to the current Qt Quick interface, not a proposed logo, design mockup or live storage cutover.

## User-facing change

An operator can press **Ctrl+F** from Overview, Fleet or Rentals to open the Fleet workspace and focus the real Fleet search text field. Existing search/filter behavior remains C++-owned and all vehicle selection and business data remain intact. A shortcut is not allowed to steal focus from open booking, return, archive, contract-details, archived-delete, Fleet-add or Fleet-remove dialogs.

The shortcut is a top-level Qt Quick `Shortcut` in `spikes/qtquick_p2/Main.qml`. The handler switches to Fleet then schedules focus on the visible `fleetSearchField`, with no automatic record selection, booking, return or file write.

## Real native regression

Existing wide and compact `--p4-tab-smoke` real Qt Quick scenarios in `spikes/qtquick_p2/main.cpp` now test:
- Ctrl+F while the booking modal is open **does not navigate to Fleet or steal focus** from its active vehicle field.
- After cancelling the modal, Ctrl+F from Rentals opens Fleet and focuses its search field.
- Ctrl+F from Overview also opens Fleet and focuses its search field.
- Previously checked Tab/Shift+Tab navigation, modal Escape priority, cancellation, fixture byte immutability and screenshot generation remain enabled.

| Environment | Exact result |
|---|---|
| Linux C++ Core | **13/13 PASS**, [run 41480936517](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41480936517) |
| Qt 6.8.3 Linux GCC | **112/112 PASS**, native #65 and #66 PASS |
| Qt 6.8.3 hosted Windows MSVC | **112/112 PASS**, native #65 and #66 PASS |
| Hosted Windows packaged PowerShell 7 / 5.1 | **PASS** |
| Owner Windows Qt Creator 6.10.2 MinGW, OS scaling and Narrator | **NOT TESTED** |

The native results are at [run 41480936245](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41480936245). No new CTest was added; existing tests were strengthened. The source code remains in stacked draft branch `feature/p7-sqlite-sandbox-20261102`; the separate P6 PR #14 does not independently contain this later shortcut.

## Boundaries and next work

Normal Qt Quick still relies on protected fictional QSaveFile files; this change does not use the opt-in P7 SQL repository, import contacts or records, enable commercial use or license/branding assets, install the app, merge PRs or change `main`. Physical display scaling, keyboard usability with Narrator and final owner acceptance remain pending.

**No formal score increase:** P4 5/7, P5 0/8, P6 0/9, P7 0/8; overall 28/74 accepted, weighted 40.6%, not a release/completion score. Next high-value gate is consolidated owner P7 storage/privacy/lifecycle approval, followed by explicitly gated fictional-only application integration. Batch physical UX review rather than manually repeating automated cases.
