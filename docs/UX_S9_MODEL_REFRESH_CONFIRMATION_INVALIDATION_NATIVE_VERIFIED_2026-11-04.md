# UX-S9 | Model-refresh invalidation of pending Return and Archive confirmations

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled and native-verified source:** [`dfd398a96fcf18916a0e55b168ffa7b0dbf89258`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/dfd398a96fcf18916a0e55b168ffa7b0dbf89258)  
**GitHub Actions:** [run 41739193120](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41739193120), **COMPLETED SUCCESS**  
**Branch:** `feature/p7-sqlite-sandbox-20261102`; draft PR #17 stacked against P6 #14; no merge.

## Operator risk

UX-S7 captured the reviewed rental ID and checked it again inside C++. UX-S8 irreversibly invalidated an open dialog after a changed selection, even if it moved back to the original ID. A further gap remained: an authoritative `RentalListModel::refresh()` could rebuild the model using new C++ data while retaining the **same selected rental ID**. Such refreshes include the UX-S5 local calendar rollover or the host's other model refresh paths. Since `selectionChanged` is not guaranteed when the ID/row remains stable, the existing confirmation could stay enabled against a newly refreshed contract snapshot. The precise rollover while a modal is open was not reported as an owner-observed incident; this is bounded prevention.

## Bounded native UI correction

- `spikes/qtquick_p2/Main.qml`: an existing QML `Connections` handler for `rentalsModel` now observes `modelReset` in addition to selection changes, and conservatively marks a visible Return or Archive confirmation's `reviewInvalidated` latch true even if the same rental ID is selected. A common `invalidateOpenRentalReviews(reason)` method retains the **first** invalidation cause.
- The original target ID remains frozen, and Confirm remains disabled after invalidation. Its existing accessible question now states **"Rental data refreshed. Close and reopen to review this return/archive."** This distinguishes model refresh from the UX-S8 **"Selection changed"** reason.
- A fresh operator click opens a new confirmation, resets the invalidation flag/reason and captures its then-current selected ID. Cancel and Escape remain read-only; selection/record identity is unchanged by a refresh.
- The C++ `RentalReturnController` and `RentalArchiveController`, their UX-S7 exact-ID methods, authoritative domain saving, guarded rollback, fleet availability, P7 sandbox and all storage remain untouched.
- `spikes/qtquick_p2/main.cpp`: strengthened the existing genuine wide (1500×860) and compact (1280×720) Qt shared-component tests. With a live modal and an unchanged selected ID, explicitly call real C++ `rentalModel.refresh()`; assert that the modal disables Confirm, shows its cause and reopening instruction, preserves the original selected ID and C++ eligibility, then Cancel/Escape and reopen to confirm fresh eligibility and a cleared reason. Existing tests also retain selection-away/back checks, focus restoration and comparison of original protected vehicle/rental file bytes.
- No existing native test deleted or skipped. The full 123-test suite remains unchanged in count.

## Native exact-source verification

[GitHub Actions run 41739193120](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41739193120) **COMPLETED SUCCESS** for `dfd398a96fcf18916a0e55b168ffa7b0dbf89258`:
- **Ubuntu 24.04 GCC / Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failed, total **158.99 seconds**. Existing C++ Return/Archive controller tests #9/#11 PASS. Actual Qt wide/compact shared confirmation tests #69/#70 PASS, with new model-refresh invalidation, Cancel/Escape and reopening assertions.
- **Hosted Windows Server 2022 MSVC / Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failed, total **178.83 seconds**. Same four targeted tests pass.
- **Relocated portable Windows application:** **8/8 real fictional functional executable checks PASS**. P2/P4 packaged automation, PowerShell 7 and Windows PowerShell 5.1 verification PASS.
- Generated [Windows physical acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41739193120/artifacts/13279959346), [actual hosted Windows Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41739193120/artifacts/13280813355) and [Linux Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41739193120/artifacts/13280647660). All expire 10 November 2026.
- These are hosted automated runs, NOT an actual laptop/Qt Creator MinGW build, physical OS scaling 100/125/150%, Narrator accessibility check or owner manual acceptance.

## Preserved project boundaries

**Formal owner acceptance remains 45/74 criteria, weighted 70.6%; P7 0/8.** Existing P5/P6 fictional scope and accepted criteria are unchanged. Physical UX-S1 Rentals page-scrolling retest, owner keyboard/mouse focus acceptance, MinGW, OS scaling, Narrator, P7 D2–D8 real-data/privacy/security/retention/backup decisions, P8 installer, P9 release and all draft PR merges are OPEN. Final real fleet population, photos and image licences intentionally remain for the last project section. No protected demo source data, real contact data, production database, installer, operational backup or release was created.

The later documentation-only HEAD is **not** a newly compiled or separately verified source.
