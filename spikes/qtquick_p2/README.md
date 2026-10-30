> **30 October 2026 | CURRENT VERIFIED P2 NATIVE KEYBOARD/DPI CHECKPOINT:** New actual source `eeb08485245ef127d6a9e53c2d80ec68bca66c0b` passed [Linux+Windows Qt6.8.3 Actions run 41045646448](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045646448): **8/8 CTests on each** including C++ Fleet, compiled QML Gallery/Table at 1500×860 and 1280×720, **real Qt Test Space/Escape selection**, live resizing, and **synthetic Qt scaling 125/150%**. Twelve real Qt Quick PNGs across both platforms inspected for actual dimensions and representative layouts. Initial run [41045247197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045247197) **FAILED 7/8**, fixed actual QML ListView delegate test lookup and reran without weakening assertions. [Detailed latest report](../../docs/P2_NATIVE_INPUT_DPI_VERIFIED_2026-10-30.md). **P2 still 3/6 (50%), weighted total still 18.4%**, because physical owner's Windows 100/125/150%, Qt Creator kit and toolkit go/no-go are NOT VERIFIED. P1 imagery/accessibility/owner signoff remains open. PR #6 stays draft; PR #4 unmerged; main untouched. Earlier dated source-unverified notes below are superseded.

> **CURRENT 30 October 2026 verification:** This spike now **builds and executes on hosted Linux and Windows Qt6.8.3**, with native model/UI CTests **5/5 on each**, [run 41043137443](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41043137443). Actual screenshot dimensions validated at 1500×860 and 1280×720 on both; see [evidence and limits](../../docs/P2_QTQUICK_NATIVE_CI_VERIFIED_2026-10-30.md). This is **not** physical owner Windows Qt Creator or 100/125/150% acceptance. The old source-prepared status and missing-local-SDK note below remain as historical context.

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

## Hosted CI (separate from owner's physical Windows acceptance)

The opt-in review workflow `.github/workflows/p2-qtquick-review.yml` runs the new QML target alongside unchanged Qt Widgets targets on Ubuntu 24.04/GCC and Windows Server 2022/MSVC using Qt 6.8.3. It captures **real QQuickWindow** Gallery and Table screenshots at 1500×860 and 1280×720 and checks model parity, but **cannot establish true physical monitor scaling**. This workflow runs for a **draft pull request targeted at the product-reset documentation branch**, not on stable main. It is not proof of successful execution until a run actually passes; if GitHub Actions is restricted, record the failure without waiver.

## Additional native acceptance instrumentation (30 October 2026)

Opt-in P2 CTests now include **real Qt Test keyboard** events (Space to switch Gallery/Table, Space to select a native Table delegate, Escape to dismiss the selected Inspector, dynamic 1280x720 -> 1500x860 window resizing) and separately recorded **QT_SCALE_FACTOR 1.25 / 1.5 synthetic DPI** captures at 1024x660 logical. This is not a browser simulation. The synthetic scale tests exercise Qt's devicePixelRatio, but **cannot replace physical Windows monitor or Qt Creator acceptance**. No production booking/data-writing actions are added.

Use the exact native test output and attached screenshots; do not mark P2 physical Windows gate complete from hosted CI.
