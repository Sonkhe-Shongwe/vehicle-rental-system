# P5-G: Cancel and Escape Booking Draft Safety
**Verified on 1 November 2026 | Draft PR #12 | fake data only**

## Specific operator defect fixed

The P3/P4 booking dialog had two different close behaviors. Clicking its Cancel button explicitly cleared customer name and contact fields; pressing Escape (Qt Popup.CloseOnEscape) closed the dialog and discarded the C++ quote, **but retained the uncommitted customer contact text in the QML form**. Reopening the form could therefore expose the previous fictional draft contact even though nothing was saved. There was also no unambiguous visible cancellation outcome after closing.

[Source commit `3e5d40efe20a796b0c5ed47e0f48a3e177cd3eb3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3e5d40efe20a796b0c5ed47e0f48a3e177cd3eb3) changes only `spikes/qtquick_p2/Main.qml`, its native test harness `main.cpp` and CMake registration:

- The dialog's single `onClosed` handler handles **every dismissal**, not just its Cancel button: calls `bookingActions.discardPreview()`, clears ephemeral customer and contact text, and restores focus to the New rental button. The Cancel button now delegates to normal dialog close.
- A separate UI-only `bookingCancelledNotice` displays the exact result **`Booking cancelled. No rental saved.`** through the existing accessible `rentalBookingMessage` control. It is not a successful receipt or a domain transaction. It is cleared when starting a new booking from Rentals or Fleet.
- A genuine `bookingReceiptNotice` remains the highest priority message, populated **only** after `bookingActions.confirm()` returns success from C++ atomic persistence. Closing the modal after a successful booking **does not** show a fake cancellation or erase a genuine receipt.
- Vehicle ID is intentionally **preserved** after cancellation to retain existing P3 operator and regression behavior, but any saved quote is invalidated so a fresh preview is required. No C++ pricing, durable storage or foreign data inputs are changed.

## Real native QML tests and evidence

New native Qt CTests `rental_studio_p5_booking_cancel_wide` and `_compact` at **1500×860** and **1280×720** drive actual Qt keyboard Space and Escape events in the real QQuickWindow. Each test:

1. Creates a valid R450/day × 3-day fictional C001 quote, enters fictional contact, clicks the real Cancel button, and asserts quote discarded, contact fields scrubbed, focus returned to New rental, honest cancelled status visible, no receipt, no R003 and byte-identical disposable ledger.
2. Reopens the form, proves fields and Confirm are clear, enters new fictional contact and previews a valid quote, then presses the **real Escape key**, asserting the same full cleanup, status and no-write guarantees.
3. Reopens, previews and attempts to confirm with a blank customer, proves existing C++ `Enter a valid customer name.` inline rejection without any write, then presses Escape and verifies declined-draft cancellation also cleans the fields and never commits.
4. Captures a real native QQuickWindow screenshot named `p5-qt-cancel-outcome-1500x860.png` or `-1280x720.png`, and confirms original SHA-pinned fictional source Fleet and Rentals files remain byte-identical.

Source logs and outcomes:

| Platform | Workflow | Result |
|---|---|---|
| Core C++ and legacy regressions | [41302083582](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41302083582) | **13/13 CTests PASS** |
| Linux Qt Quick 6.8.3 GCC | [41302083630](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41302083630) | **60/60 CTests PASS**, two new cancellation tests |
| Windows Server 2022 Qt Quick 6.8.3 MSVC | Same run | **60/60 CTests PASS**, same two new tests |
| Windows SHA fixture/packaged smoke | Same Windows job | Intentional non-demo fixture swap rejected; packaged four P4 checks PASS under PowerShell 7 and separately Windows PowerShell 5.1 |
| Visual capture | Native suite | Actual wide/compact `p5-qt-cancel-outcome-*.png` generated; screenshot uploads added in the subsequent documentation/CI commit |

The actual completed Linux and Windows job logs show `100% tests passed, 0 tests failed out of 60`; no pre-existing test, safeguard or strict new assertion was disabled.

## Formal acceptance status and next work

P5 still **0/8 formally accepted** even though all eight issue-defined P5 behaviors now have representative automated evidence, as detailed in [P5 acceptance crosswalk](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md). P4 stays **5/7**, overall **28/74**, evidence-weighted **40.6%**, **not** production release readiness. Real physical owner Windows Narrator/display scale/Qt Creator and final visual review are still open, as are broader operational data/storage requirements in separately gated later milestones. Keep P5 Draft PR #12 stacked on unmerged P4 Draft PR #10; `main` untouched. The owner explicitly asked not to repeat PowerShell/manual reviews, so no new manual task is assigned now.
