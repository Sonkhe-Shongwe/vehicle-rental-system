> **30 October 2026 latest owner selection (takes precedence over older palette candidates below):** The owner selected the nine-page **Rental Studio Theme Redesign Proposal Expanded** PDF as the design direction. Its **Midnight Navy / Emerald Teal / Cloud White**, ice-blue sidebar, soft-mint quote, left navigation and the p.4 guided Rentals composition replace prior speculative sage/copper and generic V3 blue palette directions. [Exact tokens, accessibility fixes, proposed behaviour boundaries and incomplete whole-product acceptance](r1/OWNER_THEME_DIRECTION_2026-10-30.md). **This is approved art direction, not yet an approved complete multi-workspace UI or compiled Qt implementation.** Old "proposed palette" entries below are retained as dated source history only and MUST NOT override the latest owner choice.

# Rental Studio — Light-First Product Experience Specification (Decision Draft)

**Date:** 29 October 2026 · **Status:** DIRECTION AGREED; HIGH-FIDELITY DESIGNS AND TOOLKIT STILL NEED PROOF  
**Authoritative product audit:** [Master Rebuild Audit](../docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md)  
**Historical drafts (rejected/superseded):** [V1 prototype](prototype.html), [V2 comparison](v2/COMPARISON.md), [old Qt screenshots](qt-spike/VISUAL_REVIEW.md).

## 1. Design intent and feeling

Build a product that feels **alive, refined, welcoming, airy and unmistakably automotive**, not an academic CRUD manager, dark trading terminal or generic SaaS dashboard. The most important task should always be clear. Remove needless decoration and show rich detail only where it helps.

**Approved:** light-dominant; Overview, Fleet, Rentals; Gallery + Table hybrid Fleet (gallery default); linked selected-vehicle context; coherent system; willingness to replace old GUI completely.

**Proposed palette to compare visually (not final approval):**
- Light warm canvas #F7F7F2; elevated white #FFFFFF; subtle border #DEE5E0.
- Primary muted deep sage #397D72 (buttons, focused selection); soft sage #E4EEE9 (surfaces).
- Warm copper #C78A66 (minor warmth only); legible dark ink #273640.
- Semantic success/warning/danger must meet text/colour-contrast checks. Avoid green-only status indicators.

**Typography:** friendly modern sans-serif with strong hierarchy; one licensed family wherever possible. Limit deliberate font weights and oversized editorial headings to page context. Avoid tiny all-caps metadata. Use sensible 8/12/16/24/32 spacing, readable dense tables and comfortably sized inputs.

## 2. Information architecture and navigation

Three primary navigation positions, always visible:
1. **Overview** — current operations and attention.
2. **Fleet** — browsable vehicles, inventory table, selected vehicle, contextual management tools.
3. **Rentals** — active, history, new rental, return and archival states.

Secondary actions belong to the relevant workspace; navigation should not expose separate primary pages for Add, Remove, Search and Available. Keep back/close, breadcrumbs or section title as required. Where possible preserve search, filter, view and selected ID on workspace re-entry. The product name "Rental Studio" is a **working name**; identity/logotype approval remains open.

## 3. Overview: structure and states

Header: meaningful title and current local date, clear New rental action (with keyboard shortcut only if discoverable).
First layer: **available out of fleet**, **active rentals**, and **booked rental value**. Do not imply payments received or future reservation inventory.
Main content: bounded recent transactions and **upcoming/overdue returns** calculated from persisted rental due dates and the current clock.
Supporting: small fleet status summary and link to Fleet. Do not display a mostly empty full-height table or manufacture trends from five records.

States to design: empty/no-fleet, no-active-rentals, one due soon, overdue, recent returned, damaged/missing photo, long record text, loading/reload failure, keyboard focus and success feedback.
All pages must represent real application models, **not hardcoded demo copy**. Historical R001 due 30 Oct 2026 is no longer "tomorrow" after 29 Oct.

## 4. Fleet gallery and table (equal functional quality)

### Gallery (default)
At roomy desktop: 3 columns if content area supports it, compact desktop: 2 columns; at actual DPI adjust columns/scrolling naturally. Card contains a coherent photo or silhouette, vehicle name, true internal ID, rate/day, textual available/rented status. Optional additional specs only when meaningful.
No unresolved image should render as a giant generic grey block with unhelpful placeholder text. Use a consistent branded car/motorcycle outline or intentional empty state.

### Table (alternate)
Professional readable compact inventory, keyboard row selection, columns for model, ID, type, availability, rate, and context action; sortable/filterable where appropriate. Do not force every column to equal width.
**Invariants:** gallery/table switch preserves search text, availability filter, sort and selected vehicle when the item remains visible. Search count updates with the same exact query across both. Escape or close dismisses the drawer without changing a record.

### Selected vehicle
Context drawer (right on wide; overlay or separate responsive panel at compact), with larger real vehicle image, licence/model disclosure, name/ID, car/motorcycle detail, true availability, price/day and relevant next action. Available → "Start rental"; Rented → open associated active rental or inspect history. No "Rent now" button for a currently rented vehicle.

### Management
Add a validated car/motorcycle; remove only if domain rules permit; searchable and available filters. Confirmation, error and success states should appear in context and be screen-reader/keyboard compatible. Do not hide destructive operations behind non-discoverable interactions.

## 5. Rentals: guided, stateful transaction experience

New rental is a visible subview inside Rentals, with **Vehicle → Customer → Review** (progressive sections may share one desktop page; avoid unnecessary full-screen routing).
- Select from actually available fleet items or enter a validated identifier; selection pre-fills vehicle ID.
- Customer name/contact with sensible masked display where needed; maintain actual input validation.
- Same-day start only unless booking engine deliberately changed and thoroughly tested; 1–365 days; quote derives from the real daily rate and duration.
- Show customer, vehicle, expected return, daily rate, days and computed **estimate** in review; explicit confirm and cancellation.
- After successful save, update Overview, Fleet status and Rentals active ledger; show transaction ID, success and useful next action. Never say payment collected.
- Deny duplicate bookings even when reached from the gallery; ensure cancel/No/Escape do not mutate persistent data.

Active Rentals: scannable due dates, status, return process from row/detail; unexpected overdue status clearly explained. Return Processing: selected rental context, confirm, update occupancy and history only after durable save. History: filter active/returned/archived, and archive/delete only when valid.

## 6. Shared components and motion specification

- ApplicationShell: light nav and crisp top utility row.
- PageHeading, MetricCard, AttentionCard, VehicleCard, VehicleTable, VehicleDetailDrawer, StatusPill.
- RentalStepper, CustomerForm, QuoteSummary, ErrorField, ConfirmationDialog, SuccessFeedback.
- EmptyState, SearchBar, FilterChips/Combo, FocusRing, LoadingFeedback and ScrollContainer.

State handling: hover and press for clickable controls, focus ring clearly visible, selected status always explicit, disabled state meaningful, invalid inputs explained near field; process buttons never submit twice. A few subtle 100–250 ms transitions are a **proposal**, not an enforced animation budget. Respect reduced-motion configuration if implementation permits.

Do not use uncontrolled looping animations, heavy blur, simulated payment effects or photo backgrounds that obscure labels.

## 7. Screen sizes, behaviour and QA

Targets: 1500×860 / 1280×720 Windows desktop and **physical OS scale 100%, 125%, 150%**. Layout must handle vertical scrolling gracefully. Dense content must not clip CTA, label, quote or drawer; keyboard Tab/Shift+Tab, Enter, Escape and confirmation focus order must be correct.

Test state matrices across **Overview, Fleet Gallery, Fleet Table, Vehicle Detail, New Rental, Active, History, Return**. Check empty/one/many, very long text, invalid input, unavailable vehicle, duplicate booking, no-return, archived state, missing image, and failed persistence. Use screenshots AND interaction tests, not PNG-integrity alone.

## 8. Presentation technology decision

**Preferred hypothesis:** Qt Quick/QML front end with typed C++ interface and existing/updated C++ rental model. See https://doc.qt.io/qt-6/qtquick-index.html . Test native Windows Qt kit and deployment first, with a real QML Overview + gallery/table/drawer proof. Qt Widgets or custom painting remain valid fallbacks if QML toolkit or performance requirements are not met.

Do not build a production-size QML UI before the owner approves cross-screen designs and a Windows technical spike. Do not introduce an unrelated web frontend solely to make the interface visually easier.

## 9. Required design review deliverables

High-fidelity, cohesive presentation at two desktop sizes with real fictional data:
- Overview with upcoming due dates and empty/active states.
- Fleet gallery, Fleet table, selected vehicle drawer and unavailable state.
- New rental vehicle/customer/review states and interactive quote.
- Active/History/Return flows and destructive confirmations.
- Consistent components, readable typography, accessible status and imagery.
- A small interaction prototype to demonstrate transitions and task flow, not just screenshots.

**Explicit owner approval** of this set precedes main UI rebuild. Any new artwork must have its own usage rights; historic asset licences alone do not approve its visual suitability.
