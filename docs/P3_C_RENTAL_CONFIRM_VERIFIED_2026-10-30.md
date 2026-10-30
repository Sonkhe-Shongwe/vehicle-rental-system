# P3-C: Typed Rental Confirmation and Save-Failure Recovery | Verification

**Current verified evidence, 30 October 2026.** [Owner-approved Qt Quick/C++ decision](P2_DECISION_AND_P3_CORE_KICKOFF_2026-10-30.md) and [interaction standard](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) remain in force. **This is backend C++ application logic, not the P5 customer-facing booking workflow, production storage approval or release.**

## Implementation and exact revision
- [Draft PR #9](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/9) on `feature/p3-rental-confirm-20261030`, stacked on [P3-B Draft PR #8](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/8), which is stacked on [P3-A Draft PR #7](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/7). **Exact C++ source SHA `d9779cd172af4fe5314b10d9c43dba9b32945164`**, including a corrected newline/CR input-validation literal fix after first commit `8881257`. Main remains unchanged.
- New `src/application/rental_confirm_service.h/.cpp` provides `RentalConfirmationRequest`, typed error or by-value `RentalConfirmationReceipt`. The explicit `confirm()` command revalidates customer text and the reviewed quote against **fresh existing C++ domain** vehicle availability, today's date, price, duration and selected ID.
- Uses a `std::unique_ptr<Rental>` until legacy `RentalSystem::createRental` independently rechecks and **commits the rental ledger using `QSaveFile`**; on commit failure no receipt is returned and memory state rolls back. A quote is only a non-mutating snapshot, never a reservation or success claim.
- The existing bool `createRental()` cannot distinguish I/O failure from last-minute domain rejection. The typed last error is intentionally **`CommitFailed`**, not an unverified promise that a specific disk error occurred. No new repository interface or SQLite layer.
- Legacy `double` rates, same-day bookings only, 1–365 days and existing incremented ID generator remain **as-is**, not a finished money/no-ID-reuse/storage solution. All customer test names and phone numbers are fictional.

## Independent source-verified results

| Verification | Outcome | Evidence |
|---|---|---|
| Qt Core/legacy Linux CTest, including new `vehicle_rental_p3_confirm` | **5/5 PASS** | [Actions run 41083939062](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41083939062) |
| Hosted Linux Qt 6.8.3 GCC full Qt Quick/legacy/P3 suite | **13/13 PASS** | [Actions run 41083938717](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41083938717) |
| Hosted Windows Qt 6.8.3 MSVC full Qt Quick/legacy/P3 suite | **13/13 PASS** | [Actions run 41083938717](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41083938717) |
| Windows portable Qt package and tampered fictional demo rejection | **PASS** | [Actions run 41083938717](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41083938717) |

New Qt Core test uses `QTemporaryDir` for invalid customer delimiters/empty values, stale date/rate/total, real successful persisted Corolla 3-day R1,350 booking and duplicate rejection, restart recovery and simulated **rental save failure** via a directory placed at `rentals.txt`. When saving fails, it checks there is **no success receipt, no active rental in memory, no rented vehicle flag and unchanged fleet file bytes**, then removes the obstacle and safely retries.

## Still unresolved or deliberately outside this slice

- No P5 guided Vehicle → Customer → Review/Confirm QML screens are wired to the new command; no UI booking confirmation or customer accessibility has been verified.
- The owner has not run **this exact revision** on local Qt Creator Qt 6.10.2 MinGW hardware. P1 whole-product visual/photos/a11y and P2 physical scale, keyboard/focus and local CTest remain separately OPEN.
- Cross-process transactional storage, immutable non-reused IDs, integer cents, persistent audit trails and AppData/SQLite decisions remain P7 tasks. A single QSaveFile ledger isn't a full data-integrity migration.
- The stacked P3 review branches **Draft PR #7/#8/#9** and P2 **Draft PR #6** are unmerged; `main` unchanged.
- **Score intentionally unchanged:** P0 5/5, P1 7/10, P2 4/6, P3 0/7 pending full P3 acceptance criteria; **16/74 and weighted 20.1%**, not percent release readiness.

**Next scoped work:** review typed command/result and integration contract for actual real rental vertical slice, with domain authority and testable failure paths. Avoid premature UI duplication or database rewrite.
