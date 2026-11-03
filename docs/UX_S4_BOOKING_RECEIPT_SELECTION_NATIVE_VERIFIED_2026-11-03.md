# UX-S4 | Booking receipt selection from filtered Rentals

**Date:** 3 November 2026  
**Exact compiled and native-tested source:** [`44a03893deff25d136748aa58b2a1fdf6f990afa`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/44a03893deff25d136748aa58b2a1fdf6f990afa)  
**Functional implementation:** [`9e71453539fc9bd4eff87bf5d8e2aea551721e03`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9e71453539fc9bd4eff87bf5d8e2aea551721e03)  
**Native evidence:** [GitHub Actions 41717444131](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41717444131), **completed SUCCESS**.  
**Scope:** Existing fictional-only C++/Qt Quick rental flow; stacked draft PR #17, no merge.

## Reproducible operator gap

After a successful booking, `RentalBookingController::confirm()` refreshed the authoritative rental list, then called `selectById(receiptId)`. That operation only selects an ID already visible under the current status filter. A user booking while viewing `History`, `Overdue` or `DueToday` could receive a successful receipt while the new active contract remained hidden and unselected. This was a concrete post-commit navigation inconsistency, not a persistence failure.

## Smallest bounded correction

- `src/application/rental_booking_controller.cpp`: after the domain successfully commits and the rental/fleet reads refresh, call the already implemented `RentalListModel::locateById(receiptId)`. If the newly created contract is hidden, this read-only lookup switches the list to `All` and selects the persisted ID; if visible, it keeps the existing filter. No return, book, price, contact, policy, or storage logic was changed.
- `tests/p3_rental_booking_controller_tests.cpp`: before the existing simulated QSaveFile failure and retry, select `History`, prove it hides all active rental records and disarms selection; prove failed confirmation preserves `History` without a new selection; prove the subsequent successful commit reveals `R002`, selects its stable row, and provides its read-only selected contract. Existing stale-quote, rollback, persisted-byte and restart assertions remain intact.
- `.github/workflows/p2-qtquick-review.yml`: branch fallback now includes `src/application/**` and `tests/p3_*.cpp`, ensuring application-only fixes and P3 tests cause the cross-platform build even if a stacked draft PR synchronize event is not delivered. Workflow checks still use existing native CTests, actual Qt smoke and packaged verification.

## Exact-source validation

- **Ubuntu 24.04 / GCC / Qt 6.8.3:** **123/123 CTests passed**, zero failed, total CTest time **150.23 seconds**; `vehicle_rental_p3_booking_controller` **test #10 passed**.
- **Hosted Windows Server 2022 / MSVC / Qt 6.8.3:** **123/123 CTests passed**, zero failed, total CTest time **184.03 seconds**.
- **Hosted Windows portable executable:** **8/8 actual fictional application functional checks passed**, including wide/compact lifecycle and cancellation/retry cases, with original fixtures intact.
- **Hosted Windows PowerShell:** P2/P4 packaged checks passed using both PowerShell 7 and Windows PowerShell 5.1.
- No change was made to QML visual geometry, so this increment does **not** claim a separate dedicated on-device screenshot of the History-to-booking selection transition. Native C++ controller coverage verifies this change; physical Windows operator interaction remains an independent gate.

## Acceptance and boundaries

The owner-approved P5 8/8 and P6 9/9 remain unchanged. **Formal programme 45/74 criteria, weighted 70.6%; P7 0/8** unchanged by automated regression. Physical owner UX-S1 scrolling retest, Qt Creator / MinGW, actual Windows scaling at 100%/125%/150%, Narrator, real-data P7 D2–D8 policies, operational backup/restore, P8 installer, P9 release, all merges, and final fleet population/photography remain open. No real customer/contact records, general persistence cutover or new image acquisition was authorized.

The documentation-only commit following `44a03893` is not another native-tested compiled source.
