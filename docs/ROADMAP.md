> **30 October 2026 R1 delivery evidence:** The owner-selected navy/emerald design is now rendered as a **whole-product interactive browser review**, not native Qt. [Evidence report](../design/r1/OWNER_THEME_FULL_PRODUCT_BROWSER_REVIEW_2026-10-30.md): 14 principal actual browser screenshots (7 screens × 1500×860/1280×720), additional state captures, Chromium functional checks including create/return/cancel/validation and compact horizontal-overflow checks PASS. **R1 owner aesthetic signoff, final images, focus/accessibility and small-screen scrutiny remain PENDING. R2 Qt Quick Windows feasibility remains NOT STARTED.**

> **30 October 2026 OWNER THEME SELECTION:** The uploaded expanded Rental Studio PDF is the agreed **visual design direction**, replacing the previous theme exploration. Source-aligned tokens and the selected left-nav/three-step-rental/live-estimate reference are [recorded here](../design/r1/OWNER_THEME_DIRECTION_2026-10-30.md). **R1 design completion is still OPEN** until the identical system is applied to every workspace, checked at both desktop sizes and explicitly approved in full. R2 Qt Quick Windows proof and all application implementation remain NOT STARTED.

> **30 October 2026 R1 update:** Owner approved the **design principles** only (operations-first Overview, vehicle-first Fleet, task-first Rentals; cohesive medium-light tonal identity). Two greyscale whole-product browser review layouts (A Split Stage, B Integrated Canvas) are [documented here](../design/r1/COMPOSITION_REVIEW.md), with local Chromium interaction checks at 1500×860, 1280×720 and 1024×768. **R1 still IN REVIEW**, no final composition/visual approval, no QML proof, no C++ source changes. The artifact's interactive HTML and contact sheets were delivered via conversation, not committed as Qt app evidence.

> **30 October 2026 master engineering pathway research:** [Read the full staged development, risk, persistence, Qt Quick, testing, CI and Windows distribution strategy](ENGINEERING_MASTERPLAN_RESEARCH_2026-10-30.md). It is a **proposal pending owner review** and refines the earlier R0–R8 milestone descriptions; no application code, approved UI or infrastructure migration is implied.

# Product Rebuild Roadmap — Light-First Rental Studio

**Updated:** 29 October 2026  
**Authority:** [Master rebuild audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md)  
**Current status:** PRODUCT DIRECTION AGREED; VISUAL SYSTEM / TOOLKIT PROOF / REPLACEMENT NOT IMPLEMENTED  
**The former 30 October 2026 app-deadline plan is superseded and preserved at** [archive](archive/ROADMAP_PRE_RESET_2026-10-29.md).

**Tracking issue:** [Full product rebuild #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5). **Historical UI review:** Draft PR #4, unmerged.

## Governing rules

- No sacred old UI, data model or code. Rewrite when it meaningfully improves the product.
- Preserve **functional outcomes, safe persistence, privacy and regression evidence**, even when replacing implementation.
- Light-first, warm, welcoming look; three workspaces; hybrid gallery+table Fleet are agreed.
- High-fidelity full-product visual approval **before** a heavy source migration.
- Work locally with Qt Creator and fake records; GitHub Actions as independent gate **only when available**.
- No automatic merge to main; old PR #4 rejected aesthetically and remains unmerged.
- Document precise status: designed ≠ implemented ≠ tested ≠ approved.

## Work packages — no artificial deadline

| Gate | Deliverable | Exit evidence | Status |
|---|---|---|---|
| R0 | Master audit, requirements and honest source inventory | Owner decisions/gaps recorded, rollback baseline linked | DOCUMENTED |
| R1 | High-fidelity system design for Overview, Fleet Gallery/Table, Drawer, Rentals/Returns | Whole-system owner approval; two sizes; empty/errors/focus | NEXT; UNAPPROVED |
| R2 | Qt Quick/QML vs alternative technical spike on real Windows kit | Compiles, model binding, navigation, keyboard, 1280/1500 and smooth interaction | NOT STARTED |
| R3 | Design system and 3-workspace navigation | Reusable components, visual states, local screenshots and usability | NOT STARTED |
| R4 | Gallery↔table Fleet + contextual management + real Overview | Shared state, accurate derived KPIs, correct selection/actions | NOT STARTED |
| R5 | Guided Rentals/Active/History/Return | Complete lifecycle parity, negative tests, restart, cancellation non-mutation | NOT STARTED |
| R6 | Data hardening and packaging decision | Migration + backups/rollback if needed; install and local data path QA | NOT STARTED |
| R7 | Cross-platform integration and real physical Windows acceptance | Full CTest, Linux/Windows when available, DPI 100/125/150, photos, owner approval | NOT STARTED |
| R8 | Merge/release decision | Explicit owner authorisation, clean branch state, truthful README/CV | BLOCKED |

**Gate R2 is not permission to implement the whole product blind.** If the first QML proof fails on the Windows kit, revisit toolkit choice before increasing scope.

## Parallel streams that are allowed

- **Visual design/research:** typography, references, components, car photo candidates and careful licence checks. Keep source-approved decisions distinct from suggestions.
- **Baseline safety:** preserve tested old rental behaviours, source SHA and fictional fixtures in independent test specs.
- **Engineering infrastructure:** staged artifact-first CI, concurrency and docs-only fast paths live separately at [optimisation branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/docs/ci-budget-development-strategy-20261029) (NOT integrated/CI-verified). Local-first helper available there.
- **Architecture design:** review long-term storage options without combining irreversible migration with a graphical rewrite.

## Non-negotiable parity checklist

Create vehicle; duplicate ID refusal; search/filter; correct status; rent available (1–365 days); reject duplicate booking; quote and days exact; persistence after restart; return and refuse repeated return; archive returned; delete archived; decline No/Escape without data change; display readable errors on write failures; fictional test records only.

## Visual quality gates

Owner rejects old screenshots; do not submit the old Qt Gallery/Dashboard as a finished showcase. New design must prove meaningful selection, shared view state, smooth low-distraction motion, responsive layouts, natural forms and appropriate photography, keyboard focus/contrast, and a coherent aesthetic on *all* workspaces.

## Delivery / dependency notes

Actions allowance expected renewal 1 November 2026 is user-reported, **not verified**. Public standard runners are generally free but account-specific restriction must be inspected. Do not use CI runs as a substitute for local native Windows acceptance.

**Immediate next action:** design a full, coherent light-first high-fidelity multi-screen review set; capture the owner's likes/dislikes; then approve or reject the QML candidate on the real Windows kit.
