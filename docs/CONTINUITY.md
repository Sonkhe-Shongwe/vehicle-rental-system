## Windows automated acceptance follow-up | 29 October 2026

**PASSED** [Windows run 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521) for source `aaf2cee`: hosted Windows Server 2022, MSVC 2022, Qt 6.8.3, Release build, CTest **2/2** (including new persisted real Qt GUI lifecycle test), ten 1500x860/1280x720 compiled Qt UI captures, two synthetic DPI render checks, and original fictional fixture SHA-256 unchanged. Earlier "Windows pending" text below predates completion and is superseded. The initial `fdecb35` failed build remains a real failed attempt, subsequently fixed.

**Not accepted:** interactive Windows Qt Creator on a physical display, keyboard focus/confirmation flow, 100/125/150% real OS scaling, final aesthetic/photo rights sign-off and owner approval. Draft PR #4 remains unmerged.

## Current Qt lifecycle integration checkpoint | 29 October 2026

**Supersedes historical "no Qt redesign" and "no Windows CI" status statements below.** Draft PR #4 now contains the redesigned real Qt Dashboard, Fleet, New Rental, Rental History and Return Processing workspaces. The code remains C++17/Qt Widgets with flat-file storage. Stable `main` is unchanged.

Source commit [`aaf2cee`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/aaf2ceee22dbe4fd782c142c1a0999e54d59d816) introduces an opt-in isolated data directory for `MainWindow` integration testing, stable form control identifiers and a real Qt GUI lifecycle CTest using only generated fictional records. Its first version [`fdecb35`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fdecb35cc2e6612afa43a8df728dcdd7ecd66ff6) failed C++ compilation because `QMessageBox::button()` returns `QAbstractButton*`; `aaf2cee` corrected the type without weakening any assertion. [Linux CI 40931662760](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931662760) configured, built and passed **2/2 CTest**: domain and real Qt offscreen add/rent/restart/return/archive/delete integration. Windows CI for this exact source commit is tracked independently and must not be marked passed until complete.

Existing hosted Windows evidence: MSVC2022/Qt 6.8.3 [build/screenshot run 40923616007](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40923616007), 12 compiled-Qt review captures across two sizes and synthetic DPI settings, and domain regression scenarios. These checks do **not** replace physical monitor 100/125/150% scaling, keyboard/modal usability, a live Qt Creator walkthrough, or final visual approval.

See [current authoritative handoff](AI_HANDOFF_CURRENT.md). Keep Draft PR #4 open and unmerged. Do not progress into SQLite, APIs, cloud or refactoring before the Qt acceptance gate.

## Photographic V3 design-branch checkpoint — 29 October 2026

The real `demo/vehicles.txt` has **Toyota Corolla, Ford Ranger, Hyundai i20, Honda CB500F and Yamaha MT-07**. Earlier proposed car-only lists mentioning Nissan X-Trail and VW Polo were not the five demo items; do not carry that mistake into later work.

Draft [PR #3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/3) contains the **review-only hybrid Dashboard/Fleet/Rentals HTML concept**, documentary model-to-image mapping, source licences and a hosted image-fetch workflow. The second image-fetch workflow [succeeded](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40901513297) and recorded **3/5 photo derivatives** (Corolla/Ranger/i20, resized, EXIF stripped and hashed) on the design branch; **Honda rate-limited (429)**, and **Yamaha unattempted afterward**. The screenshot workflow produced [Dashboard](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/design/authentic-photo-hybrid-20261029/design/v3/screens/dashboard.png), [Fleet](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/design/authentic-photo-hybrid-20261029/design/v3/screens/fleet.png) and [Rentals](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/design/authentic-photo-hybrid-20261029/design/v3/screens/rentals.png) browser preview captures. This is not a signed-off design or implemented Qt UI.

Do not merge before photo-content inspection, model/trim honesty, accessible contrast, layout review and user visual approval. The C++/Qt source and stable `main` remain unchanged. Attribution conditions for Honda CC BY-SA apply if its photo is acquired. [Main-branch credits/status](../design/ASSET_CREDITS.md).

## Hybrid visual direction and authentic photography — 29 October 2026

The owner prefers a **hybrid of Precision Atelier and Editorial Grand Touring**, and explicitly authorises **authentic vehicle photography** rather than restricting visuals to silhouettes. The project is intended as a **non-commercial software engineering portfolio project**. This preference changes the visual direction, but **not** the need for permission to use specific photos. See [authentic vehicle asset strategy](../design/ASSET_STRATEGY.md).

Use real rights-cleared vehicle images where available: one purposeful hero photo, model thumbnails and selected-vehicle photographs, with a cohesive photographic treatment. Preserve a silhouette fallback for unavailable/mismatched/licence-restricted imagery. The five demo model names do not establish exact year/trim or guarantee that a photograph depicts a real inventory unit. Keep explicit provenance and credit records for every image. Do not imply manufacturer endorsement, claim commercial clearance, or use manufacturer press imagery without verifying use terms.

**Status:** Image strategy approved at a high level, **no individual photographs cleared or incorporated**. No C++/Qt code changed. Next is candidate image sourcing with exact page/license links and a final hybrid visual comparison, then actual Qt implementation after visual approval.

## V2 comparative art-direction checkpoint — 29 October 2026

Aesthetic-only comparison [design/v2/COMPARISON.md](../design/v2/COMPARISON.md) now contains three high-resolution browser-rendered dashboard directions and a self-contained switchable visual preview. A = Precision Atelier (graphite, warm white, lime), B = Nocturne Instrument (dark technical blue), C = Editorial Grand Touring (ivory, burnt copper, serif and a different panoramic composition). All display the same **5 fictional vehicles, 4 available, 1 active rental, R2,300 booked value, 1 due on 30 Oct 2026** from repository demo files. The date is frozen to 29 October 2026 for fair comparisons. The concept controls other than the art-direction selector are inert. Browser screenshots were checked at 1440×900 and one 1280×720 viewport, with no horizontal overflow; the lower area scrolls at 1280×720. This is not Qt acceptance.

**Not decided:** The owner has not selected a direction. The next step is an explicit visual review, then Fleet and Rentals concepts in the chosen aesthetic. C++ source, tests and persistence remain unchanged in this phase. Do not call any V2 concept an implemented Qt screen. Do not reuse the generated exploratory moodboard with inaccurate figures as an application screenshot.

# Project Continuity - 29 October 2026

## Objective

Make `Sonkhe-Shongwe/vehicle-rental-system` a credible, honest software engineering portfolio artifact for a Retipuj Zoft Full-Stack Software Engineer Graduate application due **30 October 2026**.

## Source truth

Uploaded initial source archive: `VehicleRentalSystem_A3.zip` (July 2026 Qt assessment). At audit start, the public GitHub repo existed but had no commits. The complete sanitized source and screenshots were subsequently published to `main` (latest source-and-screenshot commit `253918f7b765e82df17bc5b25eec584fc11e9672`). The source ZIP contained a working-project design, not externally verified runtime execution. Its `rentals.txt` and some screenshots contained customer information and are deliberately not distributed in the hardened handoff.

## Current patch work

- Added constructor option for isolated test data directories.
- Converted fleet/rental writes to atomic `QSaveFile` results with in-memory rollback for failed operations.
- Made rental ledger authoritative so creating/returning rental needs one file write; fleet occupancy is reconstructed on reload.
- Removed automatic rewriting of source data during startup.
- Added numeric and text validation for newly created domain records; rejected duplicate active rentals from imported history.
- Added CTest regression source, sanitized `demo/`, `.gitignore`, README and documentation.
- The local container lacks Qt; GitHub Actions `40872123623` subsequently **passed** Qt 6 configuration, build, fixture hygiene and CTest on Ubuntu 24.04. Interactive Windows GUI verification is still required.

## Important preservation constraints

The default legacy data folder remains next to the C++ source (using `__FILE__`) for compatibility. The new constructor can isolate testing. Do not overwrite real `vehicles.txt` / `rentals.txt` with demo files. Back up originals. Existing data may include records in the old 14-field rental format, which the reader still supports. Do not silently migrate or delete unrecognized lines.

## Research and design checkpoint — 29 October 2026

The [full comparative portfolio / UX research report](PORTFOLIO_RESEARCH_2026-10-29.md) has been added to the repository. It reviews the current Qt source and screenshots, three comparable open-source rental systems, commercial rental workflows, Qt engineering guidance, visual hierarchy, UX, persistence, security, testing, and the Retipuj Zoft graduate role. The PDF and DOCX presentation copies were delivered separately in ChatGPT; the complete Markdown report is the tracked GitHub source.

**Confirmed completed:** current public C++17/Qt source and sanitized screenshots; source audit; regression tests; Linux Qt6 CI compile and CTest passes (latest known documentation checkpoint); the report and roadmap. No code was modified as a result of this research.

**Recommended, NOT approved or implemented:** light-first operator-focused visual refresh; grouping nine sidebar destinations into fewer user-oriented workspaces; prioritising four operational metrics; improving rental/return workflows, responsive layout and feedback; then safely introducing modular widgets, SQLite and optional REST API. Visual tokens and UI structure are proposals, not an agreed design or a working screen.

**Pending verification:** interactive Windows Qt Creator compile and user-journey acceptance, screenshots of the updated running executable, accessibility/resizing checks, data migration and recovery, and all future features proposed by the research. Never infer these from CI alone.

**Next development decision:** agree on a bounded visual/UX specification and acceptance scenarios; improve the current application incrementally, preserve domain behaviour, and test each user journey. Prioritise a truthful portfolio demonstration for the **30 October 2026 application deadline**, not a speculative framework rewrite. The full design roadmap remains in the research report; do not label later milestones complete.

## Phase 1 design exploration — 29 October 2026

**Completed as design evidence, not implemented in Qt:** An editable standalone HTML prototype of Dashboard, Fleet Management and Rental Management, plus desktop screenshots, a 1280 px layout check, full [design specification](../design/DESIGN_SPEC.md) and [design index](../design/README.md) are now tracked in GitHub. The prototype uses exactly 5 fictional demo vehicles and 2 sample rental records, and never writes application data. Interactive browser checks passed for page navigation, search, rented filter, selected vehicle, price preview, history tabs and a clearly non-persistent submit response. These are **browser prototype checks only**, not Qt tests.

**Direction proposed, not approved:** light-first operator console with dark navy navigation, fewer permanent destinations, four primary KPIs, contextual rental and fleet actions, and adaptive panels. No C++/Qt code changed during this design milestone. Existing Linux Qt6 CI remains the source-code regression gate; Windows GUI acceptance is still pending.

**Next decision:** review the three prototype screens with the owner and resolve any visual/functional changes. Only then implement a bounded Qt UI milestone, run Linux CI, and test the actual Qt app on Windows with disposable files. Do not replace verified application screenshots with prototype renders.

## Aesthetic-only V2 research checkpoint — 29 October 2026

The owner reviewed the Operator Console V1 visual prototype and found it well organized but too bland/generic, without enough visual identity or wow factor. The full [aesthetic research report](VISUAL_AESTHETICS_RESEARCH_V2_2026-10-29.md) critically evaluates the current Dashboard, Fleet and Rentals screenshots and studies current Linear, Attio, Raycast, Polestar, Fluent 2, Carbon, Fleetio and Booqable visual conventions. This phase is **visual research only**: no additional features, new Qt screens, altered persistence, UI screenshot generation, or source-code changes.

Three art directions are proposed for side-by-side visual review: **A Precision Atelier** (graphite/mineral white/signal lime, recommended starting direction), **B Nocturne Instrument** (dark high-tech), **C Editorial Grand Touring** (warm luxury editorial). None is approved. Their proposed colours, hierarchy, typography, selected-vehicle rendering, table treatment, visual risk analysis, contrast checks and desktop acceptance tests are documented. Keep V1 prototype files as the baseline; future visual iterations must be separately labelled and reviewed. Once a direction is chosen, compare designs using the same fictional data before any Qt implementation.

## Immediate next actions

1. **COMPLETE:** Prepared C++/Qt source, tests, docs, fictional demo data and sanitized screenshots are committed directly in the public GitHub repository. Do not publish real customer data.
2. **Linux CI PASS:** Hosted Qt 6 compile + CTest passed on commit `253918f`; **NEXT:** Run Qt Creator on Windows and document exact compiler/test output.
3. Complete the disposable-data GUI smoke test and save a short dated result.
4. Make a concise application submission featuring the repo link and confirmed C++/Qt functionality.
5. Defer SQLite/REST/full-stack extensions until the tested release candidate is stable.

## Review risks after this checkpoint

The project is still a Qt desktop app with flat-file storage and no service API. SQLite transactions, secure customer data lifecycle, source-independent AppData paths, deterministic IDs and a clean deployment story are not yet implemented. `mainwindow.cpp` remains large. Revenue is calculated as sum of rental values, not receipts. All code must be compiled and tested on the target kit.
