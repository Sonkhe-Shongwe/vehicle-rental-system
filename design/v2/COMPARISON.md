> **ARCHIVED DESIGN COMPARISON — superseded 29 October 2026.** None of the previous A/B/C directions represents final visual approval. The owner chose a **light-first, inviting, neat product** with a hybrid Fleet gallery/table. These images are historical comparisons, not a target to port as-is. [Current spec](../DESIGN_SPEC.md).

# V2 Visual Direction Comparison — Review Package

**Project:** [Vehicle Rental System](https://github.com/Sonkhe-Shongwe/vehicle-rental-system)  
**Date:** 29 October 2026  
**Status:** **Three competing visual concepts, NOT an approved design and NOT implemented in Qt**.

## Purpose and scope

The user judged Phase 1's coherent cobalt-blue Operator Console to be **too bland, boring and generic**. This work compares three visual art directions without altering C++ source, functional requirements, storage or rental behaviour. It is an aesthetic decision checkpoint before implementing a design in Qt Widgets.

## View the concepts

Open [`visual_comparison.html`](visual_comparison.html) locally in a browser and switch A/B/C in the upper-right. The selector changes visual tokens, composition, typography and the screen's art direction; other controls are **intentionally not functional**. A browser concept is not an application or evidence of Qt functionality.

- [A — Precision Atelier](atelier.png), 1440×900
- [B — Nocturne Instrument](nocturne.png), 1440×900
- [C — Editorial Grand Touring](editorial.png), 1440×900
- [A at 1280×720](atelier-1280.png), viewport check. The page's lower content requires vertical scrolling at this size; no horizontal overflow in the local render.

## Fixed comparison dataset

All three images use the **same** repository demo inputs, not imagined business activity:

- `demo/vehicles.txt`: five vehicles, three cars and two motorcycles; **four available, one rented**. Availability is **80%**.
- `demo/rentals.txt`: R001 = Ford Ranger / C002 / Demo Customer A, active, booked **R1,400**, due **30 Oct 2026**. R002 = Toyota Corolla / C001 / Demo Customer B, returned, booked **R900**.
- Total booked rental value = **R2,300**. This is **not revenue collected** and no payment system is claimed.
- Current comparison date is frozen to **29 Oct 2026**, so R001 is due tomorrow. The date is contextual to this snapshot, not dynamic business data.

All artwork is illustrative generic vehicle linework, not a specification-accurate image of any particular make/model. No identifiable customer data is included.

## Three deliberately different directions

| Aspect | A · Precision Atelier | B · Nocturne Instrument | C · Editorial Grand Touring |
|---|---|---|---|
| Immediate feeling | Modern, confident and technical | High-contrast night-time operations console | Mature, editorial automotive luxury |
| Base | Graphite navigation + warm mineral white | Deep midnight UI on all surfaces | Espresso navigation + warm parchment canvas |
| Signature accent | Signal lime, selectively | Electric cyan / blue | Contrast-adjusted burnt copper |
| Typography | Clean, high-density system sans | Crisp technical system sans | Large editorial/serif headings paired with sans UI |
| Hero treatment | Oversized 80% readiness and original vehicle linework | Dark grid/radar-like atmosphere and cyan glow | Panoramic quiet hero with softened vehicle linework |
| KPI rhythm | 2×2 adjacent white tiles | 2×2 dark instrument tiles | One understated four-column editorial strip |
| Best visual quality | Distinctive but readable, plausibly original | Immediately memorable cinematic contrast | Calm sophisticated character and composition |
| Main risk | Lime overuse could look gimmicky | Glow/dark density may fatigue operators or appear generic cyberpunk | May still feel a little understated after prolonged use |
| Preliminary verdict | **Lead candidate for next refinement** | Strong alternate mode; resist glow overload | Strong alternate; borrow editorial rhythm selectively |

These assessments are expert visual judgments, **not user research or recruiter data**. Avoid claiming any direction is the winner without review.

## Comparison with original V1

V1 [dashboard](../dashboard.png) used a mostly uniform grid of white cards, restrained cobalt blue, a small blue-square logo and generic table containers. The new comparisons introduce a recognizable art direction, stronger type contrast, non-uniform visual hierarchy and a vehicle-related hero illustration. The editorial candidate intentionally changes composition, not merely hue.

**Yet:** all three still use a simplified Dashboard for controlled evaluation. The winning style must be applied and evaluated on **Fleet** and **Rentals** before being approved as a whole-product aesthetic. Avoid mistaking a striking Dashboard for a complete design system.

## Readability and implementation constraints

- Source-based colour pairs were checked at palette level only: graphite on signal lime is approximately **13.04:1**; editorial text on card white is approximately **13.78:1**; Nocturne's text on a primary dark panel is approximately **14.5:1**.
- Editorial accent was darkened from the research starting colour to **#9C4C31** so light text on it has sufficient contrast (initial #BC6A44 fell below 4.5:1 for small text).
- **Not certified:** WCAG across all text/states, keyboard focus, Qt-native rendering, 125% and 150% Windows scaling, font metrics or full UI contrast.
- Browser renders validated at **1440×900** for all three and **1280×720** for A; no horizontal scroll in those checks. Lower content on 1280×720 requires vertical scrolling.
- Avoid bringing outside car photographs, third-party logos, fictitious metrics or unreviewed font licences into Qt.
- Browser CSS effects are references; Qt Widgets equivalents may require QPainter or reusable style components, not a one-to-one stylesheet port.

## Decision and implementation gate

**D-V2-01:** Review A/B/C side by side at full resolution; identify what specifically feels premium vs generic and make a recorded selection, or request a hybrid.

**D-V2-02:** Create consistent *Fleet* and *Rentals* concepts using the selected aesthetic with the same verified demo records and no invented capability. Review full UI hierarchy and 1280×720 density.

**D-V2-03:** Write final semantic tokens and Qt Widgets visual acceptance criteria. Owner approves one visual baseline.

**D-V2-04:** Implement approved styling incrementally on a feature branch while keeping existing rental services, file formats and source functionality. Verify Linux CI and actual Windows Qt GUI before claiming successful implementation.

**No C++/Qt source changes were made during this comparison.**
