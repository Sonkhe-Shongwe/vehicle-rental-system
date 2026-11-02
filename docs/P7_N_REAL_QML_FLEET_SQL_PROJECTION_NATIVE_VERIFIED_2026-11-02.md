# P7-N | Real Qt Quick Fleet projection from generated-fictional normalized SQLite

**2 November 2026. Exact tested source:** [P7-N `739f1d2`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/739f1d27e09df08010d4d41d4d8f9f73f7f55128). This remains the separate OFF-by-default P7 generated-fictional **test executable**, not a switch of normal Rental Studio QSaveFile storage. No real customer, phone, licence, payment or file import input is introduced.

## Engineering integration closed

The previous isolated P7-I–M Qt Quick review displayed real committed Rentals KPIs through the shared production-facing `RentalListModel`, but the Fleet banner was hard-coded fictional example text; Fleet's typed SQL projection was only inspected in C++ assertions. The P7-N preview now actually binds **vehicle details and C++-derived availability** to real Qt Quick content.

- New `src/application/p7_sandbox/fictional_fleet_snapshot.h`: a value-only `QObject` read adapter, depending exclusively on a validated `std::optional<QList<FleetVehicleSummary>>` provider, with QML-readable `snapshotAvailable`, `vehicles`, `totalCount` and `availableCount`.
- The preview harness provider uses `ReadProjection::fleet()`, which gets vehicle and active-rental occupancy within the **single read transaction** implemented in P7-L. It exposes no SQL objects, paths, contacts or mutable Vehicle pointers to QML. Display money is derived from cents as an explicit display-only legacy double; canonical storage remains integer cents.
- After each successful SQLite COMMIT, the already existing `PreviewController::committed` signal refreshes both the shared Rentals model and Fleet model. A preview quote or rejected COMMIT does not emit it.
- On Fleet provider read failure, the new adapter retains its last known-good rows for comparison but marks `snapshotAvailable=false`; the QML Fleet label and totals visibly withhold stale values. A real `Retry Fleet read` button invokes `refresh()`; only a successful read publishes current metrics again.
- The fictional preview is now 880×720 to accommodate visible Fleet status, with no change to the normal Qt Quick 1500×860 / compact 1280×720 interface.

## Native regression evidence

Source [`739f1d2`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/739f1d27e09df08010d4d41d4d8f9f73f7f55128):
- [Core C++ 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41486126096).
- [Qt 6.8.3 Linux GCC **113/113 PASS** and hosted Windows MSVC **113/113 PASS**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41486126451), including existing native `rental_studio_p7_qml_journey`, `_rollback`, `_read_model` CTests. Hosted Windows packaged PowerShell 7 and 5.1 checks PASS.

The genuine QML harness verifies initial `1 total/1 available`, no Fleet refresh from uncommitted quote or rejected booking, `0 available` after booking, `1 available` after return, `0 available` after confirmed retirement, and consistent archived history after independent reopen. It injects a fixed provider fault, requires no false `snapshotChanged`, last-known-good rows unchanged, stale figures concealed and visible Retry, then clicks the **actual QML button** to restore verified availability. No new CTest was added; the existing QML scenarios were made more demanding.

## Scope, acceptance and next decision

The read-only Fleet adapter is **not** the complete production FleetModel or full parity with the normal Gallery/Table/Inspector. The separately generated preview is not the normal application. Current normal QML still uses protected fictional QSaveFile files, with P7 SQLite off by default. This does not grant commercial storage, real PII, migration, backup policy, release or installer approval. It does not substitute for owner Qt Creator 6.10.2 MinGW, 100/125/150% physical scaling, Narrator or operator signoff.

Owner still must review [P7 D1–D8 decision brief](P7_OWNER_DECISION_BRIEF_2026-11-02.md), especially monetary ceilings, historical-ID/retention, purpose-limited contacts, backups and cutover policy before any normal-application storage integration. **Formal score remains 28/74 accepted and 40.6% weighted; P5 0/8, P6 0/9, P7 0/8; P8/P9 unstarted; draft PRs unmerged and main untouched.**
