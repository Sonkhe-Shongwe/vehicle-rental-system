# Source Audit - 29 October 2026

**Baseline examined:** `VehicleRentalSystem_A3.zip` uploaded by the project owner. **Repository observation:** `Sonkhe-Shongwe/vehicle-rental-system` existed but was empty at the beginning of the audit. The original archive contained C++ sources, a CMake build, README, runtime text records and 13 screenshots.

## What works at source level (runtime verification is separate)

| Feature | Evidence in baseline | Assessment |
| --- | --- | --- |
| Fleet CRUD and ID generation | `rentalsystem.cpp`, `mainwindow.cpp` | Implemented in source. |
| Car/motorcycle polymorphism | `vehicle.h`, `car.cpp`, `motorcycle.cpp` | Clean small inheritance example. |
| Rental create, return, archive, delete | `rental.cpp`, `rentalsystem.cpp` | Implemented with state guards. |
| Availability and double-booking prevention | `RentalSystem::createRental` | Guards exist, test coverage previously absent. |
| Dashboard KPIs and transaction tables | `mainwindow.cpp` | UI logic exists; metrics are historical transaction totals, not verified cash collected. |
| Persistence with backward format support | `load*FromFile`, `save*ToFile` | Basic file persistence; failure/corruption risks existed. |
| Build system | `CMakeLists.txt` | Qt5/Qt6 and C++17 targeting; no initial tests. |

## Audited issues, ordered by risk

| ID | Severity | Finding | Source baseline | Mitigation / status |
| --- | --- | --- | --- | --- |
| VR-01 | Critical | Initial GitHub repository was empty. No recruiter could inspect the code. | GitHub API contents returned `repository is empty`. | Resolved 29 October: all 27 text/source/test files committed `4c6d2b2`, then three sanitized screenshots `253918f`. |
| VR-02 | High | File save errors were ignored. UI-facing operations could return success without persisted data. | `rentalsystem.cpp`: `saveVehiclesToFile`, `saveRentalsToFile` returned `void` and used `QFile`. | `QSaveFile` plus boolean result and rollback of in-memory operations prepared. Needs actual Qt build/tests. |
| VR-03 | High | Two separate file saves on rental create/return could disagree after partial failure. | `createRental`, `completeRental` wrote both files. | New flow writes authoritative rental ledger once and reconstructs occupancy on reload. Still needs crash/restart validation. |
| VR-04 | High | Loading rental history automatically rewrote both files, including invalid-row omission and format migration without backup. | `loadRentalsFromFile` called both `save...` functions. | Read operation changed to read-only. Migration deferred until explicitly backed up. |
| VR-05 | High | Original ZIP included customer names and mobile numbers in `rentals.txt`, including an owner-linked record. Several screenshots also exposed customer details. | Original data fixtures and screenshots. | Original runtime text and customer screenshots excluded from public handoff. Fictional `demo/` data only. |
| VR-06 | Medium | New transaction domain methods accepted caller-supplied prices/totals without independently checking against vehicle price or expected total. | `createRental` checked only positivity. | Added numeric finiteness, rental-length, price equivalence and total checks. Needs runtime tests. |
| VR-07 | Medium | Raw delimited storage was vulnerable to record-format corruption from unvalidated separators and newlines in direct domain calls. | `toFileString`, basic UI checks. | Added model-level guards for record delimiter and line breaks on new records. Existing malformed historical rows still require reporting. |
| VR-08 | Medium | Duplicate active rental entries could load from externally modified data and no error was surfaced. | `loadRentalsFromFile` record loop. | Reject second active booking on import; missing diagnostics still open. |
| VR-09 | Medium | Runtime files are stored beside the source path resolved using `__FILE__`; install and permissions are fragile. | `RentalSystem` default constructor. | Path isolation constructor for tests; AppData migration remains open for compatibility. |
| VR-10 | Medium | Deleted maximum IDs may be reissued. | `generateNextVehicleId`, `generateNextRentalId`. | Persistent sequence allocator or UUID/DB identity needed in next milestone. |
| VR-11 | Medium | No automated regression, CI, warning policy or static analysis in baseline. | Original CMake file and archive inventory. | Domain tests, CTest and GitHub Actions committed; Ubuntu 24.04 Qt 6 build and CTest passed in run `40872123623`. Windows GUI tests remain pending. |
| VR-12 | Medium | `mainwindow.cpp` had ~1,900+ lines spanning UI construction, validation, business presentation and rendering. | `mainwindow.cpp` inventory. | Refactor incrementally after release gate, not under imminent deadline. |
| VR-13 | Low-Medium | `double` stores South African rand and the dashboard sums all rental contract totals as revenue. | `Rental` price fields and dashboard `revenue` loop. | Document revenue definition; use integer cents or fixed decimal and payment events before financial claims. |
| VR-14 | Medium | No built-in database, REST API, authentication, deployment pipeline or installer. | Source inventory. | Be transparent; these are future full-stack extensions, not current capabilities. |

## Verification boundaries

- **Observed:** Source contents and code paths were directly inspected; privacy exposure was verified in supplied data and screenshots.
- **Prepared:** Safer write implementation, validations, test suite, ignore rules and sanitized demo records.
- **Verified in CI:** On 29 October 2026, Ubuntu 24.04 + Qt 6 GitHub Actions run [40872123623](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40872123623) passed fixture hygiene, configuration, compilation and CTest for commit `253918f`.
- **Not yet verified:** Interactive GUI acceptance on Windows, migration compatibility with old data, crash/disk-full fault injection and screenshot correctness after the hardened patch.
- **Toolchain limitation here:** CMake configuration fails because neither `Qt5Config.cmake` nor `Qt6Config.cmake` is installed in this workspace. This is a missing dependency, not evidence of a code defect or a passed build.

## Safe release gate

Linux CI configuration, compilation and CTest have passed; **Windows GUI rent/return/restart with disposable fixtures is still required** before claiming fully validated desktop behaviour. Preserve backup copies of user data and do not replace the student's original working installation.
