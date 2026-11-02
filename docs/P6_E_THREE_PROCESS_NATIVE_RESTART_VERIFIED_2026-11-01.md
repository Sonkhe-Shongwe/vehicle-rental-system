# P6-E | Three-process native Fleet and Rentals restart verification

**Date:** 1 November 2026. **Product:** Rental Studio. **Exact tested source:** `7fe971d9397d8f19388696ceb5a7ac8e5ce71845`. **Development:** Draft [PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), stacked on unmerged P5 Draft #12 and P4 Draft #10. No merge or stable main changes.

## What was verified

Two new CTests, `rental_studio_p6_cross_process_wide` and `_compact`, each launch **three actual separate copies** of the real Qt Quick application, with separate C++ domains and independent process lifetimes, at **1500×860** and **1280×720**:

1. **First process:** opens Fleet, adds fictional Car C004 and Motorcycle M003 through real keyboard-activated QML dialogs, archives existing returned fictional rental R002 in Rentals, commits through the authoritative C++ domain to an isolated temporary fixture, and exits. This tests the intended **4-door** Car default.
2. **Second process:** reopens the exact files from its predecessor, reconstructs both added vehicle records and archived rental, verifies the active/archived references, uses native Rentals to delete R002 only after the exact `DELETE R002` phrase, then uses the real Fleet confirmation modal to remove unreferenced C003 and now-unreferenced C001 with exact `REMOVE <ID>`. The active R001/C002 reference is retained.
3. **Third process:** reopens independently and checks the reconstructed Fleet count (5), availability (4), Rentals count (1), Active count (1), History count (0), remaining vehicles C002, M001, M002, C004 and M003, absent C001/C003 and R002, Overview active metric, and active-rental refusal to remove C002. Navigation does not write to the ledgers.

The parent process owns a unique `QTemporaryDir` for each test; it copies only **build-time SHA-pinned demo fixtures**, supplies **no arbitrary data-directory CLI option**, and removes the fixture after the test. Each child uses its verified temporary working directory, a fixed test-only marker, no symlinks/foreign files and **stage-specific exact fictional record allowlists** before constructing the domain. The original checked-in demo files must remain byte-for-byte identical. The P5 fixed synthetic persistent session, its separate allowlist and single-writer lock are unchanged.

## Additional actual UI bug fixed

During initial testing, the Add Car dialog's first-open Qt SpinBox unexpectedly committed **8 doors** despite the intended 4-door default. The real `FleetAddDialog.qml` now sets type-specific defaults after the SpinBox's dynamic bounds finish initializing: **4 doors for Car** and **450 cc for Motorcycle**. The first-process native regression asserts the 4-door value before saving. This was a genuine UI correction, not merely a changed test expectation.

## Actual CI, including initial failures

| Gate | Evidence | Result |
|---|---|---|
| Core C++ tests, exact source `7fe971d` | [Run 41344420812](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41344420812) | **13/13 PASS** |
| Qt 6.8.3 Linux GCC native | [Run 41344420876](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41344420876) | **68/68 PASS**, both three-process wide/compact PASS |
| Qt 6.8.3 hosted Windows MSVC native | Same run | **68/68 PASS**, both three-process wide/compact PASS |
| Packaged Windows P4 safeguard | Same run | **PASS** on PowerShell 7 and Windows PowerShell 5.1. Physical owner Qt Creator/Narrator and 100/125/150% OS scaling NOT TESTED |

The first newly added source tests failed **2/68** on Linux and Windows at the strict second-process allowlist. Diagnosis using only row positions and hashes identified the actual first-open **8-door** Car value; the protected rental ledger already matched expectation. Fixed the QML control and added an explicit UI assertion. The final **exact source** passed all 68 native tests on both operating systems. Do not silently relabel the initial failed/superseded commits as passing or imply earlier native runs validated this final feature.

## Acceptance interpretation and remaining gap

This provides representative native automated evidence for **provisional P6 group #8: restart and reconstruct state**. The P6 diagnostic matrix can now state **8 automated-covered, 0 partial, 1 open (full lifecycle parity)**. The original P6 roadmap does not independently number nine acceptance criteria, so this is **not** a ratified rubric, **not** formal P6 acceptance and **not** commercial release readiness.

**Official acceptance remains P4 5/7, P5 0/8, P6 0/9, overall 28/74 and 40.6% weighted evidence.** Remaining: formally define the nine P6 checks, audit full Qt Quick / legacy feature parity (#9), choose a non-destructive commercial vehicle retirement and historical rental retention model, and keep P7 production storage/migration, P8 licensing/packaging/privacy and P9 owner physical/release gates separate. The fixed persistent fictional session continues to forbid Fleet mutations; no real customer records have been enabled.
