# P3-B | Verified Read-Only Rental Quote Preview

**Date:** 30 October 2026. **Evidence status:** SOURCE COMMITTED / HOSTED NATIVE CI PASS. **Not owner local Windows Qt Creator acceptance; not real booking.**

## Exact code and boundaries
- [Draft PR #8](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/8), stacked on unmerged [P3-A Draft PR #7](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/7), branch `feature/p3-rental-quote-20261030`. Code SHA [`f8289567eb3da16ca13acc9d8a449f57cbea0e69`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f8289567eb3da16ca13acc9d8a449f57cbea0e69).
- `RentalQuoteService` is an **independent, read-only C++ application boundary**. Typed errors: invalid duration, unknown vehicle, unavailable, invalid/overflow price, invalid date. Return by-value preview with authoritative C++ vehicle rate, same-day immediate-only start, 1–365 days, expected return date and **R450 × 3 = R1,350** for fictional Corolla. Injectable date callback permits deterministic test without global framework.
- Legacy money remains `double`, explicitly named `legacyDailyRate` and `legacyTotal`. Price and occupancy must be **revalidated at real `RentalSystem::createRental` time**; quote does not reserve a vehicle or authorise a booking. No Qt/QML changes, real customer data, source-adjacent data migration, SQLite, future reservation, payment or API.
- `tests/p3_rental_quote_tests.cpp` uses `QTemporaryDir` to prove normal quote, trimmed/case-insensitive ID, missing/rented, 0/366-day, 365-day boundary, invalid date, total overflow, no file mutation and existing domain booking acceptance/duplicate refusal.

## Native evidence (exact SHA)
| Check | Result | Source |
|---|---|---|
| Linux Qt Core standalone/legacy CTests | **4/4 PASS** | [Actions 41074601176](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41074601176) |
| Linux Qt6.8.3 GCC complete P2/P3 suite | **12/12 PASS** | [Actions 41074601145](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41074601145) |
| Windows Qt6.8.3 MSVC complete P2/P3 suite | **12/12 PASS** | [Actions 41074601145](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41074601145) |
| Windows portable Qt kit and fake-fixture tamper refusal | **PASS** | [Actions 41074601145](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41074601145) |

## Explicitly open
- P3 typed commands/results, rental workflow/transaction, central repository/Clock seam, QML read/write integration and other **full P3 acceptance criteria** remain unaccepted. A read-only quote is not a saved rental.
- P1 finished design/images/accessibility acceptance and P2 real owner physical Qt6.10.2 MinGW exact SHA/CTest, supported screen scale, keyboard and resizing follow-up remain open.
- **Project accounting remains P0 5/5, P1 7/10, P2 4/6, P3 0/7, 16/74 and weighted 20.1%.** This is evidence coverage, not release readiness.
- Stable `main` is untouched and Draft PRs #6, #7, #8 remain unmerged.

## Next practical engineering step
Review both isolated P3 services and define a small typed **real rental command/result** that revalidates at transaction time, with safe negative and persistence-failure handling. No P5 UI flow or P7 database conversion until their respective milestones.
