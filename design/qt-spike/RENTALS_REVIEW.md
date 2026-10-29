# Rental Management V2 | Real Qt Verification

**Checkpoint:** 29 October 2026. **Branch:** `feature/qt-hybrid-visual-spike-20261029`. **Review:** [Draft PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4). **Not merged into main.**

## Implemented in Qt Widgets

- **New Rental:** Customer/vehicle form beside a dark, high-contrast *estimated rental total* panel; current availability, vehicle rate and return date remain derived from the existing domain logic. Original same-day checkout and 1–365 day duration rules are unchanged. Confirmation is disabled until customer name and phone are nonempty; existing deeper validation remains active.
- **Rental History:** Purposeful ledger heading, record-status dropdown, retained archive/delete safeguards, and column sizing adjusted so Rental ID remains legible at 1280 px.
- **Process Return:** Clean identifier/date form, retained return confirmation and active contracts table, with no new business rules.
- All three use the established graphite, warm white and restrained lime visual language. Fleet and Dashboard remain preserved.

## Actual Qt screenshots

| Screen | 1500 x 860 | 1280 x 720 |
| --- | --- | --- |
| New Rental | [Full](rent-qt.png) | [Small](rent-small-qt.png) |
| History | [Full](history-qt.png) | [Small](history-small-qt.png) |
| Return | [Full](return-qt.png) | [Small](return-small-qt.png) |
| Dashboard | [Full](dashboard-qt.png) | [Small](dashboard-qt-1280.png) |
| Fleet | [Full](fleet-qt.png) | [Small](fleet-qt-1280.png) |

These are screenshots of the **compiled Qt Widgets executable**, not HTML mockups.

## Verified checks

**Passed:** [Ubuntu 24.04 Qt6 visual workflow 40914456325](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40914456325) using five fictional vehicles and two fictional rental records, including CMake configure/build, CTest, ten distinct-size screenshots, PNG/dimension verification, and non-destructive checks:

- Existing rented Ford Ranger (C002) does not generate an available rental quote.
- Available Corolla (C001) at R450/day for three days produces **R1350.00**.
- Confirm button disabled when customer details empty; enabled after sample fields are entered. No rental is actually created.
- History filtering: 2 current, 1 active, 1 returned, 0 archived, and 2 after reset.
- Return page shows 1 active contract (R001). Test enters the identifier but does not complete a return.
- Existing Dashboard/Fleet geometry assertions still run. The new rental panels were manually inspected from screenshots after an earlier pre-render geometry check produced false positions; do **not** claim a geometry assertion for rental pages.

## Open gates

- Windows Qt Creator visual check, keyboard navigation, resizing at Windows 100/125/150% scale.
- End-to-end add/rent/restart/return/archive persistence verification on a disposable dataset.
- Owner visual sign-off and more premium photographic assets (especially Ford; two motorcycles still missing).
- Monolithic MainWindow refactor, SQLite and API are future milestones, not completed here.

**Important:** Do not merge Draft PR #4 until user acceptance and Windows tests. Stable `main` remains unchanged. No real customer data, payment processing or deployed web API is involved.
