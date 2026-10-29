## Qt acceptance checkpoint: responsive panels | 29 October 2026

The active Qt visual-redesign milestone gains repeatable real Qt geometry verification at **1280×720 and 1500×860** across all five finished screens. [Code `9f6dd7c`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9f6dd7c32b2f3feb14aa85a1f3c4c5329de19e50) passes [Linux 40936435098](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40936435098) and [Windows 40936435292](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40936435292), CTest 2/2 plus real Qt offscreen screenshot smoke. It supplements prior lifecycle, keyboard and status-contrast automated acceptance gates; it is not a merge approval or a physical-monitor test.

**Next remaining priority:** actual Windows Qt Creator interaction, live resize with real 100/125/150% DPI, final lawful and visually fitting automotive photography, owner aesthetic approval. Keep Draft PR #4 unmerged; do not begin the separate SQLite, REST, AI, cloud or redesign phase.

## Active milestone checkpoint | keyboard acceptance on compiled Qt, 29 October 2026

Existing visual redesign and real Qt lifecycle tests now also have repeatable **keyboard-event regression** (rental ID Tab-to-customer, return ID Enter), visible keyboard-focus button styling and a corrected Linux visual CI trigger for test-only source changes. [Linux 40935419732](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40935419732) and [Windows 40935419768](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40935419768) **PASS CTest 2/2 and compiled Qt screenshot gates** at source `525099b`. This completes an automated keyboard coverage increment, **not** the Qt redesign acceptance milestone. No storage, SQLite, REST/API, React, cloud or architecture phase transition.

**Remaining exit blockers:** physical Windows Qt Creator manual input/real DPI, polished correctly licensed photographic assets, owner visual approval and explicit decision to merge. Keep PR #4 draft and stable `main` unchanged.

## Active Qt visual acceptance milestone | 29 October 2026 evidence update

Two focused review-branch increments are now fully verified in Linux and hosted Windows, without changing rental business rules: [`aaf2cee`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/aaf2ceee22dbe4fd782c142c1a0999e54d59d816) disposable Qt GUI end-to-end lifecycle CTest, and [`c5c1e78`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c5c1e7885c80c3b7f88c0b40adf891fb2d9a2c91) table-status AA contrast correction/regression. Latest source check: [Linux 40932934420](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40932934420) and [Windows 40932934337](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40932934337), both 2/2 CTest; screenshot checks passed. Do **not** advance to unrelated architecture phases.

**Still open:** dedicated hands-on Windows Qt Creator GUI, physical-display 100/125/150% scaling, keyboard focus and modal accessibility, operator aesthetic review and better licensed authentic representative photos. Require owner approval before PR #4 can leave draft or merge to main.

## Qt acceptance evidence update | 29 October 2026

The live review branch has passing automated Qt functional validation on both platforms for source `aaf2cee`: [Linux 40931662760](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931662760) and [Windows 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521), each **CTest 2/2** including new GUI add/rent/restart/return/archive/delete; Windows also passes 12 synthetic screenshot/DPI cases. This does not complete the visual acceptance phase. Remaining: actual Windows physical scaling and keyboard UX, detailed aesthetic review and licensing, owner sign-off, and review of any defects found. Do not start a separate architectural milestone yet.

## Current priority override | Qt visual-acceptance milestone, 29 October 2026

The historical research/design-only notes below describe earlier checkpoints. **Current implementation:** Dashboard, Fleet, New Rental, Rental History and Return Processing have been redesigned in actual Qt Widgets on Draft PR #4. The existing one-phase-at-a-time requirement now takes precedence over the old forward-looking P1/P2 list.

**Acceptance evidence so far:** Linux [run 40931662760](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931662760), code `aaf2cee`, 2/2 tests passed including a new disposable GUI lifecycle with restart. Previous Windows MSVC/Qt screenshot, smoke and synthetic DPI evidence is recorded in the Windows reports. **Do not interpret offscreen checks as real Windows interaction.**

**Still blocking milestone exit:** actual Windows Qt Creator 1280x720 and wide display interaction; physical 100/125/150% monitor scaling; keyboard navigation and modal confirmation review; full GUI lifecycle against a disposable Windows clone; critical clipping/spacing and photo-crop review; valid model image provenance and owner visual approval. If significant defects are found, fix and retest before advancing. **No merge or portfolio-ready declaration.**

# Development Roadmap - Deadline: 30 October 2026

Goal: credible, demonstrable graduate software engineering project. Preserve existing Qt workflow. Prioritize evidence and correctness rather than speculative features.

**29 October update:** P0A source and sanitized screenshots have been published; GitHub Actions Qt 6 Linux build, hygiene check and CTest **passed** ([run 40872123623](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40872123623)). Windows Qt Creator GUI verification remains outstanding.

| Priority | Work package | Why now | Acceptance gate |
| --- | --- | --- | --- |
| P0A - Today | Publish sanitized complete source, README, screenshots and `.gitignore` to GitHub. | Empty repository fails recruiter inspection; real rental records cannot be public. | Public tree shows CMake, sources, docs, tests and only safe fixtures. |
| P0B - Today | Run Qt build and CTest on Windows with Qt Creator. Correct any compilation/test failures. | All source-level changes are unverified until executed. | CMake configure + build + `ctest` green; report kit/version and test output. |
| P0C - Today | Smoke test add, search, rent, double-book rejection, return, archive, delete, restart, and storage failure with a disposable dataset. | Protect original functionality. | Evidence in `docs/TESTING.md` or a dated test log; no personal records. |
| P0D - Today | Display safe screenshots and include concise CV-ready project description. | Recruiter can judge user-facing product quickly. | Screenshots accurate, hyperlinks work, documented scope truthful. |
| P1 - Next | Replace source-directory persistence with Qt application-data path and safe migration/backups. | Installability and data protection. | Upgrade from old data preserves full records, old files are untouched. |
| P1 - Next | Make parsing errors explicit and retain originals before migration. | Silent invalid-row dropping risks history integrity. | Malformed records produce actionable diagnostics; no discarded source. |
| P1 - Next | Add durable monotonically increasing ID allocation and money in integer cents. | Avoid identity reuse and floating-point financial drift. | Test deletion/restart/id reuse and monetary edge cases. |
| P2 | Introduce SQLite and transactional fleet/rental storage. | Atomic state changes, relational data modelling, SQL skills. | Rollback, unique constraints, foreign keys and transaction tests pass. |
| P2 | Split large `MainWindow` into presentation widgets/view-models and a service/repository layer. | Maintainability and separation of concerns. | Existing user journeys have parity tests. |
| P2 | Expand tests, code formatting, static analysis, Windows CI or reproducible manual Windows matrix. | Quality and review readiness. | Green repeatable pipeline and published commands/results. |
| P3 | Optional REST API, API contract and a small browser UI. | Full-stack relevance to Retipuj Zoft, **only after** reliable core. | Independent API tests, access validation and working integration demo. |
| P3 | Packaging and signed release considerations. | Distribution and deployment. | Clean Windows installation and startup tested. |

## Product design and comparative research — 29 October checkpoint

The full analysis is tracked in [PORTFOLIO_RESEARCH_2026-10-29.md](PORTFOLIO_RESEARCH_2026-10-29.md). Its recommendation is to preserve C++/Qt, treat aesthetic quality as operational usability, and evolve toward an operator-focused rental application: clearer dashboard hierarchy, consolidated navigation, task-first rental/return flows, consistent feedback, and small-window accessibility. Three open-source analogues and commercial workflow references are compared critically. The current UI is a baseline, not the final approved visual design.

**Status:** Research completed and documented; design decisions are still proposals. No code changes were made during research. The P0 application deadline and Windows manual test gate are unchanged. After the application, validate UX concepts before implementing P1 visual redesign, P2 transactional SQLite / architecture, P3 operational completeness, and optional P4 API.

## Phase 1 visual design checkpoint — design only (29 October 2026)

[Visual prototype and spec](../design/README.md) propose a task-first Dashboard/Fleet/Rentals structure, responsive panels and coherent light-first enterprise styling. Three 1440×900 concept screenshots plus a 1280×720 dashboard render are included. The HTML preview was interaction-tested, but **the Qt GUI has not been redesigned or Windows-tested**. Approval/iteration precedes implementation. Implementation order: shell/navigation, dashboard, fleet, rental workflow, Windows UI quality gates. Preserve existing Qt slots, pricing, persistence and regression test behaviour until functionality parity is verified. Further SQLite/API work stays independently scoped.

## What not to attempt before the application deadline

Do not rewrite the project in React, add cloud AI, or claim a REST API without a verified implementation. A polished smaller project with passing tests has stronger interview credibility than a wide feature list with failing builds.

## Mapped job criteria

- Programming fundamentals: C++17 domain logic and polymorphism.
- Software design: separation between Qt GUI, rental service and domain models.
- Debugging/problem solving: explicit audit defects, regression fixtures and reproducible correction notes.
- Testing: standalone CTest domain suite and manual GUI checklist.
- Databases / APIs: currently **not implemented**; planned architecture evolution, not CV keywords for the current app.
- Git and teamwork: public repository history, reviewable changes, documented decisions, CI (green on Linux Qt 6, with Windows interactive verification pending).
- Deployment: reproducible CMake/Qt Creator build instructions; standalone installer still planned.
