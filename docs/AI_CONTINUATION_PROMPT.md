# Vehicle Rental System | AI Continuation Prompt

Continue development of my **Vehicle Rental System** from our authoritative GitHub checkpoint.

**Repository:** `Sonkhe-Shongwe/vehicle-rental-system`  
**Active development branch:** `feature/qt-hybrid-visual-spike-20261029`  
**Review:** Draft Pull Request **#4**  
**Current-state handoff:** `docs/AI_HANDOFF_CURRENT.md` on `main`  
**Tracking:** Issue **#2**

## 1. Recover the authoritative state

First read `docs/AI_HANDOFF_CURRENT.md`. Verify the latest GitHub branch HEAD, Draft PR #4 status and diff, latest GitHub Actions results, and relevant Issue #2 updates. Then read `design/qt-spike/RENTALS_REVIEW.md` and `design/qt-spike/VISUAL_REVIEW.md` on the development branch, followed by `docs/CONTINUITY.md`, `docs/TESTING.md`, and `docs/ROADMAP.md` as needed.

Recover the exact active milestone, implemented Qt features, design decisions, engineering constraints, test evidence, known defects, risks, and next acceptance criteria. The handoff is a dated snapshot: **verify live GitHub state before relying on a recorded commit SHA**. Prefer the current source and newest verified checkpoint over older chronological notes.

## 2. Continue the active phase

Resume hands-on development from the latest verified position. **Do not restart the audit, recreate completed mockups, repeat finished work, or move to unrelated phases.**

Maintain a **one-primary-phase-at-a-time** approach. The immediate focus is completing the existing **Qt Widgets visual redesign acceptance milestone**: Windows Qt Creator build and GUI checks, full disposable-data rental lifecycle and restart testing, interface quality at multiple display scales, and final design review.

The Dashboard, Fleet, New Rental, Rental History, and Process Return redesigns already exist on Draft PR #4. Preserve them. The current art direction combines **Precision Atelier and Editorial Grand Touring**, with graphite navigation, warm mineral surfaces, restrained lime highlights and authentic, appropriately licensed automotive photography.

Do not introduce SQLite, REST APIs, React, cloud services, AI or major architecture rewrites merely to increase scope before the current release gate is met.

## 3. Verification, visual quality and safety

Preserve all working C++17/Qt functionality, rental rules, file persistence and existing data. Test with **fictional or disposable data**, never real customer records.

Do not interpret a successful Linux build, CTest result or screenshot capture as proof that interactive Windows workflows have passed. Keep verified tests, pending tests and failures clearly separate. Do not disable or weaken failing tests to obtain green CI. Fix root causes and add regression coverage where appropriate.

Inspect actual **compiled Qt screenshots**, not only browser prototypes. Check readability, clipping, spacing, window resizing, keyboard use, high-DPI rendering, photo quality, source credits and interface consistency. Never present estimated rental totals as collected payments, or illustrative car photos as actual fleet inventory photographs.

If the working environment cannot run Windows or Qt Creator, complete the checks it genuinely supports, record the Windows-specific blocker and prepare reproducible instructions and acceptance evidence for the target Windows machine. **Never claim unexecuted checks passed.**

## 4. GitHub accountability and continuity

Work on `feature/qt-hybrid-visual-spike-20261029`, or a clearly identified review branch based on it. Keep stable `main` untouched until the required verification and my approval are obtained. Do not merge Draft PR #4 automatically.

Commit focused, reviewable increments. After each verified milestone, update:
- `docs/AI_HANDOFF_CURRENT.md` as the canonical state record.
- `docs/CONTINUITY.md` and relevant test/design review documents.
- Draft PR #4 and Issue #2 with changes, exact tested SHA, evidence and remaining gates.

Avoid unrelated changes, unsafe data migrations, private data, unlicensed imagery and unnecessary generated files. Verify branch and commit state again after any CI workflow that writes to GitHub.

## 5. Progress reporting

Give concise updates stating what changed, what was verified (environment, command/run and commit), what remains unresolved, and the next highest-priority acceptance criterion. Measure progress against documented acceptance criteria, **not arbitrary percentages**.

Do not ask me to repeat information already documented in GitHub. Ask only for an essential decision or an action that genuinely requires my local Windows machine or approval.

**Continue development immediately after recovering the live checkpoint. Preserve functionality, prioritise real software quality and visual polish, and do not call the redesign complete until its outstanding acceptance gates have been met.**
