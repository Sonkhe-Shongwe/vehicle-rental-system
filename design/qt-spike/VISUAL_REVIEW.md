# Qt Photographic Dashboard | Visual Acceptance Checkpoint

**Date:** 29 October 2026  
**Branch:** `feature/qt-hybrid-visual-spike-20261029` | [Draft PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4)  
**Status:** **Bounded proof of concept passed its current automated checks.** Not an approved visual design, not a release, not Windows-certified.

## Verified in hosted environment

- [x] **Qt6 CMake configure and GCC release compilation** on Ubuntu 24.04.
- [x] **CTest** rental domain suite passed.
- [x] The real Qt Widgets executable started in Xvfb with fictional demo fixtures using the screenshot-only CLI mode. No real customer data used.
- [x] Captured `dashboard-qt.png` from an actual **1500 × 860** window.
- [x] Captured `dashboard-qt-1280.png` from an actual **1280 × 720** window. Earlier supposedly small screenshots were accidentally identical to the large screenshot, and the script was corrected to resize the window explicitly and assert dimensions.
- [x] Automatic visual-layout geometry assertion confirms the top of the rental activity heading is at least 3 px below the bottom of the secondary metrics strip at each resolution.
- [x] Manual inspection of both rendered screenshots: no cropped or overlapping KPI labels, full photo and hero visible, rental table headings and both rows readable.
- [x] Synthetic fixture facts: 5 total vehicles, 4 available, 1 active rental, 20% utilisation; 3 cars, 2 motorcycles, R2300.00 in **booked rental value**, not actual payments.

[Latest passing screenshot/build job](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40907466823)

## Visual shortcomings still open

1. **Authentic Ford image does not meet aesthetic quality target.** Properly credited representative model photo, but rear-angle street setting, visible licence plate, distracting background. It does not deliver the intended premium automotive editorial appearance. Source: [Wikimedia Commons, crash71100, CC0](https://commons.wikimedia.org/wiki/File:Ford_Ranger_US-Spec_(52179269642).jpg). Replace after an actual visual-rights review, don't imply it depicts the fictional fleet vehicle.
2. **Navigation remains the original nine-action sidebar.** This is a visual spike, not the approved consolidated three-workspace experience.
3. **Dashboard density remains conventional.** A readable and coherent shell, but not yet a complete or memorable luxury-tech art direction. Improve photographic composition and product-brand mark rather than adding meaningless graphics.
4. **Fleet and Rentals pages have not been visually rebuilt in Qt.** Browser V3 concepts should not be presented as compiled-Qt screenshots.
5. **Windows Qt Creator manual acceptance, keyboard focus, scaling at 125%/150%, and full rent/return/archive workflows** still need hands-on verification.
6. **Two motorcycle asset derivatives are missing.** Wikimedia rate-limited the Honda request; Yamaha has not been retrieved. Track in [PR #3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/3). This does not affect Qt domain logic.

## Trace of fixes

- Original Qt screenshot showed KPI cards compressed by a conflict between Dashboard maximum height (215px) and expanded hero content.
- Subsequent captures still showed secondary metrics intersecting the rental section title.
- Root correction: remove the global `actionStack` minimum height and give Dashboard its own higher maximum height; other pages keep their existing maximums.
- Replaced four secondary cards with one compact metrics strip and added a non-overlap assertion.
- Fixed a false small-screen test that had reused the full-size maximized screenshot.
- All intermediate failures are recorded in the branch and workflow history; this note describes the latest successful verification, not retroactive passes.

## Acceptance before merge

- [ ] Owner reviews image direction and overall Qt screenshot aesthetics.
- [ ] Curate visually strong, licence-compatible photos for the chosen hero and inventory.
- [ ] Finalise Dashboard, Fleet and Rentals visual consistency in genuine Qt.
- [ ] Run Windows GUI at 1280x720 and higher, verify main rental journeys and persistence.
- [ ] Only merge after evidence, updated credits and documented limitations are accepted.

**Keep Draft PR #4 open.** Stable `main` has not been modified by this implementation.

## Real Qt Fleet workspace checkpoint — 29 October 2026

The existing Qt review branch now implements a **branded, task-oriented Fleet Inventory page**, not just an HTML concept:

- Grouped sidebar with RM wordmark treatment and Workspace/Fleet/Rentals sections. The original nine navigation actions and associated slots still work; they have **not** been collapsed into three functional pages.
- Selected-vehicle inspector with an authentic representative photograph (where available), source credit, live vehicle ID/type/details/status and daily rate.
- Live fleet counts, in-page brand/ID/model search, available/rented dropdown filter and Add Vehicle shortcut.
- Toyota Corolla, Ford Ranger and Hyundai i20 CC0 images embedded using Qt resources and fully listed in [review branch photo credits](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/feature/qt-hybrid-visual-spike-20261029/assets/README.md). Both demo motorcycles show an explicit placeholder until source images can be obtained.
- Actual Qt screenshots: [1500×860 Fleet](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/feature/qt-hybrid-visual-spike-20261029/design/qt-spike/fleet-qt.png) and [1280×720 Fleet](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/feature/qt-hybrid-visual-spike-20261029/design/qt-spike/fleet-qt-1280.png).
- [Latest passing workflow 40911451582](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40911451582) on Ubuntu 24.04: Qt6 CMake build, CTest, both Dashboard and Fleet screenshot captures at distinct sizes, heading-to-metric geometry non-overlap, and in-process Fleet search/status smoke checks using the five fictional demo records. Verifies search for Ranger selects the Ford, rented filter finds 1, available filter finds 4, reset reveals all 5. No Windows manual runtime claim.

**Still outstanding:** The three legitimate car photos have non-premium backgrounds. Licence compliance does not equal an acceptable aesthetic. Honda and Yamaha photos remain pending. Fleet search filtering has only automated synthetic acceptance, not exploratory Windows GUI testing. Rental Management UI redesign, keyboard/high-DPI review, real Windows persistence journey and owner visual approval remain outstanding. Draft [PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4) stays unmerged.

