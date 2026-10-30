# R1 | Final Independent Visual Audit: Navy / Emerald / Cloud White

**30 October 2026. Decision: CONDITIONAL DESIGN-REFERENCE APPROVAL BY ASSISTANT, NOT OWNER APPROVAL.**

The owner-supplied nine-page Rental Studio Theme Redesign Proposal Expanded is the selected styling reference. It remains the authority for Midnight Navy `#17324D`, Emerald Teal `#0F766E`, Cloud White `#F6F8FA`, Ice Blue `#EAF0F4`, Soft Mint `#E8F5F0`, three primary left-nav areas and the Vehicle → Customer → Review with live not-payment quote. The original PDF and corrected independent browser HTML, screenshots and full P0–P9 workbook were provided in the ongoing ChatGPT conversation; the HTML is **not committed Qt source**.

## Findings corrected in the offline HTML design deliverable

1. Removed dead A/B switch handler and added a clean product viewing mode, hiding review toolbar/banners without losing state controls.
2. Corrected dialog Tab / Shift+Tab focus trap, Escape handling and focus restoration to the originating action.
3. Added keyboard Space activation to inventory table selection, with visible focus.
4. Differentiated rented/active, due-today, overdue, returned, archived chips using visible text and distinct colours.
5. Empty fleet now explicitly explains unavailable rental entry; Next is disabled. Invalid rental duration produces inline error rather than silently clamping.
6. Improved compact 1280×720 form geometry: rental primary CTA and quote are visible inside the viewport in normal state; no horizontal page overflow.
7. Removed redundant desktop inspector close affordance; preserved compact overlay close/Escape interaction.

## Reproduced verification boundary

**Final HTML SHA-256:** `0de4376e35b08ef073399da23455ce8fe860e502b2207b145529435f055a3363`.  
**Environment:** Debian 13, Chromium 144.0.7559.96, Python Playwright headless.  
**PASS:** 19/19 historical regression script checks replayed against *the corrected HTML*, 63/63 additional targeted visual, keyboard/focus, state and functional browser assertions. Actual clean-mode screenshot renders: seven key views × 1500×860/1280×720 = 14. Compact 1024×768 horizontal-overflow smoke also passed. The original HTML and a latest source-locked test script reside in the conversation deliverable package, not on a GitHub review branch.
  
**NOT TESTED/PASSED:** Compiled Qt Quick/QML, typed C++ native models, CMake/CTest for new app, actual Windows Qt Creator, 100/125/150% physical OS DPI, real persisted rental file, Windows restart, screen-reader, exhaustive native accessibility, owner image approvals. Historical Qt Widgets CTests are previous implementation evidence only.

## Visual-review verdict and blockers

The new visual language is coherent, readable and task-oriented across Overview, Fleet Gallery/Table/Inspector, New Rental/Active/History/Return. **Independent assessment: acceptable reference for the future minimal native feasibility spike, subject to owner signoff.** R1 has NOT exited: missing owner whole-product approval, licensed model-matched vehicle/motorcycle photography, and broader accessibility/manual visual checks. Do not call it Qt-approved, shipped or portfolio-ready.

[Prior selected theme](OWNER_THEME_DIRECTION_2026-10-30.md) · [Earlier whole-product browser review](OWNER_THEME_FULL_PRODUCT_BROWSER_REVIEW_2026-10-30.md) · [P0–P9 weighted transparency plan](../../docs/P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md).

Stable `main` and historically rejected Draft PR #4 remain untouched, no merge or new hosted CI claim.
