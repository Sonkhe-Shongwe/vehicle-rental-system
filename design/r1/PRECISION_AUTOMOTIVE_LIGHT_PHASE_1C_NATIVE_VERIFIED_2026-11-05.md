# Precision Automotive Light | Phase 1C Fleet engineering checkpoint

**Date:** 5 November 2026  
**Verified executable source:** [`b5c8d3f97546d9fa4d485b9781b5fdfddf9996da`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/b5c8d3f97546d9fa4d485b9781b5fdfddf9996da)  
**Native CI evidence:** [Actions #42090885484](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42090885484)  
**Review stage:** Implemented and native-tested, still pending owner physical/visual acceptance.  
**Reference:** [Precision Automotive Light/Contrast master](PRECISION_AUTOMOTIVE_CONCEPT_MASTER_2026-11-05.md)

## Verified outcome

- Native Linux GCC Qt 6.8.3: **138/138 CTests PASS**.
- Native hosted Windows MSVC Qt 6.8.3: **138/138 CTests PASS**.
- Native wide and compact Fleet design smoke `rental_studio_pa_fleet_003_{wide,compact}`: **PASS on both platforms**.
- Portable Windows fictional application: **8/8 functional checks PASS**, PowerShell 5.1 verification PASS.
- Tested real QML gallery, table header, selected inspector, rate, available/rented status, Fleet status pill and search presentation.
- The new test asserted correct C++-bound selected vehicle, displayed rate and status, sensible Gallery/Inspector geometry, stable selected ID across gallery/table switching and byte-for-byte protection of original demo fleet/rental fixtures.
- All verified screenshots came from the actual compiled QML executable at both **1500x860** and **1280x720**, not from the generated design board.

## Components and user-visible changes

- New reusable `spikes/qtquick_p2/FleetStatusPill.qml` uses existing C++ availability; mint/emerald Available and clear blue Rented labels are accessible as text, not colour alone.
- Fleet toolbar uses restrained outlined filters, local search icon, clearer view switch, contextual Add vehicle and a factual filtered count.
- Gallery rows use a consistent image frame, truthful Reference image/Illustration label, stronger model name and make/ID caption, authentic C++ daily rate and state pill.
- Inspector uses a clear name/type/status and daily-rental rate band. It continues to respect C++-guarded booking, photo viewing/replacement and removal rules.
- Real selected records remain stable across Gallery/Table switching. No independent customer/payment/maintenance/reports module or new business state was added.

## Native screenshots inspected (Windows)

- `pa-fleet-003-gallery-1500x860.png`
- `pa-fleet-003-gallery-1280x720.png`
- `pa-fleet-003-table-1500x860.png`
- `pa-fleet-003-table-1280x720.png`

Windows screenshot artifact: **13445523657**; Linux screenshot artifact: **13446916147**, both held on GitHub Actions with limited retention. Daily owner review now uses **GitHub Desktop Fetch/Pull → Qt Creator Build/Run** as documented in [the no-ZIP guide](../../docs/DAILY_UI_REVIEW_NO_ZIPS.md).

## Visual review findings and gates still open

The latest wide Gallery image shows a credible, consistent light workspace: active mint Fleet nav, clear Emerald New rental command, outline filter/search area, white photo-backed vehicle cards and a separate detail panel.

The compact 1280x720 evidence shows a scrolled Fleet grid after a programmatic car selection, so the first row is partially beyond the viewport. This **does not prove a clipping bug at the initial gallery position**; the physical owner test should start with search cleared, selection cleared, scrollbar reset to top and then inspect the selected-vehicle scrolling behaviour. The demo's five-vehicle screenshots contain Honda/Yamaha neutral silhouettes; the normal offline showcase has 131 fictional vehicles across 70 models, with eight currently unresolved photo cases. Verify both before final imagery signoff.

Remaining final-design work: even spacing of toolbar/view switch at different DPI values; compact card image/text visibility during scroll; full model-specific photo review; keyboard navigation and actual Qt Creator 6.10.2 MinGW scaling/Narrator evidence; complete owner comparison to the saved Precision Automotive master.

## Next phase

**Phase 1D: Rentals.** Improve layout hierarchy and coherent Light styling around the existing Active/History/status/timing controls, contract rows, booking quote and return/archive confirmation. Preserve authoritative C++ transactional validation, deliberate confirmation, accurate booking value versus payments, protected fictional data and existing owner-accepted P5/P6 behaviour. No fake features.

**Formal owner status unchanged: 45/74 criteria, weighted 70.6%; P7 0/8.** Draft PR #17 remains unmerged and stable `main` untouched. No commercial installer or release.
