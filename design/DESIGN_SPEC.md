# Rental Manager — Operator Console

**Phase 1 visual and interaction design | Draft v0.1 | 29 October 2026**  
**Project:** [Sonkhe-Shongwe/vehicle-rental-system](https://github.com/Sonkhe-Shongwe/vehicle-rental-system)  
**Target:** Retipuj Zoft Software Engineer (Full-Stack) Graduate application (30 October 2026)  
**Implementation status:** **CONCEPT ONLY.** The HTML prototype and screenshots are design references, not compiled Qt screens, live application output, a database/API feature or evidence of GUI acceptance. The existing C++/Qt source remains unchanged by this phase.

## 1. Product direction and design objective

Turn the university-style collection of CRUD pages into a coherent **local rental operations console**. Make it faster to answer these questions:

1. Which vehicles are available and which are being rented?
2. Which rental needs attention, and when is it due?
3. How do I create a rental or complete a return without navigating through unrelated screens?
4. What can I safely change, and has the system actually saved it?

The design should look professional without imitating a specific commercial rental product. Keep the C++17/Qt Widgets desktop application and its existing domain behaviour. Avoid introducing future reservations, payments, user accounts or API-dependent displays until they exist in tested code.

**Design system working title:** Rental Manager / Operator Console. **Proposed direction**, not final approval.

## 2. Actual-source baseline and design delta

The source file `mainwindow.cpp` currently has a fixed 235 px sidebar, a window minimum of 1280×720, nine primary action destinations, eight dashboard statistic cards, and a shared data table beneath the page stack. The historical screenshots demonstrate existing navy navigation and a light workspace, but they do not prove that the recent hardened build has passed Windows GUI tests.

| Existing baseline | Problem for real operators | Design decision to evaluate | Scope guard |
| --- | --- | --- | --- |
| Dashboard, Add Vehicle, Remove Vehicle, Search Vehicle, All Vehicles, Available Vehicles, Rent Vehicle, Rental History, Return Vehicle in permanent navigation | Operators must mentally translate separate CRUD operations into tasks | Three prototype destinations: Overview, Fleet management, Rentals; history and returns become contextual rental views/actions | Existing Qt slots stay until replacement passes parity tests |
| Eight equally prominent KPI cards | Duplicates fleet status and buries actionable information | Four primary KPIs: available vehicles, active rentals, due within 7 days, booked rental value | Rename old `Rental Revenue`; do not equate booked values with collected payments |
| Large shared table with empty lower area | Weak information density and unclear purpose | Bounded recent activity, a focused attention queue and availability comparison | Use real filtered records, never decorative charts or fabricated alerts |
| Separate search/add/rent/return pages | Excess page switching | Fleet search + filters + detail inspector; rental ledger + same-day new-rental form | Keep existing business validation and save semantics |
| `setMinimumSize(1280,720)`, fixed wide form cards | Poor fit on scaled/narrow desktop windows | Layouts reflow at narrower widths and scrolling contains dense tables | Test on Qt 1366×768 at 100% and 125%; HTML reflow is not Qt proof |
| Many inline QSS declarations | Styling drift as features grow | Central tokens + component class/style roles | Do not recreate the entire Qt widget hierarchy at once |

## 3. Prototype and evidence files

- [Interactive HTML concept](prototype.html). **Standalone self-contained design only:** navigate among three screens; search/filter the 5 vehicle records; inspect a selected vehicle; preview rental duration/price; switch Active/History tabs. No live Qt app, local files or server are modified.
- [Dashboard concept](dashboard.png)
- [Fleet management concept](fleet.png)
- [Rental management concept](rentals.png)
- [1280 px dashboard layout check](dashboard-1280.png)

The fictional demo data comes from the repository's `demo/vehicles.txt` and `demo/rentals.txt`. At the design snapshot (29 October 2026) it has **five vehicles, four available, one currently rented**, and **two rental records**: one active, one returned. The booked rental values are R1,400 and R900 (R2,300 combined). A rental is due on 30 October 2026, giving the prototype one due-within-7-days item. These are **illustrative demo records**, never live-business evidence or proof of revenue received.

## 4. Visual language (proposed tokens)

| Role | Value | Usage |
| --- | --- | --- |
| `nav` | `#172538` | Primary navigation rail |
| `nav-hover` | `#203148` | Nonselected hovered navigation |
| `ink` | `#15263E` | Headings and important values |
| `ink-soft` | `#405573` | Table data and secondary labels |
| `muted` | `#6C7B90` | Supporting instructions and metadata |
| `blue` | `#245DEB` | Primary CTA, selected navigation, focus |
| `blue-tint` | `#EAF0FF` | Informational backgrounds and rented state |
| `surface` | `#FFFFFF` | Content panels |
| `background` | `#F6F8FC` | Workspace canvas |
| `border` | `#E5EAF1` | Panel and table separators |
| `success` | `#16815C` | Available, returned |
| `warning` | `#B26A13` | Due soon (time-qualified) |
| `danger` | `#B13B44` | Errors, destructive actions |

Typography: Segoe UI / Inter / system sans fallback; headings about 29 px in the HTML reference and equivalent scalable Qt point sizes. Use a spacing rhythm of 4, 8, 12, 16, 20, 24 and 32 px. Borders should be subtle; 9–13 px radii. Prefer icon + text labels, particularly in the primary navigation. Reserve blue for primary and selected states, orange for genuinely due items, and green for reliably completed/available states.

**Not yet verified:** WCAG AA colour contrast for each font size and state; high-DPI Windows rendering; keyboard focus in native Qt; system font metrics at 125% scaling. These are acceptance gates before finalising tokens.

## 5. Screen A: Overview dashboard

### Structure
- Persistent title bar: `Operations / Overview`, current context and explicit concept label (prototype only).
- Heading `Fleet overview`; primary `New rental` and secondary `Add vehicle` actions.
- Four KPIs with *accurate definitions*: available/total fleet, active rental count, due within 7 days, **booked rental value (all recorded rentals)**. Display a time scope where appropriate.
- Main left: recent rental activity, limited to 5–8 results where data exist; rental ID, vehicle, fictional customer, booked value, status.
- Main right: `Needs attention` with contextual `Open rental` action and a compact fleet-availability proportion.
- No meaningless “real-time” badges or invented financial trends; if zero records, show helpful empty-state text.

### Required Qt states
- **Empty fleet:** zero KPIs (with honest denominators), ``Add a vehicle`` CTA; no empty analytics containers.
- **Fleet but no rentals:** empty recent-activity message; `Create first rental` CTA.
- **Approaching due date:** due label calculated against the local date using the documented clock rule.
- **Overdue:** differentiated from due soon, never hidden in an active-rentals total.
- **Read/save failure:** visible recovery path; never display “Saved” if `QSaveFile` reported failure.

### Acceptance
No more than four equally prominent KPI cards. Recent activity contains only actual rental records; selecting one navigates to its details. A reviewer can find an available vehicle or an active rental within two actions from the dashboard. Financial label does not claim payment collection.

## 6. Screen B: Fleet management

### Structure
- Search by ID, brand, model; filter `All`, `Available`, `Rented`.
- Table fields: vehicle, ID, class, rate/day, availability.
- Optional right details inspector: selected vehicle, current status, subtype details (doors/engine cc), appropriate action.
- `Add vehicle` is a primary contextual action; editing and removing (after confirmation) belong to vehicle details instead of main navigation.
- Use a selected-row state and keyboard row activation. Search and status filters must compose predictably.

### Required Qt states
- No vehicles; filter with no match; unavailable vehicle; selected vehicle removed; malformed imported record; save failure; rate validation failure.
- Never offer a working `Rent` action on an already rented vehicle. Its primary action should open the active rental.

### Acceptance
Searching `M002` or `Yamaha` finds the motorcycle in the demo data. Filtering `Rented` shows `C002` only. The detail view never displays stale vehicle attributes after the selected record changes. No deletion occurs without preview, confirmation and successful persistence.

## 7. Screen C: Rental management

### Structure
- Active and history tabs above the ledger, with statuses grounded in data: **Active, Returned, Archived** in current release scope.
- Active rental card/table includes vehicle, customer, start, expected return, booked total and contextual `Return` action.
- Same-day `Create rental` flow selects *only currently available* vehicles, customer identity/contact, rental duration, verified daily rate, computed expected return and computed total.
- `Create rental` is a deliberate confirm action; avoid blocking success popups for repeated normal work, while preserving strong errors and destructive confirmations.

### Required Qt states
- Empty active list; completed rental; past due; duplicate active rental attempt; invalid customer input; unavailable vehicle; write failure; return date validation; restart consistency.
- Important distinction: **advance reservations** are *not implemented*. Do not label this flow “Reserve” or claim date-range availability until overlap logic exists and is tested.
- Rental prices are business calculations, not authoritative values typed by the UI; service must validate the totals and report errors clearly.

### Acceptance
A user can start the rental process from Overview, choose an available vehicle and see the total update as the number of days changes. Confirming the real Qt workflow must either save a valid rental exactly once or return a visible error with state preserved. Return and archive actions must not destroy history.

## 8. Concrete Qt mapping, implementation order

**Milestone D0 — design review (this document):** HTML prototype, three screenshots, comparison and acceptance scenarios. **No Qt source changes.**

**Milestone D1 — safe shell and navigation:** Add a central style token file; group sidebar into Overview, Fleet and Rentals, using existing pages/slots as adapters. Keep all legacy user journeys callable until replaced. Validate keyboard selection and target resolution.

**Milestone D2 — dashboard hierarchy:** Replace the eight-card layout with the specified four KPIs and meaningful activity/attention panels, driven by `RentalSystem`, never static demo numbers. Verify current totals and empty states.

**Milestone D3 — fleet workspace:** Introduce FleetPage and a data-bound Qt table, reuse existing CRUD service logic; search+status filter, selection inspector and add form; consider `QAbstractTableModel` with `QSortFilterProxyModel` for maintainability.

**Milestone D4 — rental workspace:** Unify current rent, return and history pages in a task-oriented RentalsPage. Same-day limitation clearly displayed. Preserve and test rental price, duplicate prevention, return and archive transitions.

**Milestone D5 — Windows quality gate:** 1366×768 at 100% and 125% scaling, keyboard-only completion, Qt Creator Windows build, domain + UI smoke tests, import/restart with disposable files, safe screenshots. Only then replace the historical README screenshots with verified current GUI captures.

**After validated UI:** safe AppData migration, modular repository/service boundaries, SQLite transactions and (optional) API. These remain separate, individually testable engineering milestones.

### Suggested Qt component responsibility map

```text
MainWindow / AppShell       navigation, active workspace, visible global errors
  ├── DashboardPage         four KPIs, due-state view, recent rentals
  ├── FleetPage             filters, table, selected vehicle, add/edit workflow
  ├── RentalsPage           active/history, new rental, return flow
  └── Shared UI             status chip, form row, feedback, empty/error widget
           ↓
     RentalSystem (legacy service, preserve existing rules)
           ↓
     Vehicle / Car / Motorcycle / Rental
           ↓
     current text-file persistence (SQLite only after migration proof)
```

Do not refactor storage and UI simultaneously without a regression baseline.

## 9. Design prototype interaction checks

Completed on the self-contained HTML prototype using local headless Chromium, **not** Qt:

- Navigation displays the correct three page headings.
- Fleet search `yamaha` returns one row; rented filter returns one row, `C002`.
- Clicking a fleet record changes the details inspector.
- Fleet rented-vehicle action navigates to rentals; no disabled rental action is promised.
- Changing rental duration from 3 to 5 days updates the demo total from R1,350 to R2,250 for C001 at R450/day.
- Missing name/phone blocks the prototype submit; entering fictional values displays `not saved`, with no data writes.
- History tab shows exactly two fictional records.
- Prototype renders at 1440×900 and a 1280×720 dashboard capture. **No Qt/Windows UI test was run by these checks.**

## 10. Alternatives and rejected directions

- **Pure dark dashboard:** visually striking but becomes less readable for long tables and forms. Retain the existing navy rail, keep primary workspace light.
- **Dense enterprise ERP layout:** efficient for trained power users but intimidating for a graduate portfolio demonstration. Use progressive details.
- **Large full-bleed vehicle photography:** attractive for a customer marketing site, distracting in an operator console. Use compact consistent icons instead.
- **Calendar booking app:** potentially useful later but cannot be represented as working before date-overlap and availability rules are implemented.
- **React/Qt Quick rewrite, payments, sign-in or AI now:** unnecessary and risky for the deadline; defer until there is a verified user requirement.

## 11. Product decision register

| Decision | Current state | Next decision / proof |
| --- | --- | --- |
| Keep C++17 / Qt Widgets | **Confirmed project constraint** | Maintain existing build/test compatibility |
| Operator-focused navigation / light-first visual language | **Proposed** | Owner review of prototype and screenshots |
| Four dashboard KPIs | **Proposed** | Validate business definitions against rental model |
| Task-first Fleet and Rentals workspaces | **Proposed** | Owner approves structure; test current workflow parity |
| No future reservations in current UI | **Confirmed existing limitation** | Implement only with tested date-range overlap rules |
| Windows GUI release readiness | **Unverified** | Qt Creator, responsive layout and end-to-end acceptance |
| SQLite / service API | **Future only** | Data migration / transaction / service contract tests |

## 12. Research and source-of-truth references

- [Comparative research (29 Oct 2026)](../docs/PORTFOLIO_RESEARCH_2026-10-29.md)
- [Current project source audit](../docs/AUDIT.md)
- [Current engineering roadmap](../docs/ROADMAP.md)
- [Qt model/view](https://doc.qt.io/qt-6/model-view-programming.html)
- [Qt Style Sheets](https://doc.qt.io/qt-6/stylesheet.html)
- [Qt standard paths](https://doc.qt.io/qt-6/qstandardpaths.html)
- [Qt Test](https://doc.qt.io/qt-6/qtest-overview.html)

**Governance:** This directory is a design proposal and visual handoff. It is not production Qt source. Approve the design explicitly before replacing functional GUI code. Every implemented step must carry a named test/visual acceptance result and update `docs/CONTINUITY.md`.
