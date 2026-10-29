> **HISTORICAL VISUAL RESEARCH — superseded 29 October 2026.** Old Precision Atelier/Nocturne/Grand Touring explorations were not owner-approved final product designs. The owner rejected the implemented graphite/lime aesthetic and explicitly chose a **welcoming light-first** direction. Use as comparative evidence only. See [new design spec](../design/DESIGN_SPEC.md) and [master reset](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md).

# Vehicle Rental System — Visual Aesthetics Research (V2)
**29 October 2026 | Design research, not implementation**
**Scope:** Visual styling and art direction only. Colour, typography, spatial composition, visual hierarchy, brand signature, iconography, depth, data density, visual feedback and native-desktop feasibility. This report **does not propose changing the domain model, reservation rules, persistence, database, API, or working Qt interactions**.

## Executive finding

The existing Operator Console V1 is clean, usable, and consistent, but its screenshot looks interchangeable with a generic SaaS administration template. A dark navy sidebar, cobalt actions, light-grey canvas and uniformly rounded white panels create sound order but little visual personality. The problem is **insufficient brand distinctiveness, excessive uniformity of visual emphasis, and little automotive character**. The answer is **not more decoration everywhere**. Use a distinctive but restrained automotive-inspired visual system, one prominent visual anchor per screen, stronger typographic contrast, and a deliberate component hierarchy.

**Recommended research direction:** Precision Atelier / Automotive Instrumentation — graphite, warm mineral white, a controlled high-energy lime accent, precision typography and a data-first desktop surface. Alternative directions are documented below. **None is approved or implemented.**

## 1. Examined baseline

Actual sources: [Dashboard V1](../design/dashboard.png), [Fleet V1](../design/fleet.png), [Rentals V1](../design/rentals.png), [Phase-1 design specification](../design/DESIGN_SPEC.md). Screenshots are **HTML design prototypes**, not the compiled Qt interface.

### Dashboard: where the blandness originates
- Four visually equal KPI tiles are lined up at identical height, all white, bordered and lightly shadowed. This prevents the eye from recognizing which fact is central.
- The white Recent Activity, Needs Attention, and Availability panels all follow almost the same card formula. The attention item receives a warm edge, but its surrounding card feels like every other card.
- Cobalt appears on the selected navigation item, header action, mini-icons and links. Repetition without hierarchy makes the colour functional but unmemorable.
- The small R-square logo and generic title Rental Manager do not create an identifiable automotive/technical brand.
- Large quiet areas across a 1440×900 screenshot are not intrinsically bad, but with only five vehicles and two rental records the rhythm becomes repetitive and visually static.
- The thin fleet availability bar could be a signature visual instrument, but currently reads like a standard progress indicator.

### Fleet: where opportunity is lost
- The selected Ford Ranger is represented by the same generic outline car icon as other models. This sacrifices an automotive focal point.
- The right details panel has a small icon followed by conventional labels and divider lines. It could become an elegant asset inspector with a typographic vehicle identity and restrained technical illustration.
- Five table rows end high above the bottom of a tall white container. Preserve honest emptiness, but visually end the data region intentionally rather than stretching a generic card.
- Type, rate and status are legible but use nearly equal visual weights. The eye should find model and status before auxiliary metadata.

### Rentals: where emphasis is too evenly distributed
- A left white ledger and right white checkout form have little contrast or visual tension.
- The active rental line is a small text strip, not a visually legible lifecycle indicator.
- The blue quotation total feels like another generic input card rather than a designed financial instrument.
- The page misses a visually distinctive focal element when the current rental is selected.

**Diagnosis, not evidence of usability failure:** These are expert visual judgments from source screenshots; they are not measurements of users, recruiter preferences, or a controlled design experiment.

## 2. What exemplary products teach us (aesthetic principles only)

| Source | Observed aesthetic practice | Useful adaptation | What NOT to copy |
|---|---|---|---|
| **Linear** (March 2026 design refresh) | Less prominent navigation, consistently resized icons, softer dividers, and content given greater visual authority | Dim the surrounding shell; make the central rental workspace feel important | Copying the dark issue-tracker surface wholesale or making every screen almost black |
| **Attio** (May 2026 record page redesign) | Composed headers and action clusters, structured details, clean negative space and varied information density | Improve typographic rhythm and the selected-vehicle inspector | Replicating CRM record complexity or ultra-pale micro-labels |
| **Polestar visual identity** | Pure minimalism with precise typography, controlled colour and an industrial product character | Give the app an automotive-inspired design language with precision and restraint | Copying a car infotainment UI, which serves drivers rather than desk operators |
| **Raycast** (2022 design explanation; 2026 new version) | Distinctive, consistent icons and careful local visual refinements; new materials used selectively | Treat icons, selection and shortcut indicators as part of product personality | Expensive-looking glass effects that worsen contrast or Qt portability |
| **Fluent 2 / IBM Carbon** | Colour assigned a role; purposeful layer depth, calibrated typography, readable tables and restrained elevation | Adopt role-based palettes and a two-to-three-level visual layer system | Using one shadow, border and corner radius indiscriminately |
| **Fleetio and Booqable screenshots** | Neutral operational backdrops with clear asset statuses and contextual focus | Keep data and asset status visually readable | Generic KPI wallpaper; additional graphics without a factual basis |

**Primary references and dates:**
- Linear, *A calmer interface for a product in motion*, 12 March 2026: https://linear.app/now/behind-the-latest-design-refresh
- Attio, *Record page redesign*, 28 May 2026: https://attio.com/changelog/2026/record-page-redesign
- Polestar, *The Identity* (brand principles): https://www.polestar.com/global/news/journal-1/
- Raycast, *A fresh look and feel*, 19 July 2022: https://www.raycast.com/blog/a-fresh-look-and-feel
- Raycast, *The New Raycast*, 14 May 2026: https://www.raycast.com/blog/the-new-raycast
- Fluent 2, elevation: https://fluent2.microsoft.design/elevation/
- Fluent 2, colour: https://fluent2.microsoft.design/color
- Fluent 2, icons: https://fluent2.microsoft.design/iconography
- Carbon, typography for productive vs expressive interfaces: https://www.carbondesignsystem.com/building-blocks/foundations/typography/style-strategies
- Carbon, layering and palette roles: https://www.carbondesignsystem.com/building-blocks/foundations/color/guidelines
- Carbon, data table specifications: https://www.carbondesignsystem.com/building-blocks/core/components/data-table/specifications
- Fleetio, visual reference: https://www.fleetio.com/solutions/for-fleet-managers
- Booqable, visual reference: https://booqable.com/industries/camera-rental-software/

## 3. Three competing visual directions

These are **design hypotheses**, not demonstrated preferences of recruiters or drivers.

### A — Precision Atelier (recommended for a first visual comparison)
**Mood:** premium automotive instrumentation; confident, calm, slightly futuristic, tangible.

| Token | Proposed colour | Role |
|---|---|---|
| Graphite | #15212A | Navigation shell, selected high-impact panels |
| Mineral white | #F6F5F0 | Warm desktop canvas |
| Card white | #FFFFFF | Main content and table surfaces |
| Signal lime | #CFF375 | Small signature highlights, key focus moment, primary call-to-action |
| Main ink | #1B2834 | Standard text and values |
| Supporting ink | #596776 | Secondary labels |
| Status green | #187263 | Verified available/returned status |
| Warning amber | #946009 | Caution and due-soon labels |
| Destructive | #A63232 | Destructive action; verify local contrast before approval |

Design markers: warm-neutral canvas against charcoal, subtle asymmetrical section boundaries, one oversized numerical instrument, accurate silhouette-style vehicle illustration, crisp monoline icons and brief high-contrast lime moments. Avoid filling cards or badges with lime.

**Measured proposed-pair contrast (WCAG standard luminance formula, on the listed flat colours):** graphite text on signal lime ≈13.0:1; supporting ink on mineral white ≈5.3:1; graphite on mineral white ≈15.0:1. These do not certify the eventual app: component, state and over-image contrasts still need checking.

**Risk:** too much lime becomes gimmicky. Use it as a small brand identity element, not a default success/status colour.

### B — Nocturne Instrument
**Mood:** dark technical command centre with cool luminous blue/cyan and precision lines.

Visual markers: graphite-to-midnight surfaces, clear focal spotlights, 1-pixel rules, narrow status strips, restrained luminous accents, small monochrome icon set, large tabular values.

**Strength:** immediate visual impact and believable high-tech style. **Risk:** prolonged forms and tables can become heavy or low-contrast; the result can resemble many crypto dashboards. Only consider if the light workspace remains pleasant and well balanced.

### C — Editorial Grand Touring
**Mood:** luxury product catalogue meets serious operational software.

Visual markers: ivory surfaces, near-black text, generous typographic scale, fine lines, one muted burnt-copper accent, beautiful negative space and carefully composed asset headings.

**Strength:** mature and elegant. **Risk:** less immediate visual energy; easily slips back into tasteful blandness without a bold art direction and strong composition.

### Comparative qualitative matrix (design-team judgments, NOT empirical scores)

| Criterion | A Precision | B Nocturne | C Editorial |
|---|---|---|---|
| Immediate distinctiveness | High | High | Medium |
| Data readability potential | High with limited lime | Medium / needs careful testing | High |
| Automotive association | Strong | Moderate technical | Strong luxury |
| Risk of looking generic | Low–medium | Medium–high | Medium |
| Qt Widgets implementation difficulty | Moderate | Moderate | Moderate |
| Recommendation | **Prototype first** | Dark-theme alternative | Refined alternative |

## 4. Fifteen visual changes to investigate, ranked by aesthetic impact

| Rank | Change | Why it changes the impression | Suggested constraint |
|---|---|---|---|
| 1 | Replace the anonymous blue R square with a simple original mark and precise wordmark | Product recognition instantly improves | Legible at 16–32 px, not a borrowed automotive logo |
| 2 | Establish a signature accent colour distinct from generic cobalt | Recognizable identity | Restrict accent to key interactions and a few highlights |
| 3 | Replace four visually equal KPI cards with one dominant instrument and two/three supporting measures | Creates hierarchy and intentional composition | Show only real derived numbers |
| 4 | Give every screen a designed focal point | Removes the template feeling | One dominant element, not five |
| 5 | Introduce warm-neutral vs dark-graphite contrast | More nuanced material character | Preserve clean data-reading surfaces |
| 6 | Make selected vehicle a visually prominent asset portrait | Communicates automotive context | Original vector/silhouette illustration, not unrelated stock imagery |
| 7 | Strengthen display typography and tabular number treatment | Premium editorial character | Desktop legibility comes before novelty |
| 8 | Use bento-like asymmetry selectively | Breaks grid monotony | Avoid arbitrary card sizes or waste |
| 9 | Create a consistent icon family | Quiet, persistent feeling of polish | One stroke weight/geometry; icon+label for critical actions |
| 10 | Limit depth to three levels: canvas, working surface, floating focus | Makes important layers obvious | Shadows only where depth has meaning |
| 11 | Refine table headers, row dividers and selected state | High-impact in an operational product | Keep scanning and selection unmistakable |
| 12 | Upgrade the rental quote/total panel | Gives the financial outcome visual authority | Do not imply payment collected |
| 13 | Redesign active-rental progression motif | Adds purposeful technical detail | No misleading animation or unsupported status |
| 14 | Introduce tasteful micro-motion to state changes | Makes product feel responsive | 120–180 ms as a candidate, test on target Windows system |
| 15 | Distinctive zero-state illustrations | Empty datasets feel designed, not broken | Honest illustration and a clear action only |

## 5. Screen-specific art direction

### Dashboard: one hero, not a row of four twins
- Replace the equally weighted opening row with a carefully designed **fleet readiness instrument** occupying about 40–50% of the first content row.
- Make the central figure the visual anchor (example: **4/5 available**, derived from demo data), accompanied by a compact two-tone occupancy ring or engineered arc; this must reflect actual state when implemented.
- Give due-soon rental attention its own contrasting but smaller visual treatment; let the ledger remain a neutral, readable content surface.
- Use a single highlight strip or panel in graphite with lime numerals, balanced by a spacious mineral-white canvas.
- Eliminate decorative icon tiles from every metric: a few recognized visual signatures beat repetitive icon backgrounds.
- Vary panel heights based on meaningful information volume rather than symmetry for symmetry's sake.

### Fleet: treat a selected vehicle as a physical asset
- Keep a clean table as the primary information surface; add a distinctive technical asset header in the selected details panel.
- The selected-vehicle header should include original simplified car/motorcycle silhouette art, vehicle class, model and ID in a stronger type pairing. No random photographs and no unsupported specification fields.
- Use a quiet status indicator and a crisp selected-row strip, not multiple saturated pills.
- Make daily rate a clear tabular value, aligned with other numeric data; let name and model dominate identification.
- Remove the false sense of a giant blank card below a five-row table: either size the content to its contents or explicitly show a designed end-of-list footer.
- Optional subtle background linework may echo engineering drawings, but keep it away from table text.

### Rentals: make the quote feel like an instrument
- The right-hand quote panel should be the most distinctive object: a darker contrasting surface, strong R-value typography and a precise breakdown.
- Use a meaningful lifecycle line with distinct labelled stages; do not present incomplete or future states as completed.
- Keep form controls calm and accessible; their purpose is data entry, not decoration.
- Separate visually the active record from historical records using considered typography and surface contrast.
- A selected rental can have a compact document-like identity strip, not a wall of unrelated cards.

## 6. Typography, shape, motion and icons

**Type roles proposed (starting points, not final Qt point sizes):**
- App-level heading: 30–34 px, semibold, strong typographic character.
- Workspace section heading: 18–20 px.
- Body and table rows: 14–15 px, regular/medium.
- Secondary label: 12–13 px with verified contrast.
- Instrument numerals: 34–44 px, tabular where available.
- Use title case/sentence case for normal content. Reserve uppercase micro-labels for short technical annotations. Avoid letter-spaced all-caps on every table.
- Start with Segoe UI / system; an optional licensed bundled display face should be approved and tested separately. Do not treat font file acquisition as necessary to research.

**Radii and rhythm:** large hero 16–20 px; work cards 10–14 px; form controls 8–10 px; tags can be fully rounded. Main layout 8 px rhythm with finer 4 px adjustments. Do not round touching table cells or edge-to-edge panels separately.

**Icon language:** consistent 1.75–2 px strokes at appropriate 16/18/20 px sizes, one geometry and a filled selected state if legibility improves. Design an original rental-brand mark. Consider platform license requirements for third-party icon sets.

**Motion:** immediate feedback, not decoration. Fade/slide tab content gently, animate the utilization indicator once when the data loads, and make hover/focus states crisp. Respect reduced motion. Avoid animating every metric or table row.

**Layering:** one physical-looking hero, quiet work surfaces, and a floating inspector or dialog when context demands. Reference Fluent elevation and Carbon layer models for consistency.

## 7. Aesthetic anti-patterns and why they fail here

- **Random gradients/glow on every card:** dilute emphasis, become generic fintech imagery.
- **Glassmorphism applied to dense tables:** sacrifices contrast, complicates native Qt rendering, often feels trendy instead of trustworthy.
- **Oversized stock automotive photography:** turns the operator's workspace into marketing collateral and competes with live data.
- **Fictitious performance graphs or trends:** makes the screenshot appear rich but undercuts the engineering portfolio's credibility.
- **Excessively pale labels:** gives a fashionable minimalist look at the expense of readability.
- **Global dark theme as a shortcut to wow:** may disguise weak hierarchy and harm long forms.
- **Five different radii, shadows, icons or tones:** produces visual noise and accidental inconsistency.
- **Substituting Qt Quick / React just to obtain a glossy effect:** changes the technical project rather than solving its art direction.

## 8. Design-system acceptance tests (visual only)

Before approving V2, compare real renders of A/B/C with the **same** fictional dataset and the same screen geometry:
1. **2-second identity test:** Can a viewer distinguish this from a generic blue admin dashboard without reading the product title? This is a proposed evaluation exercise, not a measured claim.
2. **First-glance focus:** Is the intended focal point obvious on each screen at 1440×900 and 1280×720?
3. **Readability:** Minimum 4.5:1 for normal text, 3:1 for large text; non-text important boundaries/indicators need 3:1 where WCAG applies. Check every surface and state, not merely the global palette. W3C: https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html
4. **Status independence:** Colour cannot be the only status cue; include readable status words/icons. W3C/Carbon source: https://www.carbondesignsystem.com/building-blocks/foundations/accessibility/color
5. **Visual proportion:** The dominant accent is visually selective, not a flood of lime or cobalt. This is a qualitative review, not an arbitrary exact colour quota.
6. **Material coherence:** At most three purposeful surface/elevation levels in a primary view.
7. **Native clarity:** Native Qt text and icon assets remain crisp at Windows 100%, 125%, and 150%; Qt high-DPI guidance: https://doc.qt.io/qt-6/highdpi.html
8. **Truthful screenshots:** All displayed records and quantitative illustrations map to demo data; no fake metrics, fake data trends or disguised HTML-as-Qt screenshots.
9. **A/B judgment:** Compare all three concepts side by side and document the selected direction and exact strengths/weaknesses before styling the Qt executable.

## 9. Native Qt visuals: feasibility notes, not an implementation plan

A mature design can remain in **Qt Widgets**. The standard QStyle / QProxyStyle, palette, custom-painted widgets, vector icons and styling options exist. Qt's current docs distinguish **QStyle** as the production styling foundation and **Qt Style Sheets** as appropriate for local adjustments or prototypes; a broad one-file stylesheet is not the ideal long-term architecture. https://doc.qt.io/qt-6.12/qtwidgets-styling-approaches.html

This does **not** require Qt Quick or rewriting the existing application. Before implementing, inspect the actual installed Qt toolchain/version to select practical approaches and avoid unsupported effects. Visual evidence must ultimately come from actual compiled Qt screens, not from the HTML design exercise.

## 10. Recommendation and status

**Recommended:** Develop visual comparisons for (A) Precision Atelier first and (C) Editorial Grand Touring second. Use (B) Nocturne Instrument as a dark, technical counterpoint rather than the main working theme.

**Why:** A makes a noticeable break from generic navy/cobalt SaaS design; graphite plus mineral white remains suitable for desktop operations; a limited high-energy accent and engineered vehicle illustration add recognisable automotive identity. C protects us against overstyling. B tests whether the hoped-for 'wow' is actually dark-theme novelty.

**What has actually happened:** Research and critical baseline analysis only. No design direction has been approved, no V2 images have been generated, and **no Qt source has been edited**. The previously recorded hosted Qt tests are not V2 visual verification.

**Next visual artifact (only after design review):** Three contrasting dashboard art-direction explorations containing the same factual sample data. Evaluate style and composition first, then propagate the winning language to Fleet and Rentals.

---
**Document governance:** Aesthetic-research appendix to [Phase 1 Design Specification](../design/DESIGN_SPEC.md). Keep this record distinct from functional requirements, engineering changes, and test results.
