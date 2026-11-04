# UX-S13 | Read-only rental and vehicle ID search in fictional SQLite Lab

**Date:** 4 November 2026 (Africa/Johannesburg).  
**Exact compiled native-verified source:** [`d457dbc91dca412d78e117e0418aa863255b581a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/d457dbc91dca412d78e117e0418aa863255b581a).  
**GitHub Actions:** [run 41784726411](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41784726411), **COMPLETED SUCCESS**.  
**Branch:** `feature/p7-sqlite-sandbox-20261102`, stacked draft PR #17 on P6 PR #14. No merges.

## Operator functionality

The fictional SQLite Lab already included a searchable read-only Fleet explorer, but its Rental Contracts explorer could only filter by lifecycle status and select visible rows. The operator had to visually scan to find a contract. This increment adds a true, read-only search by **rental ID or vehicle ID**, case-insensitive, without introducing a new SQL/PII query, commercial booking surface or source-file mutation.

The search is bound directly to the **existing C++ `RentalListModel`**, the same model used by the protected fictional Rentals interface, so QML does not implement its own business filtering.

## Bounded implementation

- `src/application/rental_list_model.h/.cpp`: new `searchText` Qt property, setter and `searchTextChanged` notification. The term is trimmed and bounded to 80 characters; filtering matches only `rentalId` or `vehicleId` case-insensitively. No customer name/phone or commercial data is queried or exposed.
- `filtered()` combines the existing native C++ lifecycle filter (`All`, `Active`, `Returned`, `Archived`, `History`, `Overdue`, `DueToday`) with the optional identifier search. A hidden selected contract is cleared by **stable ID**, and Qt reset/count/selection/contract notifications fire as appropriate.
- The full authoritative rental snapshot still drives all operational counts, overdue/due metrics and booked-value figures. A zero-result search does **not** imply an empty ledger or reduce those whole-snapshot KPIs.
- Existing `locateById()` and `locateActiveReturn()` now clear search text only when necessary to reveal a confirmed matching target. Unknown IDs remain nonmutating lookup failures. The separate Return service retains its domain validations.
- `spikes/qtquick_p2/P7FictionalSqlLab.qml`: new `p7AppRentalSearch` `TextField` next to the Rental Contracts lifecycle filter, usable at wide and compact desktop sizes. It is disabled during unavailable provider snapshots, so a failed read cannot expose stale role data. The input and state remain read-only and generated-fictional-only.
- No production QtSql cutover, domain transaction, schema migration, contact storage, payment, image/catalogue, P7 D2-D8 decision or public release scope changed.

## Native regression coverage

- `tests/p3_rental_model_tests.cpp`: case-insensitive vehicle and rental ID matching, trimmed queries, combined lifecycle and search filtering, hidden stable selection clearance, unknown-ID empty results, unchanged total KPIs, explicit successful ID/active-return reveal, identical fleet/rental source file bytes and retained search across failed provider read / recovered snapshot.
- `spikes/qtquick_p2/main.cpp`: genuine native Qt P7 actual-application wide (1500×860) and compact (1280×720) tests drive the new QML field, verify a zero-match query hides selection without changing Overview totals, vehicle-ID `C001` and rental-ID `R001` searches find archived R001, status filter composes with the search, read outage disables the input and C++ selection, and successful retry restores the still-filtered verified contract.
- No test disabled or removed; 123 registered CTests on each CI platform.

## Failed intermediate test runs, honestly distinguished

The first source [`75a41236`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/75a412369f94b240851bc9c5868ba4ae9771a185) produced [run 41783043643](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41783043643), with one native test #7 failure on each platform because the new test incorrectly searched `C003` for fictional motorcycle R003, whose actual vehicle ID is `M001`. The real P7 app QML tests #14/#15 passed on Linux in that run.

The second source [`89386771`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/893867710b5ddb012bd9312faca72ba7a0ec5724) corrected that test fixture. [Run 41783838941](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41783838941) then failed only native model test #7 on both platforms because the pre-existing read-outage test expected zero Qt model resets, not accounting for the deliberate new search reset before the outage. The application/QML P7 tests #14/#15 again passed on Linux. This was corrected by comparing with the **captured pre-outage reset and metrics counters** in the final source `d457dbc91dca412d78e117e0418aa863255b581a`. Neither intermediate run is passing evidence.

## Exact-source verification

[GitHub Actions 41784726411](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41784726411) **COMPLETED SUCCESS** at `d457dbc91dca412d78e117e0418aa863255b581a`:
- **Ubuntu 24.04 GCC / Qt 6.8.3:** **123/123 genuine CTests PASS**, zero failures, **158.47 seconds**. Rental model #7 and genuine actual-application P7 Lab wide #14/compact #15 PASS.
- **Hosted Windows Server 2022 MSVC / Qt 6.8.3:** **123/123 genuine CTests PASS**, zero failures, **179.23 seconds**. The same new C++ and actual wide/compact Qt UI tests PASS.
- **Hosted relocated Windows portable executable:** **8/8 real fictional app functional checks PASS**. P2/P4 package automation, PowerShell 7 and Windows PowerShell 5.1 verification PASS.
- Generated artifacts expire **11 November 2026**: [portable Windows physical acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41784726411/artifacts/13301292096), [Windows native Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41784726411/artifacts/13300808149), [Linux native Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41784726411/artifacts/13300997190).

Hosted automated verification **does not** constitute physical owner Windows/MinGW acceptance, display-scaling or Narrator validation.

## Decisions and gates unchanged

**Formal owner acceptance remains 45/74, weighted 70.6%; P7 0/8.** P7 SQLite Lab remains an opt-in **isolated, generated-fictional-only** engineering sandbox, not a commercial persistence implementation. Owner P7 D2-D8 decisions for real data/privacy/security/retention/backup remain unapproved. Physical UX-S1 Rentals scrolling/focus, Qt Creator/MinGW, scaling 100/125/150%, Narrator, P8 installer, P9 release, draft PR merges and public launch are OPEN. Final Fleet Population/Photos and image licence review remain **LAST**.

Documentation-only commits after `d457dbc91dca412d78e117e0418aa863255b581a` are not separately compiled.
