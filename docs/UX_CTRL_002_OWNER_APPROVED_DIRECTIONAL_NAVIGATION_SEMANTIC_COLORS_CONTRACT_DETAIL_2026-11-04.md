# Rental Studio 2.0 | UX-CTRL-002: Directional navigation, semantic color, hover and rental contract layout

**Decision date:** 4 November 2026 (Africa/Johannesburg)  
**Status:** **OWNER-APPROVED DESIGN REQUIREMENTS; IMPLEMENTATION AND PHYSICAL ACCEPTANCE OPEN.**  
**Applies to:** Offline-first Qt Quick/QML Overview, Fleet, Rentals, shared navigation, buttons and the read-only selected rental contract.  
**Source:** Owner's actual Windows Rentals screenshots and explicit feedback on 4 November, followed by confirmation of both requested clarifications: (1) Right from an active Overview sidebar item enters its quick actions and Left returns to sidebar; (2) Enter on a rental opens **read-only** contract details, never an automatic Return or Archive. Owner requested the complete interaction, exact colors and exact contract arrangement be documented.  
**Precedence:** This addendum refines the existing [UX-CTRL-001 keyboard policy](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) and selected [R1 Navy/Emerald theme](../design/r1/OWNER_THEME_DIRECTION_2026-10-30.md) for these named regions. It does **not** authorize a global geometric focus engine, change Qt-native field arrows, or overrule popup safety. Any future conflict in these named navigation and visual details: use UX-CTRL-002; for unchanged areas retain UX-CTRL-001.  
**No engineering claim:** This is a design contract and future test plan, not a compiled code change, Qt CI PASS, whole-product design signoff or P1/P2/P4 acceptance. Formal project score remains **45/74, fixed-weight 70.6%, P7 0/8**.

## 1. Owner-observed defect and intent

The latest 4 November real Windows Rentals screenshot confirms that the application launches and the owner can reach the bottom of the record panel with scrolling/PageUp/PageDown: both R001 and R002 plus the **View contract details** button are visible, with no obvious clipping in that screenshot. **Owner then explicitly rejects the quality of existing directional navigation:** moving from Overview to Fleet using Down must focus Fleet; Enter should actually switch the workspace. Inside each page, arrow keys should move naturally between visible actions and groups, with Enter activating the focused task. The present visual styling is too uniformly grey; remove/delete need recognizably destructive red, other actions purposeful color and QML hover feedback. Existing read-only contract details look like a formal unarranged field list and need an intentionally composed card layout.

A screen that scrolls correctly can still fail the interaction standard. Record **owner-reported scrolling PASS; directional-navigation/usability redesign REQUIRED**. Do not call P1 broader accessibility, P4 keyboard/Narrator or P2 scale testing accepted from this observation alone.

## 2. Keyboard semantics, non-negotiable safeguards

1. **Focus, active workspace, selected record and command are separate states.** An arrow moves focus or moves the highlighted current record. **Only Enter/Space or an explicit pointer action executes an enabled control**, and business state changes still need the existing separate confirmation and authoritative C++ guard. Arrow navigation never books, returns, archives, removes or deletes.
2. **Sidebar:** Up/Down moves keyboard focus among actual Overview, Fleet and Rentals buttons **without changing the current workspace**; Enter or Space activates the focused page. The selected workspace remains visibly selected in Navy even when keyboard focus moves elsewhere. Right from the **currently active** sidebar entry enters that page's first logical action. From an inactive entry, Enter activates that page first; Right must not silently switch pages.
3. **Cross-region return:** Left from a page's top-level action/group returns to the corresponding **active sidebar** item, unless focus is in text editing, a native menu, an open popup or a collection that owns Left internally. A focused action is announced by name and immediately outlined; selected and hovered states are visually separate.
4. **Inside groups:** Right/Left moves through enabled siblings laid out horizontally, Up/Down moves between explicit vertical groups. At first/last item, do not loop to unrelated items, change pages, or scroll unpredictably. Skip disabled/hidden controls predictably. Use bounded explicit focus connections in each FocusScope; **do not calculate nearest controls globally by pixel distance**.
5. **Keyboard activation:** Enter and Space activate focused enabled Buttons/filters/navigation. **On a focused rental record, Enter opens its read-only contract-details modal** for that exact selected ID. Return/Archive/Delete require their distinct named controls and original confirmation. Escape dismisses the topmost modal/popup first, then restores focus to the invoking row/control; no storage write on dismiss.
6. **Native input semantics:** Left/Right within a TextField move the caret; ComboBox, autocomplete/IME, spinbox and other input popups keep native arrows. Enter in Find rental executes lookup, **not** contract opening. Tab/Shift+Tab always remain a discoverable native fallback. A single-line Find rental input may use Down to enter the list only when no IME/popup is intercepting it. Do not steal Alt/Ctrl-modified navigation.
7. **Focus restoration and screen-reading:** On page return, preserve a valid last focused control where safe, otherwise enter first enabled action; on selection or filter removal, retain correct C++ identity, never stale row indices. Focus has visible Navy outline, appropriate Qt Accessible role/name/checked state, and an equivalent pointer route.

### 2.1 Sidebar and Overview routing (fixed explicit graph)

```text
Sidebar: [Overview] --Down--> [Fleet] --Down--> [Rentals]
                 each Enter/Space opens THAT workspace
                 Up reverses; Down/Up alone never opens one

Sidebar active [Overview] --Right--> [Review active rentals]
                                    --Right--> [Open Fleet]
                                    --Right--> [Review overdue]
                   [any top-level action] --Left at exit--> [Overview sidebar]
                   Enter on an action triggers the existing safe route
```

- The **visible Overview quick-action area must present these three actions in this left-to-right logical and visual order**, rather than keeping Review overdue isolated far above the others with a surprising keyboard jump. Move/reorganize an existing action instead of rendering an unintentional duplicate.
- **Review active rentals:** routes to Rentals with Active filter. **Open Fleet:** routes to Fleet. **Review overdue:** routes to the C++-derived oldest overdue active rental, only when it exists. If unavailable, display a disabled/empty-state explanation and skip it in arrow focus; do not fabricate an overdue record.
- At the last enabled Overview quick action, Right stays there. Left reverses the action order until the first action, then returns focus to the Overview sidebar entry.
- Other Overview interactive recent-contract rows have their own explicit collection navigation and keyboard activation; static metric cards are **not** turned into fake buttons.

### 2.2 Fleet routing

```text
Active [Fleet] sidebar --Right--> [Search]
Fleet toolbar: [Search] --Tab--> [Availability filter] --Tab-->
               [Sort] --Tab--> [Gallery / Table choice]
               Down from toolbar --> [active Gallery or Table collection]
Gallery: Left/Right moves adjacent actual vehicle cards, Up/Down moves rows.
Table: Up/Down moves actual visible vehicle rows.
Enter on focused vehicle --> select/show its existing Inspector details
                             (never begin booking automatically).
```

- **Search input caret exception:** typing keeps ordinary Left/Right. An operator uses Tab to leave Search. A single-line Search may use Down to enter the collection if this does not interfere with native input handling.
- From a horizontally focused **button/choice**, Left/Right may navigate adjacent Fleet controls. The Inspector's controls and any available management actions form a separate scoped group; focus is not teleported past card/table selection.
- Gallery selection changes the stable C++ vehicle ID and synchronizes Inspector. In Table view do the same. Across filters, sort and Gallery/Table changes, preserve selection only if still visible; scroll to new current item; never leave a stale Inspector.
- Enter on a Fleet record is **inspect**, not New rental/Remove. The separate **Start rental** action and existing booking confirmation remain mandatory. Remove uses a separately marked red control and its typed confirmation.
- Arrow access and focus must work at both 1500x860 and 1280x720 logical windows and supported physical 100/125/150% scaling.

### 2.3 Rentals routing (owner's requested path)

```text
Active [Rentals] sidebar --Right--> Status: [All] -> [Active] ->
                                        [Returned] -> [Archived] -> [History]
                                           Right moves; Enter applies filter
                                     Down from All -> [Overdue]
Return timing: [Overdue] --Right--> [Due today]
                 Down -------------------> [Find rental ID field]
Find rental:    [Rental or vehicle ID] --Tab/Right*--> [Find rental button]
                 Down -------------------> [first/selected visible rental]
Rental list:    [R001] --Down--> [R002] --Down--> ... bounded at end
                 Enter ------------------> [Read-only contract detail]
```

`* `Right from the **editable input** moves its caret, not focus. Use Tab to reach the Find rental button; Left/Right apply to button siblings only. The diagram is a visual reading-order concept, not permission to override that exception.

- Status row horizontal order is exactly **All, Active, Returned, Archived, History**. Due row horizontal order is **Overdue, Due today**. Both retain accurate C++-backed counts and checked states; **Overdue/Due today are read-only derived filters, not new stored rental statuses.**
- From All, Down **must** land on Overdue as the owner described. For another status item, Down enters the appropriate enabled return-timing control via an explicitly documented stable mapping, or the next available group when due-timing items are not relevant. No positional guessing.
- From Overdue or Due today, Down focuses the Find rental input. From that single-line input, Down reaches the selected visible contract (or first visible contract); while text editing and IME interactions are active, native behavior takes priority and Tab offers equivalent access.
- Within the rental list, Up/Down selects the corresponding current C++ rental ID and reveals the row in the scroller. **Enter on that focused row opens the details modal** for the currently selected visible rental. A pointer single click still selects; a deliberate double-click may open details if clearly supported and tested. Maintain the separate visible **View contract details** button for discoverability, accessibility and pointer users.
- When no records match, Down navigates to **Show all rentals** if visible/enabled; otherwise remains at the nearest meaningful focus target. On lookup miss, ambiguous vehicle ID or unavailable snapshot, no hidden record is selected and the existing safe error feedback remains.
- New rental, Return, Archive and Delete areas are distinct action groups. Moving arrows in Rentals must not invoke any of them; activation and existing durable-write/reconsent safeguards remain.

### 2.4 Focus/hover/selection distinction

| State | Visual rule | Behavior |
|---|---|---|
| Keyboard focus | **3 px solid Navy `#17324D` outline**; 2 px gap where geometry allows | Shows what Enter/Space affects; immediate and not animation-dependent |
| Current/selected workspace | Navy `#17324D` fill + white text | Persists independently of keyboard focus |
| Selected vehicle or rental | Soft Mint `#E8F5F0` fill + **2 px Emerald `#0F766E` border** | Stable selected ID, not automatically a command |
| Mouse hover | Token-specific hover fill, no focus ring unless keyboard-focused | No data change; no false selected checkmark |
| Pressed | Brief darker fill or inset response | Must not double submit |
| Disabled | `#E6EAEE` background + `#6B7580` label; explicit reason where possible | Not arrow/Tab activated; never presented as an enabled destructive command |
| Popup open | Focus contained in topmost popup; initial safe action | Escape closes, restores focus, no background activation |

## 3. Exact approved semantic palette (hex values are normative)

Preserve the preselected R1 base colors. The newer warning, destructive, neutral-hover and accessible focus roles below are the precise design specification for **this revision**, not evidence that existing QML already uses them. No competing sage/copper or V3 palette.

| Role / token | Hex | Required use |
|---|---|---|
| `canvas` | **`#F6F8FA`** | Main screen background |
| `surface` | **`#FFFFFF`** | Dialogs, forms, contract cards, raised content |
| `sidebar` / `ice` | **`#EAF0F4`** | Left rail, quiet cards, default neutral filters |
| `navy` | **`#17324D`** | Major headings, active sidebar, primary keyboard focus |
| `teal` / `primary` | **`#0F766E`** | Create, proceed, valid primary next action |
| `primaryHover` | **`#0C625C`** | Hover for Teal button |
| `mint` / `selectedSurface` | **`#E8F5F0`** | Selected records, verified value/estimate summary |
| `mutedInk` | **`#5F6F82`** | Secondary text on white/canvas |
| `border` | **`#D8E2E8`** | Neutral input and card outline |
| `rentedInk` | **`#1D4ED8`** | Explicit Rented status, text plus status |
| `warningSurface` | **`#FFF2D5`** | Due/overdue attention and non-destructive warning |
| `warningInk` | **`#965A0A`** | Warning label and icon |
| `danger` | **`#B42318`** | **Delete archived**, **Remove vehicle**, irreversible destructive confirmation |
| `dangerHover` | **`#912018`** | Destructive-button hover |
| `dangerSoft` | **`#FEECEB`** | Destructive dialog caution panel or soft danger badge |
| `neutralHover` | **`#DCE8EF`** | Secondary buttons/chips/neutral cards on hover |
| `disabledSurface` | **`#E6EAEE`** | Inactive or unavailable action |
| `disabledInk` | **`#6B7580`** | Disabled label only |
| `whiteInk` | **`#FFFFFF`** | On Navy, Teal, Red filled buttons |

**Semantic action map (must remain consistent across all workspaces):**
- **Primary Create / New rental / Confirm safe progression:** filled Teal `#0F766E`; hover `#0C625C`; text white.
- **Navigation selected / active filter:** filled Navy `#17324D`; text white. Unselected filters use Ice `#EAF0F4`, Navy label and Neutral Hover `#DCE8EF`.
- **View contract / Open Fleet / Search / Close:** white or Ice, Navy label; hover `#DCE8EF`; Navy 3 px keyboard focus outline. Do not use red for mere viewing.
- **Overdue / Due today / attention:** `#FFF2D5` with `#965A0A` plus explicit words/icons; use C++ date derivation, not color alone.
- **Return selected rental:** positive/secondary state-changing action (Teal or clearly styled secondary), **not red**, requires its separate confirmation. **Archive returned:** neutral or warning treatment, **not an irreversible-delete color**. Both only enabled on eligible current contract.
- **Remove vehicle / Delete archived / irreversible erase:** **RED `#B42318`** with white text, deeper red `#912018` hover, and red-bordered/soft-red final confirmation. Never make permanently destructive actions merely grey or the same Teal as New rental. Disabled destructive buttons remain neutral disabled until available.
- **Error feedback:** red text with descriptive wording, not a bare warning icon; avoid claiming a deletion occurred until C++ returns success.
- **Focus vs status:** Navy focus remains distinct from Mint/Teal selected; a danger button still receives the Navy focus outline, with sufficient separation from the red fill.

**Contrast checks for palette candidates, not whole-screen accessibility certification:** white on Teal ~5.47:1; white on Red ~6.57:1; warning ink on warning surface ~5.03:1; Navy on Ice ~11.42:1; muted ink on canvas ~4.83:1; red on soft-red ~5.76:1. Verify actual text/control pairs in rendered Qt views, especially disabled labels, borders, focus and compact sizes. Do not rely solely on color to express status.

## 4. Hover, press, motion and focus implementation contract

- Qt Quick equivalent of CSS hover: set `hoverEnabled: true`, bind visible surfaces to `hovered` / `down` states; use shared `DesignTokens`, reusable button/StatusChip/FocusFrame styles and C++ `MotionPolicy`. No CSS/web frontend introduced.
- On hover: soft neutral button `#FFFFFF` or `#EAF0F4` -> `#DCE8EF`; Teal -> `#0C625C`; Red -> `#912018`; records -> faint Ice or Mint without changing selected ID. Pointer leaves restore correct idle/selected base.
- Hover and selected/keyboard focus use **different** visual layers; keyboard users get the same clarity without a mouse. Touch/no-hover still functions.
- Hover tint transition **90 ms maximum when ordinary motion is enabled; 0 ms when reduced-motion is enabled/unknown**. Focus outline, cursor/current selection and confirmation enabled state update instantly. Never animate business values, modal consent or warnings. Existing platform motion policy remains authoritative.
- Interactive controls use at least **44 px logical high target** where feasible. Accessible names describe the resulting action; disabled actions have context explanation. Do not weaken existing Escape and typed confirmation protections.

## 5. Exact read-only Rental contract detail redesign

**Current source:** `RentalListModel::selectedContract`, the deliberately narrow **10-key allowlist**: `rentalId`, `vehicleId`, `status`, `dueState`, `startDate`, `expectedReturnDate`, `actualReturnDate`, `days`, `dailyRate`, `total`. Current modal displays these as a flat vertical sequence. This spec **rearranges exactly those verified fields**; it must not request customer names, contacts, driving licences, deposits, payment status, licence plates or new PII.

**Modal shell:** titled **Rental contract**, modal read-only, width `min(600 logical px, window.width - 48)`; maximum height `min(650 logical px, window.height - 64)` with an inner scroll if necessary. White `#FFFFFF`, 14 px outer radius, 24 px content padding (16 px compact), consistent 16 px section spacing. At narrower content width stack all metric cards one column, instead of truncating. Preserve real Escape/Close focus restoration and blocked interaction with background dialogs.

### 5.1 Mandatory visual order

```text
+------------------------------------------------------------------+
| RENTAL CONTRACT                                  [ACTIVE status] |
| R001                                     [OVERDUE warning if due] |
| Vehicle C002                                                     |
|------------------------------------------------------------------|
|                                                                    |
|  [ Rental duration  ]       [ Daily rate         ]                |
|  [ 2 days           ]       [ R 700.00           ]                |
|                                                                    |
|  [ Start date       ]       [ Expected return    ]                |
|  [ from C++ date    ]       [ from C++ date      ]                |
|                                                                    |
|  [ Actual return    ] (if shown, Not returned / verified date)     |
|                                                                    |
|  +--------------------------------------------------------------+  |
|  | BOOKED CONTRACT TOTAL                                        |  |
|  | R 1,400.00                                                  |  |
|  | Booked value, not a payment receipt                         |  |
|  +--------------------------------------------------------------+  |
|                                                                    |
|  Read-only verified rental summary                 [ Close ]      |
+------------------------------------------------------------------+
```

**Diagram uses the fictional R001/C002/R1,400 visible in the owner's screenshot; example duration and rate values are only arithmetic illustration, not verified actual source values. The running UI MUST bind every figure/date to the real selected C++ contract.**

### 5.2 Exact component hierarchy and geometry

1. **Top identity row:** compact all-caps eyebrow `RENTAL CONTRACT` (12 px muted), large **rental ID** (26 px Navy, bold), secondary **Vehicle <vehicleId>** (14 px muted). On the right an explicit status pill (e.g., Active, Returned, Archived) with text plus color; a separate due-state pill when C++ says Overdue/Due today. Do not call Overdue a stored lifecycle status.
2. **Divider:** 1 px border `#D8E2E8`; 16 px vertical separation.
3. **Two-column information grid** on sufficient width (e.g., inside content width >= 460 px), with **16 px gap** and 12 px card radius; otherwise 1 column. **Row 1:** Rental duration | Daily rate. **Row 2:** Start date | Expected return. Actual return appears as a **full-width third row**, titled Actual return, showing ISO date if recorded or **Not returned** if absent. All labels 12 px muted; value text 16 px Navy. Each mini-card has Ice `#EAF0F4` base, 12–16 px padding; long values wrap.
4. **Financial highlight:** full-width **Soft Mint `#E8F5F0`** rounded panel, 16–20 px padding; small header **BOOKED CONTRACT TOTAL**, large Navy booked amount (26 px bold, two decimals with R currency prefix), and visible caption **Booked value, not a payment receipt**. Never say Paid, Revenue or Deposit received.
5. **Footer:** quiet note **Read-only verified rental summary** at left; **Close** neutral button at right, at least 44 px high. The **Close** button initially receives safe keyboard focus when opened. Enter on Close dismisses; Escape dismisses; both restore focus to the invoking rental row/list or the existing View contract details button. No Return, Archive or Delete action in this read-only modal.
6. **Selection and stale data:** capture the opened exact rental ID and require `selectedContract` to continue matching an available verified snapshot. If selection changes, data refresh invalidates validity or snapshot fails while open, **do not render mixed fields from another contract**. Close the modal or show an explicit unavailable/please-reopen state with no stale financial details.
7. **Dates/rates:** show existing authoritative ISO YYYY-MM-DD dates or another locale format only if unambiguous and tested; money formatted as **R 1,400.00** example (not necessarily the previous `R 1400.00` spacing) using C++ supplied values, with no rounding or rule derivation in QML. Do not infer or fill absent source fields.

### 5.3 Contract status color rules

- Active: soft Mint with Teal status ink, label **Active**.
- Returned: Ice with Navy text, label **Returned**.
- Archived: Ice with muted Navy text, label **Archived**.
- Overdue / Due today: warning `#FFF2D5` plus `#965A0A` and explicit corresponding text. If due state says NotApplicable, no misleading overdue chip.
- Not returned is data absence, **not** a red failure. A deleted/unknown or unavailable selected contract shows no old modal content.

## 6. Native implementation and staged verification checklist

**Sequence (design requirements approved, implementation not started):**
1. Extend `DesignTokens.qml` and shared button/StatusChip/FocusFrame styles to implement semantic colors, hover and focus without altering business logic.
2. Introduce bounded scope-local focus routes in `WorkspaceNavButton.qml`, Overview actions and Fleet/Rentals focus groups. Re-layout Overview actions into an actual ordered strip; retain native TextField/ComboBox behavior. Add sensible visible/disabled skips and focus restoration.
3. Implement Enter-open-read-only-contract on a focused rental record, preserve selected ID, pointer route and C++ exact data source. Do not change Return/Archive/Delete controllers.
4. Replace only the contract modal's flat labels with the precisely ordered header, grid, actual-return card, Mint total panel and Close footer. Prevent stale cross-record details and test keyboard Escape.
5. Native real Qt wide/compact tests: every sidebar Up/Down/Enter/Right/Left route, Overview quick-action order/activation, Fleet Gallery/Table arrows and Enter inspect, Rentals All->Overdue->Find->list path, list Up/Down/Enter opens correct modal, TextField caret preserved, ComboBox native options, disabled skipping/boundaries, Escape restores, hover colors and keyboard-focus tokens, reduced-motion 0 ms, no inadvertent writes.
6. Manual owner Windows acceptance: keyboard-only route on Qt Creator/MinGW and packaged build, actual 100/125/150% scale where supported, real Narrator spoken roles/state, compact modal readability and keyboard focus, color/hover aesthetics, safe warnings, protected fictional data. Record PASS/FAIL/NOT TESTED per criterion; avoid an automatic overall signoff.

**Must preserve:** current C++ model authority, original SHA-pinned fictional fixtures, invalidation of review dialogs after selection or refresh, immutable protected files on failed lookup/cancel/escape, no real customer data, no P7 production cutover and no release/merge. No production source or Qt test result is claimed by this design-only record.

## 7. Acceptance and tracking

- **Owner decisions recorded:** Yes to Overview Right entering actions and Left returning; Yes to rental-record Enter opening read-only details; Yes to a holistic directional-navigation/hover/semantic-color improvement and the exact card-based contract arrangement captured here.
- **Implementation status on 4 Nov 2026:** **SPECIFICATION ONLY / NOT IMPLEMENTED**. Existing scroll/PageUp/PageDown owner observation is separate, and user considers current navigation **unsatisfactory**.
- **Formal rubric:** P1 7/10, P2 4/6, P4 5/7, overall **45/74 weighted 70.6%** unchanged. No owner physical keyboard/Narrator or whole-product final design gate closed.
- **Related sources:** [UX-CTRL-001](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md), [R1 theme](../design/r1/OWNER_THEME_DIRECTION_2026-10-30.md), [P6-K current contract detail](P6_K_CONTRACT_DETAIL_NATIVE_VERIFIED_2026-11-02.md), [UX-S18 verified implementation](UX_S18_PRECISE_RENTAL_LOOKUP_FEEDBACK_NATIVE_VERIFIED_2026-11-04.md), [physical Windows review checklist](P1_P2_P4_ONE_SESSION_PHYSICAL_REVIEW_2026-11-03.md), [P0-P9 frozen scorecard](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md).

**Explicit out of scope:** new payment capabilities, real-person/contact data, driver IDs, hard-delete policy, production SQLite, P8 installer, final fleet photography and commercial release. All remain under their separately recorded owner decisions.
