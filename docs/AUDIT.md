# Audit record | 29 October 2026

**Baseline:** Uploaded `VehicleRentalSystem_A3.zip` (C++17/Qt Widgets app, CMake, local text data, 13 screenshots). The GitHub repository was empty at the start of this audit. The application source is being prepared for upload separately.

## Implemented at source level
- Fleet CRUD and search, sequential IDs.
- Vehicle abstract base class; Car and Motorcycle implementations.
- Rental creation, double-booking checks, return, archiving and controlled deletion.
- Customer and date capture, price calculations, fleet dashboard, rental history.
- Two text-file stores with 13-field rentals and older 14-field read compatibility.

## Prioritized findings

| Severity | Issue | Evidence and action |
|---|---|---|
| CRITICAL | Empty GitHub repository at start of audit | Initialized with project README. **Complete source still needs to be committed.** |
| HIGH | Save failures were ignored | Original `RentalSystem::saveVehiclesToFile` and `saveRentalsToFile` returned void and ignored write errors. Revised local package uses `QSaveFile`, boolean status and rollback. |
| HIGH | Rental create/return wrote two files independently | Partial failure could make vehicle/rental status disagree. Revised local package uses a single authoritative rental write and reconstructs fleet occupancy on reload. |
| HIGH | Startup could rewrite both source files without consent | `loadRentalsFromFile` invoked both save functions after parsing, potentially discarding invalid lines. Revised local package makes startup read-only. |
| HIGH | Original demo material included names/phone numbers | Raw rental fixtures and certain screenshots must be excluded. Sanitized fictional examples provided in the local package. |
| MEDIUM | Business rules accepted caller-provided rental amount | Additional finite number, price, days, total and delimiter validation prepared. |
| MEDIUM | Invalid, duplicate-active or malformed imported records | Revised loader rejects duplicate active booking and invalid format; diagnostic reporting is still pending. |
| MEDIUM | `__FILE__`-based source folder used for runtime storage | AppData migration requires testing against old data; current local patch supports an isolated directory for test fixtures. |
| MEDIUM | IDs may be reused after deleting a highest-number record | Persistent sequence allocator pending. |
| MEDIUM | Single `mainwindow.cpp` contains a large UI+presentation layer | Incremental refactor pending; preserve working screens for deadline. |
| MEDIUM | No pre-existing automated tests, CI or backend API | Local patch adds CTest domain tests. SQLite, API, CI green status and installer are not implemented/verified yet. |
| LOW-MEDIUM | Currency uses `double`; revenue sums rental contract values | Integer cents and a clearer paid-vs-booked definition are future items. |

## Verification truth
- Direct source and GitHub metadata inspection: completed.
- Static checks on revised local copy: completed.
- CMake configure in the available environment: **blocked by absent Qt5/Qt6 dev package**.
- Compilation, CTest and Windows GUI smoke test: **not run**, cannot be reported as passed.
- Current remote repository: documents are bootstrapped, but complete source import still required.

No live customer data may be posted to public issues or GitHub history.
