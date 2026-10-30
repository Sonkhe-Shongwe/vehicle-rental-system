> **HISTORICAL RESEARCH STATUS ONLY (30 October 2026 audit):** Read [Canonical State](PROJECT_STATE_CANONICAL.md) and [Full Continuity Audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) for today's facts. This document remains valuable dated research; its old assertions of no selected palette or Qt Quick implementation were accurate in their earlier stage but are now superseded. Selected Navy/Teal theme and read-only C++/QML Fleet P2 exist; final P1/P2 owner gates remain open.

# Vehicle Rental System 2.0 — Full Engineering Masterplan

**30 October 2026 | Research-based planning proposal; not implementation approval**

**Product:** a distinctive, offline-first Windows desktop rental operations application with Rivian-inspired automotive focus, Arc-inspired tonal workspace structure and Tide Guide-inspired polished data interactions. The accepted IA is Overview, Fleet Gallery/Table with detail drawer, and Rentals (New, Active, History and Returns).

**Governance:** [Product rebuild Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5), [source/product audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md), [design DNA study](../design/V4_RIVIAN_ARC_TIDE_REFERENCE_BREAKDOWN_2026-10-30.md).

> Strategic decision: rebuild deliberately through independently testable, working vertical slices. No current UI implementation, Qt Quick feasibility, SQLite migration, clean installer or aesthetic approval is asserted by this document.

## 1. Existing source facts

Reference source: unmerged Draft PR #4 head d1704ec3174b765e3dc82ff03a5531f09e8b507e. Stable main: 64aac966631b262c8ced123f932496518ec9872e.

| Verified area | Reality | Implication |
|---|---|---|
| Toolchain | C++17, CMake, Qt Widgets; CMake finds Widgets only | New QML app requires Quick/Quick Controls, modules and new entry point |
| Main Window | Large, approximately 2,384-line Qt Widgets implementation; nine UI destinations | No single new mega-QML component; split shell, screens, data models |
| Core | Fleet CRUD, Car/Motorcycle, rentals, return, archive/delete and double-booking checks | Preserve behaviour even if replacing C++ implementation |
| Booking rules | New rental must start today; duration 1–365 days; expected return = start + days | Not a future reservations system; freeze or deliberately change with tests |
| Storage | Human-readable text files adjacent to source; QSaveFile; rent/return occupancy rebuilt from rental ledger | Need AppData location, diagnostics, safe migration and multi-record atomicity |
| Monetary types | Daily price and rental total are double | Prefer qint64 integer cents before release and audit import rounding |
| ID generation | Highest currently present numeric suffix + 1 | After deletion, external/public IDs could be reused: require durable allocator/identity |
| QA | Domain and real Qt Widgets GUI CTest, disposable QTemporaryDir; hosted checks historically passed | Reuse test scenarios, add Qt Quick tests, do not claim new UI verified |
| Photos | Illustrative car assets with recorded provenance; bikes need credible matches | Product images not aesthetically approved; credits must survive rebuild |
| Distribution | No final installer or clean non-developer PC acceptance | Treat deployment as a separate critical milestone |

Keep user data private, all test records fictional, and old functional source recoverable. Historic CI results never certify new source.

## 2. First release contract — scope control

**P0, essential:** working Windows app, Overview live state, Fleet hybrid view with shared search/sort/filter/selection, vehicle details/add/remove; immediate validated Rental via Vehicle → Customer → Review, quote/confirm, double-book rejection, return, history, archive/delete guards, restart persistence, keyboard/focus/empty/errors, coherent imagery, offline clean deployment.

**P1, independent reliability improvements:** durable SQLite migration, safe backups and diagnostics, stable IDs, integer cents, AppLocalDataLocation storage and optional import/export after validation, performance with more records, professional polish and packaging.

**P2, NOT assumed or marketed:** future bookings/date conflicts, payment collection, invoices/tax, cloud sync, user accounts, multi-user permissions, remote APIs, maintenance telemetry, real-time notifications and AI. Each requires a separate actual problem statement, design and tests.

**Semantics:** Booked Rental Value is a sum of records, not money collected. No imaginary revenue charts, paid status or future reservations. Due/overdue derives from current or injected date, never fixed demo labels.

## 3. Proposed stack and architecture

**Preferred candidate:** Qt Quick/QML + Qt Quick Controls **Basic-based customized style** for presentation. C++17 and Qt Core/domain code for all rules. Use a Qt 6.x kit matching the actual Windows Qt Creator compiler and installation; known legacy hosted Windows source used Qt 6.8.3, but that does not identify the user's local kit.

    qml/Screens + Components + Theme
                  |
       typed QObject application adapters
       QAbstractListModel / table model + proxy
                  |
         application commands / queries
       FleetService, RentalService, Clock
                  |
          domain entities and invariants
                  |
       repository abstraction and migrations
                  |
       compatibility text OR future SQLite

**Invariants:** QML cannot commit data directly, invent availability or calculate authoritative prices. A command returns a typed result/error; success updates the visible model **after persistence succeeds**. Select by stable vehicle ID, not table row number. Avoid exposing raw Vehicle pointers to QML delegates. Never build a huge global singleton that becomes the new MainWindow.

Indicative module tree:

    src/app/main.cpp
    src/domain/{Vehicle,Rental,Clock,Rules,...}
    src/application/{FleetService,RentalService,Result,...}
    src/persistence/{IRepository,LegacyTextRepository,SqliteRepository,...}
    src/presentation/{FleetModel,RentalModel,AppController,...}
    qml/{App.qml,Theme,Components,Screens}
    assets/{manifest,approved-images}
    tests/{domain,application,persistence,qml}
    demo/{vehicles.txt,rentals.txt}
    docs/{ADRs,testing,release,design}

Use Qt CMake QML module tooling and associated qml linting, not manually copied QML folders without resource/dependency verification.

**Official references:** [Qt Quick 6.8 best practices](https://doc.qt.io/qt-6.8/qtquick-bestpractices.html), [Qt Quick Control customisation](https://doc.qt.io/qt-6.8/qtquickcontrols-customize.html), [Qt 6.8 CMake QML modules](https://doc.qt.io/qt-6.8/qt-add-qml-module.html), [Qt profiler](https://doc.qt.io/qtcreator/creator-qml-performance-monitor.html).

## 4. Gated development pathway

| Gate | Build / learn | Exit evidence |
|---|---|---|
| G0 Environment and baseline | Verify local Windows Qt Creator kit, compiler, Qt Quick module availability, clone/disposable fixtures; freeze old rules and tests | Exact kit/commit, old domain baseline builds locally |
| G1 Cohesive visuals | Compare two greyscale/tonal compositions BEFORE exact blue palette; full Overview, Fleet Gallery/Table/Drawer, Rental/History at 1500x860 and 1280x720 | Owner approves whole-system visual direction, errors/empty states included |
| G2 Technology proof | Small **real QML** app with five live C++ model vehicles, Gallery/Table, shared filter/selection and Inspector | Build, run, keyboard, resizing, native Windows DPI and acceptable interaction on actual PC |
| G3 Core integration | Pull UI concerns out of domain, typed command/result interfaces, observable models, injectible Clock | C++ model/contract tests, no QML-owned business truth |
| G4 Design system | Shell, navigation, tokens, cards, tables, forms, drawers, statuses, accessibility and purposeful motion | Reusable components, real rendered cross-screen states |
| G5 Vertical slice | Corolla Gallery → select → inspect → Rent → customer/days → quote → review → confirm → **durable save** → update Overview/Fleet/Active → restart | Automatic and manual end-to-end tests, cancel/duplicate/write-error negatives |
| G6 Complete P0 parity | Car/bike add/remove, search, available/rented, due/overdue, Active/History, Return, Archive/Delete, all error states | Existing domain behaviour + new Qt Quick UI checks all pass |
| G7 Storage reliability | Durability and identity design; text parser diagnostics, versioned SQLite migration if chosen, backup, integer cents, AppLocalDataLocation | Dry-run import, exact record reconciliation, safe rollback and transaction tests |
| G8 Packaging | Bundle Qt/QML/plugins, images, runtime; clean Windows VM/PC, safe user data directory, installer decision, legal notices | Runs offline without Qt Creator, reinstall/update preserve records |
| G9 Release | Full native display/keyboard QA, profiling, privacy/credits, exact SHA CI, README/videos/screenshots and owner approval | Approved distributable app, tagged build and explicit limitations |

**Important:** G1 composition and a tiny G2 feasibility experiment can be researched in parallel. A *full* UI rewrite must wait for visual/Qt evidence. G5 is the central risk-reduction milestone. Do not rewrite persistent storage and UI simultaneously.

## 5. Priority risk register

| Risk | Severity | Detection / mitigation |
|---|---|---|
| Windows Qt Quick modules incompatible or missing | Critical | G0/G2 exact installed kit proof, no blind migration |
| Gallery, Table, Drawer, Overview and Rentals show inconsistent state | Critical | Single C++ model, shared selection by ID, signal tests |
| Successful-looking UI when save actually failed | Critical | Typed command result, no optimistic final status, injected disk-failure tests |
| Hidden corruption or old customer data lost during conversion | Critical | Backup original as immutable, parse diagnostics, dry-run comparison, rollback |
| Double booking, stale rental ownership | Critical | C++ invariant AND transactional uniqueness on future DB |
| Customer PII leaked into screenshots/Git/CI | Critical | Fake fixtures and temporary storage only, sanitize logs, .gitignore |
| Currency errors and reused IDs | High | Integer cents, durable unique ID strategy, checked overflow and migration rounding |
| SQLite database copied without WAL context | High | Use SQLite backup API, controlled checkpoint or safely closed DB |
| Installer omits QML imports/plugin/runtime | High | Early windeployqt / CMake deployment and clean PC test |
| Unapproved/licence-unclear images and Qt modules | High | Source and licence manifest, module licence review |
| QML jank, costly effects, huge UI delegates | Medium | Qt Creator QML Profiler, lazy loading only when useful, benchmark real PC |
| User can't use compact DPI or keyboard | High | Native Windows 100/125/150%, 1280x720, focus and Escape tests |
| Endless visual or feature scope creep | High | Owner-reviewed design gate, P0/P1/P2, strict acceptance |
| Wasteful CI cycles and stale pass claims | Medium | Local-first loop, exact SHA records, artifact screenshots, lean branch triggers |

## 6. Persistence decision details

Short-term **LegacyTextRepository** can support the first vertical slice without a premature data migration. Long-term, SQLite is a reasonable choice for a single-operator offline tool, since related lease and inventory updates can be transactional and constrained. Qt provides the QSQLITE driver. This is recommended, not already implemented.

Suggested conceptual schema:
- vehicles: durable internal primary key, public display code, type, brand/model, subtype specs, daily_rate_cents and metadata; do not maintain an independently drifting rented flag as business truth.
- rentals: durable primary key, display code, vehicle foreign key, customer/contact, start/due/actual-return dates, rate snapshot in cents, days, total cents, archived state.
- schema version or SQLite user_version; explicit foreign keys; a unique constraint/index that prevents **two active rentals for the same vehicle**, under current immediate-rental semantics.
- persistent public-ID allocator or immutable tombstones for deleted historical codes; no reuse.
- transactional update; explicit error codes; data remains recoverable after failure.

Use QStandardPaths::AppLocalDataLocation for app-specific local files on Windows, creating directory if absent. SQLite foreign key enforcement must be enabled explicitly per connection; not rely on defaults. WAL is **not automatically necessary** for one local user: evaluate its extra sidecars, backup rules and crash/durability tradeoffs.

A migration dry run must reconcile IDs, totals, active/returned flags and all malformed rows; never auto-skip invalid records then overwrite originals. Backup with SQLite's supported online Backup API or a correctly quiescent database rather than blindly copying a live WAL file. Keep a tested reversible path.

[Qt SQL drivers](https://doc.qt.io/qt-6/sql-driver.html) · [Qt writable app paths](https://doc.qt.io/qt-6/qstandardpaths.html) · [SQLite foreign keys](https://www.sqlite.org/pragma.html) · [WAL tradeoffs](https://www.sqlite.org/wal.html) · [SQLite backup](https://www.sqlite.org/backup.html).

## 7. Testing and Definition of Done

**Domain:** rent available, reject already rented, validity of price/day/date and availability, return, repeat-return rejection, archive/delete, durability, rollback and unique identifiers.

**Application model:** role values, filter/search/sort, ID selection surviving view switch, observable model events after successful commands and no events claiming success after failed writes.

**QML UI:** card/table selection, drawer Escape and focus restoration, guided New Rental, review and quote, unavailable guard, keyboard/Enter/Tab, cancel/No nonmutation. Use **Qt Quick Test** and C++ Qt Test rather than the old Widget object-name tests as the only UI assurance.

**Realistic error/test matrix:** empty/one/five/large fleet, long strings, missing vehicle photos, malformed historic rows, no disk space, read-only directory, duplicate IDs, future/overdue dates, status after restart, rapid double-click submit, runtime theme/DPI and GPU responsiveness.

**Definition of Done for each real feature:**
1. Domain operation and price/status validity.
2. Real model data across ALL affected workspaces.
3. Positive, negative, cancellation and failed-persistence checks.
4. No PII in tests/screenshots/logs.
5. Keyboard/compact layout/empty and error state.
6. Local exact-commit verification and recorded owner visual review where relevant.

**Release Definition of Done:** real native Windows screen-size and DPI/keyboard acceptance, a clean-machine offline deployment, independent CI on exact release SHA, safe storage and migration if introduced, final rights and licensing review, truthful documentation and explicit owner merge/release consent. Old CI passes never carry over to new UI.

[Qt Quick Test](https://doc.qt.io/qt-6/qtquicktest-index.html) · [Qt QML profiler](https://doc.qt.io/qtcreator/creator-qml-performance-monitor.html).

## 8. Working efficiently and avoiding process traps

1. **Local-first:** Build/test the changed target in Qt Creator using matching compiler and kit, and disposable fixtures; keep clean build folders. Hosted CI is an independent gate, not a prerequisite for each small edit.
2. **One working vertical slice:** don't make 20 gorgeous static cards before a single real rental can survive restart.
3. **Small feature PRs:** no combining a giant UI rewrite, SQLite conversion, 40 screenshots and CSS cleanup into one unreviewable commit.
4. **Design token/component library:** one place for colours, spacing, type, focus and motion; avoid copy/pasted screen-level styling.
5. **Architecture Decision Records:** brief why/options/decision/reversal for Qt Quick, storage, IDs, future bookings and packaging.
6. **Exact-source status:** separate proposed, coded, tested locally, CI verified, visually approved and merged; never a vague completion percentage.
7. **Measure before micro-optimising:** Qt Creator QML Profiler to identify slow bindings, hidden items and JavaScript; no gratuitous shader/glass/blur.
8. **Artifacts not source commits:** CI screenshots should be workflow artifacts, not bot commits that trigger themselves. Filter irrelevant paths without accidentally blocking required checks.
9. **Keep scope coherent:** no microservices, auth, cloud backend, React web app, telematics or a general plugin system without a real user need.
10. **Preserve rollback:** old application/test fixtures and source SHA stay recoverable until the new release is accepted.

GitHub currently states standard hosted Actions runners on public repositories are generally **free**; earlier user-reported quota restrictions require checking the actual account notice, not assuming the project must wait for the next month.

[GitHub billing](https://docs.github.com/en/billing/concepts/product-billing/github-actions) · [workflow path filters](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax).

## 9. Distribution and legal considerations

Use Qt CMake QML deployment tooling or Windows windeployqt with QML import scanning; test outside Qt Creator on a clean Windows environment. Check third-party compiler runtime, image/font/icon licences, offline resources, and preserving user data on uninstall/upgrade.

Qt is dual licensed; the LGPLv3 route has redistribution/relinking and notice obligations and not every Qt module is necessarily under LGPL. Audit **actual module usage** and distribution requirements before shipping, without assuming any licence category automatically applies. Don't label current customer storage as encrypted or production-certified.

[Qt Windows deployment](https://doc.qt.io/qt-6/windows-deployment.html) · [Qt QML deployment](https://doc.qt.io/qt-6/qt-generate-deploy-qml-app-script.html) · [Qt open-source obligations](https://www.qt.io/development/open-source-lgpl-obligations).

## 10. First executable work package — proposed next milestone

1. Record Windows Qt Creator version, installed Qt 6 Desktop Kit, compiler, native display scale; isolate a clean demo-data clone.
2. Finish complete tonal composition review (NOT selecting a palette or approving mockups by inference).
3. Compile small real Qt Quick Gallery ↔ Table and Vehicle Inspector backed by typed C++ demo vehicles. Selection/filter must be shared.
4. Define C++ command and result for selected vehicle → accurate quote → customer → confirm → persisted transaction.
5. Demonstrate Corolla R450 x 3 = R1,350, refusal to rent already-rented Ford, nonmutating cancellation, committed availability change and restart.
6. Record exact git SHA/tests/screenshots, then extend screens one cohesive feature at a time.

**Branching:** Make a new dedicated rebuild branch after gates; retain stable main and visually rejected Draft PR #4 as reference. If the tested hardening source on Draft PR #4 is selected as base, record that exact SHA and do not assume its rejected UI is approved. Keep this research proposal on the independent documentation branch until owner accepts the development strategy.

## 11. Open decisions requiring sign-off

- Confirm what product operations must exist in the first installable version versus a demo-only portfolio milestone.
- Confirm whether migrating real historical customer records is necessary; default do not touch or publish them.
- Confirm expected behaviour for archived rental deletion (full hard delete vs auditable tombstone), and immutable public rental codes.
- Confirm final visual composition, native toolkit feasibility, images and legal/software licence.
- Confirm single-operator offline scope; multi-user future reservations not silently included.
- Confirm when SQLite migration becomes a release gate, after functioning UI and domain integration.

**Bottom line:** Yes, this is achievable, but the fastest **reliable** route is not one big rewrite. It is a verified Qt Quick experiment, then a perfect end-to-end rental slice, followed by complete features, storage and packaging as separate tested milestones. This plan is open for owner revision before implementation.
