# Rental Studio 2.0 | Precision Automotive concept master v1

**Capture:** 5 November 2026  
**Owner feedback:** The two-theme, three-screen design board was positively received and explicitly requested to be saved and exhaustively documented. This does **not** by itself authorise a Qt implementation, new backend features, a theme toggle, full design signoff, or a release.  
**Document type:** Design-only archival checkpoint and durable implementation contract.  
**Master image:** PRECISION_AUTOMOTIVE_LIGHT_VS_CONTRAST_MASTER.png, 1536 x 1024 RGB PNG.  
**Master image SHA-256:** fb2bab34f99696cc9f2b95db3163e7e9e852d01081effa03384edc1edc11933f.  
**Master image custody:** Stored with the complete companion archival ZIP generated in this chat. The image binary is **not committed into this GitHub change**, so this document does not pretend to be a hosted rendering of it.  
**Complete specification:** The companion ZIP contains an 8,000-word, 20-section Markdown source, editable 24-page DOCX, unchanged original PNG, seven real crops, approved and proposed theme token JSON, 22-item component manifest, provenance/asset hash and implementation checklist.

## Visual design selected for further development

The captured image presents **A. Precision Automotive Light** and **B. Precision Automotive Contrast**, each showing **Overview, Fleet and Rentals**, with one shared palette/typography/component footer. A is the **proposed default**, consistent with the already owner-selected light-first Navy/Emerald direction in [OWNER_THEME_DIRECTION_2026-10-30.md](OWNER_THEME_DIRECTION_2026-10-30.md). B is a separately reviewable dark navy interpretation and **must not be shipped without theme and contrast approval**.

The target is a respected, quiet, high-quality desktop rental-operations product. Borrow the structure and consistency of respected productivity software, but use vehicle photography and simple automotive identity instead of decorative UI noise. Avoid bloated modules and gratuitous effects.

### Navigation architecture, intentionally limited

- **Exactly three primary workspaces:** Overview, Fleet, Rentals.
- **New Rental** is an emerald sidebar **command**, not a fourth workspace, reusing the authoritative existing booking dialogue and C++ process.
- **Settings** and **Help & About** may appear as **bottom utilities only if genuinely implemented**. Do not add dead menu entries or false preference switches.
- Do **not** introduce Reports, Calendar, Customers, Maintenance or Payments modules.
- Preserve the current intentionally separate **opt-in fictional SQLite Lab** status, which is not a normal fourth navigation item.
- Keep the existing 218 px expanded and 76 px collapsed QML sidebar contract, accessible labels and keyboard Up/Down/Enter/Right behaviour until a reviewed change replaces it.

### Light aesthetic baseline, source of truth

The known approved DesignTokens.qml colours take priority over the approximate pixels and printed palette legend in the generated concept. Main colours:

| Role | Hex |
|---|---|
| Midnight Navy, headings/structure | #17324D |
| Emerald Teal, primary action | #0F766E |
| Primary hover | #0C625C |
| Cloud canvas | #F6F8FA |
| Card surface | #FFFFFF |
| Ice sidebar | #EAF0F4 |
| Soft Mint selected/quote surface | #E8F5F0 |
| Muted legible text | #5F6F82 |
| Border | #D8E2E8 |
| Explicit Rented blue | #1D4ED8 |

Use measured spacing and typography: headings approximately 28-32 logical px, section headings 17-20, body 14-15, table and labels 12-14, KPI values 24-30, buttons 44 px minimum height, nav rows 48, radii 8-14 and visible native keyboard focus. Aim for a restrained, very light sidebar, subtle separators, precise line heights, good typography and white dominant working surfaces. The concept's source font is not identified or licensed.

### Contrast candidate, not approved theme

Keep exactly the same layout and underlying C++ controllers. Contrast's visual intent is deep navy sidebar/canvas, tonal dark panels, bright legible type, carefully controlled emerald accent, and an optional car-detail header image. Candidate unapproved values: canvas #071B2C, sidebar #061827, surface #102D42, raised surface #16374C, text #F3F8FA, secondary #B6C9D5, border #315065 and focus #9BE6D7. All must be individually contrast-checked and physically reviewed before use. The automotive header artwork in the image is **not an independently licensed asset**.

## Screen-by-screen anatomy

### Overview

Heading and concise subtitle, one context/date/mode badge if genuinely correct, four aligned KPI blocks (Total Vehicles, Available, Active Rentals, Due Next 48h), and a lower two-panel rhythm for Fleet Availability and real recent rental records. Donut percent must derive from authoritative fleet data, with accessible text. The generated image's examples **131 / 104 / 24 / 3 / 79%** are creative mock values, not current app counts; due rentals may overlap active count. Avoid a fabricated activity feed, fabricated event timestamps, or Booked Value called revenue.

### Fleet

Page heading, Gallery/Table segmented view, real make/model/vehicle ID search, honest availability status filters and sort. Photo-led card grid with complete vehicle visible, consistent neutral image framing, strong model name, real ID/type, correctly formatted ZAR daily rate and accessible Available/Rented. Separate right inspector holds selected image, factual metadata, status, daily rate and booking shortcut. Use the real FleetPhotoStore model-matched images and truthful silhouette fallback. The screenshot shows a **heart favourite icon**, but there is no corresponding saved favourites model, so **omit it**. The screenshot also shows transmission, fuel and seats, which may not exist in the authoritative FleetVehicleSummary; do not invent them. Honda CR-V is an illustration, not a source dataset requirement. At compact 1280 x 720, show 2 or 3 gallery columns only as layout width safely permits; maintain 282 px inspector if feasible and uncropped 160/170/194 px photo baseline.

### Rentals

Strong title, concise subtitle, true New Rental shortcut, prominent Active/History/All internal tabs with access to existing Returned/Archived statuses, a search input only for supported fields, real due-filter semantics and an actual contracts table. Columns conceptually: Rental ID / Customer / Vehicle / Start Date / Due Date / Status / Booked Value / safe row actions. Example customer names, rental IDs, amounts and dates are invented; always render actual fictional fixture projections. Preserve the approved Vehicle -> Customer -> Review flow and a clearly labelled LIVE QUOTE / NOT A PAYMENT estimate, quote revalidation, active return confirmation, safe archival and protected delete boundaries. No new Customers module.

## Distinguish screenshot fantasy from product truth

- No static KPI/date/activity values from the reference picture.
- No inert Settings, Help, hearts/favourites, ellipsis menus, disabled-looking but clickable workflow shortcuts, or fabricated Transmission/Fuel/Seats.
- No fake pending/draft/paid workflows; due-soon is a derived date indicator, not a persisted domain state.
- No misuse of an illustrative photo as an actual customer's rented vehicle.
- Do not change or ingest real operational customer records for visual review.
- Existing protected five-vehicle fixture remains unchanged. The separate default showcase currently has 131 fictional vehicles across 70 model families, with 48 recently mapped candidate photographs and 8 unresolved silhouettes.
- Normal app continues to respect quote, booking, return, rollback, accessibility, correct status/money labels, and offline rights/credits.

## Reproduction and implementation contract

1. Treat the **master source PNG** as a creative source for **look and hierarchy**, not a pixel-perfect native screen or evidence of implemented functionality. The complete companion pack records observed montage crop boxes: Light Overview (5,67)-(760,383); Contrast Overview (777,67)-(1532,383); Light Fleet (5,389)-(760,706); Contrast Fleet (777,389)-(1532,706); Light Rentals (5,711)-(760,924); Contrast Rentals (777,711)-(1532,924).
2. Compose real 1500 x 860 and 1280 x 720 review frames; also inspect nav expanded/collapsed and empty, selected, rented, overdue, long-text, loading-if-real, error and missing-photo states. Do not stretch the 755-pixel montage mockup directly into native geometry.
3. Define shared tokens and component contracts first: shell, sidebar, brand, New Rental CTA, page heading, metric card, status chip, filter/search, tab segment, Gallery card, table, Inspector, record action, real booking/confirmation flow and mode notice.
4. Implement the shell and shared components **incrementally on the existing feature branch**. Keep current `spikes/qtquick_p2/Main.qml`, `WorkspaceNavButton.qml`, `DesignTokens.qml`, `FocusFrame.qml` and typed C++ services authoritative. Do not create a giant new UI dependency or duplicate the business rules.
5. Bind Overview, Fleet and Rentals sequentially to actual C++ data; verify real empty/active/error paths and real input, no static screenshot simulation.
6. Perform exact-source real Qt hosted Windows/Linux CTests; inspect QML screenshots at both sizes, then owner physical Qt Creator 6.10.2 MinGW, Windows DPI 100/125/150 where supported, keyboard and Narrator.
7. Keep owner acceptance score at **45/74, fixed-weight 70.6%, P7 0/8** until explicit owner acceptance. Draft PR and stable main remain protected. No installer/release claims.

## Design decisions still open

- Final preference: Light only, or Light plus separately tested Contrast option.
- Actual font chosen on Windows with licence and rendered size/contrast checked.
- Whether Help/About and Settings should ship in the first design increment.
- Whether any decorative hero photo should be used in Contrast, after licensing.
- Approval of the final real Qt mockups and component composition, not merely the generated concept illustration.

**No code, fixtures, QA policy, production SQLite, installer or main branch changed by this design checkpoint.**
