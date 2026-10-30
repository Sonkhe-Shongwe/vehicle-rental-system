# P2 Qt Quick + C++ Fleet feasibility spike

**Status 30 Oct 2026: SOURCE PREPARED; NOT COMPILED OR APPROVED ON WINDOWS.**

Isolated read-only Qt Quick executable reusing actual `RentalSystem`, `Vehicle`, `Car` and `Motorcycle` from the legacy C++17 code. It displays five **fictional** demo vehicles in a Gallery/Table backed by one `QAbstractListModel` plus `QSortFilterProxyModel`, with a shared vehicle-ID selection and contextual inspector. The selected Navy/Teal/Cloud design is a minimal reference, not finished implementation of the full visual prototype.

No source or customer data is written: executable copies only `demo/vehicles.txt` and `demo/rentals.txt` into a new auto-removed `QTemporaryDir`, passes that path into `RentalSystem`, and has **no mutation methods or storage controls**. No `--data-dir` parameter is accepted. A model self-test checks the 5/4 inventory, Honda filter, Rented status, search/sort/selection and compares both source files byte-for-byte.

## Native Windows steps (required before marking P2 verified)

1. In **Windows Qt Creator**, install/select a **Qt 6.5+ desktop MSVC or MinGW kit** with **Qt Quick, QML, Quick Controls 2** modules; record Qt Creator, Qt, compiler, Windows version and physical scaling.
2. Check out this exact **spike branch in a clean clone**, not an operational/customer data directory. Do not open or edit real source-adjacent `vehicles.txt`/`rentals.txt`.
3. Open root `CMakeLists.txt`; set `BUILD_QTQUICK_P2_SPIKE=ON`, `BUILD_TESTING=ON`. Existing Widgets target remains intact and is built normally.
4. Configure/build Release. Example from **Qt 6 MSVC Developer PowerShell** with an installed Qt kit available to CMake:
   ```powershell
   cmake -S . -B build-p2 -DBUILD_QTQUICK_P2_SPIKE=ON -DBUILD_TESTING=ON -DCMAKE_PREFIX_PATH="C:/Qt/6.8.3/msvc2022_64"
   cmake --build build-p2 --config Release --parallel 2
   ctest --test-dir build-p2 -C Release --output-on-failure
   .\build-p2\spikes\qtquick_p2\Release\rental_studio_qtquick_spike.exe
   ```
   The executable path varies by kit/generator. Qt Creator Run is preferred.
5. Confirm **five entries**, **four available**, **one rented Ranger**, **R450/day Corolla**; search `Honda` shows one, Gallery ↔ Table preserves search/status/selected ID, inspector shows correct details, rented vehicle has no Rent action.
6. Repeat at **1500×860 and 1280×720**, live resize, Tab/Shift+Tab/Enter/Space/Esc where relevant. Use real Windows Display settings **100/125/150% scaling**. Note layout problems and screenshot the **real Qt executable** for evidence.
7. Capture exact git SHA, Qt/Windows kit versions, screenshots, `ctest` output and problems. Do **not** report PASS based on a clean CMake listing or browser prototype.

**Expected baseline:** the legacy domain and Qt Widgets GUI CTests continue to pass; P2 model CTest is an *additional* optional test. The Qt Quick app must render and respond on Windows before progressing to any P3/P4/P5 full rebuild. No hosted CI or cross-platform success was claimed for this source.

**Go/no-go:** If Qt Quick modules are unavailable, compile fails, or native behaviour/performance is poor, record the failure and reconsider toolkit before architectural work.

### Evidence status at source creation

- GitHub review-branch source: **implemented, uncompiled**.
- Current executing environment: Debian GNU/Linux 13, GCC/CMake/Ninja available but **Qt6 development packages missing**; live `cmake` cannot complete and must not be recorded as PASS.
- Historical Linux and Windows Qt Widgets CI runs from different commits remain valid **only for the old UI**.
- Project phase score stays P0 100%, P1 70%, P2 0%, weighted **13.4%** until a P2 check is actually executed.
