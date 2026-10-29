# AI / Developer Handoff — CURRENT STATE
**Captured:** 29 October 2026 (Africa/Johannesburg)  
**Repository:** https://github.com/Sonkhe-Shongwe/vehicle-rental-system  
**Goal:** Produce a polished, truthful, portfolio-ready C++17/Qt Widgets Vehicle Rental System for a remote graduate full-stack software engineering application, deadline **30 October 2026**. The near-term deliverable remains a credible *desktop* software engineering project; do not claim a web app, API, database, payments, cloud deployment or production certification.

> **Start here for a new AI or collaborator.** This document gives the latest known state and reading order. It is a dated snapshot, not a live status feed. Verify current GitHub branch heads and workflow conclusions before changing code. The timeline in `docs/CONTINUITY.md` includes older superseded checkpoints; resolve conflicts in favour of verified source, latest PR commits, tests and this handoff's captured date.

## 1. Exactly where work stopped

**The latest completed work is Rental Management V2, implemented in REAL Qt Widgets** on a separate design implementation branch. Dashboard and Fleet were redesigned earlier on the same branch. The graphical user interface is coherent in Ubuntu/Xvfb captures at two resolutions. **The user has NOT approved the final visuals; Windows GUI acceptance and full lifecycle persistence regression remain outstanding. Do not merge yet.**

- **Stable `main`:** branch SHA at snapshot `9dbf42721e1fba2e7c0786a51cc7c1446e0ae6b1` (documentation will advance this hash). The source on `main` is the previously verified baseline, not the new visual interface.
- **Current implementation branch:** `feature/qt-hybrid-visual-spike-20261029`; snapshot HEAD `3edc66108a83bd204519144e61fd3529e8f9cec7`. [Draft PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4) into `main`: open, draft, **unmerged**.
- **Separate authentic-photo sourcing branch:** `design/authentic-photo-hybrid-20261029`; [Draft PR #3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/3): open, draft, **unmerged**. It contains conceptual browser previews and source assets; do not mistake its HTML screenshots for Qt screenshots.
- **Design coordination:** [Issue #2](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/2) (open), with checkpoints and pending acceptance.
- **The very latest application-code update** corrected rental quote language to **ESTIMATED RENTAL TOTAL** and updates the prompt after customer details are entered. These changes are included in passing [Qt screenshot run 40914456325](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40914456325).

### Implemented on the review branch, not on `main`
1. A warm mineral-white desktop canvas, dark graphite grouped sidebar and selective lime highlights, combining **Precision Atelier + Editorial Grand Touring** art direction.
2. Dashboard: dynamic fleet readiness and original metrics, compact secondary metrics, real Qt hero image, truthful booked-value semantics.
3. Fleet: selected-vehicle inspector with locally bundled representative vehicle photos for Corolla/Ranger/i20 (CC0, credited); model/rate/availability details; in-page ID/brand/model search; availability filters; previous operations retained.
4. Rentals: two-column immediate-checkout form, live estimate, due date, available status, nonempty customer name + phone gating; refreshed Rental History ledger with status filters and guarded archive/delete; refreshed Process Return panel. Existing domain functions and persistence retained.
5. 10 real Qt screenshot assets on this branch in `design/qt-spike/`: Dashboard, Fleet, New Rental, Rental History, Process Return at **1500×860** and **1280×720**.

## 2. Exactly what is verified, and what is not

**Passed:**
- [Review-branch Ubuntu 24.04 Qt6 screenshot workflow 40914456325](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40914456325): CMake configure, C++17/Qt Widgets compilation, CTest `vehicle_rental_domain`, 10 synthetic-fixture Qt UI captures and PNG/dimension checks.
- Non-destructive Qt runtime checks: C002 already rented is unavailable for a new quote; available C001 Corolla R450/day × 3 days = **R1350.00**; confirm button disabled until required customer name/phone present; History filter gives 2 current / 1 active / 1 returned / 0 archived; Return page shows active record R001.
- Dashboard/Fleet widget geometry non-overlap checks; rental page layout **visually reviewed from both real screenshots** (do not claim the separate geometry assertion passed for rental forms; its early reading was inconsistent).
- The latest source branch HEAD (documentation-only commit `3edc661...`) also had an independent passing [domain-build workflow 40914850112](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40914850112).

**NOT yet verified:**
- Interactive **Windows Qt Creator** compilation/run and screenshots in a real Windows session, including keyboard navigation, input validation and Windows scaling at 100%, 125% and 150%.
- End-to-end create → reject duplicate/double booking → save → restart → return → archive → delete on a **disposable copy** of records.
- File-write failures, crash/power-loss recovery, all empty/error states, and installer/deployment packaging.
- Final high-quality imagery and user sign-off of the new aesthetic. The current Ford photo is licensed but aesthetically weak (street background, visible plate); motorcycle photos still pending.
- Any SQLite, REST API, React, backend server, cloud, AI, payments, production security controls or application installer. These are future milestones only.

**Important:** Some intermediate CI runs failed while fixing layout assertions and screenshot harness issues. Do not claim those passed retroactively; cite the latest passing run and its exact SHA. Review-branch screenshots are **real compiled Qt captures**; older `design/v2` and `design/v3` HTML comparison screens are concepts.

## 3. Design rules decided with the owner

- Stronger-than-generic enterprise aesthetic, but not a flashy gaming dashboard: graphite/ivory/mineral white, lime used sparingly, editorial typography, asymmetric emphasis and automotive personality.
- Prefer **authentic photographs of the demo vehicle models**, not only silhouettes. App remains a **non-commercial portfolio** project, but non-commercial intent is **not** an automatic reuse licence.
- Image sources require individual permission, attribution/provenance and licence compliance. Three representative CC0 model photos for cars are bundled in the Qt review branch (`assets/`, credits in `assets/README.md`). Missing Honda/Yamaha photos must use labelled placeholders; do not insert unlicensed downloads.
- Avoid inventing product functionality, operational metrics or recorded payments. Show rental cost as an estimate until booking; historical booked amounts are **not** payment receipts.
- Preserve working C++ domain and file persistence while improving the interface. Changes should be small, reversible and verified.

## 4. Real demo data and privacy rules

**Authoritative demo files:** `demo/vehicles.txt`, `demo/rentals.txt` (fictional); use these rather than data inferred from older design mockups.

| Vehicle ID | Model | Rate/day | Demo state |
|---|---|---:|---|
| C001 | Toyota Corolla | R450 | Available |
| C002 | Ford Ranger | R700 | Rented |
| C003 | Hyundai i20 | R400 | Available |
| M001 | Honda CB500F | R280 | Available |
| M002 | Yamaha MT-07 | R300 | Available |

Two rental records: R001 active on C002 for R1400; R002 returned on C001 for R900. Totals: 5 vehicles, 4 available, 1 active, 3 cars, 2 motorcycles, and R2300 in *booked transaction value* (not received revenue). Fixture dates are fixed to October 2026; date-sensitive behaviour must be tested knowingly on later dates.

**Never commit real customer names, phone numbers or sensitive local storage.** Do all functional GUI tests with disposable copies. Do not overwrite the owner's existing local project or real data.

## 5. File map and reading order

1. **This file**: most recent concise state and immediate handoff instructions.
2. [PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4), and branch `feature/qt-hybrid-visual-spike-20261029`: authoritative *current implementation*. Inspect `mainwindow.cpp`, `mainwindow.h`, `main.cpp`, `resources/portfolio.qrc`, `assets/README.md`, CI workflow and recent commits. Base `main` is older.
3. [`design/qt-spike/RENTALS_REVIEW.md`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/feature/qt-hybrid-visual-spike-20261029/design/qt-spike/RENTALS_REVIEW.md): latest rental screenshots, functional smoke checks and remaining gates.
4. [`design/qt-spike/VISUAL_REVIEW.md`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/feature/qt-hybrid-visual-spike-20261029/design/qt-spike/VISUAL_REVIEW.md): earlier Dashboard/Fleet iterations and known issues. Earlier statement that Rental UI is pending is superseded by the file above.
5. [`docs/CONTINUITY.md`](CONTINUITY.md): full chronological decisions. **Read newest entries first** and treat older "next steps" as historical.
6. [`docs/TESTING.md`](TESTING.md), [`docs/ROADMAP.md`](ROADMAP.md), [`docs/AUDIT.md`](AUDIT.md), [`docs/ARCHITECTURE.md`](ARCHITECTURE.md): original engineering audit and baseline test plan; older status entries may predate PR #4.
7. [`design/ASSET_STRATEGY.md`](../design/ASSET_STRATEGY.md), [`design/ASSET_CREDITS.md`](../design/ASSET_CREDITS.md) and [photo PR #3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/3): photography policy, credits, source limitations.
8. [Issue #2](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/2): open design and acceptance checklist.

## 6. What to do NEXT (do not jump ahead)

**Priority P0, deadline-sensitive:**
1. Re-fetch GitHub branch SHA, PR #4 diff and latest CI status. Keep stable `main` unchanged until sign-off. Work on the review branch or a new branch based on it.
2. On Windows, open the **review branch** with Qt Creator and a working Qt 6 kit. Configure/build; run CTest. Record exact Qt/compiler/Windows version and exit codes. Suggested CLI:
   ```powershell
   cmake -S . -B build -DBUILD_TESTING=ON
   cmake --build build --config Release
   ctest --test-dir build -C Release --output-on-failure
   ```
   These are instructions, not evidence they were run.
3. In a **disposable** test checkout, verify add/search/rent, reject second rental of C002, close/reopen persistence, return by ID, repeat-return refusal, archive returned, delete archived, and reject removing a rented vehicle. Check all UI destinations, keyboard focus and resizing; test Windows 100/125/150% scaling. Capture screenshots of the **real Qt executable**.
4. Fix any defects in bounded commits, rerun Qt tests/screenshots, update [PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4) and a dated Windows acceptance report.
5. Request explicit owner final visual approval. Only then consider merging to `main`. Update README/screenshots to distinguish stable app from the redesigned release.

**Priority P1 (after credible application submission):** Improve photo curation/remaining motorcycles; simplify the old nine-action sidebar into fewer task-oriented destinations if desired and verified; refine empty states; refactor oversized `mainwindow.cpp`; improve persistence reliability and data handling. SQLite and small REST API are optional later increments, not emergency additions.

## 7. Communication and development guardrails

- Another AI should **not re-audit from zero, redesign from zero or assume old mockups were implemented**. Continue from PR #4 and this document.
- State exactly which branch and commit was tested, and distinguish *source exists*, *build passed*, *non-destructive UI smoke passed*, *manual Windows run*, and *production-grade*.
- Maintain README, current handoff, continuity, issue/PR notes and test evidence whenever the state changes.
- New AI **will not automatically inherit this conversation or personal context**. All indispensable decisions should be explicit in this repo, and any missing owner preferences should be asked rather than invented.
- The owner wants polish but also engineering credibility for a 30 October 2026 graduate application, so prioritise verified functioning software and truthful portfolio descriptions over untested last-minute features.

**Suggested prompt for a new AI:** "Open this repository's `docs/AI_HANDOFF_CURRENT.md`, inspect Draft PR #4 and its latest commit, read `design/qt-spike/RENTALS_REVIEW.md` and `docs/CONTINUITY.md`, verify recent Actions, then continue the P0 Windows acceptance work. Preserve existing functionality, do not merge or claim unverified work, and update the handoff after changes."
