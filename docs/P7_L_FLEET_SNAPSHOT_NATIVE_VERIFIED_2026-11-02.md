# P7-L | Consistent Fleet vehicle-and-rental SQLite snapshot, native verified

**2 November 2026. Exact compiled source:** [P7-L `3108849`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3108849ab571c63355ca87703e307a6b22f9bc85). **Verified:** [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41477526035) and [native Qt 6.8.3 Linux/hosted Windows 112/112 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41477526173) both PASS; hosted Windows packaged PowerShell 7 and 5.1 PASS. This is an OFF-by-default generated-fictional-only SQLite proof. **It is not the normal Rental Studio runtime or an approved commercial database.**

## Problem prevented

The P7-J read projection previously retrieved `Repository::vehicleRows()` and `Repository::rentalRows()` as separate SQL reads. A concurrent return, booking or retirement committed between the two reads could cause Fleet availability to combine vehicle state and rental state from different moments.

## Implemented improvement

- Add typed value-only `FleetRows` containing both validated collections.
- `Repository::fleetRows()` wraps the two SQL reads in one SQLite **BEGIN deferred read transaction**, committing only after both have loaded. Failed transaction/read/commit rolls back and returns `nullopt`, not partial rows.
- `ReadProjection::fleet()` now derives availability only from that consistent collection.
- Add a **fixed test-only inter-read hook**, invoked in the opt-in sandbox by a second, independent database connection. Its attempted rental return is refused while the snapshot is held; after the read finishes the return commits successfully. The next snapshot reflects the returned contract. No new user-visible callback or customer-data path exists.

## Verified source CI

| Platform | Result |
|---|---|
| Linux C++ core [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41477526035) | **13/13 PASS** |
| Linux GCC Qt 6.8.3 [native Qt 6.8.3 Linux/hosted Windows 112/112 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41477526173) | **112/112 native CTests PASS** |
| Hosted Windows MSVC Qt 6.8.3 [native Qt 6.8.3 Linux/hosted Windows 112/112 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41477526173) | **112/112 native CTests PASS** |
| Hosted Windows packaged PowerShell 7 / 5.1 | **PASS** |

The newly added `rental_studio_p7_normalized_fleet_snapshot` is native test **#109/112**. All previously existing tests remain enabled; QML tests are now #110–112. These tests verify software-level snapshot consistency, not physical power-loss safety.

## Strict boundary and remaining gates

No QtSql cutover in normal `Main.qml`, real customer/contact/licence data, production file path, arbitrary import, backup activation, general migration or commercial storage rights. Actual Windows owner Qt Creator 6.10.2 MinGW, 100/125/150% physical scaling, Narrator and operator signoff remain untested. The P7 SQLite/privacy/retention/money/IDs/backup/migration ADR still requires owner approval.

**Formal ledger remains P5 0/8, P6 0/9, P7 0/8, programme 28/74 accepted and 40.6% weighted.** P8/P9 unstarted, all draft PRs unmerged, main untouched. Next gate is owner-ratified P7 architecture and business/privacy policy before normal-app storage integration.
