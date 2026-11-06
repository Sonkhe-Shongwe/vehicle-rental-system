# Rental Studio 2.0 | Editorial Contrast R2 Rentals Phase 1A | Native verified | 2026-11-06

## Scope and evidence standard

This report verifies the exact pre-polish executable source `9acc241d0ad153a38a9094ccbb05d8665d040994` on `feature/p7-sqlite-sandbox-20261102`. It does **not** grant owner visual acceptance, approve a release, merge any PR, or activate persistent production storage. The app remains offline-first and fictional-only; C++ owns rentals, dates, selected IDs, due state, booked value, confirmations and persistence.

## Exact-source native results

- **Run:** [GitHub Actions #42272843229](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42272843229), status **completed SUCCESS** against precisely `9acc241d0ad153a38a9094ccbb05d8665d040994`.
- **Linux GCC / Qt 6.8.3:** **142/142** real CTests PASS, including compact Rentals scroll #56 and both filters #59/#60.
- **Windows MSVC / Qt 6.8.3:** **142/142** real CTests PASS, including scroll #56 and filters #59/#60. Windows packaged fictional-app **8/8 PASS** and Windows PowerShell 5.1 P4 verification **PASS**; the package test notes that physical Windows scaling remains untested.
- **Actual compiled screenshots:** [Windows artifact #13532887672](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42272843229/artifacts/13532887672), [Linux artifact #13533331825](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42272843229/artifacts/13533331825), Windows physical-test kit [#13531958328](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42272843229/artifacts/13531958328).
- **Inspected screenshot images on both operating systems:** `p3-qt-rentals-1500x860.png`, `p3-qt-rentals-1280x720.png`, `pa-rentals-004-controls-1500x860.png`, `pa-rentals-004-controls-1280x720.png`, `pa-rentals-004-register-1500x860.png`, `pa-rentals-004-register-1280x720.png`, and compact scrolled `ux-s1-rentals-bottom-1280x720.png`. Images are delivered as workflow artifacts, not duplicated as binary Git blobs.

## Native visual QA observations

The app uses R2's charcoal navigation, light workspace, mint selected section and white informational cards, rather than the older all-light-sidebar concept. Rentals has a short editorial heading, four C++-backed metrics (including **contractual active booked value, not payments**), an integrated left contract register (~62%) and an evergreen right selected-contract inspector (~38%). The status/due/search controls are inside the register, not a disconnected panel. Initial screenshots show real fixture R001/C002 active and overdue and R002/C001 returned; the selected row is mint and selection details use C++ identity and status. Inspector imagery is labelled as model reference, not a photo of the actual rental vehicle. Action enablement remains contextual and tested; all returned/archive/delete flows retain their prior C++ validation and confirmation paths.

At **1500x860** the four cards and both records are visible above the fold; the selected inspector and register align and lower controls are accessible. At **1280x720** the two records and inspector remain readable; the content scrolls to the lower action, and real #56 compact scroll test passes across both operating systems. Linux and Windows font rendering differ slightly but retain the structural hierarchy and no missing workspace controls were observed.

This is a structural match, **not pixel-perfect or final luxury finish**. The source-tested KPI typography and icon presentation remained modest, booked money lacked digit grouping, the hero vehicle photo remained quite dim, and wide-height register affordance deserved further refinement. The original full-resolution [R2 visual master](../design/r2/EDITORIAL_CONTRAST_VISUAL_MASTER_2026-11-06.md) companion ZIP is **not** in GitHub; do not claim image-diff parity. The user-supplied light-sidebar Overview screenshot is a high-quality aesthetic benchmark, but the **later selected R2 dark-sidebar override** remains governing.

## Bounded follow-up

A separate source commit [`36cce285`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/36cce2854114835c5bf46ce60fd6b03c9a427b55) improves KPI size/spacing/icon tile, title typography, vehicle-image legibility, wide register fit and QML currency formatting via an existing presentation helper. This source is **not** part of the verified `9acc241d` artifact. It must independently pass [Actions #42276745140](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42276745140), yield native screenshots at both sizes on both operating systems, and receive visual review before being promoted.

Previously observed regressions remain recorded: first R2 commit `7dc099a` failed the filter tests on Windows and Linux and compact scroll on Linux; intermediate `f70f63c` restored the filter count (Windows 142/142, Linux 141/142) but retained compact scroll failure. `9acc241d` repaired these without changing or weakening those tests.

## Still open

Physical Qt Creator 6.10.2 MinGW launch and genuine Windows 100/125/150% DPI and Narrator checks, owner signoff on Overview/Fleet/Rentals separately, original approved visual source ZIP/photography review, and final cohesion. Do not change source data, assume a release or merge draft PR #17. Owner formal acceptance remains **45/74, weighted 70.6%, P7 0/8**.
