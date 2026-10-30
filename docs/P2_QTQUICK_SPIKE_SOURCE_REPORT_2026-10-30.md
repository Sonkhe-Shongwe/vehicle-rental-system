# P2 Qt Quick + C++ feasibility: source-stage checkpoint

**Date:** 30 October 2026. **Status:** SOURCE PREPARED AND STATIC-REVIEWED ONLY. No native runtime PASS.

**Branch:** `spike/p2-qtquick-fleet-20261030`, based on product reset docs commit `b49dc258c2ebd1b923c0168a16f465d2b5746ec1` (not on rejected Qt Widgets PR #4 for visual approval). This branch intentionally retains the existing Widgets source and tests for comparison but has **no source changes to legacy rental domain or persistence**.

## Built (source)

- `BUILD_QTQUICK_P2_SPIKE` CMake option defaults OFF. When ON it builds a separate Qt 6.5+ Quick Controls 2 QML executable with a `qt_add_qml_module` module, without altering the original app target.
- `FleetModel : QAbstractListModel` reads actual `RentalSystem` domain vehicle pointers, exposing typed model roles for stable ID/name/type/rate/availability/specs.
- `FleetProxy : QSortFilterProxyModel` shares search, rented/available filter and name/rate sort between QML Gallery and Table. `FleetController` owns stable selected vehicle ID and read-only inspector labels and count properties. QML does not determine pricing, booking or persistent availability itself.
- Entry point copies **only committed fake** `demo/vehicles.txt` and `demo/rentals.txt` into a fresh `QTemporaryDir`. The domain reads the disposable copy. No custom data path accepted; no mutation endpoints. Original bytes are compared by `--self-test`.
- P2 UI offers Overview demonstration counts; Fleet Gallery + Table with shared C++ backing and Inspector; deliberately disabled/nonexistent rental workflows marked future P5. Branded layout follows selected owner colour roles, but this **does not yet reproduce the high-fidelity whole-product design**.
- `--self-test` is wired into an additional optional CTest `rental_studio_p2_model` verifying the 5 fictional vehicles / 4 available / Corolla daily rate, Honda search, rented-status count, persistent C++ selected ID through filter and sort, clearing selection, unchanged original source fixture bytes. **Created but not executed**.

## Honest verification

**Repository source-level checks:** QML and C++ delimiter balance, two Gallery/Table bindings to the exact same `fleet.visibleModel`, source-defined five vehicle and two rental demo records, Qt CMake policy and opt-in OFF switch, absence of mutation endpoints / external data path, Qt role identifiers and avoiding nested delegate `parent` scope bugs. These are **static checks only**, not compiler, Qt qml lint, GUI/runtime or functional validation.

**Local environment:** CMake with GCC 14.2/Ninja on Linux lacks **Qt 6 development packages**. A real CMake environment probe `find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2)` failed at configure because `Qt6Config.cmake` / `qt6-config.cmake` was not found. Exit code **1 (FAIL/BLOCKED)**, not PASS. No P2 CTest or Qt Quick screenshot was generated. Cannot reach owner's native Windows Qt Creator kit in this environment.

**Windows acceptance next:** Follow [P2 README](../spikes/qtquick_p2/README.md) with a clean clone, actual installed Qt 6.5+ Quick/QML kit, exact SHA, CMake build, all CTests, mouse + keyboard, Gallery/Table/Inspector, 1500×860 / 1280×720, physical Windows display 100/125/150% and source fixture hash checks. Collect observed results and resolve failures before counting any P2 checked criterion as verified.

**Progress remains frozen:** P0 5/5 100%; P1 7/10 70% (licensed vehicle images, broader accessibility, and owner whole-product signoff remain); **P2 0/6 0%** because no real Qt proof has run; P3–P9 0%; weighted delivery coverage 13.4%. Source preparation is meaningful work but **does not itself meet a runtime acceptance check**. No CI requested. No architectural migration, API, SQLite, user data or release promotion.

**Next highest priority:** native Windows Qt Creator build / interactive UI evidence (or a Linux Qt6 build on a machine with modules installed), then address genuine failures on this branch. Historical Widgets CI is not QML evidence.
