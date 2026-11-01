# P5-B | Booking Receipt and Persisted C++ Reload | Verified 1 November 2026

## User-facing improvement

Previously the successful C++ booking message `Booking R003 saved.` was briefly available through `RentalBookingController.lastMessage`, but the QML modal's `onClosed` called `bookingActions.discardPreview()`, clearing `lastMessage` before the rental page could keep showing its result. A successful transaction therefore had no durable **visible** receipt once the dialog closed. Also, a declined confirmation's reason was rendered **behind** the still-open modal, leaving the operator unsure why Confirm had not worked.

At exact [source `2fca87cdce8bcefcbcfb477d3da8601fca554c22`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2fca87cdce8bcefcbcfb477d3da8601fca554c22):

- `spikes/qtquick_p2/Main.qml` captures the authoritative `bookingActions.lastMessage` into `window.bookingReceiptNotice` **only when `bookingActions.confirm()` returns true**, before closing the popup. The Rentals page's actual `rentalBookingMessage` presents it after the popup closes. Opening another booking clears this transient UI notice; a cancelled booking cannot invent success.
- A `bookingDialogFeedback` domain-message component inside the modal binds to the existing C++ `lastMessage`, making invalid name, phone, stale quote and failed commits visible without closing the form. No customer contact values are included in the receipt or accessibility metadata.
- No domain pricing, storage, booking/return service, customer data access or original demo fixture is changed. All UI feedback derives directly from existing C++ signals/results, not optimistic QML writes.

## Real persisted state rehydration and duplicate refusal

The existing `--p5-overview-smoke`, still performed on a real Qt Quick window at 1500×860 and 1280×720, now additionally:

1. Captures the **original, authoritative** available Corolla C001 three-day quote at R450/day. The C++ BookingController books it using the already-verified QSaveFile-backed domain service; its R003 rental appears in the real Overview/Fleet/Rentals model.
2. Returns fictitious R001 through the existing C++ ReturnController, reconciling Overview booked totals and vehicle availability.
3. Constructs a **new** `RentalSystem(disposable.path())`, `RentalReadService` and `RentalListModel` from the **persisted actual text files**, while the QQuickWindow remains alive. This independently checks R003 remains active, R001 remains returned, Corolla C001 remains rented, Ranger C002 is available, aggregate active/history counts and R1350 active contract value are reconstructed correctly.
4. Submits the **previous reviewed Corolla quote** to a new `RentalConfirmService(reopened)`; it must return `VehicleUnavailable`, **no receipt**, and leave the byte-for-byte on-disk ledger and occupancy unchanged.
5. Confirms protected original fictional fixtures remain SHA-identical; all test mutations occur in a disposable QTemporaryDir.

The native P3 QML Booking wide/compact checks additionally enter an invalid blank customer, assert the new **inline error** and unchanged ledger/availability, then complete a real fictional booking and check the saved receipt is still visible **after dialog close**, with a real screenshot `p5-qt-booking-receipt-<size>.png`.

**Do not overclaim app restart:** The demonstration app verifies SHA-pinned source fixtures, then creates a fresh disposable temporary copy on **every new application process launch**. Reopening a *new C++ domain instance from existing files during a test process* demonstrates domain-file persistence and safe recovery, **not a UI application relaunch with durable data**. Enabling general customer-data storage or arbitrary user-provided directories would change the explicit safety boundary and is **not** part of this change.

## Executed exact-source CI

| Environment | Evidence | Result |
|---|---|---|
| Ubuntu 24.04 Core/legacy C++ | [41291060122](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41291060122) | **13/13 CTests PASS** |
| Linux GCC, native Qt Quick 6.8.3 | [41291060197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41291060197) | **45/45 CTests PASS**, both `p3_booking_qml` and `p5_overview` sizes PASS |
| Windows Server 2022 MSVC, native Qt Quick 6.8.3 | [41291060197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41291060197) | **45/45 CTests PASS**, same wide/compact cases PASS |
| Windows portable, protected fictional fixtures | Same Windows run | **PASS**: intentionally tampered source rejected |
| Windows portable P4 smoke | Same Windows run | **4/4 PASS under PowerShell 7 and separately Windows PowerShell 5.1** |
| Visual evidence | Same native run | Real Qt Quick Overview/Booking receipt screenshots included in Linux and Windows screenshot artifacts; not owner/aesthetic approval |

Actual completed job logs were read. `100% tests passed, 0 tests failed out of 45` appeared on each native platform. Existing 45 tests remained active; no assertion or data safeguard removed.

## Open gates and next milestone

P5 is **0/8 formally accepted** despite the verified small engineering increments. Actual separate-process app relaunch, production-safe explicit persistence mode, negative write failure on the complete native UI, and complete P5 rubric still remain. P4 physically verified owner acceptance remains separate and **5/7**; baseline **28/74**, **40.6% accepted-evidence coverage**, not release readiness. No new tests requested of the owner after the user's explicit preference to reduce repetitive manual testing.

Next product-focused increment: design a **demo-only, explicit durable session** for independently restarting the actual native Qt application, with strict verified fictional inputs, no silent operational data activation or arbitrary-path injection, and automated cross-process tests. Do not activate live customer files or broader storage migration (P7). Keep PR #12 draft, PR #10 unmerged, and `main` untouched.
