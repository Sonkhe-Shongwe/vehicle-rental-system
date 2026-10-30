# P3-I | User-confirmed rental return through C++ domain | Verified

**Date:** 30 October 2026. **Repository:** `Sonkhe-Shongwe/vehicle-rental-system` (private).
**Exact tested source:** [`eb096817ca8b34fd590d23978e34a9007e7104a6`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/eb096817ca8b34fd590d23978e34a9007e7104a6), branch `feature/p3-rental-confirm-20261030`, Draft PR #9 stacked on drafts #8/#7/#6; stable main untouched.

## Bounded change

- `src/application/rental_return_controller.h/.cpp`: typed `RentalReturnError` (`MissingRental`, `NotActive`, `InvalidReturnDate`, `CommitFailed`) and `RentalReturnResult` returned by `RentalReturnService`. It preflights current authoritative `RentalReadService::recordById`, uses injected Today for validation, and calls **only** `RentalSystem::completeRental` for durable domain mutation. It does not create an alternative file writer or falsely classify ambiguous legacy commit failure as an I/O-only error.
- `RentalReturnController` is a Qt Core QObject with `canReturnSelected`, status text and `returnSelected()` for selected **visible** rental ID. C++ checks live status again, commits through the existing legacy `QSaveFile` transaction, and only then calls RentalListModel::refresh plus the caller-provided FleetController::refreshAfterCommit callback. Failures never refresh or emit success, and the UI sees no customer name or phone.
- `spikes/qtquick_p2/Main.qml` provides an accessible **Return selected rental** button with modal confirmation and separate Cancel/Confirm controls. It does not compute dates/prices, write files or expose customer contacts. Booking, archive, payment, editing and operational storage paths remain absent.
- Only the opt-in Qt Quick proof can mutate its own disposable copied SHA-256 pinned `demo/vehicles.txt` and `demo/rentals.txt` fixture data. `main.cpp` preserves source hash checking and no user-selected filesystem path.
- Adds Qt Core `vehicle_rental_p3_return_controller` CTest and real native `rental_studio_p3_return_qml_wide`, `_compact` screenshot/interaction tests; no Qt Widgets target change.

## Independently executed source verification

| Environment | Actual result | GitHub evidence |
| --- | --- | --- |
| Ubuntu Qt Core + existing legacy/domain suites | **9/9 CTests PASS** (new return controller included) | [run 41107908823](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41107908823) |
| Linux GCC Qt6.8.3 native Qt Quick + legacy | **23/23 CTests PASS**, real wide and compact return QML smoke | [run 41107908887](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41107908887) |
| Hosted Windows MSVC Qt6.8.3 native Qt Quick + legacy | **23/23 CTests PASS**, real wide and compact return QML smoke | [run 41107908887](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41107908887) |
| Hosted Windows windeployqt and packaged synthetic-demo automatic check | **PASS**. Manual physical Windows scaling explicitly **NOT TESTED** | Same run, hosted Windows job log |
| Screenshot artifacts | Linux and Windows screenshot archives plus Windows physical acceptance kit uploaded | Same native run, three uploaded artifacts |

## Evidence scenarios

- Core test: missing selection is rejected with no refresh or file modification. Invalid and future injected return dates fail preflight and do not persist.
- Core test: forcibly block the rental ledger target in disposable storage; `completeRental` rolls back active rental/vehicle availability. The controller reports no persisted receipt, performs no Rental/Fleet refresh callback, retains visible active selection and preserves the previously saved ledger.
- Core test: a valid selected active return commits, refreshes Rentals and Fleet once, moves the record out of Active into History and clears hidden selection. Repeated return and returning historical contract are rejected. A second successful return under All preserves the same visible ID while disabling further returns. Restart reconstructs both returned records and vehicle availability from the persisted rental ledger.
- Native QML: start with Return disabled until active rental selection; use **real keyboard Space/Arrow events**; Cancel closes the dialog without any write; second confirmed action calls the C++ controller, persists a return for fictional R001/C002, updates Fleet available count 4 to 5, changes rental status to Returned, prevents duplicate return, and shows that record in History. No original source demo fixture bytes change; wide 1500×860 and compact 1280×720 screenshots captured.

## Open gates and formal acceptance

**P3 3/7 accepted, total 19/74, weighted 25.2% unchanged**, not release readiness. This is only an opt-in fictional-data proof, not an operational customer booking journey. Typed commands still lack full lifecycle coverage and independently injectable repository; date injection is service-level preflight, not full domain clock replacement. Complete QML guided quote/confirmation and archive/recovery lifecycle remain unwired. P1 visual/a11y and physical owner Qt Creator MinGW / native OS scale 100/125/150% signoff remain OPEN. Draft PR #9 unmerged, main unchanged.

**Recommended next:** review P3 command coverage and failure paths, then isolate an archive command under the same commit-first refresh seam, but do not expose irreversible deletion or operational-data paths until explicit acceptance.
