# Rental Studio 2.0 | Editorial Contrast R2 Rentals Phase 1B | Visual polish native verified

**Date:** 6 November 2026

**Verified executable:** [`43084f8c563007ab4a92cba256004704ee39cfa0`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/43084f8c563007ab4a92cba256004704ee39cfa0)

**Native run:** [#42278609485, completed SUCCESS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42278609485)

## Exact-source build and regression verification

- **Linux GCC / Qt 6.8.3:** 142/142 native CTests passed.
- **Windows MSVC / Qt 6.8.3:** 142/142 native CTests passed.
- **Windows packaged real fictional application:** 8/8 native functional journeys passed.
- **Windows PowerShell 5.1 P4 verification:** PASS.
- **Existing native accessibility:** both wide and compact P4 cases #91 and #92 pass. The previous `36cce285` (Windows 140/142) changed spoken rental-row money from `total R 1400.00` to grouped `total R 1,400.00`, breaking the established accessible-name contract; `43084f8` restores stable spoken output but retains grouped **visible** amounts. No assertion weakened.
- **Compact scrolling:** UX-S1 #56 passed on both operating systems, preserving keyboard PageDown and access to lower contract actions.

## Actual visual inspection

Downloaded **both** complete screenshot artifacts: [Windows #13534743477](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42278609485/artifacts/13534743477) and [Linux #13534263725](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42278609485/artifacts/13534263725). Inspected `p3-qt-rentals-1500x860.png`, `p3-qt-rentals-1280x720.png`, `pa-rentals-004-controls-1500x860.png`, `pa-rentals-004-controls-1280x720.png`, `pa-rentals-004-register-1500x860.png` and `pa-rentals-004-register-1280x720.png` on both platforms. Contact-sheet comparisons are retained as local review artifacts, not falsely linked as source-controlled PNG files.

The R2 charcoal sidebar frames a light canvas. The four KPI cards use improved spacing/scale and source-backed active, overdue, history and contractual booked value. Grouped display amounts are `R 1,400.00`, not payments received. The dominant white register contains model-backed lifecycle/timing/search filters and both fictional R001/C002 active-overdue and R002/C001 returned contracts; selected row and contract inspector stay synchronized. Dark evergreen photo-backed selected contract hero labels the actual **model reference**, not an actual rental unit. Buttons for return/archive/delete remain contextual. At 1280x720, lower controls are accessed through native page scrolling; do not claim all actions fit above the fold.

**Remaining visual gap observed:** The persistent fictional notice and a duplicate contextual New rental row consume unnecessary vertical space above KPI cards and register, especially compact. More editorial density and final source-reference/photo review remain open. A separate candidate [`3b74c50`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3b74c50eaf3187af3e10c36713791efbb5096b48) consolidates that disclosure and CTA into one source-backed toolbar; [CI #42282222982](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42282222982) is still in progress at this report's checkpoint. This candidate is **not** included in the verified source and needs its own tests and screenshots.

The user's earlier light-sidebar Overview screenshot is a premium aesthetic benchmark; the later owner-approved **Editorial Contrast R2 dark sidebar** overrides its navigation palette. The original 1672px R2 P0/P1 reference ZIP is not in the Git repository, so no claim of pixel-level parity is made. Screenshots and all three owner visual signoffs remain independent of full engineering CI.

## Guardrails and remaining gates

All business and persistence decisions remain C++ authoritative, with no customer/payment/maintenance/cloud functionality fabricated. Original demo fixtures stay protected. Do not merge draft PR #17, modify main, activate P7 production SQLite, or call real Windows Qt Creator 6.10.2 MinGW / 100/125/150% OS DPI / Narrator tested. Formal owner acceptance remains **45/74, weighted 70.6%; P7 0/8**. Reference pack and final individual workspace visual signoffs are still needed.
