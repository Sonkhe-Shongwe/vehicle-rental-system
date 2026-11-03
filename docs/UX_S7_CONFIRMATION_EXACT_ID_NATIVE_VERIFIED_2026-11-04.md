# UX-S7 | Exact-ID return and archive confirmation guards

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled and native-verified source:** [`c392bc5051676ea7e24a59461275e3a88484cc16`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c392bc5051676ea7e24a59461275e3a88484cc16)  
**GitHub Actions:** [run 41730752450](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41730752450), **COMPLETED SUCCESS**  
**Branch:** `feature/p7-sqlite-sandbox-20261102`; draft PR #17 stacked on P6 #14. No merge.

## Functional risk found

The native Qt Quick Return and Archive dialogs previously bound their question string to the **current live** `rentalsModel.selectedRentalId` and the Confirm button only to current action eligibility. A programmatic selection change while a modal was open could make its text follow a different rental, and a second eligible active/returned rental could inherit a previously opened confirmation. The C++ action methods previously re-read only the current selection at commit time, without verifying that it matched the originally reviewed ID.

This was a potential confirmation/consent mismatch, not an observed physical Windows incident. The change is deliberately confined to existing fictional-data commands.

## Smallest safe fix

- In `spikes/qtquick_p2/Main.qml`, each Return/Archive action now captures the **canonical selected rental ID at modal open**. The modal question displays this frozen target. The Confirm action is enabled only while the frozen target is nonempty, equals the live selected rental ID and the C++ action remains eligible.
- In `src/application/rental_return_controller.{h,cpp}`, new `Q_INVOKABLE bool returnSelectedFor(const QString &expectedRentalId)` validates the exact captured ID against current, visible selection before dispatching to existing `returnSelected()`. On mismatch, it emits a typed rejection and a human-readable request to reopen confirmation, **without** calling the return service or touching storage.
- In `src/application/rental_archive_controller.{h,cpp}`, the analogous `archiveSelectedFor` enforces the same exact-ID guard before existing `archiveSelected()`.
- The existing C++ domain services continue to own the actual authoritatively validated transactions, QSaveFile atomic save / rollback, lifecycle updates and post-success receipt selection from UX-S6. No second writer, bypass, revalidation regression, or P7 storage change was introduced.
- `tests/p3_rental_return_controller_tests.cpp` now sets up two **eligible active fictional contracts**, deliberately submits a mismatched reviewed ID, and verifies typed rejection, zero domain writes, unmodified fleet and ledger bytes, retained selection, no false success or refresh; valid-ID failed-save and successful-ID paths continue to run.
- `tests/p3_rental_archive_controller_tests.cpp` now sets up two **eligible returned fictional contracts**, rejects a mismatched reviewed ID without modifying either contract or fixture bytes, and then proves a valid target can be archived while the other returned contract remains unchanged.
- `spikes/qtquick_p2/main.cpp` strengthens the actual Qt QML wide/compact shared-component tests: open Return for R001 then switch C++ selection to R002, verify the question remains R001 and confirmation becomes disabled, restore selection and safely Cancel; repeat for Archive R002 while current selection changes to R001, then Escape. The existing protected fixture byte checks and focus restoration remain in place.

No existing native test was removed, disabled or reduced in expectation. These tests cover both controller-level identity mismatch with another eligible contract and real QML binding safety.

## Exact-source native verification

[GitHub Actions 41730752450](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41730752450) **COMPLETED SUCCESS** for source `c392bc5051676ea7e24a59461275e3a88484cc16`:
- **Ubuntu 24.04 GCC / Qt 6.8.3:** **123/123 native CTests PASS**, zero failures, total **155.99 seconds**. New coverage in existing tests `vehicle_rental_p3_return_controller` #9 and `vehicle_rental_p3_archive_controller` #11 PASS; real QML `rental_studio_p4_components_wide` #69 and `_compact` #70 PASS.
- **Hosted Windows Server 2022 MSVC / Qt 6.8.3:** **123/123 native CTests PASS**, zero failures, total **172.48 seconds**. The same four targeted tests PASS.
- **Hosted Windows packaged application:** `ALL 8 REAL APP FUNCTIONAL CHECKS PASSED`. P2/P4 packaged verification and both PowerShell 7 and Windows PowerShell 5.1 checks PASS. The test artifacts include compiled Qt native screenshots and a portable fictional acceptance kit. This is NOT a physical owner-on-device GUI/Qt Creator/MinGW, Narrator or display-scaling signoff.
- [Windows fictional acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41730752450/artifacts/13276801106), [Windows screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41730752450/artifacts/13278001477), [Linux screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41730752450/artifacts/13276487482), expiration 10 November 2026.

## Boundaries and next owner checks

**Formal acceptance unchanged: 45/74 criteria, weighted 70.6%; P7 0/8.** Existing P5 8/8 and P6 9/9 owner acceptance remain bounded to fictional-only scope.

Physical owner Windows UX-S1 scroll retest, mouse/keyboard focus, Qt Creator/MinGW, physical OS 100/125/150% scaling, Narrator accessibility, P7 D2-D8 real-data/security/retention/backup decisions, P8 installer, P9 release, and final fleet population/photos are OPEN. No real customer data, default commercial SQLite storage, new operational backup system, installer or merge was authorized. Original protected demo fixtures remain unchanged.

The following documentation-only HEAD must not be reported as separately compiled or release-certified.
