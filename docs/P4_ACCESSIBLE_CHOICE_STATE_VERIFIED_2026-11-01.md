# P4 Native Accessible Selection State | Verified 1 November 2026

## Defect and bounded fix

The real Qt Quick Fleet Gallery/Table switch and Rentals All/Active/History filter previously relied on visual highlighting and colors to indicate which view/filter was selected. They exposed an action label, but **no explicit mutually-exclusive accessible selected/checked state**. A keyboard or assistive-technology user could not reliably infer the active option from the accessibility metadata.

At [exact source commit `74016298e2acc58462b400dd433c98fd1aa9b6e0`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/74016298e2acc58462b400dd433c98fd1aa9b6e0):

- `spikes/qtquick_p2/Main.qml`: Fleet view and Rentals filter Buttons retain their existing native keyboard/click handlers and C++-controlled state. Each option exposes `Accessible.role: Accessible.RadioButton`, `Accessible.checkable: true`, a concise distinct `Accessible.name`, `Accessible.description`, and `Accessible.checked` derived from the **authoritative current QML view property/C++ `RentalListModel.statusFilter`**.
- `spikes/qtquick_p2/main.cpp`: a dedicated `--p4-a11y-smoke` accesses real native `QAccessible::queryAccessibleInterface` for Fleet's view choices and search/status/sort input names. After keyboard-activating Fleet Table and Rentals History then Active, it verifies `RadioButton` roles, exact names, mutually exclusive checked-state transitions, authoritative filter values and immutable fictional files.
- `spikes/qtquick_p2/CMakeLists.txt`: adds separate `rental_studio_p4_accessibility_wide` (1500×860) and `_compact` (1280×720) tests, retaining all 41 existing native CTests. Qt accessibility is enabled in Linux smoke test environment without editing global OS settings.

No new pricing/availability rules, real customer storage, PII UI roles, arbitrary file paths, migrations, payment flows, assets or admin writes. The original protected demo inputs are still SHA-256 pinned, test mutations remain in `QTemporaryDir`, and state remains sourced from the existing C++ model.

## Independent executed verification

| Environment | Exact commit / run | Result |
|---|---|---|
| GitHub-hosted Ubuntu Core and legacy application | [41284643818](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41284643818) | **13/13 CTests PASS** |
| Linux GCC Qt 6.8.3 compiled QQuickWindow | [41284643733](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41284643733) | **43/43 CTests PASS**; both new accessibility cases PASS |
| Windows Server 2022 MSVC Qt 6.8.3 compiled QQuickWindow | [41284643733](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41284643733) | **43/43 CTests PASS**; both new accessibility cases PASS |
| Windows packaged portable / synthetic fixture safeguards | Same Windows run | **PASS**, intentional substituted non-demo fixture rejected |

Both native OS runner logs were read, confirming all 43 CTests and exact wide/compact new test names. No prior test was removed, bypassed, renamed to conceal failure or weakened. This covers the Qt accessibility interface, not physical Microsoft Narrator output or full user-facing accessibility certification. Existing native screenshots verify QQuickWindow renders, not HTML prototypes; no claim of manually approving new screenshot appearance is made.

## Formal acceptance and next action

P4 category **#4 remains OPEN** until complete keyboard/focus/roles/names audit and physical Windows Narrator verification (including changing filters and announcing checked status); category **#7 owner actual Qt Creator 6.10.2 MinGW, Windows OS 100/125/150% where supported, system animation settings, final UX/aesthetic signoff** stays OPEN. P1/P2 other owner checks also OPEN, P5–P9 not accepted. **P4 5/7, programme 28/74, weighted 40.6% evidence coverage** unchanged, not release-readiness.

Next: test current live Narrator announcements and focus behavior on owner's Windows Qt Creator machine, documenting exact source SHA and observed behavior; fix any verified accessibility defects before considering #4 or #7. Keep all stacked PRs unmerged and stable `main` untouched.
