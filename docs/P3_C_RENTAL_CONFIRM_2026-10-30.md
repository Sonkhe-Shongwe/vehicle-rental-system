> **VERIFIED P3-C SOURCE at `d9779cd172af4fe5314b10d9c43dba9b32945164`:** [Full Qt native Actions 41083938717](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41083938717) **Linux 13/13 + hosted Windows 13/13 CTests**, Windows portable and fictional-fixture checks PASS. [Standalone Linux core 41083939062](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41083939062) **5/5 CTests PASS**. [Complete evidence and limits](P3_C_RENTAL_CONFIRM_VERIFIED_2026-10-30.md). This **does not** mean P3 gate fully accepted, P5 workflow built or user's physical Qt Creator retested. P2 4/6, P3 0/7, 16/74, 20.1% weighted remain unchanged.

# P3-C | Typed Rental Confirmation and Persistence-Failure Handling

**Scope:** isolated [P3-C source branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/feature/p3-rental-confirm-20261030), stacked on [P3-B Draft PR #8](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/8), with existing P3-A and Qt Quick P2 foundation unmerged. **No new QML screen, P5 complete journey or SQLite migration.**

## Actual command
- `RentalConfirmService::confirm(RentalConfirmationRequest)` accepts a **previously reviewed quote**, fictional customer name and phone only when an explicit caller invokes the command.
- Rejects blank/unsafe customer values, invalid quote fields, missing/rented vehicle, stale/tampered quote price/days/dates. It recomputes the **fresh** quote using the authoritative `RentalSystem` and actual current date before persisting; a preview by itself is NOT a booking.
- `RentalSystem::createRental` remains the only commit writer: it independently revalidates occupancy, same-day 1–365 day dates and actual price, atomically commits **rentals.txt** using QSaveFile and rolls back the in-memory rental list and flag on failure.
- On success return a small by-value `RentalConfirmationReceipt`. On any failure return a typed error with **no receipt**, never display optimistic success. Since the legacy bool return does not distinguish persistence from concurrent/last-minute validation, the last error is safely named **CommitFailed**, not falsely guaranteed to be storage-only.
- Use `std::unique_ptr<Rental>` until legacy domain accepts ownership, protecting failed commit paths.
- Preserve money as explicitly **legacy double** and the existing ID generator. Durable no-reuse IDs, integer cents and unified storage migration belong to P7, not this slice.

## Source-level verification cases
A Qt Core-only disposable `QTemporaryDir` test covers valid Corolla R450 × 3, bad customer/phone, fabricated/stale day and rate, duplicate booking, genuine persisted receipt, restart reconstruction, and **forced QSaveFile failure** by placing a directory at `rentals.txt`. On the failed save, assert no success receipt, no rental in memory, no rented flag, unchanged vehicle data; then remove the blocker and safely retry. All existing domain, Fleet P3-A, quote P3-B, QML/UI and packaged-demo regression suites remain enabled.

**No real customer information is logged or used.** This is deliberately scoped demonstration/test-only application service. It does not claim all cross-file storage conditions are transactional or that the finished P5 UI already uses the command.

**Approval and milestone constraints:** Qt Quick/C++ direction is owner-approved. P1 and P2 remaining actual Windows and visual gates OPEN. At branch creation **P0 5/5, P1 7/10, P2 4/6, P3 0/7, weighted 20.1%**; individual P3 checks change only after actual source tests and acceptance review. Stable `main`, PR #6/#7/#8 remain unmerged.
