# Rental Studio 2.0 | Direction A selected | Editorial Automotive Light

**Date:** 5 November 2026
**Decision:** The owner explicitly chose **Direction A** for continued design development. This selects a visual direction, **not** final pixel-level design acceptance, asset licensing approval or Qt release approval.
**Source:** Companion Direction A Design Master v1.1 kit shared in the project conversation (6 main SVG screens, 3 verified UI state SVGs and one component catalogue). Its photos and vector renders are not represented as source-controlled assets in this commit.

## Visual design direction
- Premium light-first, automotive editorial look, with one purpose per workspace and confident typography.
- Reuse owner-selected Navy #17324D, Emerald #0F766E, Cloud #F6F8FA, Ice #EAF0F4, Mint #E8F5F0, White #FFFFFF, muted #5F6F82, border #D8E2E8 and rented blue #1D4ED8.
- Exactly three primary workspaces: **Overview**, **Fleet**, **Rentals**. **New Rental** remains a command; not a fourth module.
- No dark theme, payments, GPS, reports, customers, maintenance, calendar, fabricated vehicle specs or dummy settings.
- Respect existing 218-px expanded and 76-px collapsed sidebar; minimum 44-px actionable controls, visible focus, keyboard traversal and screen reader labels.
- Approved design direction is **not** an approval of screenshots, colours outside existing source tokens, permanent labels, photography rights or product functionality changes.

## Composition and accurate demo examples
1. **Overview:** top priority is current overdue active return *only when supported by typed snapshot*; 4/5 fleet availability in protected demo, authentic fleet totals and active booked contractual value; recent rentals and actually available vehicles fill the bottom fold. No false revenue claim.
2. **Fleet:** photo-led gallery and a connected selection inspector; selected available vehicle may offer existing booking flow, rented vehicle must disable booking. Reference photography is not approved production media.
3. **Rentals:** contract-first register, compact filters, contextual inspector and existing review/confirmation flows. Separate persisted Active/Returned/Archived from derived Overdue/DueToday; empty archives and returned states must be represented without invented records.

**Fixture:** protected `demo/vehicles.txt` has five fictional vehicles (C001 Corolla, C002 Ranger, C003 i20, M001 CB500F, M002 MT-07), four available; `demo/rentals.txt` has active R001 due 2026-10-30 and returned R002; active booked value R 1,400. Concept date labels are fixed design-snapshot annotations, not runtime strings. The public portfolio fleet differs in size.

## Design master artefacts and workflow
- Companion SVG/PNG designs in the downloadable chat design kit, not in this commit: 1500x860 and 1280x720 Overview/Fleet/Rentals, selected-rented Fleet C002, zero-record Archived Rentals, returned-R002 Rentals, and component library.
- Design tokens in `DIRECTION_A_EDITORIAL_LIGHT_PENPOT_TOKENS_2026-11-05.json` are a proposal for Penpot DTCG import. Actual Penpot import, native editable text, native component creation, auto-layout and interactions are **not** yet verified or implemented.
- Source photography was cropped from an existing compiled UI screenshot and marked REFERENCE; model-accurate media provenance, permission and image quality need a separate review before any release.

## Engineering acceptance order
1. Visual review of the six real-sized design mockups and selected state variations.
2. Rebuild text, components, component states and 8px rhythm in a Penpot-native design file. SVG art alone does not create Penpot native components.
3. Implement Overview first in small QML components, preserving authoritative C++ services, `objectName` test contracts and protected fixtures. Then Fleet, then Rentals.
4. Compare real compiled Qt Quick screenshots at 1500x860 and 1280x720 with the approved reference.
5. Linux GCC and Windows MSVC Qt 6.8.3 native CTests and Windows packaging regression; then owner physical Qt Creator 6.10.2 MinGW, real DPI 100/125/150 where supported, keyboard/Narrator.
6. Owner must explicitly accept functional and visual gates before scoring changes, release or PR merge.

**Protection:** PR #17 remains draft, `main` untouched, SQLite Lab experimental and fictional-only. Formal owner acceptance stays 45/74, weighted 70.6% with P7 0/8 until revised through actual acceptance.
