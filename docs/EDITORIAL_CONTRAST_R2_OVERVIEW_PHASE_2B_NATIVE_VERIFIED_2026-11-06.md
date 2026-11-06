# Rental Studio 2.0 | R2 Overview Phase 2B exact-source native verification

**Date:** 6 November 2026. **Tested executable:** [`a909a7881ef26e3355a28b3f2ee0f6af94c44652`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a909a7881ef26e3355a28b3f2ee0f6af94c44652). **Run:** [#42246522764 completed SUCCESS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42246522764). Branch `feature/p7-sqlite-sandbox-20261102`, draft PR #17 on P6 base, `main` unchanged.

## Source changes

- `Main.qml` uses the approved approximately 65/35 dark priority hero and white fleet-readiness ratio, keeping a 290 logical-pixel readiness minimum for resizing. The photo is the real C++ overdue vehicle C002 (R001 active/overdue), framed with editorial `PreserveAspectCrop` and clearly labelled `MODEL REFERENCE`. The Fleet full-image and attribution path is unchanged. No new image was acquired, licensed or represented as an actual vehicle unit.
- `OverviewMetricCard.qml` increases wide and compact metric values, labels and notes without inflating the four existing cards. Values remain from C++ totals/availability/active rentals/contractual booked value, never fabricated payments or cash receipts.
- `EditorialVehiclePreview.qml` changes its decorative arrow to a source-pinned, locally bundled ISC/Feather-noticed Lucide chevron-right; existing keyboard, focus, selection identity, status, rate and application routing remain unchanged.
- The native Overview C++ wide/compact tests now enforce the hero 65% share (tolerance 4.5 percentage points), photo containment and source ID C002, local SVG decode and original fixture nonmutation.

## Exact-source test evidence

| Verification | Linux GCC Qt 6.8.3 | Windows MSVC Qt 6.8.3 |
|---|---|---|
| Full native CTest | **142/142 PASS**, zero failures | **142/142 PASS**, zero failures |
| R2 Overview wide/compact | PASS / PASS | PASS / PASS |
| Inter opt-in trial wide/compact | PASS / PASS | PASS / PASS |
| Packaged fictional functional checks | N/A | **8/8 PASS** |
| PowerShell 5.1 packaged | N/A | **PASS** |

Evidence: [Linux actual Qt PNG ZIP #13518242670](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42246522764/artifacts/13518242670), [Windows actual Qt PNG ZIP #13518193012](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42246522764/artifacts/13518193012), [hosted Windows owner-review kit #13517933070](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42246522764/artifacts/13517933070). A hosted QA kit is not a physical owner acceptance.

## Native screenshot inspection

The real `pa-overview-002-1500x860.png` and `pa-overview-002-1280x720.png` captures from **both** native platforms were downloaded and inspected. White readiness panel appears wider and balanced against the dark hero, KPI numerals and headings are more legible, source-backed R001/C002 information and photo reference label remain correct, recent contractual rows and available vehicle preview cards are aligned. No clipping, overlapping essential controls or missing action was observed at these sizes. Windows Segoe type is lighter than Linux's system fallback; the optional Inter trial remains inactive in normal builds. The original owner full-resolution R2 PNG ZIP remains unavailable, so pixel-accurate concept matching is not claimed.

## Open gates and next action

The entire Overview has **not** received owner visual signoff. Fleet gallery/inspector and Rentals register/inspector R2 reconstruction remain open. Physical owner Windows Qt Creator/MinGW, 100%,125%,150% scaling, Narrator, keyboard, focus, final photo suitability, all workspace owner approvals and release gates are separate from hosted CI. C++ domain, booking, return, archive, delete, persistence and P7 fictional-only isolation are unchanged. Formal acceptance **45/74, weighted 70.6%, P7 0/8** remains unchanged.

**Next bounded work:** any further Overview concept-fidelity issues and owner feedback, then begin Fleet R2 photo gallery and dark selected-inspector design, preserving source-backed C++ availability. No merge, production data or release.
