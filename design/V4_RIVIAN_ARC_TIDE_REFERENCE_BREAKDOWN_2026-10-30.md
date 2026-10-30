# Rental Studio — Rivian × Arc × Tide Guide: Design DNA Reference Breakdown

**30 October 2026 | Research & design thesis only. No final palette, mockups or app-code approval.**

> **Design thesis:** A *vehicle-first product workspace with tonal depth and polished motion*. Product structure stays **Overview / Fleet (Gallery + Table) / Rentals**, selected-vehicle drawer, guided rental and return workflows. Owner rejects the old dark Qt aesthetic, white-heavy concepts and generic bright-blue SaaS look. The new goal is *not white-first and not dark-first*: cohesive mid-light tonal depth, meaningful vehicle presentation and readable operations.

This GitHub document is the **persistent project handoff** for the full eight-page research report, distributed as an editable Word file in the project conversation. The full report contains the detailed transfer matrix, page-specific design tests, component behaviours, motion table, excluded patterns and citations.

## 1. Verified reference facts — not our design claims

**Rivian — automotive object and contextual controls.** Official 26 June 2026 R2 technology article describes Rivian OS 2.0, an intuitive display built with Unreal Engine 5 and easier access to common functions. It is *vehicle-cabin UI*, not fleet-management software. Published cabin images show a prominent vehicle representation alongside contextual controls. Sources: [Rivian OS 2.0](https://rivian.com/stories/r2-transformational-tech-ai-defined-vehicle-2026), [February 2026 software update](https://rivian.com/stories/software-update-2026-03), [third-party R2 display photographs](https://www.caranddriver.com/photos/g70699907/2027-rivian-r2-revealed-interior-gallery/).

**Arc — tonal workspace identity and focus.** Official Arc help describes Space-specific themes/gradients, a collapsible sidebar, previews and split views. **Arc's official site announces a sunset on 22 December 2026**, so it is an aesthetic/interaction *reference*, not an application dependency. Sources: [Arc Themes](https://start.arc.net/paint-the-internet), [focus, split, previews](https://start.arc.net/find-focus), [command bar](https://start.arc.net/command-bar-actions), [Arc official site / transition](https://arc.net/).

**Tide Guide — subject-inspired atmosphere and layered, useful data.** Apple awarded Tide Guide the **2026 Visuals and Graphics Apple Design Award**, citing coherent aquatic theme, clear charts, custom animation and sky-matching palette. In an earlier Apple developer interview, creator Tucker MacDonald explained that he prioritised simple core tasks and progressive disclosure of deeper information, and learned from overly unconventional navigation. Sources: [Apple winners 2026](https://www.apple.com/newsroom/2026/06/apple-reveals-winners-of-the-2026-apple-design-awards/), [2026 awards](https://developer.apple.com/design/awards/), [developer interview 2024](https://developer.apple.com/news/?id=4r9b23wx).

## 2. Transfer matrix — design inferences, not literal copies

| Lens | Reference lead | Rental Studio translation | Explicitly avoid |
|---|---|---|---|
| Application shell | Arc | A coherent mid-light coloured/tinted outer workspace, simple 3-item sidebar, lighter focus surface | Browser Spaces/profiles, obscured navigation, many gradient panels |
| Vehicle hierarchy | Rivian | One selected-vehicle **stage** with larger licensed image, ID/status/rate and contextual next action | Unreal/3D for its own sake, fictional telemetry, misleading manufacturer logos |
| Operational information | Tide Guide | Bounded recent activity and genuinely data-derived availability/due-return attention | Invented revenue trends, fake charts and meaningless animated KPI gauges |
| Motion | Tide Guide + Arc | Short, purposeful gallery/table, selection/drawer, quote/return state feedback | Infinite loops, confetti, motion as sole status signal, delays to action |
| Tonal materials | Arc + Tide Guide | Atmospheric medium-light canvas, controlled stronger selected zones, lighter forms/tables | Flat white wall, full dark theme, random bright blue cards |

**Critical rule:** Light-first ≠ white-first. Colour must follow its *role*, not arbitrarily recolour every card. Brand accent choices and typography remain unapproved.

## 3. Expected feelings by workspace

- **Overview:** a calm **operations lounge**, not a PowerPoint KPI dashboard. Real availability, active rentals, booked rental value (never cash received), due/overdue attention and recent actions. No invented graphs for the five-car fictional demo.
- **Fleet Gallery:** an **automotive showroom linked to operational truth**. Strong model-matched imagery, coherent crops, availability text, daily rate, selected vehicle state, easily switchable inventory table.
- **Fleet Table:** a fast, professional table wearing the same design DNA, not an unstyled default Qt table. Persistent search/filter/sort/selected ID; legible row density and focus.
- **Vehicle Inspector:** a meaningful selected vehicle representation with actual ID, type-specific specs, rate and appropriate contextual action. A rented vehicle must not offer active Rent.
- **New Rental:** a focused, confidence-building Vehicle → Customer → Review flow; live quote, explicit confirm and status update **only after durable success**. Not a payment checkout.
- **History and Returns:** precise legible ledger and safe state transitions. Esc/No/cancel cannot mutate persistent records.

## 4. Component and motion grammar

Core components: AppShell, NavigationRail, VehicleStage, VehicleCard, ViewSwitcher, SearchFilterBar, FleetTable, Inspector, StatusChip, DueReturnIndicator, RentalStepper, QuoteSummary, ConfirmationDialog, InlineError, EmptyState, SuccessFeedback.

| Event | Proposed feedback | Non-motion alternative |
|---|---|---|
| Gallery ↔ Table | Brief substitution without losing toolbar state | Immediate view switch, visible selected tab |
| Select vehicle | One selected outline, inspector and contextual info | Static explicit selected indicator |
| Open/close Inspector | Short aligned lateral movement, correct focus restoration | Immediate panel |
| Change rental days | Instant accurate quote and subtle value emphasis | Instant updated number and text label |
| Confirm or fail | Save first; show result with ID or actionable inline error | Static success/error and live model update |
| Cancel / Escape | No state mutation; return focus to origin | Same instantaneous result |

**Proposed** 120–220 ms for noncritical motion, to be tested, not asserted as the three products' animation timings. Respect reduced-motion support. See [Apple motion guidelines](https://developer.apple.com/design/human-interface-guidelines/motion).

## 5. Qt implementation boundary

Legacy application is C++17/CMake **Qt Widgets**, with safe fictional fixtures and historical passing CTests, **not** a QML app. Qt Quick is capable of these view states in principle, but must be proved on the owner's installed Windows kit before any full UI rewrite. See [Qt Quick best practices](https://doc.qt.io/qt-6/qtquick-bestpractices.html), [performance](https://doc.qt.io/qt-6/qtquick-performance.html), [Basic style](https://doc.qt.io/qt-6/qtquickcontrols-basic.html).

Small proof requirements: typed C++ five-vehicle model; Gallery ↔ Table with same selection/filter; a real vehicle inspector; resize at 1280×720 / 1500×860; actual Windows 100/125/150% scaling, keyboard/focus/Esc, smoothness and disposable data. Do not mix an irreversible data migration with the graphical spike.

## 6. Design gates, no premature mockups

1. **Research validated:** source-grounded reference anatomy and transfer matrix (this document). Owner reviews the *principles*, not swatches.
2. **Tonal composition:** two variants of the same full application content **in grey-tone hierarchy first**, not simply two blue hex palettes; prove distinctiveness and information flow.
3. **Material/typography/motion:** apply coherent visual materials only after composition is strong; test ALL major pages and states at two desktop sizes.
4. **Native Qt feasibility:** compiled real C++-bound Qt Quick sample on actual Windows with keyboard/DPI and no source-adjacent private records.
5. **Feature parity and release:** existing fleet/rental rules, destructive-action guards, CTests, licensed imagery, real OS scaling and explicit owner sign-off.

**Open:** exact font, exact hues, artwork, image set, visual composition, toolkit feasibility and final approval.

**Reference visual pages:** [Rivian R2 display](https://www.caranddriver.com/photos/g70699907/2027-rivian-r2-revealed-interior-gallery/) · [Arc themes](https://start.arc.net/paint-the-internet) · [Tide Guide Apple designer interview with chart images](https://developer.apple.com/news/?id=4r9b23wx). Reference images are **not** copied into the app or this repository.

**Tracking:** [Rebuild Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5). Earlier rejected Qt design remains historical evidence. No source, tests, fixtures or CI workflows are changed by this research.