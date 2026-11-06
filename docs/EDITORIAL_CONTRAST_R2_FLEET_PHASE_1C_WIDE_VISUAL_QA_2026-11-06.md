# Rental Studio 2.0 | Editorial Contrast R2 Fleet Phase 1C | Native and visual review

**Date:** 6 November 2026

**Exact engineering-tested source:** [`8957da92005e4edc1c261ad0bf1b2ffca646ef01`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8957da92005e4edc1c261ad0bf1b2ffca646ef01)

**Run:** [#42291921837 completed SUCCESS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42291921837)

## Native build and functional evidence

- Linux GCC / Qt 6.8.3 native CTest: **142/142 PASS**.
- Windows MSVC / Qt 6.8.3 native CTest: **142/142 PASS**.
- Windows packaged, fictional functional journeys: **8/8 PASS**.
- PowerShell 5.1 P4 verification: **PASS**.
- P4 accessibility, real booking availability, Fleet photo/credit and Gallery/Table selection retain native coverage and remain functional. No C++ rental/status/rate/payment truth changed.
- Actual QML screenshot ZIPs: [Windows #13540562364](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42291921837/artifacts/13540562364); [Linux #13539669463](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42291921837/artifacts/13539669463).

## Visual inspection and defect

Both Windows and Linux 1500×860 and 1280×720 images were inspected, specifically `pa-fleet-003-gallery-*.png`, `pa-fleet-003-table-*.png`, `pa-overview-002-*.png`, and `p3-qt-rentals-*.png`. Overview's refined four KPI cards and Rentals' photo-backed selected R001 register remain intact. Fleet holds a real 60/40 Gallery / selected inspector split, the source-correct C001 Corolla photo and credit, true C++ R450/day and Available, selected Gallery card and genuine booking/removal actions. C002 Ford Ranger remains Rented and nonbookable. Compact 1280×720 Fleet retains two legible Gallery rows and a complete selected inspector.

**Visual rejection despite technical green:** On the 1500×860 screenshot the bottom of the wide Fleet inspector's history-based removal warning was pushed outside the white panel. The increased hero/rate hierarchy improves photo prominence but consumes more height than the prior layout, and the old native tests did not check this warning's actual scene bounds. This is a visual defect, not business validation failure. Do not call wide Fleet design approved based only on the 8957 green result.

## Narrow repair pending independent verification

A follow-on exact source [`71ed79e`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/71ed79e32ff07626f3bac27d1d16e422a2964e6f) addresses the observed clipping: Fleet inspector wide spacing 12→9px, removes the expanding spacer above context actions in favor of a fixed small one, and adds a C++ real QML smoke-test assertion verifying `fleetRentalHistoryHint` exists, is visible for historical C001 and its bottom edge stays within both the inspector and window at 1500x860 and 1280x720. Original regression tests are not weakened. Inspect [new CI #42296488062](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42296488062) and the new Windows and Linux screenshots before accepting this repair. 8957 remains the latest **fully CI-green** executable until then, but not final visual signoff.

The original owner-approved 1672px R2 visual reference pack is not in GitHub, so no pixel parity can be established. Physical owner's Windows Qt Creator 6.10.2 MinGW / DPI and Narrator, final photo provenance and explicit individual Overview/Fleet/Rentals visual approvals remain open. Formal project score 45/74, weighted 70.6%, P7 0/8, PR #17 draft and main untouched.
