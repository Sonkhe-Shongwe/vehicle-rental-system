> **HISTORICAL RESEARCH — superseded 29 October 2026.** This original career/portfolio research uses earlier UI-preservation and deadline assumptions. The owner now explicitly authorises a full product rebuild with a **light-first** design. Treat this document as source material and comparative research, **not as the current roadmap or architecture rule**. Current authority: [Master Product Audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md).

# Vehicle Rental System: From University Assignment to Graduate Engineering Portfolio

**Independent comparative research and product-development report**  
**Date:** 29 October 2026  
**Project:** https://github.com/Sonkhe-Shongwe/vehicle-rental-system  
**Target:** Retipuj Zoft, Software Engineer (Full-Stack) Graduate, Johannesburg / Remote, advertised closing 30 October 2026  
**Status:** Research and recommendations only. No application source was modified as part of this report.

## 1. Executive findings and decision

The existing C++17/Qt Widgets application is not a throwaway school project. It already implements inheritance and polymorphism, fleet CRUD, rental lifecycle, a multi-page GUI, pricing, active-rental checks, saved history, and local persistence. An Ubuntu 24.04 + Qt 6 GitHub Actions run has passed fixture checks, CMake configuration, compilation, and CTest. What it lacks is the product discipline that makes a reviewer trust and enjoy it: clear information hierarchy, a realistic operational workflow, good responsive behaviour, recoverable data, separation of presentation and domain logic, demonstrable real-world testing, and a concise visual demo.

**Recommended direction: a refined, light-first, operator-focused Qt desktop application, then transaction-safe SQLite and modular services, then a small optional API extension.** Preserve the working Qt application and its domain concepts. Do not spend the application deadline rewriting it in React, adding an unneeded login screen, or decorating it with unrelated AI.

Four conclusions govern the programme:

1. **Product realism beats feature count.** Rental software needs a credible transaction lifecycle and operational overview, not ten equally visible CRUD screens.
2. **Aesthetic quality is functional quality.** The visual system should make availability, the next action, expiry and errors easier to understand. It should not be limited to a new colour palette.
3. **Engineering evidence beats architecture labels.** A repository claiming MVC, security and tests is not automatically robust; inspect the design and prove the claims.
4. **Relevance to the full-stack graduate role requires honest positioning.** C++/Qt demonstrates application development; SQLite and a later documented REST API could broaden alignment with the advertised database/API requirements. Neither should be claimed before implementation.

## 2. Research scope, methodology and evidence quality

### Sources actually reviewed

- Current project source and implementation: `mainwindow.cpp`, `mainwindow.h`, `rentalsystem.cpp`, `rentalsystem.h`, `rental.*`, `vehicle.*`, `CMakeLists.txt`, CTest source, README and audit documents (29 October 2026 working baseline).
- Current **historical** visual captures: `screenshots/dashboard-redacted.png`, `screenshots/add-car.png`, `screenshots/add-motorcycle.png`. They show the earlier GUI and are **not** proof the hardened source has run on Windows.
- Public analogues: `onouh/Vehicle-Rental-System` (C++/Qt6/SQLite), `kowama/Car-Rental-App` (C#/Windows Forms), `StefanRomanov/Car-Rental-React` (React/Spring Boot/MySQL), and Booqable's published product workflows and calendars.
- Primary engineering references: official Qt Widgets, styling, model/view, QSaveFile, QSqlQuery, QStandardPaths, Qt Test, and resource system documentation; SQLite foreign keys; OWASP password storage; GitHub portfolio and README guidance; Microsoft Fluent layout.
- Employer evidence: Retipuj Zoft's LinkedIn company post and graduate listing.

The public analogue repositories are illustrative, **not audited or certified deployments**. Their README claims are identified as claims unless code or other primary evidence was checked. Commercial product pages are workflow inspiration, not open-source blueprints or a licence to copy their UI assets.

### What was not tested

No interactive Windows usability trial, crash-consistency fault injection, accessibility audit, payment integration, real bookings, production install/upgrade or REST service was executed for this report. The CI signal is a Linux build-and-domain-test signal only.

## 3. Comparison: what similar systems get right and wrong

| Reference | What is evidenced | Positive pattern to adopt | Caution / negative to avoid | Transfer value |
|---|---|---|---|---|
| **onouh / Vehicle-Rental-System** (C++17, Qt6, SQLite) | Public README describes an MVC-like Qt application with `DatabaseManager`, `AuthManager`, `RentalManager`, car/bike fleet, reservations, login, dark QSS and screenshots. `AuthManager.cpp` directly uses `QCryptographicHash::Sha256` for passwords. | Separate domain/rental management from database, use SQLite with constrained records, give reviewers screenshots and a build path. | Hard-coded default users are advertised; unsalted SHA-256 is not modern password storage. `DatabaseManager` centralises numerous CRUD responsibilities. Do **not** assume 'CodeQL 0 vulnerabilities' in a README is proof of security. | **High** for architecture comparison and critical thinking. |
| **kowama / Car-Rental-App** (C#/Windows Forms) | Public README and screenshots show users/roles, cars, rents, bills, customers, PDF billing, Excel/PDF export, stats and a demo video. | End-to-end administrative journeys and a visual GitHub showcase; simple printable rental receipt can be valuable. | Screenshots convey a fairly traditional dense desktop look. Multiple role/report modules are not evidence of robust tests; do not reproduce complexity for its own sake. | **Medium-high** for portfolio packaging and useful operations. |
| **StefanRomanov / Car-Rental-React** (React, Spring Boot, MySQL) | README and repository folders show distinct `front-end` and `server`, user/admin roles and JWT-based design as described by author. | A recognisable client/server/database division, relevant to a full-stack vacancy. | Separate stacks, authentication and deployment expand scope and failure modes. README claims do not independently verify JWT configuration or end-to-end robustness. | **Medium** for a later optional service/API phase, **low** for a deadline rewrite. |
| **Booqable** (commercial rental operations software) | Official product pages document Draft → Reserved → Picked up → Returned → Archived, availability calendar, customer/order history, availability filtering and status updates. | Model the user journey and availability question; surface who has an item, when it is due, and what the operator should do next. | Full commercial feature set (payments, signatures, multi-location, online shop, integrations) is not appropriate to clone in a graduate portfolio build. | **Very high** for task-oriented information architecture and state modelling. |
| **Current Vehicle Rental System** (our source) | Qt Widgets, CMake, domain tests, flat-file data, add/rent/return/archive, current screenshots. | Good basic OOP, real desktop UI, tested core workflow in Linux CI, distinct cars/motorcycles. | UI navigation and data hierarchy are still CRUD-first; legacy persistence; no SQL/API; large UI file; Windows GUI test pending. | **Highest**: strongest result comes from disciplined evolution rather than replacement. |

### Detailed lessons

**Qt analogue (onouh):** The positive is the conceptual split between `RentalManager` and `DatabaseManager`; this improves testability when responsibilities are truly separate. The negative is its use of SHA-256 password hashing. OWASP recommends a salted, deliberately slow password-hashing algorithm such as Argon2id, scrypt, bcrypt or PBKDF2. For a single-user local desktop app, deliberately *not* adding authentication is better than shipping an unneeded insecure login facade.

**Windows Forms analogue (kowama):** Billing/receipts and a short demo are disproportionately useful because they show a complete business task. But ten forms, numerous statistics and role screens can make a portfolio look like a checklist. Borrow its task completion, not its visual density.

**React/Spring analogue (StefanRomanov):** A front end, a service and a database match the vacancy's wording, but a last-minute rewrite would discard existing C++/Qt work and dilute verification. Borrow the architectural boundary only after the core application is stable.

**Commercial workflow (Booqable):** Real rental operations have meaningful intermediate statuses and time-dependent availability, while our current program restricts rental start to today. A date-range reservation engine should be a deliberately tested future release, not an overnight UI-only promise.

### Comparison source links

- https://github.com/onouh/Vehicle-Rental-System
- https://raw.githubusercontent.com/onouh/Vehicle-Rental-System/main/AuthManager.cpp
- https://github.com/kowama/Car-Rental-App
- https://github.com/StefanRomanov/Car-Rental-React
- https://booqable.com/features/
- https://help.booqable.com/en/articles/3845244-the-booqable-order-workflow
- https://help.booqable.com/en/articles/4103695-how-to-view-availability-on-the-calendar
- https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html

## 4. Baseline evaluation: what makes the current UI look academic

### Strengths worth preserving

- Coherent navy sidebar, blue selected state, light work area and generally readable headings.
- Consistent typography in forms and tables, already better than unstyled native controls.
- Visible business metrics, vehicle type switcher and useful rental estimate values.
- Clear category-specific fields for cars (doors) and motorcycles (engine capacity).
- Detailed recent-rental table, which can become a useful operational component.

### Source and screenshot findings

| Finding | Evidence | Product effect | Proposed response |
|---|---|---|---|
| Too many equal-priority destinations | Screenshot shows nine sidebar pages including Remove Vehicle, Search Vehicle, All Vehicles and Available Vehicles. | Forces users to understand internal CRUD functions rather than a real workflow. | Group into Dashboard, Fleet, Rentals and History/Reports; use action buttons/filters inside pages. |
| Eight dashboard cards with redundant data | Total Vehicles 10, Available 7, Rented 3, Active Rentals 3, Cars 5, Motorcycles 5, Utilisation 30%, Rental Revenue R12,850. | Visual fragmentation and duplicated rental/availability facts. | Show four meaningful KPIs and a prominent action queue. Keep breakdown as secondary detail. |
| Large underused grid | The dashboard screenshot shows a four-row table followed by substantial empty space. | The most valuable screen looks unfinished at normal desktop dimensions. | Give table a content-sized region and add a relevant due/overdue or attention list. Never add fake data to fill space. |
| Destructive action promoted as navigation | Remove Vehicle is a primary sidebar item; Exit is a red full-width button. | Rare actions compete with daily tasks. | Move remove to Fleet detail with confirmation; put Quit in a conventional menu or discrete control. |
| Form success interrupts flow | Add Vehicle screenshot uses a blocking standard QMessageBox. | Makes repeated data entry slower; standard dialog looks visually separate from app. | Consider inline success banner/toast with View Vehicle action; retain blocking dialogs for destructive or high-risk decisions. |
| Rigid minimum window size | `mainwindow.cpp:71` calls `setMinimumSize(1280, 720)`; fixed sidebar width 235 and form minimum widths 820/940. | Narrow windows and 125% text/display scaling may clip content. | Responsive Qt layout with scroll areas and smaller minimum; test 1366×768 and 125% scaling. |
| Huge presentation file | `mainwindow.cpp` contains 1,971 lines and mixes layouts, table population, form checks, event handling and styling. | Slower code reviews and risky incremental changes. | Extract DashboardPage, FleetPage, RentalPage, RentalTableModel and application services gradually, with regression tests. |
| Ad-hoc style and state overrides | `MainWindow::applyStyles` uses one embedded style string; several `setStyleSheet` calls create per-control state colours. | Design tokens/contrast may drift, and dynamic state changes can diverge. | Centralise palette, typography, spacing and icons; keep styling minimal and consistent. |
| Terminology has financial ambiguity | Dashboard sums rental `totalCost` into `Rental Revenue` in `updateDashboardCards`. | A committed rental amount is not necessarily money collected. | Label it 'Booked rental value' unless payments exist and are tracked. |
| Booking model is same-day | `QDateEdit` minimum and maximum are set to today; `createRental` rejects other start dates. | This is a same-day checkout tool, not a future reservation scheduler. | State that scope accurately or later implement dated reservations with overlap checks. |
| Flat-file persistence and identity constraints | Current `RentalSystem` writes and reads text; IDs are inferred from current data. | Limits migrations, auditability, history integrity and reliability after deletion. | Preserve compatibility initially; move to transaction-safe SQLite with stable IDs and schema versioning. |

The screenshots are a historical visual snapshot. The hardening changes and CI results cannot substitute for an updated Windows UI screenshot.

## 5. Proposed product definition

**Working product positioning:** "Vehicle Rental Manager | A local-first fleet and rental operations desktop application." The application serves a small rental-counter operator who needs to understand availability, issue a rental, receive a return and inspect history. It is not positioned as a national booking marketplace.

### Three high-value user journeys

**Journey A: Locate and rent a vehicle**  
Launch → Dashboard → Fleet (search/filter) → choose an available vehicle → Rent → enter customer and duration → preview total and due date → confirm → see a receipt/details screen → verify occupancy updated.

**Journey B: Return a vehicle**  
Dashboard highlights active/due rental → open rental → confirm vehicle and actual return date → mark returned → display completion confirmation → vehicle becomes available; historical record persists.

**Journey C: Inspect and recover**  
Open History → filter by status/date/customer or rental ID → open record and view price/status timeline → export or back up where implemented → close/reopen and confirm data consistency. A failed save must show a useful error and preserve the earlier committed state.

### Requirements and non-goals

**Essential in the flagship version:** fleet management; customer transaction fields; rental status and due dates; consistent price calculation; prevention of active double booking; return and history; readable dashboard; robust persistence; tests; safe fictional demo and documentation.

**Strong next increments:** vehicle detail view; due/overdue queue; date-range booking and conflict detection; SQL storage with migrations; receipt export; robust sorting and filtering; data integrity and error logging; backup/restore.

**Not essential before application:** customer marketplace, payment gateway, multi-branch/cloud sync, AI pricing agent, live map tracking, a large account-management subsystem, mobile application, or unrelated charts.

## 6. Aesthetic design direction: polished operations software

### Overall choice

Keep Qt Widgets. Adopt a restrained, **light-first operational desktop** style, not a web SaaS clone, flashy glassmorphism design or an all-black dashboard. The existing navy/blue foundation is reasonable; the biggest upgrade will come from composition, visual hierarchy and responsive states.

### Suggested visual system (proposal, not approved implementation)

| Element | Working specification |
|---|---|
| Brand/nav background | Deep navy `#182538` or similar; use a small amount of saturated accent. |
| Main canvas | Soft neutral `#F6F8FB`, cards `#FFFFFF`. |
| Primary action | Medium royal blue `#2563EB`; reserve bright colour for the primary next action. |
| Text | Near-black navy `#172338`; secondary slate `#64748B`. |
| Success / warning / danger | Semantic and accessible green, amber and red with text labels, not colour alone. |
| Typography | Qt-friendly Segoe UI/system sans-serif; headings 22–26pt, sections 15–18pt, body 11–12pt depending on DPI. |
| Layout rhythm | 8px-equivalent spacing scale; 20–24px page padding; purposeful card grouping. |
| Tables | Readable 36–42px rows, subtle separators, left-aligned identifiers, right-aligned currency, clear hover/selected states. |
| Buttons | One primary CTA per major surface, secondary ghost/outline actions, explicit destructive-action confirmation. |
| Iconography | One coherent icon family bundled via `.qrc`, small and labelled; avoid unrelated car stock images. |

A contrast audit at 100% and 125% scaling is required before choosing final colour values. Microsoft Fluent's layout guidance supports grid consistency and clear spacing; Qt's styling guidance discourages an unlimited collection of ad-hoc QSS rules for a production finish.

### Target information architecture

```text
Dashboard
Fleet
    Vehicles (search, status filters, inspect)
    + Add vehicle (primary action)
Rentals
    Active rentals / due soon
    + New rental (primary action)
    Returns (action within rental details)
History / Reports
    Rental history (filters and details)
    Exports (only when implemented)
Settings / About
    Data location, demo reset, backup and app information
```

No permanent sidebar item for every data operation. Show context actions where the data appears. If a mode is not implemented, do not leave non-functional navigation.

### Target dashboard: hierarchy, not decoration

1. **Heading and action row:** "Fleet overview", a quiet live status, `+ New rental` and a secondary `+ Add vehicle` action.
2. **Four KPI cards maximum:** Available vehicles, Active rentals, Due/overdue rentals, Booked rental value (with correctly disclosed time scope). The existing total/Cars/Motorcycles/utilisation data can appear in Fleet or as supporting figures rather than all competing above the fold.
3. **Operational attention:** due today, overdue, failed/stale records if any; empty state when none.
4. **Recent activity table:** 5–8 compact rows, status chips and a View action. An appropriate finite table height avoids empty space.
5. **Secondary insight (optional):** small utilisation comparison only if it answers a question. No decorative doughnut chart or unrelated analytics gallery.

### Form and feedback design

- Vehicle registration: type segmented control, prefilled generated ID as noneditable, brand/model, rate, subtype field, helpful validation, persistent Save action; if saved, nonblocking confirmation and view link.
- Rental checkout: select or search a vehicle, display a clear availability badge, customer contact, rental duration, total and due date. Separate the calculation preview from the final confirmation.
- Returns: display rental details, customer and vehicle, actual return date, one unambiguous `Mark returned` control; show validation errors before mutation.
- Destructive operations: confirm with record identity and effects; never delete transaction history as a side effect of removing a vehicle.
- Empty/error states: state what is missing, whether earlier data is safe, and a relevant next action. Never claim success until persistence succeeds.

### Qt implementation trade-off

**Immediate:** reuse Qt Widgets, layouts, palette and small centralised style resource. Avoid repainting all widgets manually just for a new look.  
**Subsequent:** use `QAbstractTableModel + QTableView + QSortFilterProxyModel` for dense fleet/rental tables and a predictable sort/filter API; Qt recommends model/view for reusable data tables.  
**Long-term:** if a fully bespoke production theme is essential, evaluate `QProxyStyle`, `QCommonStyle` or StyleKit. Qt's current official documentation explicitly limits style sheets to targeted adjustments and prototyping.  
**Avoid:** rewriting the validated app in Qt Quick/QML or React solely to resemble a modern website.

## 7. Engineering architecture recommendation

Current structure is effectively `MainWindow → RentalSystem → Vehicle/Rental + flat files`. The correct incremental destination is:

```text
Qt Widgets (DashboardPage / FleetPage / RentalPage / HistoryPage)
            ↓
Application services (RentalService, VehicleService)
            ↓
Domain rules (Vehicle, Car, Motorcycle, Rental, Money, status)
            ↓
Repository interfaces (VehicleRepository, RentalRepository)
            ↓
SQLite implementation (schema, constraints, migrations, backups)
```

In the first refactor, separate business logic from widget event handlers without changing behaviours. Keep regression tests passing. Then add SQLite transactions and schema-level checks:

- Vehicle IDs unique and stable; rental IDs monotonic; preserve historical references.
- Rental has a referenced vehicle and valid nonnegative duration/price totals.
- A single current rental per vehicle in the simple same-day model; later reservation-overlap rules for date ranges.
- Lifecycle transitions explicit and tested (Active → Returned → Archived in current scope).
- Monetary amounts stored as integer cents or an appropriate decimal representation; avoid cumulative floating-point rounding error.
- All SQL uses bound parameters. Enable and verify `PRAGMA foreign_keys=ON` on every SQLite connection; transactions commit only after all required writes succeed.
- Store data in `QStandardPaths::AppLocalDataLocation` on Windows with documented backup/migration. Never silently overwrite the old text data.
- Import older text records only after a dry-run preview; retain the original as a backup and provide a visible migration result.

`QSaveFile` is a good existing reliability step for whole-file replacement, but it does not make independent files a multi-record database transaction. Official Qt documentation supports its use and explains its direct-write fallback limitation.

## 8. Security and privacy

1. **No real customer samples in a public repository.** Use fictional names and placeholder numbers. Keep actual data, secrets, logs and backups out of Git.
2. **Input trust:** validate lengths, identifiers, dates, rates, delimiter/newline content for legacy import, and eventual bound SQL values; keep user-visible errors concise and specific.
3. **No pointless authentication.** Local single-user desktop workflows may not need user accounts. If multi-user access is later introduced, use modern salted password storage and an actual permission model, not default admin credentials or SHA-256.
4. **No fake security claims.** A passing scan does not establish absence of security flaws. Test actual unauthorised access paths in an API phase.
5. **Data loss tests:** write failure, malformed line, duplicate ID, interrupted save, restart and migration are first-class acceptance cases.
6. **Privacy-friendly screenshots:** avoid customer names/phone numbers even if they are merely old sample data unless demonstrably fictional.

Sources: OWASP Password Storage Cheat Sheet; Qt QSaveFile/QSqlQuery; SQLite foreign key documentation.

## 9. Testing and verification strategy

The GitHub Linux Qt6 workflow passed on 29 October. This is encouraging but insufficient to claim a tested Windows desktop release. The verification ladder should be:

| Layer | What must be demonstrated | Gate |
|---|---|---|
| Source and hygiene | No secrets/real customer records, working .gitignore, correct assets | CI pass |
| Unit/domain | Valid vehicle, pricing, duplicated ID, double booking, status transitions, cancellation | Repeatable CTest pass |
| Storage integration | Save failure atomicity, restart consistency, migration, transaction rollback | Isolated test directory/DB tests pass |
| UI interaction | Required fields, keyboard workflow, statuses, confirmation and error text, no cropped controls | Qt Test + Windows manual pass |
| End-to-end demonstration | Add → Rent → Reject duplicate → Return → History → Restart | Screen-recorded and verified run |
| Release | Windows installer, dependencies, initial demo state and clean removal | Only claim after separate test |

Qt Test supports simulated mouse/keyboard input and data-driven Qt tests. Build on it rather than relying only on manually clicking screens. Capture the Windows OS, compiler, Qt version and date whenever reporting an acceptance result.

## 10. Mapping to Retipuj Zoft's full-stack graduate requirements

| Job capability | Existing evidence | Best portfolio improvement | Honest claim boundary |
|---|---|---|---|
| Programming/OOP | C++17, inheritance, polymorphism, Qt | Explain domain responsibilities and invariants | Already present |
| Front-end UI | Qt Widgets pages and forms | Navigation, states, keyboard support, professional screenshots | Desktop front-end, not React |
| Back-end logic | RentalSystem business commands | Separate service/repository, error contracts | Local domain layer, not web backend |
| Data/database | Legacy text persistence | SQLite migrations, transactions and SQL | SQL not yet implemented |
| APIs | None | Optional small REST service with stable contracts | Do not claim API yet |
| Testing/debugging | CTest and passing Linux GitHub Actions | Integration and Qt UI tests, failure reproductions | Windows GUI unverified |
| Version control/teamwork | Public GitHub, CI, issue/roadmap | Focused PRs with reviewed changes and rationale | Solo project; no fabricated team work |
| Documentation | README, audit, architecture and continuity | Concise main README, demo, decisions, tests, known limitations | Documentation can be verified now |
| Deployment | CMake Qt build | Windows packaging and release notes | No production installer currently |
| Agile/continuous improvement | Prioritized roadmap and issue history | Small verified increments, changelog, feature acceptance criteria | Process evidence, not a claim of Scrum team membership |

The employer explicitly accepts university and personal projects and names C++ among advantageous languages. An excellent desktop Qt project can therefore be a legitimate portfolio piece despite not being a deployed website. A future SQLite/API extension improves full-stack coverage, but is not a prerequisite to applying.

## 11. Strategy options and trade-offs

| Strategy | Advantages | Disadvantages | Recommendation |
|---|---|---|---|
| **A. Polish current Qt Widgets + documentation + tests** | Preserves working source, fastest to demonstrate, directly verifiable, strengthens C++ | API/SQL exposure remains limited | **Choose first** |
| **B. A + SQLite + modular services** | Real transactions, relational design, clean architecture, strong interview material | Needs migration and data integrity tests | **Choose second, as a controlled milestone** |
| **C. B + optional documented REST service** | Covers APIs and deployment fundamentals; stronger full-stack narrative | Two runtimes, auth/consistency and packaging become harder | **Choose after B is stable** |
| **D. Rewrite in React/Node from scratch** | Conventional full-stack keywords and easier web demo | High regression risk, loses C++ differentiator, deadline infeasible | **Reject for this project** |
| **E. Add AI, GPS or payments immediately** | Attention-grabbing feature headlines | Unrelated complexity, higher security and correctness risks, harder to defend | **Reject until a validated user problem demands it** |

The eventual API could be a small FastAPI service in Python or a well-bounded C++ HTTP service; both need tested database ownership, authentication decisions and cross-process consistency. No API framework is approved at this stage.

## 12. Prioritised implementation roadmap

### Gate 0: Freeze and understand the present baseline

- Mark current tested Git commit; keep all currently working workflows intact.
- Confirm Windows Qt Creator app launches with fictional fixtures.
- Capture a screen-by-screen QA record and baseline screenshots.
- Record existing business invariant tests. No unexplained regressions.

### P0, before the 30 October application: make it clearly presentable

**Highest return for time and risk:** verify GUI; take 3–5 truthful current screenshots; make README's opening concise and visual; show a short add → rent → return walkthrough; ensure a stable build and record remaining limitations. If coding capacity permits, implement **one coherent UI milestone** (grouped sidebar + dashboard hierarchy) only if it can be visually and functionally verified before submission. No untested sweeping re-style.

**Exit evidence:** public code, passing named CI run, real Windows screenshot/demo, correctly described project scope, no private data, simple setup, zero known critical data-loss bugs in demonstrated flows.

### P1: design quality / usability milestone

- Group navigation around Fleet/Rentals instead of CRUD screens.
- Dashboard: four KPIs, primary action, due/overdue section and compact activity view.
- Add/return forms: field validation, nonblocking feedback where safe, stronger focus handling.
- Responsive/125% scaling and empty/error states.
- Centralized theme tokens/resource icons, consistent labels and colour contrast.

**Exit evidence:** screenshot comparison, keyboard test, 1366×768/125% checks, no lost existing action.

### P2: transactional data and architecture milestone

- Introduce repositories/service boundary; SQLite schema, foreign keys, transactions, migration path.
- Preserve old data on import; tests for ID lifecycle, rollback, corruption and restart.
- Cents-based monetary values and unambiguous financial KPI names.
- QAbstractTableModel/QSortFilterProxyModel where table complexity warrants it.

**Exit evidence:** migration regression on synthetic old records, database test suite, no data loss and UI parity.

### P3: credible product functionality milestone

- Date-range reservations and conflict detection, optional fleet maintenance/unavailability.
- Due/overdue workflow, meaningful status transitions, printable rental receipt.
- Data filtering, CSV export and clearly described reporting time windows.

**Exit evidence:** lifecycle tests, status transition tests, date overlap edge cases and demonstrable business journey.

### P4: graduate full-stack stretch milestone

- Documented, small REST API and service/client integration.
- Contract/integration tests, error handling, API documentation and repeatable local launch.
- Authentication only if a genuine multi-user requirement is added; never introduce it as decoration.
- Optional release package and deployment/demo environment after stability proof.

**Exit evidence:** reproducible API example, tests, clear deployment diagram, demo and limitations.

## 13. Acceptance checklist for a respectable portfolio release

A reviewer should be able to answer yes to these questions without having to trust marketing claims:

- [ ] Can I understand the app's business purpose and main workflows within one minute of opening the README?
- [ ] Are the dashboard and forms genuinely polished and coherent, with current screenshots?
- [ ] Is there a clear navigation hierarchy and a natural Rent → Return workflow?
- [ ] Do invalid input, duplicate rentals and failed saves produce safe, understandable outcomes?
- [ ] Are all visible KPI definitions correct and defensible?
- [ ] Can I configure/build/test it with a short documented sequence?
- [ ] Does CI pass on a named revision and are local limitations honestly recorded?
- [ ] Is sensitive data absent from public history, screenshots and fixtures?
- [ ] Are domain rules separate enough to test without GUI interaction?
- [ ] If SQLite/API are claimed, are the schema/contracts and transaction/integration tests visible?
- [ ] Can the author explain technical trade-offs, one bug fixed, one design decision and one future improvement in an interview?

## 14. Risks and explicit stop rules

| Risk | Impact | Control |
|---|---|---|
| Redesign breaks rent/return business workflow | Critical | Create visual baseline, change one screen group, test full lifecycle after each change |
| New SQLite adapter silently loses historical rows | Critical | Dry-run import, backup, duplicate/invalid warnings, migration roundtrip tests |
| Attractive screenshots show stale or fabricated data | High | Only capture real running GUI with clearly fictional fixtures |
| Password/login added without real policy | High | Defer authentication; if needed use modern salted hashing and permissions |
| API consumes time without value | High | Only introduce after repository and domain boundary stabilise |
| UI fits author's monitor but clips at 125% scaling | High | Minimum-window and scaled Windows acceptance matrix |
| Too many charts crowd useful actions | Medium | Every chart needs a user question, data scope and truthful definition |
| README implies features not built | High | Separate existing/verified/proposed sections and link test evidence |
| Portfolio work delays actual application | Critical | Application submission remains the deadline gate; defer risky additions |

## 15. Final evaluation

The most credible portfolio version is **not the version with the most technologies listed**. It is the version in which a reviewer can see a well-designed desktop workflow, inspect competent C++ architecture, run tests, understand data persistence and follow a history of measured engineering improvements. The current project can reach that standard without being abandoned.

The optimal final direction is a **polished rental operations console with a task-oriented dashboard**, backed over time by **transaction-safe SQLite**, modular C++ application services, realistic reservation rules, targeted UI tests and concise GitHub documentation. A REST API is a meaningful second-stage full-stack demonstration, not a prerequisite for tomorrow's application.

**Immediate decision before implementation:** approve the information architecture and dashboard priorities; then protect the current tested build and implement incremental changes. For the next-day application, prefer a truthful current visual demonstration and tested core over last-minute feature inflation.

## 16. Research sources and verification anchors

**Project / employer**

1. Current source: https://github.com/Sonkhe-Shongwe/vehicle-rental-system
2. Initial working Qt6 CI success: https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40872123623
3. Retipuj Zoft graduate listing: https://za.linkedin.com/jobs/view/graduate-program-at-retipuj-zoft-4473487932
4. Company hiring post: https://za.linkedin.com/company/retipuj-zoft

**Comparables**

5. C++/Qt/SQLite analogue: https://github.com/onouh/Vehicle-Rental-System
6. Auth code (SHA-256 detail): https://raw.githubusercontent.com/onouh/Vehicle-Rental-System/main/AuthManager.cpp
7. C#/WinForms analogue: https://github.com/kowama/Car-Rental-App
8. React/Spring full-stack analogue: https://github.com/StefanRomanov/Car-Rental-React
9. Booqable feature inventory: https://booqable.com/features/
10. Order lifecycle (16 Sep 2026): https://help.booqable.com/en/articles/3845244-the-booqable-order-workflow
11. Calendar / availability: https://help.booqable.com/en/articles/4103695-how-to-view-availability-on-the-calendar

**Engineering and UX authorities**

12. Qt styling approaches: https://doc.qt.io/qt-6.12/qtwidgets-styling-approaches.html
13. Qt model/view: https://doc.qt.io/qt-6/model-view-programming.html
14. Qt file atomicity: https://doc.qt.io/qt-6/qsavefile.html
15. Qt SQL prepared statements: https://doc.qt.io/qt-6/qsqlquery.html
16. Qt StandardPaths: https://doc.qt.io/qt-6/qstandardpaths.html
17. Qt Test: https://doc.qt.io/qt-6/qtest-overview.html
18. Qt resources: https://doc.qt.io/qt-6/resources.html
19. SQLite foreign keys: https://www.sqlite.org/foreignkeys.html
20. OWASP password storage: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
21. Microsoft Fluent grid and layout: https://fluent2.microsoft.design/layout
22. GitHub portfolios: https://docs.github.com/en/account-and-profile/tutorials/using-your-github-profile-to-enhance-your-resume
23. GitHub repository best practices: https://docs.github.com/en/repositories/creating-and-managing-repositories/best-practices-for-repositories

*This report is analysis and recommendation, not a claim of implementation or product certification.*