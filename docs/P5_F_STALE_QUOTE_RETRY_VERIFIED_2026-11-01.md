# P5-F: Refresh Stale Quote in the Native Booking Dialog
Verified on 1 November 2026 | Draft PR #12 | all fictional synthetic records

## Operator-facing change

Rental Studio's C++ `RentalConfirmService` already independently rechecks the immutable reviewed `RentalQuotePreview` against **current C++ Fleet availability, daily price and date**, and refuses stale/missing/unavailable quotes before any rental is written. Previously the Qt booking dialog showed the error but did not clearly direct the operator to retry. This increment improves **only controller state and dialog affordances**, not the domain's source of truth.

- `RentalBookingController` exposes a new read-only, change-notified `needsFreshQuote` Qt property. It is true only after a rejected stale/unavailable/missing/invalid reviewed quote; the old `m_reviewed` snapshot is cleared and Confirm is disabled. Starting a new preview or discarding the dialog resets the marker.
- The real `bookingPreviewButton` becomes **Refresh quote** with accessible name and description while a rejected stale snapshot needs review. The dialog continues displaying the real C++ rejection reason, and **returns keyboard focus to the refresh button** after Qt settles the disabled Confirm state. No background automatic rebooking, no optimistic receipt, no bypass of customer validation.
- Explicit preview recalculates through `RentalQuoteService`; a new, separate Confirm must still succeed through `RentalConfirmService` and the normal `QSaveFile`-backed domain writer. Failed re-preview of an unavailable vehicle leaves Confirm disabled and explains that availability remains false.

## Exact real native UI regressions

Two new Qt native CTests `rental_studio_p5_stale_quote_wide` and `_compact` operate a real QQuickWindow at **1500×860 and 1280×720** using keyboard Space:

1. Start with original SHA-verified fictional ledger, exactly two rental records and four available vehicles.
2. Open real Qt Rentals booking dialog, review C001 at **R450/day × 3 = R1350** with valid fictional contact.
3. Change only the **in-memory test-domain** C001 daily rate to **R500** after review (no original fixtures modified), then click real Confirm. C++ must reject stale price, show **Quote changed. Preview again.**, reset `canConfirm`, disable Confirm, display **Refresh quote** and restore keyboard focus there; disk ledger byte-for-byte unchanged and no success receipt.
4. Activate Refresh quote. The real C++ quote must show **R500/day × 3 = R1500**, with no write until a separate Confirm. Confirm saves fictional **R003 at R1500**, updates active/Fleet status, and shows the actual booking receipt.
5. Start a second booking for C003 with **fresh valid fictional customer details** and quote. Mark C003 rented in the in-memory domain **after** review. Confirm must reject with **Vehicle became unavailable. Preview again.**, reset quote and disable Confirm, return focus to Refresh quote and leave the ledger unchanged. Refresh while still unavailable must say **Vehicle is not available.** with Confirm disabled and no new receipt.
6. Both initial original SHA-pinned fictional source files must remain byte-identical.

No production vehicle mutation UI, new customer storage, payment or data import is introduced by these tests.

## Transparent correction history

- [`1bf2e7d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/1bf2e7d00a0663892c4c3e9ca1d32b323cb9bc5f) first implementation. [Native run 41299536843](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41299536843): Linux **56/58**, new two stale-quote checks failed; C++ rejection, disabled Confirm and text were correct, but keyboard focus was not restored.
- [`ee2db61`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/ee2db61ca7bf3af3f9f78414377b5c577ef26a4d) deferred focus after Qt disabled Confirm. [Native run 41299902924](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41299902924): Linux **56/58**; actual log named `Main.qml:806: ReferenceError: bookingPreviewButton is not defined`.
- [`0d403ae`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0d403ae283db2b36922eed938af0f4c28b7ad9d6) added the missing QML ID. [Native run 41300318222](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41300318222): Linux **56/58**; stale price/review/rebook now worked, but the *second* unavailable-vehicle test left its customer fields blank after successful first booking. C++ correctly rejected missing customer **before** checking occupancy.
- [`8f5eb94`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8f5eb94cc40774e07f7130ef55283cacc86d0b50) completes the unchanged strict test path with valid fictional customer fields for the second quote; did **not** change actual domain rejection priority or disable assertions.

## Final exact-source independently verified CI

| Scope | Evidence | Result |
|---|---|---|
| Core C++/legacy | [41300723296](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41300723296) | **13/13 CTests PASS** |
| Linux GCC Qt Quick 6.8.3 | [41300723315](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41300723315) | **58/58 CTests PASS**, two new real stale-quote UI cases |
| Windows Server 2022 MSVC Qt Quick 6.8.3 | Same run | **58/58 CTests PASS**, same two cases |
| Windows relocated review EXE | Same Windows job | Packaged P4 four checks PASS under PowerShell 7 and separately Windows PowerShell 5.1 |
| Fixture safety | Same Windows job | Intentionally swapped non-demo input rejected and restored |
| Screenshot artifacts | Same run | Existing Linux/Windows QQuickWindow screenshot sets uploaded; stale-quote screenshots were not separately requested/captured |

Actual complete native CI job logs were read. Both platforms reported `100% tests passed, 0 tests failed out of 58`.

## Formal status and next scope

This is a meaningful **verified implementation increment**, not formal P5 signoff. P5 remains **0/8**, P4 **5/7**, programme **28/74** and **40.6% accepted-evidence coverage**, **not** release readiness. Draft PR #12 remains stacked on unmerged Draft PR #10 and stable `main` must not be changed. All user-preview behavior remains SHA-pinned fictional-only, default ephemeral, with explicit opt-in synthetic persistence only. Do not ask the owner to repeat manual acceptance steps.

Next P5 scope: more complete guided cancellation/decline and stale-availability product polish, or consolidate all eight P5 acceptance criteria into a source-evidence matrix, without prematurely accepting untested physical owner criteria. Later phases still need broader owner approval and the separately gated P7 production storage design.
