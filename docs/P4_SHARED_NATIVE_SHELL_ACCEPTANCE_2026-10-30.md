# P4 native design tokens and shared-shell checkpoint | 30 October 2026

**Source:** private `Sonkhe-Shongwe/vehicle-rental-system`; P4 [`03a0e66`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/03a0e66927bf094993725259d82d08ca96765c97), stacked [Draft PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10) onto unmerged P3 Draft PR #9. Stable `main` untouched.

## What is implemented

- `DesignTokens.qml`: extracted owner-selected Cloud/Ice, Midnight Navy, Emerald Teal, Mint and muted ink colors from `design/r1/OWNER_THEME_DIRECTION_2026-10-30.md`. Existing native QML references centralize in this token object.
- `FocusFrame.qml`: reusable keyboard focus Navy ring distinct from selected-ID Mint/Teal state, shared by Fleet Gallery, Fleet Table and Rentals. No input event handling or implicit animation.
- `WorkspaceNavButton.qml`: real shared native button delegate, group-local Up/Down with no wrap, and owner-approved Fleet sidebar Right-to-Search. Space/Enter remain native. Search arrow keys preserve text caret.
- Dialog Escape is no longer allowed to clear Fleet/Rentals selection behind open modals. Return/Archive/Booking close paths restore invoker focus (or nearby valid Rental list). Explicit Return/Archive widths avoid previously observed Qt Basic Dialog implicit-width warnings.
- Two new native QML CTests drive real QQuickWindow controls and keyboard events in wide 1500x860 and compact 1280x720; verify sidebar, Search, focus/selected state, Escape dialog priority, focus restored, screenshot dimensions and untouched demo data.

## Evidence and correction history

| Source / run | Observed result |
|---|---|
| [Initial P4 source e682f18](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/e682f18f95bbefbc4ab06431dda4a0c1054e557c) | Native components and tests added |
| [Test-only correction dd3edc4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/dd3edc4bdbab73d56f5d9ad1948d22fd39a8f938) | Removed a local C++ `rentals` variable that shadowed a file path, fixing initial native Linux compile |
| [Focus test and width correction f8def25](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f8def2527e93598466692b60553db319b269135a) | Prior Linux 31/33 had two new P4 failures from brittle fixed C001 expectation, despite correct focused/selected state; corrected source **33/33 PASS on Linux and Windows**, Return/Archive widths bounded |
| [Final screenshot uploader 03a0e66](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/03a0e66927bf094993725259d82d08ca96765c97) | [Linux Core 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41119721899); [Linux native Qt 33/33 + Windows native Qt 33/33 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41119721897); Windows packaged auto-checks PASS. Both Linux and Windows screenshot archives uploaded with 18 files and P4 `p4-qt-shared-focus-*.png` glob included |

## Seven-category P4 roadmap acceptance ledger

These seven distinct roadmap categories are identified from [P0–P9 transparency](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) and [owner UX-CTRL-001 contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md). Partial evidence does not count toward acceptance.

| Category | Status | Boundary |
|---|---|---|
| 1. Owner-selected native design tokens | **ACCEPTED** | Shared design tokens source-aligned and consumed in real QML |
| 2. Robust shared native shell/navigation | PARTIAL | Sidebar keyboard/Right-to-Search proven; full multi-workspace shell and focus cycle remain to be reviewed |
| 3. Reusable list/card/table/field/quote/dialog/status components | PARTIAL | FocusFrame and WorkspaceNavButton reused; remaining form/status/quote/dialog components not yet extracted |
| 4. Focus/accessibility | PARTIAL | Real keyboard and dialog Escape tests pass; complete Tab/Shift+Tab, Narrator and physical screen-reader approval open |
| 5. Reduced-motion | PARTIAL | Static focus by default, but OS reduced-motion behavior and all screens not assessed |
| 6. Native two-size screenshots | **ACCEPTED** | Real 1500x860 and 1280x720 Qt screenshots captured with dimension assertions and uploaded to both native CI screenshot archives |
| 7. Owner Qt design feedback | OPEN | Local physical Qt Creator 6.10.2 MinGW, real OS 100/125/150% scaling, visual and accessibility review not approved |

**P4 2/7**, P3 7/7 remains unchanged. **Programme 25/74 accepted; weighted 35.5%.** Calculation: P0 5 + P1 12×7/10 + P2 10×4/6 + P3 12×7/7 + P4 12×2/7 = 35.4952%, displayed 35.5%. This is evidence coverage, not release readiness.

## Next milestone-closure priorities

Consolidate actual booking/return/archive field, quote, dialog and status components, then verify full task-order focus, keyboard-only usability and reduced-motion behavior across the native shell. Secure owner Windows visual/physical DPI feedback independently. All P4 changes remain fictional-data-only on stacked draft PR #10; no production data, database migration or installer.
