> **LATEST CONTINUITY (30 October 2026):** [Canonical current state](../docs/PROJECT_STATE_CANONICAL.md) and [full audit](../docs/FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) govern the current implementation evidence. Owner selected light Midnight Navy `#17324D`, Teal `#0F766E`, Cloud White `#F6F8FA`, Ice Blue `#EAF0F4`, Soft Mint `#E8F5F0`. Real Qt Quick Fleet P2 compiled in independent hosted Qt CI and owner's local Windows Qt Creator; final whole-product aesthetic approval, photo rights, accessibility and P2 physical monitor toolkit go/no-go are still open. Earlier speculative palettes and "QML not built" notes below are **dated history**, not the latest status.

> **30 October 2026 R1 final independent design QA:** [Reviewed fixes, browser-only test boundaries and outstanding owner approval](r1/FINAL_VISUAL_AUDIT_2026-10-30.md). Modal keyboard focus, duration errors, table Space selection, status meaning, responsive checkout CTA and clean preview improved. Browser checks passed on exact HTML, but real Qt Windows and licensed photography remain unverified. Full [P0–P9 transparency plan](../docs/P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md).

> **New interactive design R1 review, 30 October 2026:** The owner-selected theme has been carried across Overview, Fleet Gallery/Table, Inspector, New Rental and Active/History/Return in an offline **browser-only** prototype. [Read actual browser test and outstanding acceptance evidence](r1/OWNER_THEME_FULL_PRODUCT_BROWSER_REVIEW_2026-10-30.md). Standalone HTML and screenshot package provided in ChatGPT, not compiled Qt code. **R1 not yet owner-approved in full.**

> **CURRENT OWNER-SELECTED THEME, 30 October 2026:** [Midnight Navy / Emerald Teal / Cloud White design direction](r1/OWNER_THEME_DIRECTION_2026-10-30.md). This supersedes the previous colour-only directions and A/B greyscale aesthetic hypotheses; R1 whole-workspace visual acceptance and Qt Quick proof remain outstanding. The reference originated in a user-uploaded nine-page PDF, not a compiled Qt app.

> **Active 30 October R1 review:** [Compare Split Stage vs Integrated Canvas greyscale composition hypotheses](r1/COMPOSITION_REVIEW.md). The owner approved only the common principles, **not either composition**. HTML prototype and actual Chromium screenshots were delivered in the conversation; no native Qt/QML implementation or UI signoff is implied.

> **30 October 2026 — Current research direction:** After rejecting the overbright V1/V2 and generic professional-blue V3 visual experiments, the owner chose to study **Rivian (vehicle-first), Arc (tonal workspace), and Tide Guide (information/motion)** together. The agreed structure remains unchanged, and **no new exact palette or UI is approved**. The authoritative new reference handoff is [Design DNA: Rivian × Arc × Tide Guide](V4_RIVIAN_ARC_TIDE_REFERENCE_BREAKDOWN_2026-10-30.md). The earlier V3 blue token research below remains *historical exploration only*, not an implementation instruction.

> **30 October 2026 V3 research — professional light-blue system:** The owner approves the current screen structure but rejects V1/V2 font, theme and overbright colour decisions. [Read the researched V3 blueprint and Qt 6.8 feasibility study](V3_PROFESSIONAL_BLUE_BLUEPRINT_RESEARCH_2026-10-30.md). Blue/steel-neutral tokens are **proposed, not final approval**; no new Qt UI has been built.

# Design Workspace — New Light-First Rental Studio

**Owner direction updated:** 29 October 2026  
**Status:** **Conceptual product direction agreed, exact visuals/technical toolkit not yet approved**  
**Master decisions:** [Product Rebuild Audit](../docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md)  
**Current design brief:** [Light-First Experience Specification](DESIGN_SPEC.md).

**Owner-approved interaction decision, UX-CTRL-001:** [Keyboard, Focus and Interaction Contract](../docs/KEYBOARD_FOCUS_INTERACTION_CONTRACT.md). Native Qt focus conventions, one small product-wide key policy now, reusable focus styling in P4, per-feature implementation and tests as future functions arrive. This is not final product-wide accessibility acceptance and does not change the 18.4% verification score.

## Approved design direction

- Bright, inviting, neatly structured software; **no dark application shell**.
- Three primary workspaces: Overview, Fleet, Rentals.
- **Fleet gallery-first with table alternative**; common search/filter/selection and contextual vehicle drawer.
- Meaningful dynamic Dashboard: actual availability, due/overdue attention, bounded activity and no invented revenue.
- Guided rentals and returns; obvious validation, clear confirmations, subtle purposeful transitions.
- Owner can approve total code/UI replacement, but not silent loss of safeguards, privacy or tests.

**Not approved yet:** final brand name, exact sage/copper palette and typography, photography set, detailed screens, animations, Qt Quick/QML migration, source/persistence rewrite or final visual signoff.

## Required design set before code migration

| Experience | Review states |
|---|---|
| Overview | normal, empty, due/overdue, activity and CTA |
| Fleet Gallery | available/rented, missing images, selection and filters |
| Fleet Table | same exact query/selection/sort, compact operational density |
| Vehicle Drawer | available vs rented actions, correct specifications, close/Escape |
| New Rental | Vehicle → Customer → Review, live quote, validation, No/Cancel |
| Active / History / Return | status changes, return confirmation, archival guard |

Review wide **1500×860**, compact **1280×720**, keyboard accessibility and actual native Windows DPI possibilities. Designs must be coherent across all workspaces—not a beautiful Dashboard followed by unrelated forms.

## Previous research / rejected baselines (retain for learning, not implementation guidance)

- [Original blue/white V1 prototype](prototype.html), [V1 gallery](dashboard.png), [V1 Fleet](fleet.png), [V1 rental form](rentals.png).
- [V2 comparisons](v2/COMPARISON.md) and their **unapproved** A/B/C screenshots: [Atelier](v2/atelier.png), [Nocturne](v2/nocturne.png), [Editorial](v2/editorial.png).
- [Actual Qt Widgets screenshots](qt-spike/VISUAL_REVIEW.md): compiled and tested, **aesthetically rejected by owner**.
- [Archived old spec](archive/DESIGN_SPEC_PRE_RESET_2026-10-29.md) and [old asset strategy](archive/ASSET_STRATEGY_PRE_RESET_2026-10-29.md).

The new work should draw lessons from these earlier explorations, **not inherit their graphite/sidebar, lime hero or table-based shell**.
