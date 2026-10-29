## Accessibility regression for rental ledger | 29 October 2026

A status-text legibility defect was corrected within the existing Qt visual acceptance milestone: [`c5c1e78`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c5c1e7885c80c3b7f88c0b40adf891fb2d9a2c91) changes available/returned, rented and archived table status colours to AA-conformant darker tokens, with new GUI lifecycle assertions enforcing at least 4.5:1 against both real Qt table background colours. All normal rental safety checks remain in place. **Verified:** [Ubuntu Qt6 40932934420](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40932934420) and [Windows MSVC Qt6.8.3 40932934337](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40932934337) both compiled and passed CTest 2/2, including real Qt lifecycle persistence; 10 Linux real-Qt captures / 12 Windows offscreen DPI/screenshot checks also passed. No full interactive Windows/manual acceptance yet.

## Follow-up Windows real-Qt verification | 29 October 2026

[Windows Qt6/MSVC 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521) on source `aaf2cee`: **PASS** Qt build, CTest **2/2** including the new full GUI lifecycle regression in an isolated data directory, plus ten compiled-Qt captures at 1500x860/1280x720 and two synthetic DPI cases. These are automated offscreen checks, not actual Qt Creator keyboard/mouse usage or final visual approval. Previous "Windows pending" state below was written before the run finished. Owner approval and physical Windows scaling remain open.

## 29 October 2026: real Qt lifecycle regression improvement

The initial Rental Management screenshot proof did not click through persistent transactions. A subsequent increment added a **new real Qt Widgets GUI integration test**, with explicit test data directory injection in `MainWindow` for safety, unique control object names and guarded handling of expected confirmation dialogs. It checks Add Vehicle, customer gating, live quote, Rent, duplicate-rental blocking, closing/reopening the Qt GUI without rewriting original files, Return and repeated-return rejection, premature archive/delete refusal, archive, and deletion persistence.

**Verified Ubuntu 24.04 Qt6:** `aaf2cee`, [run 40931662760](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931662760), CMake build and CTest **2/2 passed**. The earlier `fdecb35` run failed compilation and is preserved as failed evidence, then corrected without suppressing tests. **Windows result for same new test remains unverified pending run 40931645521.** This is offscreen UI automation, not manual Windows or approved visual quality.

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
