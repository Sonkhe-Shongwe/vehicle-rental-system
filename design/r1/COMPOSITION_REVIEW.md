# R1 / G1 | Whole-product greyscale composition comparison

**30 October 2026 | Owner principles approved, compositions UNDER REVIEW**  
**Current branch:** `docs/product-rebuild-reset-20261029`; tracking [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5).

## What has been approved

One coherent medium-light tonal design system: **Overview is operations-first, Fleet is vehicle-first, Rentals is task-first**. Keep the known three workspaces, gallery/table Fleet with shared search/filter/selection, contextual vehicle inspector, guided Vehicle → Customer → Review, and verified C++ business rules in the future application. This approval **does not** select visual layout A/B, palette, fonts, imagery, motion or Qt Quick.

## Two genuinely different layout hypotheses

| Question | A / Split Stage | B / Integrated Canvas |
| --- | --- | --- |
| Navigation | Persistent slim left rail | Compact horizontal navigation |
| Overview | Operational metrics and activity with right-side action and due-return column | Wide connected metric band with attention and activity beneath |
| Fleet Gallery/Table | Main gallery/table with persistent adjacent selected-vehicle inspector | Wider gallery/table across main surface; temporary detail drawer overlay |
| New Rental | Guided form and live quote side-by-side | Main guided form with subordinate broad quote summary |
| Good at | Durable context and selected-vehicle visibility | Readable scanning and broader vehicle stage |
| Tradeoff | Narrower main area at 1280x720 | Drawer occlusion; must prove focus restoration and keyboard trap |

**Not a palette comparison:** Both use greyscale and generic original SVG car/motorbike illustrations only. Never market those as model photographs. No licensed real vehicle photos have been approved for this new design.

## Deliverable and source truth

An offline self-contained HTML/CSS/JS **R1_Tonal_Composition_Comparison.html** and 2 contact sheets showing A/B across five common screens at 1500×860 and 1280×720 were delivered in the owner's ChatGPT conversation review package, not uploaded into the application codebase. This repository document is the persistent decision ledger, **not a claim that compiled Qt screens exist**.

Fictional data copied exactly by identity/rate/status from `demo/vehicles.txt` and `demo/rentals.txt` (read 30 Oct): 5 vehicles, 4 available, 1 rented; Ford Ranger R001 active, Corolla R002 returned, R2,300 booked rental value (not payment). New rental quote Corolla R450/day × 3 = R1,350; all simulated lifecycle actions use browser memory only and reset on refresh.

Local HTML file SHA-256: `5bb933132e15ad24f6f9abe1db7ecfc9f0fb489a0265351583f59b80b1aaf527`.

## Verified locally in isolated browser, NOT Qt/Windows

**Environment:** Chromium 144.0.7559.96, Debian GNU/Linux 13, Python Playwright headless. HTML loaded via Playwright `set_content` after sandbox declined local `file://` navigation. Actual 20 viewport captures: A+B × 1500×860 / 1280×720 × Overview, Fleet Gallery, Fleet Table, New Rental, Active.

- **PASS:** For both variants/sizes, source-derived counts and booked figure; fleet search Honda; gallery/table query parity; vehicle inspector; Escape close; R1,350 quote; customer/review steps; declined confirmation without new record; successful fictional in-memory create → return → history. Zero captured JS page errors.
- **PASS:** 1280×720 document-level horizontal-overflow checks in the captured state set; 1024×768 smoke on Overview/Fleet/Rentals; negative archive/delete confirmation followed by successful fictional archive/delete; rented Ranger lacks a new-rental action.
- **Not tested:** Qt Quick C++ binding, CMake/CTest on new presentation, physical Windows DPI/Qt Creator, true disk persistence or restart, production write failure, screen-reader focus-trap and exhaustive keyboard accessibility. Some form controls require vertical scroll at 1280×720.

**Owner decision remaining:** Review both spatial systems and decide whether A, B or a deliberately tested hybrid becomes the base; then refine complete states at wide/compact sizes, typography, final tonal material and licensed imagery. No source rewrite or SQLite migration before current gate exits.

**Protected:** `main` and rejected historical Draft PR #4 remain untouched; the browser deliverable contains no actual customer data and does not write source files.
