# Rental Studio 2.0 | Editorial Contrast R2 | Three-workspace native visual audit

**Date:** 6 November 2026

**Last fully verified executable:** [`b2dacc2a0cc6640703330ce3b70e393c848c5df7`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/b2dacc2a0cc6640703330ce3b70e393c848c5df7)

**Native CI:** [#42286318986, SUCCESS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42286318986)

## Engineering evidence and scope

- **Qt 6.8.3 Linux GCC native smoke/CTest:** **142/142 PASS**.
- **Qt 6.8.3 Windows MSVC native smoke/CTest:** **142/142 PASS**.
- **Windows packaged fictional journeys:** **8/8 PASS**, PowerShell **5.1 PASS**.
- Existing Rentals P3-H filters, compact UX-S1 scrolling #56, P4 accessibility #91 and #92 retain their original assertions and all pass.
- **Real images, not design mockups:** [Windows screenshots #13538296868](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42286318986/artifacts/13538296868) and [Linux screenshots #13537972641](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42286318986/artifacts/13537972641), both **1500×860** and **1280×720**. I inspected `pa-overview-002-*.png`, `pa-fleet-003-gallery-*.png`, `p3-qt-rentals-*.png`, and selected-register screenshots across both systems. Screenshot files are CI artifacts, not Git blobs.
- Source-controlled direction is the owner-selected R2 mixed charcoal/light editorial palette, **not** the older light-sidebar Overview screenshot. That earlier screenshot remains a useful quality benchmark. The original full-resolution P0/P1 concept pack is not in this repo, so **no true pixel-diff or owner signoff** is implied.

## Review by workspace

### Overview

**Confirmed:** Charcoal/mint navigation, four real data-backed metrics, contract value explicitly not cash receipts, evergreen overdue R001/C002 priority hero, correctly labelled model-reference photo, white fleet-readiness and lower activity/highlight cards. Real five-fixture test environment shows 5 vehicles/4 available; it is deliberately different from the user's 131-vehicle showroom example. Do not fabricate showroom data for passing screenshots.

**Visual gap:** The icon-led metric cards use smaller labels and figures than the premium light-reference target, reducing hierarchy relative to the hero and headline. At 1500×860 a modest increase fits their existing heights; 1280×720 needs an elision check, especially the active booked amount. The reference's hero and readiness imagery look more expansive than the test-fixture screenshot; reserve final pixel geometry decisions for original owner concept ZIP and full-screen review.

**Candidate:** [`95e9531`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/95e9531b6ac238a41ba0ad3d4c6b337ad3fd2068) modifies only `OverviewMetricCard.qml`: larger icon tile, 34px wide/25px compact values, clearer labels, and grouped visual currency while retaining underlying `value` and pre-existing spoken names. **NOT YET NATIVE VERIFIED**; [run #42288527437](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42288527437) must complete before promoting.

### Fleet

**Confirmed:** ~60/40 photo gallery versus selected vehicle inspector, real C001 Toyota Corolla available, C002 Ford Ranger rented/nonbookable, source-correct picture credits and synthetic motorcycle illustrations. Gallery and inspector are aligned at both sizes; keyboard and management actions remain native.

**Visual gap:** Compared with the photographic premium target, the selected Fleet inspector has low visual density below its price/action region and some conspicuous blank white space. Product imagery spans mixed illustration/reference types by necessity; do not quietly replace licensed assets or claim illustrative motorcycles are photos. Review section spacing, exact copy hierarchy and safe collapsed empty states in a separate bounded pass only after source-level Overview KPI verification.

### Rentals

**Confirmed:** Four source-backed metrics, integrated white contract register with filter/status/timing controls, 62/38 selected contract inspector and real R001/C002 active overdue + R002/C001 returned rows. The compact New Rental/disclosure toolbar keeps the register higher in the viewport. Final photo uses actual selected ID, opacity 0.92 with an evergreen horizontal text-protection gradient, and retains visible MODEL REFERENCE/NOT ACTUAL RENTAL UNIT disclosure. The real native screenshots show the Ford Ranger brighter than the earlier all-dim version; selected text remains usable. Native lifecycle actions are contextual, and no C++ business logic changed.

**Visual gap:** The initial compact viewport cannot show every lifecycle action without scrolling, but this is designed and verified rather than hidden or broken; native PageDown and #56 scroll regression pass. Relative to owner premium imagery, the inspector/register detail is still operationally dense. Do not remove any real filter/action solely for visual compactness.

## Priority after this audit

1. Run exact-source CI for the Overview KPI polish and compare its 1500×860 and 1280×720 Windows/Linux screenshots for overflow, tabular amounts, source-backed contract values and accessibility. If the candidate fails, repair without weakening tests.
2. Conduct a **bounded Fleet inspector density/padding pass**, but only after evidence-based screenshot measurement, preserving authentic photos/licences and real enabled/disabled buttons.
3. Re-review all three workspaces together against the owner's actual full-size P0 hybrid and P1 concepts when the original reference pack is available, plus 131-vehicle owner showcase on real Windows. Do not claim exact visual parity without it.
4. Owner's physical Qt Creator 6.10.2 MinGW + OS 100/125/150% + keyboard/Narrator checks and three explicit page visual approvals remain separate gates.

**Guardrails:** Exactly three workspaces, C++ business truth, no payments/customer/cloud/maintenance modules, no automatic P7 production SQLite, no non-fictional records, no merge/release. Draft PR #17 remains open; main must remain untouched. Formal acceptance stays **45/74, fixed-weight 70.6%, P7 0/8**.
