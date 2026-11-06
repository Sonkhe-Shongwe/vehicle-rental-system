# Rental Studio 2.0 | Editorial Contrast visual master | R2

**6 November 2026. Status: OWNER-SELECTED VISUAL TARGET, DOCUMENTED, NOT IMPLEMENTED.**

The owner selected the **mixed black and white** version of the three new concepts, **not** the full-black mockups and **not** the earlier all-light sidebar. This is a visual refinement of the approved Direction A, not a product restart, permission to add modules, or formal release/design signoff. Earlier [Direction A Light selection](../r1/DIRECTION_A_EDITORIAL_LIGHT_SELECTION_AND_IMPLEMENTATION_CONTRACT_2026-11-05.md) is historical for any contradictory all-light or "no dark theme" statements: the new R2 decision permits **dark navigation/titlebar and hero**, but the working canvas, metric cards, registers and inspector detail bodies remain **light**.

## Reference provenance and priority

**P0, OWNER-APPROVED PALETTE/COHESION:** `APPROVED_HYBRID_MASTER.png` in companion reference pack. Original image is 1672x941, SHA-256 `0077ea102c26f8922d7fdebfbec1564146e81dc1a37d604951781e536648c29e`. It contains the **Overview window above, Fleet and Rentals windows below**. The reference is an AI-generated flattened montage, not an interactive design source or three independent editable 1500x860 frames.

**P1, FULL-SIZE GEOMETRY:** `DETAIL_LIGHT_OVERVIEW.png`, `DETAIL_LIGHT_FLEET.png`, `DETAIL_LIGHT_RENTALS.png`, each 1672x941 and included byte-for-byte in the companion pack. They show detailed card composition, icons, register/grid and visual hierarchy. **Override their LIGHT sidebar with the DARK sidebar in P0**. Convenience crops `APPROVED_HYBRID_CROP_*.png` are also in the pack but have less effective resolution.

**P2, ACTUAL CURRENT-APP BASELINES:** two owner-supplied physical Windows app screenshots of Overview and Rentals are included in the companion pack, separate from concept images; use them only to measure visual improvements.

**Reference pack**: `RentalStudio_EditorialContrast_ReferencePack_2026-11-06.zip`, SHA-256 `52c94646fb24bd97533aef5fe89a3df9942e4fa42a2bceb39ff003da6af02cb0`, supplied as a download in the 6 November design-specification chat. Contains exact reference images, crops, readable 3,670-word `DESIGN_MASTER.md`, proposed machine-readable tokens, icon inventory, file hashes and physical app baselines. **The PNG bytes are supplied in that companion download, not uploaded into this Git repository.** Do not write relative image links to non-existent Git blobs or claim source-controlled imagery. Retain the pack with the design review artifacts before visual implementation.

**Design document**: `RentalStudio_EditorialContrast_DesignMaster_2026-11-06.docx` with original concept images embedded, available in the same chat. It was rendered and inspected page by page. This source-controlled Markdown is the cross-chat contract if the separate files are not mounted.

## Visual master, exact perceived composition

- **Window and sidebar:** nearly black charcoal `#151B1B`, native titlebar target `#202628` if safely supported, subtle deep emerald footer glow/wave, compact upper R symbol, strong green New Rental command, exactly Overview/Fleet/Rentals nav. Selected nav uses pale mint fill against the black sidebar. The page background **does not become dark**.
- **Main canvas:** quiet cloud/off-white around `#F7F8FA`, white `#FFFFFF` metric/register/details cards. Main dark text `#14202A`, muted `#5F6F78`, few fine `#DEE7E3` dividers, and discreet card shadows. Black is used to frame and structure, not fill every card.
- **Feature/selected headers:** evergreen `#072A28` through `#041A19`, subtle emerald `#0D5948` depth behind illustrative reference photography. The **top of a selected vehicle/contract inspector is dark; the details and actions underneath remain white**. Readable image badge and source credit are mandatory.
- **Data hierarchy:** short large page title + concise subtitle; four tight KPI slots where source-backed; high-density work card below, contextual selected inspector on the right. Outer gutters approx 24 wide / 16 compact, 16px card gaps. Rounded cards approx 14px, hero 18px, controls 10px; all interactive targets at least 44 logical px.
- **No random embellishment:** avoid excessive green outlines, neon glow, glassy blur, emojis, giant empty spacer regions, inconsistent icon sizes or black data tables. The visual outcome must feel alive and editorial, not merely recoloured.

## Proposed source-matched design system

The companion `DESIGN_TOKENS_PROPOSED.json` is a **candidate** file, not exact editable source recovered from the PNG. Use semantic roles: shell, titlebar, canvas, white surface, muted surface, emerald primary/hover, mint selection, warning overdue, danger, focus and dark hero. Do not erase existing token meanings for booked value, rented, disabled and motion.

**Typography:** Original font cannot be identified reliably from generated pixels. Proposed pilot **Inter** 400/500/600/700 with tabular figures; fallback Segoe UI/sans-serif. Wide page title 32px (28 compact), subtitle 15, section 20, KPI figure 32, KPI label 13, body 14, row title 15, metadata 12, small caps 11. Verify actual Qt screen samples; **do not claim Inter is already bundled or exact**. Inter official license SIL OFL 1.1: https://github.com/rsms/inter ; no font binaries were distributed in the pack.

**Icons:** One local vector family. Proposed Lucide official SVGs at 24x24 viewBox, stroke 2, round caps/joins; draw at 18/20/24 logical px. Examples: `layout-grid` Overview, `car-front` Fleet, `clipboard-list` Rentals, `plus` New Rental, `car-front/layers/key-round/database` KPIs, `clock-3` Overdue, `search/list-filter` search and filters, `list/layout-grid` view toggle, `calendar-days/history/images` context, `undo-2/archive/trash-2` actions and `chevron-right` drilldowns. Custom R brand mark stays custom. [Full proposed map](EDITORIAL_CONTRAST_ICON_MAP_PROPOSED_2026-11-06.json). Lucide ISC and some Feather MIT icons: https://github.com/lucide-icons/lucide . Do not copy raster icons from the concept; reconstruct editable source icons, preserve notices, support Qt offline Svg/Image/VectorImage based on actual 6.8.3 and 6.10.2 testing.

## Three-page contracts

### Overview

Confident `Your fleet. Your next move.` heading, short subtitle, fictional-demo badge on right. Four white KPI cards in one line, then **dark priority/photo hero left ~65%, white fleet readiness right ~35%**, then **Recent contracts left ~58%, Ready for next rental right ~42%**. Data all from C++: total, available %, active rentals, **booked contractual value, not cash receipts**. Show overdue return and expected date **only if authoritative snapshot proves it**. Otherwise honest healthy/empty state. Bottom cards remain white with concise rows and source-backed names, dates and rates. Hero photo carries `MODEL REFERENCE` disclaimer, not an actual rental-unit claim.

### Fleet

Short `Fleet` heading, four metric slots **only if legitimate**, left gallery/register approx 60%, right selected inspector approx 40%. Real Gallery/Table/search/status/sort/selection and photo source metadata. Cards have photos, clear badges, make/model/ID, category and real rate; white cards and mint selected state. Selected inspector dark image-header top, **white details body**, real status and correctly enabled booking/management buttons. No fabricated tabs or service/maintenance backend just because image shows `In service`. **Illustrative error to reject:** the mockup shows Ford Ranger C002 *Available* and a rate that may not match C++ even while active R001 rents it; application must show **Rented**, cannot Book until return, and must use C++ rate. Existing 131 portfolio and protected five-fixture test data remain distinct.

### Rentals

This is the biggest visual composition improvement. Short `Rentals` heading/subtitle replaces redundant giant title plus separate Contract Management band. Four source-backed metrics (active, overdue, returned/archived without double count, active booked value). Dominant white **Contract register left approx 62%**, selected contract inspector right approx 38%; **status filters, derived timing and search live inside register card immediately above records**, not in a second tall panel. Register starts above fold and shows two current fictional rows if feasible at 1500x860. Selected row mint with narrow emerald left rule; white unselected rows, restrained dividers, precise status/overdue distinctions, strong booked amount. Inspector evergreen photo-backed top with R001/vehicle ID, white factual detail body, contextual **Return only active, Archive only returned, Delete only archived with confirmation**. No selection shows designed neutral empty state, not an invented default R001. Preserves true C++ selection/keyboard/modal actions and derived overdue/due-today filters.

## Differences from real current Qt source

Current Qt main page uses a **light sidebar**, smaller type, three Overview metric cards, verbose Rentals header plus separate bulky filter card, and a mostly unthemed white selected rental panel. Existing `spikes/qtquick_p2/DesignTokens.qml` anchors Navy/Emerald/Cloud, `WorkspaceNavButton.qml` and `PrecisionPrimaryButton.qml` draw the light sidebar; `SidebarGlyph.qml` is a small hand-drawn QML Canvas icon set; `OverviewMetricCard.qml` has a left accent rule instead of four icon-led cards; `Main.qml` owns the three pages and existing C++ bindings. The contract calls for **shared QML components**, not a screenshot texture pasted over a working UI.

**Protected invariants:** only 3 workspaces (New Rental is action), authoritative C++ booking/return/archive/delete/status/rates, undo/retry/persistence protections, real active vs overdue distinction, real vehicle IDs, accessible keyboard/focus/Narrator names, disabled controls, 44px hit targets, photo attribution, fictional-only P7. Do not add a customer, payment, GPS, maintenance, cloud, settings or photo licensing cycle through styling alone.

## Visual fidelity test matrix: rejection is allowed even with green CI

**Reference states:** Overview overdue/normal/empty; Fleet gallery and table, available and rented, fallback silhouette and custom photo controls; Rentals none selected, active-overdue R001, returned R002, archived/empty, filter/no-results and destructive dialogs. Do not hardcode screenshot data to force passing images.

**Compare each implementation** with P0 hybrid for dark/light split and P1 corresponding light concept for geometry and detail, while verifying **actual Qt compiled screenshots** at 1500x860 and 1280x720 on **Linux GCC + hosted Windows MSVC**. Record exact executable source SHA, CTest and Windows package outcome, screenshot artifact ID and diff notes. Check shell, spacing, KPI order, white surfaces, hero/inspector contrast, register visibility, icons, typography, images, focus and buttons.

**CRITICAL rejection:** working canvas all dark, sidebar left light, false rental status/pricing, fabricated module, wrong Book/Return/Archive/Delete enablement, hidden confirm, clipped action, misleading photo credit, broken focus/selection. **MAJOR rejection:** disconnected register/inspector, large empty filter island, inconsistent icon family, typography/spacing clearly unlike the reference, too much border/neon, unreadable at 1280x720, clipped photo or opposite colour distribution. **MINOR:** very small kerning/shadow/radius differences that do not compromise look or usability, subject to owner review.

**Physical owner gate:** real Windows Qt Creator 6.10.2 MinGW, OS 100/125/150% where feasible, 1280x720 and 1500x860 logical windows as supported, Tab/Shift+Tab/arrows/Enter/Escape, Narrator announcements, reduced motion and real display contrast. Owner recently showed a screenshot of the running Qt app, **confirming local launch**, but exact local HEAD/CTest/Narrator and full matrix remain OPEN. At 1920x1080 physical 150% OS scale, 1500x860 logical cannot fit; do not call that expected limitation a clipping defect.

**Do not mark visual fidelity complete** while any critical/major differences remain. Each of Overview, Fleet and Rentals requires its own **explicit owner visual approval** against the approved hybrid and full-size structural concept. Whole-product cohesion and final model-photo licensing/quality are separate from native CI and current formal 45/74, 70.6%, P7 0/8.

## Implementation order after this documentation gate

1. Keep this document and the exact companion image pack as durable visual source of truth. Owner can review and request spec changes before any code.
2. Once approved, do a **bounded shared-shell + type/icon pilot**. Pin source, font, icon license and Qt compatibility, compare compiled screenshot to approved hybrid at both sizes.
3. Roll visual tokens/real QML components to **Overview**, then **Fleet**, then **Rentals**, preserving native data/tests. Require visual evidence for each, not just code compilation.
4. After screen-by-screen parity, get owner physical Windows and full P1/P2/P4 visual/accessibility review. Do not automatically raise scores, merge PR #17, release, source new photos, or enable production P7.

**References:** [Live handoff](../../docs/LIVE_HANDOFF_STATE.md), [Owner Windows review](../../docs/OWNER_WINDOWS_QT_CREATOR_PHYSICAL_REVIEW_CURRENT_2026-11-06.md), [Existing photo rights](../../catalogue_acquisition/ACTIVE_ASSET_CREDITS.md), [Font](https://github.com/rsms/inter), [Icons](https://github.com/lucide-icons/lucide), [Qt 6.10 SVG](https://doc.qt.io/qt-6.10/topics-vectorimageformats.html).