# Rental Studio | Owner-Selected Navy / Emerald Theme Direction

**Decision:** 30 October 2026. **Status:** VISUAL LANGUAGE AND RENTALS COMPOSITION SELECTED; full-product R1 acceptance still open.  
**Source supplied by owner:** nine-page PDF, `Rental_Studio_Theme_Redesign_Proposal_Expanded.pdf`, explicitly selected as the direction to take. This text records its design rules; it is **not a claim the PDF, images, or new application UI have been committed to GitHub**.

## 1. Decision precedence

This is the owner's **newest explicit visual decision** and supersedes earlier unselected sage/copper, V3 blue, and greyscale-only directions. Retain the earlier Rivian/Arc/Tide research as *inspiration and interaction principles*, not a competing palette. The older graphite/lime Qt Widgets design remains rejected. Do not interpret the new PDF as permission to merge historic Draft PR #4 or as proof of any Qt Quick build.

**Selected:** premium light SaaS / desktop product styling; cool neutral canvas; **Midnight Navy** for structure, headings and active navigation; **Emerald Teal** for the primary next action and focus; **Cloud White / Ice Blue / Soft Mint** for controlled surface roles. A left-side three-item Overview/Fleet/Rentals navigation is the preferred shell; New Rental uses a clearly labelled Vehicle → Customer → Review progression with visible side-by-side estimate. Page 4 of the owner proposal shows the reference rental composition.

**Not yet claimed:** complete owner approval of all Overview and Fleet layouts, focus/empty/error variants, final authentic vehicle imagery, typography/font licence, actual Qt Quick/C++ implementation, real Windows testing or final release. **R1 remains open** until whole-product review at both target sizes.

## 2. Source-aligned token contract (design-level only)

| Role | Token | Value | Application |
| --- | --- | --- | --- |
| Page canvas | `canvas` | `#F6F8FA` | Cool light background, not bright unbounded white |
| Elevated surface | `surface` | `#FFFFFF` | Main cards, forms, important legibility |
| Sidebar / quiet surface | `sidebar` | `#EAF0F4` | Left navigation and subdued panels |
| Structure / main ink | `navy` | `#17324D` | Headings and selected navigation |
| Primary action | `primary` | `#0F766E` | One clear main CTA per step |
| Primary hover | `primaryHover` | `#0C625C` | Pointer feedback only |
| Selection / quote | `selected` | `#E8F5F0` | Active selection and estimate panel |
| Muted readable text | `mutedInk` | `#5F6F82` | Secondary body text; corrected from `#64748B` |
| Border | `border` | `#D8E2E8` | One-pixel form and card borders |
| Rented status text | `rentedInk` | `#1D4ED8` | Explicitly labelled rented state |
| Pending status text (future) | `pendingInk` | `#92400E` | **DO NOT expose as current rental status** |
| Overdue status text | `overdueInk` | `#B91C1C` | Derived date warning with text and icon |

**Checked WCAG-style contrast arithmetic** on indicated source pairs: white on emerald = **5.47:1**; navy on canvas = **12.33:1**; old slate `#64748B` on canvas = **4.47:1 (below 4.5:1)**; corrected muted ink `#5F6F82` on canvas = **4.83:1**. The actual screen still needs control-by-control contrast verification, including coloured chips, buttons, focus outlines and disabled states.

**Typography and geometry from PDF pp. 8–9:** heading about **32/40 px**, body **14–16/22 px**, labels **12/16 px** only when legible, base spacing **8 px**, field gap **16 px**, cards **24 px** padding and **12–14 px** radii, buttons **8–10 px** radii, interactive target **44×44 px**, focus ring **2 px** with **2 px** gap. These are a component design baseline, **not a promise to force fixed pixel dimensions under native Windows 125/150% DPI**. Font family and licensing still to select.

## 3. Screen-by-screen translation, preserving approved information architecture

- **Overview (operations-first):** use navy structure, a quiet ice-blue shell, clear action affordances and selectively mint-highlighted attention. Fleet 5 / 4 available / 1 active and R2,300 booked value apply only to the fictional sample, not hardcoded product truth. Due/overdue derives from persisted dates and clock. Never label booked value as collected revenue.
- **Fleet (vehicle-first):** carry the same navigation and component system into gallery, table and inspector. Real approved model-matched imagery is still pending. Gallery/table share filter/search/sort/selected ID, status is text plus colour, rented vehicle cannot start another rental. Avoid turning the gallery into repetitive brightly coloured card panels.
- **Rentals (task-first):** owner PDF p.4 is the selected composition reference: left rail, navy page heading, New Rental/Active/History/Return subnavigation, white guided form, persistent soft-mint **LIVE QUOTE / NOT A PAYMENT** panel. Vehicle → Customer → Review; 1–365 days, same-day only; quote and confirmations come from domain and persisted state. Example Corolla R450 × 3 = R1,350 is illustrative demo data.
- **History / Returns:** share tokens, status, buttons, form focus, confirmations, accessibility; no destructive state before confirmation and successful write. No rewrite of existing domain behaviour solely for design.

## 4. Source-to-product safety adjustments

The PDF is a visual design **proposal**, not a new rental engine specification. Therefore:
- Its **Pending** status chip is a *future-state design example*: the current domain has active/returned/archived rental states, not advance/pending reservations. Do **not** introduce a fake pending booking feature.
- Its **Save draft** secondary action is illustrative; current domain has no draft-rental persistence. Do not render a clickable faux action.
- **Overdue** is computed from an active rental's due date relative to the injected/current clock, not a new persistent rental status enum.
- Keep **Booked Rental Value** distinct from income or paid amounts; keep estimates explicitly labelled NOT A PAYMENT.
- Maintain cancellation/No/Escape non-mutation, atomic existing saves, negative booking guards and fictional data.

## 5. R1 acceptance still required before R2 QML Windows spike

1. Produce one coherent **owner-PDF-inspired** high-fidelity review for **Overview, Fleet Gallery, Fleet Table, Inspector, Vehicle/Customer/Review, Active, History, Return** at **1500×860 and 1280×720**.
2. Verify truthful sample labels, correct availability, quote/return dates, empty/unavailable/error/long-text states, keyboard focus and alternative status communication.
3. Confirm typography, contrast and photograph rights; ensure the reference page is treated as a **concept**, not a real compiled Qt screen.
4. Seek explicit **whole-product owner design approval** of that review. Only then begin small real Windows Qt Creator **Qt Quick/QML + typed C++** feasibility, preserving old C++ behavioural contract and original data.
5. Keep documentation/design changes off stable `main`; historical PR #4 stays DRAFT/unmerged. No new QML, SQLite, shipping claims or test pass should be inferred from this approval.

## References within owner PDF

- PDF p. 2: keep left navigation, three-step rental and live estimate; improve contrast/action hierarchy.
- PDF p. 3: palette definitions and roles.
- PDF p. 4: selected high-fidelity **Rentals** composition.
- PDF pp. 5 and 7: semantic states and colour-as-purpose rules.
- PDF pp. 6 and 8–9: component implementation guidance, geometry, focus and contrast verification.

**Historical A/B greyscale compositions** remain exploration artifacts, not the selected aesthetic. We use their tested workflow concepts where useful, but the new user-supplied PDF takes precedence for visual direction.
