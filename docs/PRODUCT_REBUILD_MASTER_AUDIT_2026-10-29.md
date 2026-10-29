# Vehicle Rental System — Master Product Rebuild Audit and Decision Record

**Decision date:** 29 October 2026  
**Authority:** Owner-directed product reset following rejection of the 2026 Qt Widgets aesthetic  
**Status:** DECISIONS DOCUMENTED; REDESIGN NOT IMPLEMENTED, NOT APPROVED VISUALLY, NOT MERGED  
**Repository:** https://github.com/Sonkhe-Shongwe/vehicle-rental-system  
**Verified legacy review source:** d1704ec3174b765e3dc82ff03a5531f09e8b507e (Draft PR #4; main 64aac966631b262c8ced123f932496518ec9872e)  
**This document supersedes:** earlier assumptions that the graphite/lime Qt Widgets interface is an acceptable final baseline, the old fixed 30 October shipping roadmap, and "no architecture change" limitations.
**Preserve:** original source, historical screenshots, CI logs, licences, and original audit reports as evidence, not as required design direction.

## Executive decision

We are developing a **distinctive, inviting, light-first automotive rental operations application**. The owner rejects the previous look across the product, explicitly authorises full redesign of presentation, code, architecture and data structures where beneficial, and wants **design discussions and cohesive visual approval before an application rewrite**.

No source file, UI toolkit, navigation scheme, layout, naming convention or persistence implementation is protected merely because it already exists. However, business requirements, error handling, data privacy, tested behaviour and rollback capability remain protected by **outcome-based acceptance tests**.

**Locked decisions from owner discussion:**
1. **No dark system**: predominant warm ivory/white, daylight-friendly surfaces, excellent contrast and approachable character. Dark readable text is fine; a full dark shell or cinematic cockpit is not.
2. Three primary workspaces: **Overview, Fleet and Rentals**; subordinate operations appear contextually.
3. **Hybrid Fleet**: gallery-first for browse/select with a genuine, fast operational table switch. Search, filter, sort and selected item persist between views where applicable.
4. Real vehicle profiles, contextual details drawers, helpful selection and guided quote/review rental flow; live feedback without distracting perpetual animation.
5. Design the *whole system*, not one beautiful Dashboard bolted onto generic forms.
6. Freedom to tear down and rebuild, paired with evidence-driven testing and safe migration.
7. **Local-first verification** with GitHub Actions as an independent eventual gate, not the only way to build.

**Design directions currently proposed, not yet visually approved:** working name "Rental Studio" / "Modern Automotive Studio"; muted sage, warm neutrals, carefully used copper; 3-up gallery on roomy desktop, 2-up on compact; restrained motion; and Qt Quick/QML as the leading candidate rather than an already-proven migration.

## 1. Source-grounded baseline audit

| Area | What is actually implemented on the unmerged reference branch | Quality or gap |
|---|---|---|
| Desktop runtime | C++17; Qt Widgets; CMake; MainWindow class in mainwindow.cpp (~2,384 lines), nine stacked action pages and one shared QTableWidget | Functional baseline, coupling and styling limitations; redesign rejected |
| Fleet | Cars and motorcycles, create/search/remove, availability, filtering, detail inspector, source-linked photographs for 3 demo cars | Domain can be reused or rewritten; gallery/inspector not a polished product |
| Rentals | Same-day new rental (1–365 days), quoted daily price, double-booking guard, return, ledger, archive/delete with confirmations | Keep behaviour and negative tests; new guided journey not implemented |
| Persistence | Source-adjacent vehicles.txt and rentals.txt; QSaveFile atomic single-file saves; rental ledger reconstructs occupancy | Not transactionally unified; no AppData migration, SQLite or concurrency control |
| Tests | CTest has domain and disposable Qt GUI-lifecycle tests; automated negative actions, keyboard, contrast, geometry and restart checks | Valuable regression specifications but coupled to old widget identifiers |
| Automated evidence | Linux 40944222722 PASS (CTest 2/2, 10 compiled-Qt screenshots); Windows 40944222486 PASS (CTest 2/2, 20 offscreen and synthetic-DPI captures) at photographic code be184b6 | Evidence for **old implementation only**; not QML nor physical Windows acceptance |
| UI | Dashboard, Fleet, Rent, History, Return screenshots under design/qt-spike/ | Real compiled screenshots, but *owner-rejected aesthetics*; not design approval |
| Photography | 3 illustrative model JPGs credited under assets/README.md; motorcycle photos not approved | Source rights are recorded; showroom/road clutter, variant mismatch and visual inconsistency remain |
| Delivery | Stable main untouched, Draft PR #4 still unmerged; CI optimisations staged independently | No approved release or final installer |

**Known source gaps:** huge UI class mixing layout and orchestration; flat-file paths beside source; parse diagnostics and malformed historic data handling; duplicate ID reuse after deletion; financial currency represented as floating-point values; no cross-process locking; no packaged distribution; no independently verified full Windows physical display matrix. These are risks or intended improvements, **not proof that production users are affected today**.

**Data fixtures (explicit fictional):** demo/vehicles.txt contains Toyota Corolla C001 (R450/day), Ford Ranger C002 (R700/day, rented), Hyundai i20 C003 (R400/day), Honda CB500F M001 (R280/day), Yamaha MT-07 M002 (R300/day). demo/rentals.txt contains R001 active Ford Ranger at R1,400 due **30 October 2026**, and R002 returned Toyota Corolla at R900. **Booked rental value R2,300 is not revenue collected.** This dated due-state must never be represented as a live/current real rental on another date; derive actual due/overdue status from runtime dates.

## 2. Why the old aesthetic failed — assessed from real screenshots

| Finding | Impact | New direction | Test for improvement |
|---|---|---|---|
| Nine permanent CRUD navigation entries | Academic/admin tool feel; too much choice | Three operator workspaces with contextual tools | Complete any common task through obvious route |
| Dark wide sidebar with bright lime selection | Hard, dated or gadget-like rather than inviting | Warm/light shell and calm, legible accent | Owner prefers complete cross-screen visual story |
| Four equal KPI cards, dense secondary strip, large lower table | No editorial emphasis or actionable attention | Due-return attention, concise real KPIs, bounded activity | Answer "what needs action?" in seconds |
| Small embedded vehicle photos and inconsistent composition | Vehicles feel pasted into forms | Consistent card photography and detailed model profile; coherent fallbacks | Check crop, identity, source and status at both desktop widths |
| Shared large table across unrelated workflows | Generic screen architecture; little personality | Each workspace owns task-centric content and suitable view | Different tasks feel deliberate, but controls remain predictable |
| Tiny uppercase text, tightly packed forms, limited interaction states | Low approachability, weak focus hierarchy | Consistent type scale, spacing, helpful inline feedback and modest motion | Keyboard, focus, 125/150% OS scaling, graceful empty/loading states |
| Long, contradictory docs imply design approval | Rework and inaccurate portfolio claims | One authoritative audit, short handoff, roadmap with explicit decision gates | Every "complete" claim linked to exact source and test evidence |

**Do not solve this solely by changing palette values or inserting bigger photographs.** Information architecture, UX state, typography, interactions, responsiveness and engineering structure must change together.

## 3. Product and design contract

### Positioning
A high-quality **single-operator local desktop rental workspace** for a small fictional automotive fleet. Clear enough for daily operations, beautiful enough for credible portfolio demonstration, honest about unimplemented bookings/payment features.

### Approved information architecture
- **Overview:** welcome and current date, genuine available/active totals, amount **booked** (never collected revenue), due/overdue attention, recent activity bounded to useful rows, high-confidence start-rental and inspect-rental actions.
- **Fleet:** Gallery **default**, Table alternate; shared query/filter/sort state; vehicle card with photo or consistent silhouette, rate/day, available/rented; selected vehicle drawer with exact ID/specifications, correct illustrative-model disclosures and relevant actions. Add/remove/search/available filters are contextual and keyboard accessible.
- **Rentals:** Active, History, and New Rental as related views; process returns from active items; guided Vehicle → Customer → Review; live price estimate, date restrictions, negative validation, explicit confirmation, feedback and restart persistence. Archive/delete are available only in appropriate transaction states.

**Not approved as implemented:** in-app payments, dynamic multi-day future reservations, multi-user login, billing automation, notifications, cloud sync, AI, or an external API. Any addition requires use-case, data/security design and tests before claiming it.

### Visual direction
- **Light-first**: warm paper/ivory backgrounds, white cards, subtly contrasting elevated surfaces.
- **Warm approachable brand**: muted green as prospective primary accent, gentle copper as a possible secondary accent, dark ink for typography—not full-page black or graphite.
- Sophisticated sans-serif typography; selective larger editorial headings without losing task clarity; accessible and licence-safe font selection.
- Automotive photo art direction: consistent aspect ratio, direction of light, neutral composition, no distracting backgrounds or mismatched registration plates where possible.
- No overuse of shadows, glass blur, neon, giant charts, fake graphs, arbitrary manufacturer endorsements or decorative motion.
- Interactive states: hover/focus/selected/disabled/errors/empty/success, reduced-motion preference, clear text + colour for status.
- Target physical sizes: 1500×860 and 1280×720; native Windows 100%, 125%, 150% scaling. Vertical scrolling is acceptable; hidden fields, overlapping buttons and unusable drawers are not.

**Visual tokens are still proposals**, not a final approved palette. Do not call any screenshot final until the owner explicitly approves the coherent five-screen set.

## 4. Candidate architecture: design first, prove the toolkit

**Qt Quick/QML plus C++ is the leading hypothesis**, not an imposed requirement. Qt documents Qt Quick as a declarative presentation technology with first-class states/transitions, controls and C++ integration; QQuickWidget has render-loop/performance drawbacks and should not be selected without measurement.

**Feasibility gate:** Build a small, visually real Qt Quick application on the owner's compatible Windows Qt Creator kit, using the fictional five-vehicle data and a typed C++ read-only model. Demonstrate Overview + gallery/table switching + a selection drawer, keyboard focus, drag resizing and smooth movement at 1280×720 and 1500×860. Prove Qt installation, deployment and performance. If the gate fails, evaluate native Widgets/custom painting or a more appropriate Qt composition without treating QML migration as a sunk-cost commitment.

Desired boundaries, independent of UI technology:

    Presentation (QML/Qt Quick OR alternative)
        -> typed view models / signal-driven application service
        -> validated C++ rental domain + use cases
        -> persistence abstraction + versioned migration
        -> locally stored, recoverable fictional/real operator records

Keep model business truth out of UI delegates and animations. Plan explicit error-result types, durable identifier strategy, integer-cent pricing, safe migration/backups, load diagnostics, atomicity and cross-process policy. No forceful in-place conversion of real user data.

## 5. Preservation and replacement matrix

| Item | Policy | Reason |
|---|---|---|
| Legacy executable, screenshots, Git history and test data | Preserve as archived reference | Reproducible baseline and rollback |
| Old Qt Widgets MainWindow and QSS | Replace if design demands | User rejects look, not code ownership |
| Vehicle / Car / Motorcycle / Rental concepts | Preserve requirements; implementation negotiable | Fundamental behaviours and test scenarios |
| Existing domain/GUI tests | Preserve evidence; rewrite/migrate IDs as needed | Regression contract, not widget lock-in |
| File format, source-adjacent storage | Migration permitted with backup and parity gates | Fragile distribution and future extensibility |
| Flat-file to SQLite | Explicit, separately testable architectural decision | Not needed to prove visuals; avoid premature combined rewrite |
| Current photos | Rights provenance preserved, presentation selection reconsidered | Licence permission does not imply art direction approval |
| C++17 and Windows Qt Creator environment | Current preferred foundation; change only with reasons and approvals | Work with owner's actual kit and local-first goals |
| Public demo data / private records | Fictional only in repo/tests; never migrate private records into public outputs | Data privacy |

## 6. Product rebuild work packages and gates

**G0 — Audit and direction (CURRENT):** consolidate this decision record; archive contradictory old instructions; owner signs off on high-fidelity Overview, Gallery, Table, Detail drawer, New Rental and Return/History states. No code or screenshot is accepted by implication.

**G1 — Presentation feasibility:** prove selected Qt toolkit on physical Windows with real data binding and basic accessibility; compare against design set; stop or pivot if insufficient. Do not rewrite the domain simultaneously.

**G2 — Design system and navigation:** ship reusable tokens/components, shell, three workspaces, responsive breakpoints, keyboard/focus/empty/errors; show real interactions, not mock buttons.

**G3 — Fleet and dashboard:** stateful gallery↔table, filtering, detail drawer, add/remove guards and current operational KPIs. End-to-end safe data source.

**G4 — Rental lifecycle parity:** guided rental, validated quote, double-book prevention, return, cancellation safety, archive/delete, restart and error handling. Ensure existing functional regressions pass.

**G5 — Persistence robustness (only if needed for approved release):** versioned file migration and backups, documented AppData path, numeric and ID robustness; decide SQLite separately. Never combine storage conversion with untested UI rewrite.

**G6 — Acceptance/release:** Windows physical OS DPI/mouse/keyboard/live resizing, accessibility, licences, installer if release scope includes it, full local automated tests and independent Linux/Windows CI when allowance available; owner aesthetic and merge approval.

At each gate, record what is **proposed / implemented / locally verified / CI verified / visually inspected / explicitly approved / released**. A failed gate forces correction or a revised technology decision.

## 7. Engineering delivery: fast without hidden quality loss

- **Local-first:** Qt Creator + CMake + CTest + isolated demo fixtures; no GitHub Actions dependency for each code iteration. Preserve a standalone offline test path and exact SHA.
- **Cloud independent gate:** After account Actions availability is confirmed, CTest/Linux/Windows validation on candidate revision; no CI minutes wasted on status-only commits. Repo is public; standard public runners are generally free, so the reported usage-limit message needs exact billing/account confirmation.
- **No photo/screenshot bot commits:** the independent optimisation branch already stages artifact-first screenshots, conservative docs-only required CI and scoped concurrency. **Not integrated or hosted-verified.** Do not confuse that staging branch with this docs-only product reset branch.
- **Risk-based test feedback:** targeted local tests frequently, full parity tests at integration and release; synthetic Qt scaling does **not** certify physical monitor DPI.
- **Protected customer data:** all automated review/screenshot runs use fake data in disposable paths. No private rentals in repo/PR/assets/logs.
- **Documentation:** one live short handoff and roadmap, historical evidence archived; do not repeat a long CI transcript across seven Markdown files.

## 8. New acceptance definition

The rebuilt milestone is **NOT COMPLETE** unless:
1. Owner explicitly approves a light, welcoming *coherent full-screen set*, including gallery and table, not just the hero screenshot.
2. The production-facing UI is real, compiled and data-bound; controls and transitions are functional.
3. Fleet and rental lifecycle behaviour and destructive-action guards pass parity tests with isolated fake records and disk snapshot checks.
4. Actual Windows Qt Creator keyboard, mouse, focus, 100/125/150% native monitor scaling and live resizing are verified.
5. Relevant photography/icon/font licenses and model identity claims are documented; each image is visually appropriate.
6. Persistence is safe, recoverable and does not claim transactional/production robustness beyond verified implementation.
7. All required local and hosted CI gates are green on the **exact final source revision**, or an unavailable gate is plainly marked **blocked**, not waived.
8. Approval to merge or release is **explicit**.

**Progress reset:** the earlier approximate "75% Qt design completion" estimate described the *rejected* visual milestone. It must not be reused as evidence of new product completion. The legacy business-function baseline is advanced, but **new design acceptance is at the requirements/ideation stage**.

## 9. Decisions, uncertainties and references

| Decision | Status | Owner/next proof |
|---|---|---|
| Tear-down permission / no sacred old UI code | **Approved** | Preserve functional outcomes and rollback |
| Light-first welcoming design, no dark system | **Approved** | Validate across complete high-fidelity set |
| Overview / Fleet / Rentals | **Approved direction** | Prototype navigation and tasks |
| Gallery-first with table view | **Approved direction** | Preserve search/filter/selection state |
| Muted sage / copper exact colours, product name | **Proposed only** | Owner visual comparison |
| Qt Quick/QML presentation | **Candidate** | Windows Qt Creator feasibility spike |
| Backend refactor, SQLite, AppData migration | **Permitted, not yet approved design** | Independent risk/benefit and migration tests |
| CI budget reset 1 November 2026 | **User-reported expectation** | Verify actual account notification before CI |
| Old design / PR #4 merge | **Rejected look; PR still draft/unmerged** | Replacement owner review, not auto-merge |

**Source of truth:** current Qt/C++ files, CMakeLists.txt, tests, demo/ fixtures, GitHub Draft PR #4; historical documentation archived at docs/archive; existing licensed asset register assets/README.md. Product-technology context: https://doc.qt.io/qt-6/qtquick-index.html ; Qt QQuickWidget tradeoffs: https://doc.qt.io/qt-6/qquickwidget.html ; GitHub public-runner billing: https://docs.github.com/en/billing/concepts/product-billing/github-actions .

**Next action:** develop and review one complete, high-fidelity light-first design system and all major interaction states before major source rewrite. After design sign-off, prove the Qt Quick candidate on the owner's actual Windows kit.
