# P4 Shared Shell and Keyboard Focus Closure | 1 November 2026

**Tested exact source:** [`4678aff9a9eeb1ff2671bc19d8ee624d36afd57d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/4678aff9a9eeb1ff2671bc19d8ee624d36afd57d), private `feature/p4-shared-shell-focus-20261030`, [Draft PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10) stacked on unmerged P3 Draft PR #9. Stable main unchanged.

## Formal scope of this acceptance

**P4 category #2, robust shared Qt Quick shell/navigation, ACCEPTED for existing screens**. The implemented Overview is read-only; Fleet and Rentals have the interactive controls and transactions whose focus routes were exercised. This is **not** full screen-reader certification, P1 owner design approval, manual Windows OS scaling, future screens or production operation acceptance.

## Implementation

- `spikes/qtquick_p2/ConfirmActionDialog.qml` now moves initial focus to Cancel, bounds Tab and Shift+Tab between two visible action buttons, skips disabled confirmation, and returns focus to the invoking control or valid Rental list fallback when closed. Confirm commands still only run on an explicit, eligible button activation.
- `spikes/qtquick_p2/Main.qml` gives Fleet status/sort filters stable object names and native Tab eligibility, and moves initial Booking dialog focus to the Vehicle ID input. Existing `WorkspaceNavButton` Up/Down and Fleet Right-to-Search remain active. No global focus graph or interception of editable text arrows.
- Real Qt Quick `--p4-tab-smoke` runs in wide (1500×860) and compact (1280×720) QQuickWindow. It drives Fleet Search→Status→Sort with Tab, then reverse Shift+Tab; keeps Search caret arrows native; activates Rentals via sidebar Space; verifies Return modal initial Cancel focus, forward/reverse Tab cycling and Escape; opens Booking and verifies first-field focus and Escape restoration. It compares the SHA-pinned original demo files and disposable rental ledger byte-for-byte, and saves both screenshot dimensions.
- Workflow upload globs include `p4-qt-focus-route-*.png` in both Linux and Windows native screenshot archives.

## Actual, not inferred CI outcome

| Validation | Exact GitHub source run | Observed outcome |
|---|---|---|
| Qt Core + legacy | [41264224785](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41264224785) | **13/13 CTests PASS** |
| Linux GCC Qt6.8.3 native | [41264224690](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41264224690) | **37/37 CTests PASS**, both new focus-route tests pass |
| Windows MSVC Qt6.8.3 native | [41264224690](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41264224690) | **37/37 CTests PASS**, both new focus-route tests pass |
| Hosted Windows package integrity | Same Windows job | **PASS**, owner manual physical OS scaling NOT tested |
| Native artifact retention | Same native run | Linux and Windows screenshot ZIPs each contain **22** captures, including wide/compact focus-route images; Windows physical acceptance kit available but not manually approved |

## Failure and correction transparency

- [Initial source 6146415](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6146415f2d598d93f172d820dbbc27c9457aaa14) passed Core 13/13, but native Linux compiler stopped on four **test-only** C++ references to QML-style `Qt.TabFocusReason` (main.cpp). Native Windows had not been verified at that source.
- [Corrected exact-source 4678aff](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/4678aff9a9eeb1ff2671bc19d8ee624d36afd57d) substitutes `Qt::TabFocusReason` at four smoke-test call sites. No QML feature or domain behavior changed in this correction. Full Core, Linux, Windows and package test suites then passed, with screenshots retained.

## Frozen weighted acceptance

P0 5% × 5/5 = 5%; P1 12% × 7/10 = 8.4%; P2 10% × 4/6 = 6.6667%; P3 12% × 7/7 = 12%; P4 12% × 4/7 = 6.8571%. P5–P9 0 accepted. **Overall 27/74 accepted checks; 38.9238% weighted coverage, displayed 38.9%.** This is acceptance evidence, not code-completion estimate or release readiness.

## Remaining P4 criteria

- **#4 full keyboard/accessibility:** current real key routes/accessible labels are tested, but end-to-end accessibility, all focus variants and physical Windows Narrator remain unverified. OPEN.
- **#5 reduced-motion preference QA:** no claim about OS preference support or independently checked animations. OPEN.
- **#7 owner Qt Creator/Windows visual feedback:** Qt6.10.2 MinGW, physical 100/125/150% scaling where feasible, final design/accessibility signoff are not self-approved by hosted CI. OPEN.

Maintain fictional SHA-pinned source fixtures copied into QTemporaryDir; no operational customer storage, payments, schema migrations, live data or permanent deletion QML actions; all PRs remain drafts and stable main untouched.

**Next P4 closure:** test OS reduced-motion preference and static transitions, and obtain explicit owner-side hardware/a11y approval separately. Do not count that signoff on the basis of CI or screenshots alone.
