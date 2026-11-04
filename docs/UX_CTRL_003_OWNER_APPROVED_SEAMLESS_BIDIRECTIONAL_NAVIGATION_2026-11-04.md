# Rental Studio 2.0 | UX-CTRL-003: Seamless bidirectional desktop keyboard navigation

**Owner approval:** 4 November 2026, from physical Windows screenshots, navigation examples and explicit confirmation of the Up/Left rule.  
**Precedence:** This contract refines [UX-CTRL-002](UX_CTRL_002_OWNER_APPROVED_DIRECTIONAL_NAVIGATION_SEMANTIC_COLORS_CONTRACT_DETAIL_2026-11-04.md) for the named **reverse and cross-region** routes. It intentionally changes the Fleet Search Down route from directly entering the Gallery to first focusing the active Gallery/Table selector, to make that transition reversible. All other UX-CTRL-002 safety, colors, dialogs, access, selection and Enter behavior remain binding.  
**Acceptance:** Owner-approved **design**, not automatic on-device implementation approval. Formal score remains **45/74, fixed-weight 70.6%, P5 8/8, P6 9/9, P7 0/8**.

## 1. Owner-observed usability problem

The owner launched the modern application on physical Windows and explicitly reported that keyboard navigation into a group worked but **reverse movement was missing**. Specific complaints:

- **Rentals:** Up from All should focus Return lookup; Up from the first visible rental record should return to Find rental.
- **Fleet:** Up from the top Ford Ranger card should return to Gallery, then Down should return to Ford Ranger when it is still visible.
- Keyboard operation should flow throughout the normal application without needing the mouse, while preserving native input behavior and all explicit destructive-confirmation safeguards.

The owner then agreed to this top-boundary rule: **Up focuses the preceding visible action group; Left from the first top-level non-editable action returns to the active sidebar.** Text fields and native menu controls retain their own arrow semantics.

## 2. Navigation map (no global pixel-distance engine)

| Region | Up | Down | Other |
|---|---|---|---|
| Overview quick-action strip | Remain (static metrics above are not focusable) | First recent contract, when any exist | Left/Right through approved 3 actions, first Left -> sidebar; Enter activates |
| Overview first recent contract | Last valid quick action | Next contract | Enter opens existing read-only route through Rentals |
| Rentals New rental | Bounded at top | Enabled Return/Archive/Delete action, else Return lookup | Left -> Rentals sidebar; Enter opens guided booking |
| Rentals Return/Archive/Delete controls | New rental | Return lookup | Left/Right across enabled peers; Enter opens existing guarded review |
| Return lookup input/button | Last enabled action or New rental | Last focused status chip | Input Left/Right stays native caret; Enter on input runs active lookup only |
| Status chips: All/Active/Returned/Archived/History | Return lookup | Last focused due-timing chip | Left/Right moves focus only; Enter applies filter |
| Due chips: Overdue/Due today | Last focused status chip | Find rental | Left/Right within due group; Enter applies derived filter |
| Find rental input/button | Last focused due chip | Selected visible rental, first visible rental or enabled empty reset | Native text caret/IME and lookup Enter preserved |
| First visible rental record | Find rental input | Next record or View details if last | Enter opens read-only contract; selected C++ ID retained |
| Middle/last rental record | Prior record | Next record, then View details if enabled | No auto Return/Archive/Delete |
| View contract details | Last visible rental record | Bounded | Enter opens read-only modal; Escape restores appropriate focus |
| Fleet Search | Native input (Shift+Tab alternative) | Gallery/Table choice corresponding to active view | Text Left/Right caret retained; native IME honored |
| Fleet Gallery/Table choice | Fleet Search | Actual Gallery/Table vehicle collection | Left/Right between view choices; Enter activates chosen view |
| First Gallery row / first Table record | Active Gallery/Table choice | Next real vehicle row, if present | Enter inspects, never books |
| Deeper vehicle row | Previous physical row | Next real row within bounds | Gallery Left/Right inside row; C++ stable selected ID preserved |

**Focus memory:** The UI remembers the last valid Overview quick action, Rentals status choice, Rentals due-timing choice and Return lookup control. Actual vehicle/rental selection is **not** stored as an independent QML row number; the authoritative C++ selected ID and visible-row projection determine where reentry lands. Filters/sort/failed snapshot must not restore a hidden invalid selection.

**Visibility:** Moving focus into Rentals should reveal that control within the page scroll, without invoking PageUp/PageDown, mutating any record, or turning scrolling into focus navigation. Disabled actions are skipped or replaced with the nearest safe valid group. If the list is empty, only a visible enabled Show all rentals reset may take focus.

**Keyboard safety:** Arrow movement is never a business command. Enter/Space activation stays deliberately separate and all New rental, Return, Archive, Delete, Remove and financial changes retain existing confirmation and C++ guards. Return and Archive do not become red; permanent Delete/Remove remain red. Escape closes the top modal and restores the invoking target. No real customer data or payments are introduced.

**Native exceptions:** Search and lookup fields retain Left/Right caret; Up/Down transitions only where they do not interfere with IME composition. ComboBox keeps Qt-native arrows/popups. Tab/Shift+Tab remain viable for all controls, including Fleet Inspector, modal forms and areas without explicit arrow routes. Do not implement an arbitrary nearest-pixel global focus algorithm.

## 3. Verification and acceptance gates

The proposed source change provides bounded QML arrow handlers, selected-ID preservation and no-write focus transitions. The native CTest `rental_studio_ux_ctrl_003_wide` and `_compact` drives actual Qt key events at 1500x860/1280x720, including the expected reverse routes, internal list navigation, contract Enter/Escape and before/after **byte-for-byte original fictional file integrity**. The prior UX-CTRL-002 Fleet Search test is updated only to reflect the **new owner-approved additional Gallery/Table choice**.

**Do not claim CI success until the exact commit's Linux GCC and Windows MSVC hosted jobs complete green.** Hosted tests do not replace owner physical Windows Qt Creator 6.10.2 MinGW feel, actual 100/125/150% scale, Narrator or aesthetically smooth focus transitions. Record PASS, FAIL and NOT TESTED separately.

The development branch remains `feature/p7-sqlite-sandbox-20261102`, [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) remains stacked on P6, and protected stable main must never be changed without explicit owner consent. P7 D2-D8 real-data storage policy, final Fleet media, P8 installer and P9 release remain open.
