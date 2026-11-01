# P4 Reusable Existing Rental Components | Verified 30 October 2026

**Exact tested source:** [99f3036c8115199a3c604588ea4de7d17d2add16](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/99f3036c8115199a3c604588ea4de7d17d2add16), private branch `feature/p4-shared-shell-focus-20261030`, stacked [Draft PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10) on unmerged P3 Draft PR #9.

## Accepted work within P4 category 3

Native, registered QML components now reused in the actually existing Fleet and Rentals UI:

- `AccessibleTextField.qml`: same accessible field-purpose convention and 44px minimum height for Fleet Search, Booking vehicle ID, customer name and contact number; preserves Qt-native caret, text editing and Tab.
- `DomainMessage.qml`: renders authoritative C++ quote preview, booking/return/archive messages through common muted/highlight layout; it has no rate calculations or command writes.
- `RentalStatusLabel.qml`: native text-visible active/returned/rented/available status, consistent semantics across Fleet table and Rental rows, never colour-only. Avoids a collision with the built-in Qt Quick `Item.state` property.
- `ConfirmActionDialog.qml`: actual shared Return/Archive modal template with `canAccept`, native Cancel/Escape, focus restoration, explicit labelled buttons and parent-owned `onConfirmed` dispatch to C++ typed commands. No automatic domain mutation on dialog close.
- Prior `DesignTokens.qml`, `FocusFrame.qml` and `WorkspaceNavButton.qml` remain reusable across Fleet Gallery/Table, Rentals and workspace navigation.

## CI and failure integrity

| Environment | Exact run | Evidence |
| --- | --- | --- |
| Linux C++ Core | [41122908664](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41122908664) | **13/13 CTests PASS** |
| Linux native Qt6.8.3 GCC | [41122908683](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41122908683) | **35/35 CTests PASS** including new P4 components wide/compact |
| Windows native Qt6.8.3 MSVC | [41122908683](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41122908683) | **35/35 CTests PASS** with Windows packaged automatic checks PASS |
| Screenshot artifacts | Same native run | Linux and Windows screenshot ZIP archives each have 20 captured images, including `p4-qt-shared-components-1500x860.png` and `p4-qt-shared-components-1280x720.png` |

Native QQuickWindow tests exercise interactive text input and caret arrow noninterference, Booking Cancel clearing quote and restoring focus, shared Return Cancel preserving active rental and ID, shared Archive Escape preserving returned record and selection, and byte-for-byte unchanged original and temporary rental ledgers. Previous P3 booking/return/archive tests all remain green.

## Scoring and next gates

**P4 category 3 reusable UI components accepted**, alongside previously accepted #1 design tokens and #6 screenshots. **P4 3/7**, accepted programme **26/74**, weighted **37.2%**. Calculation: P0 5 + P1 12×7/10 + P2 10×4/6 + P3 12×7/7 + P4 12×3/7 = 37.2095%, shown 37.2%. Not release readiness.

Still **OPEN**: #2 robust complete shared shell/focus-task order; #4 full keyboard/accessibility including Narrator and physical owner review; #5 OS reduced-motion preference and full motion behavior audit; #7 explicit owner Qt Creator Windows MinGW/aesthetic feedback. P1/P2 hardware and design gates still open. No new production-data authorization, external file path, payment, destructive QML delete, storage schema update, installer or branch merge. Both PRs draft, stable main unchanged.

**Next priority:** complete evidence-based focus/Tab/Shift+Tab and shell navigation without a global focus search engine, then motion-preference test. Owner device and accessibility signoff remain user-controlled manual gates.
