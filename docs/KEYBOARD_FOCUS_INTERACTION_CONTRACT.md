> **CURRENT P4 ACCEPTANCE, 30 OCT 2026: P4 2/7, overall 25/74 checks, weighted 35.5%.** Shared owner-selected Navy/Emerald palette `DesignTokens.qml`, reusable `FocusFrame.qml` used across Fleet Gallery/Table and Rentals, sidebar `WorkspaceNavButton.qml`, native modal Escape priority and restoration are implemented in [P4 source e682f18](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/e682f18f95bbefbc4ab06431dda4a0c1054e557c) with [driver fixes f8def25](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f8def2527e93598466692b60553db319b269135a) and [screenshot upload 03a0e66](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/03a0e66927bf094993725259d82d08ca96765c97). Exact-source [Core 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41119721899) and [Linux/Windows Qt6.8.3 33/33 each PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41119721897), Windows packaged checks PASS, both native screenshot archives uploaded including P4 wide/compact captures. P4 categories **design tokens** and **native two-window screenshot evidence** ACCEPTED; complete component inventory, shell/keyboard/a11y, motion-preference QA, and owner physical/visual signoff OPEN. P3 remains 7/7; P1/P2 owner gates OPEN; default main unchanged, stacked PR #10 draft; no production data. [P4 review](P4_SHARED_NATIVE_SHELL_ACCEPTANCE_2026-10-30.md). Earlier status below historical.

# Rental Studio 2.0 | Keyboard, Focus and Interaction Contract

**Decision ID:** UX-CTRL-001  
**Status:** **OWNER-APPROVED DESIGN POLICY** on **30 October 2026**. This approves the interaction rules and progressive implementation strategy, **not** completion of P2 physical acceptance, P4 implementation or accessibility certification.  
**Scope:** Windows-first offline Qt Quick/QML interface, from current Fleet feasibility through future Overview, Rentals, dialogs and any separately approved features.  
**Authority:** [Canonical project state](PROJECT_STATE_CANONICAL.md) · [Full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) · [P0–P9 acceptance](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md). If a future feature changes this contract, record an owner-approved, dated revision, update tests and keep prompt/audit synchronized.

## 1. Single governing principle

**Use Qt's native keyboard and focus behaviour, with one small, predictable product-wide contract.** The application assigns keys according to **the currently focused control**. `Tab` switches between meaningful control groups, while directional keys operate **inside** the active group. Use existing `FocusScope`, Qt Quick Controls focus policies, `GridView`/`ListView`, popup focus and `Accessible` semantics as much as possible. Do **not** build a global nearest-pixel navigation graph, large custom shortcut engine or speculative controls for screens that do not yet exist.

**Build the contract now.** Implement only the current necessary Fleet behaviour in P2. Extract a small reusable focus style and interaction helpers when P4 begins. Add screens and their context-specific rules when each genuine product feature arrives in P5/P6 and beyond.

## 2. Focus, current item, selection and business action are not synonyms

| Concept | Meaning | Design consequence |
|---|---|---|
| Keyboard **focus** | Which control receives the next key event | Visible high-contrast **Navy** focus ring; distinguish keyboard vs pointer focus when appropriate |
| Collection **current item** | Which visible GridView/ListView item arrows navigate | May be a temporary **proxy index**, never a permanent record ID |
| Domain **selected vehicle** | Stable C++ vehicle ID currently inspected in Fleet | Mint/Teal selected treatment, synchronized across Gallery/Table/Inspector and sort/filter |
| Command **activation** | An explicit user action such as open, rent, return or confirm | Keyboard movement must **never** commit a booking, mutate storage or delete a record |

**Fleet P2 chosen behaviour:** arrow movement in the active vehicle collection changes the inspected vehicle **selection**, not just scroll position. Updating the selected ID must go through the authoritative C++ filtered/sorted model. Re-sort/re-filter/re-layout must not accidentally select the vehicle that happens to occupy a previously stored row number. When a selection is hidden by a filter, define an explicit visible fallback and keep the Inspector consistent; never display a stale record as though still visible.

## 3. Standard key policy (Windows)

| Key | Where / when | Required effect |
|---|---|---|
| `Tab` / `Shift+Tab` | Across active controls and meaningful groups | Next / previous logical **visible, enabled** focus target in reading/task order; no traps or teleporting |
| `Up` / `Down` | Vertical navigation/sidebar/menu/Table | Move to previous/next relevant **item** while the group owns focus, not merely scroll |
| `Left` / `Right` | Gallery and true horizontal sibling groups | Move to the adjacent item in that visual direction; **no global geometric search** |
| `Enter` / `Space` | Focused actionable control | Activate or select according to its semantics; never fire a destructive command on movement alone |
| `Escape` | Popup, modal, Inspector, transient context | Dismiss **topmost** popup/dialog first, safely cancel/restore focus; otherwise clear nonmodal Inspector selection when appropriate; do nothing if there is nothing to dismiss |
| Arrows in `TextField`, `ComboBox`, editable widgets, slider | Input group | Preserve Qt-native caret, dropdown option or value navigation; do not intercept as Fleet shortcuts |
| `Home/End`, `PageUp/PageDown`, Ctrl shortcuts | Context-dependent | Preserve native component defaults until an actual feature needs a documented, discoverable mapping |

**Boundary policy:** do not wrap a non-popup Gallery/Table invisibly from last item to first (or vice versa). At an empty, disabled or no-next-item boundary, keep a clear, stable focus/selection. If the final Grid row is incomplete, remain on the nearest valid **actual grid item** in the requested direction or stay put; never skip to an unrelated workspace. Popup menus may use their native cycling behaviour.

**Cross-region Right from sidebar, owner-approved hybrid (Option A):** When the Fleet sidebar item **has keyboard focus**, `Right` will enter the **Search** control when that explicit connection is implemented. While Search is focused, `Left/Right` continue to move the **text caret**, and `Tab` advances to **All**, followed by the other controls in normal task order. Native `ComboBox` arrows keep their option-selection meaning. **Do not add an Enter-to-edit navigation mode or a global nearest-pixel focus engine.** The visually active Fleet sidebar item need not be keyboard-focused. This is an **approved rule for future scoped P4 implementation**, **not implemented/verified by today's P2 spike**; do not block the next product milestone on building it now.

## 4. Fleet interaction rules for current P2 and later P4

- **Gallery** is one keyboard Tab stop as a collection; `Up/Down/Left/Right` navigate **vehicle cards** in displayed grid order (column count changes with width). The Inspector reflects the new ID. Do not confuse scrolling with selecting; scroll only enough to reveal a newly selected offscreen vehicle.
- **Table** is one keyboard Tab stop as a collection; `Up/Down` move through the visible sorted/filtered vehicle rows. Do not repurpose `Left/Right` to change unrelated screens. Future cell navigation must be separately specified if the Table becomes editable.
- **Search and filters** are individual meaningful Tab targets. Text editing and ComboBox arrows keep their native controls. Switching Gallery↔Table must retain current C++ vehicle ID, correctly focus the destination view when initiated by user action and not trap Tab.
- **Mouse and keyboard parity:** clicking a vehicle and selecting it with arrows must populate the same Inspector details. Visible focus is distinct from selected status. Vehicle status remains explicitly readable rather than indicated by colour alone.
- **Selection states:** no vehicles, no match, one vehicle, last row with missing cells, hidden/rented selection, changed sort, refreshed model and compact 1280-ish logical viewport all need consistent outcomes.

**Current implemented boundary (as of owner decision):** source [`f486c8a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f486c8a32b156ddeec1816b2ab2a4811c2c45431) implements an isolated P2 Gallery/Table arrow selection and visual focus prototype. [Qt6.8.3 run 41059423971](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41059423971) passed **9/9 Linux and 9/9 hosted Windows CTests**. The owner has **not yet signed off** the revised arrows' smoothness, exact focus order and handling on their Qt6.10.2 MinGW kit. Existing handwritten arrow/column code is **not automatically** a reusable future navigation framework; prefer Qt's `GridView.currentIndex` and built-in movement where supported and proven without introducing regressions.

## 5. Future features inherit rules, not premature code

| Region when built | Focus and interaction contract | Implementation stage |
|---|---|---|
| **Overview** | One Tab path through real controls and actionable KPI/drilldowns; no arrows jumping between unrelated cards | P4/P6 as needed |
| **Sidebar** | Up/Down focus within workspace entries, `Enter/Space` activates; Tab into content; no automatic business action from merely focusing a page name | P4 |
| **Rentals guided Vehicle → Customer → Review** | Step order, field error focus, preserved draft **in-memory only** unless persistent drafts are separately approved; explicit confirmation and safe Cancel | P5 |
| **Active, History, Returns** | Related lists have group-local arrows; action menus are explicit; focus restored after return/delete/cancel dialogs | P5/P6 |
| **Dialogs/menus** | Topmost modal receives keyboard priority and appropriate contained focus; `Escape` first dismisses modal, then returns focus to invoker, never clears Fleet selection behind it | When the dialog exists |
| **New future features** | Define only a short local key map and test alongside feature, reuse shared focus style/semantics | As explicitly approved |

No `Pending` reservations, Save Draft persistence, payments, cloud, API, AI, future booking or destructive shortcut is authorized by this contract.

## 6. Motion, accessibility and ergonomics

1. **Immediate confirmation:** changing focus or selected vehicle is responsive and visually obvious. Keep animations restrained and optional; prefer Qt native highlight movement, avoid repeatedly resetting scroll or imposing custom 3D transitions. Respect reduced-motion preferences where available and test rather than assume performance.
2. **Visible and distinct:** keyboard focus must have a strong border/highlight against Cloud White and Soft Mint, while selected state has its separate Teal/Mint cue. Include readable status text and accessible labels, roles, descriptions, focusable/focused state and equivalent press actions where appropriate.
3. **Predictable restoration:** when returning from Gallery↔Table, popup, dialog, page switch or filter, restore the last valid focus target when safe; if it has disappeared, choose a meaningful nearby active control. Disabled/hidden items are skipped, not focused.
4. **Native conventions first:** Qt Quick `FocusScope` and Controls `focusPolicy`, `GridView` and `ListView` currentIndex/navigation, `Keys` only in a truly active relevant scope, and `Accessible`. Avoid global `Keys.onPressed` that steals arrow or Escape events from native popup/input controls.
5. **Accessibility requires QA:** adding `Accessible` properties or a Tab ring alone is not screen-reader proof; include Narrator/keyboard-only testing in later whole-product accessibility/release gates.

## 7. Small, non-speculative implementation plan

**P2 now:** evaluate already-implemented Fleet arrows and focus on the user's actual Windows Qt6.10.2 MinGW 150% display; test multi-key smoothness, Gallery rows/columns at feasible sizes, end-of-list, scroll-to-visible, filter/sort and search input, Tab+Shift+Tab, `Escape`. Only make bounded bug fixes when evidence warrants, with updated exact-source tests. **No broader framework.**

**P3:** maintain typed C++ selected-ID and command/result boundaries, independent of presentation focus or visible QML indices.

**P4:** introduce the smallest reusable toolkit with documented keyboard contract, one shared visual `FocusIndicator`/state token, Qt native FocusScopes and per-control focus rules. Abstract only behaviour repeated by at least two real components, not hypothetical future pages. Build human-meaningful tab order, semantic accessibility and focus restoration.

**P5/P6:** integrate guided forms, results, modal return/confirmation, active/history lists with the same policy, adding tests per feature.

**P9:** full manual Windows keyboard, supported real 100/125/150% scale, assistive technology, performance, keyboard-only task completion, screen-reader and packaging acceptance.

## 8. Verification checklist, gate policy and non-goals

Record **PASS / FAIL / NOT TESTED** per actual Qt version, source SHA, screen scale, window size and input mode; never infer physical acceptance from GitHub synthetic `QT_SCALE_FACTOR`. Minimum Fleet cases: arrows choose expected adjacent ID; Inspector updates; no unrelated scrolling; selected item revealed when needed; boundaries do not wrap; responsive columns obey actual layout; sorting/filtering changes visible order safely; Tab and reverse Tab follow logical focus; changing Gallery/Table preserves selection; search caret and dropdown keys remain native; Esc priority is correct when dialogs exist; focus contrast readable at physical 150%.

**Formal milestone:** UX-CTRL-001 is **approved as product policy**, not a passed implementation criterion. As of 30 Oct 2026: **P0 5/5, P1 7/10, P2 3/6, P3–P9 0; 15/74 and 18.4% weighted coverage, NOT released**. Document approval alone adds **0** completed criteria. Do not merge Draft PR #6 or old PR #3/#4, or alter `main`, as a side effect of documenting this decision.

## Research basis

- [Microsoft: Keyboard interactions](https://learn.microsoft.com/en-us/windows/apps/develop/input/keyboard-interactions): Tab order, visible focus, arrow keys within related collection groups, direct actions.
- [Microsoft: Focus navigation](https://learn.microsoft.com/en-us/windows/apps/develop/input/focus-navigation): logical focus order and directional groups.
- [Qt 6: Keyboard Focus in Qt Quick](https://doc.qt.io/qt-6/qtquick-input-focus.html): focus propagation, FocusScope and reusable focus.
- [Qt 6: GridView](https://doc.qt.io/qt-6/qml-qtquick-gridview.html) and [ListView](https://doc.qt.io/qt-6/qml-qtquick-listview.html): current item, keyboard navigation, wrapping policy.
- [Qt 6.10: Focus Management in Quick Controls](https://doc.qt.io/qt-6.10/qtquickcontrols-focus.html): native control focus policies.
- [Qt 6: Accessible](https://doc.qt.io/qt-6/qml-qtquick-accessible.html): semantic roles, accessible names and actions.

**Change log:** 2026-10-30, version 1.0. Owner accepts the hybrid, native-first contract and incremental delivery approach. No new C++/QML implementation was authorized as a side effect.
