## Windows hosted CTest + GUI lifecycle check completed | 29 October 2026

**PASS** [Actions run 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521), code `aaf2ceee22dbe4fd782c142c1a0999e54d59d816`. Hosted Windows Server 2022 / Visual Studio 2022 x64 / Qt 6.8.3. CMake Release build, **CTest 2/2**, now including `vehicle_rental_gui_lifecycle` with temporary fictional records and persistence/restart. Five compiled Qt screens at 1500x860, five at 1280x720, Fleet synthetic 125% and Rent synthetic 150%; all twelve PNG integrity and dimensions verified. Existing demo files passed pre/post SHA-256 integrity comparisons. The previous "Windows pending" entry below is a timestamped interim note, now superseded.

**Not run:** real monitor DPI, Qt Creator keyboard/mouse and confirmation review, and full manual sign-off. Continue the separate disposable-clone procedure below. No approval to merge PR #4.

## Additional automated GUI lifecycle regression | 29 October 2026

A new `vehicle_rental_gui_lifecycle` CTest now uses a deliberately isolated `QTemporaryDir`, not source-adjacent runtime data, and exercises buttons and dialogs for Add Vehicle, Rent, application restart, Return, Archive and Delete with fictional records. [Linux compile + both CTests passed at code `aaf2cee` in run 40931662760](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931662760). [Windows CI for this source commit: run 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521), **result pending when authored**. The older Windows 12-screen automated report remains relevant to its exact earlier source commit.

This test adds repeatable interface-level functional evidence, but it uses Qt offscreen and automatically answers specifically expected modal titles. It cannot certify keyboard accessibility, visible focus, actual mouse use, physical monitor DPI, or owner design sign-off. For those, complete the manual procedure below on a new Windows clone with synthetic customer records only.

# Windows Acceptance Procedure | Qt Visual Review

**Checkpoint:** 29 October 2026  
**Active review:** [Draft PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4)  
**Branch:** `feature/qt-hybrid-visual-spike-20261029`  
**Status:** Hosted Windows CI **PASSED** at tested code SHA `7d9027bde4fe3c6f87c57b6d29195fc8fd6d1383` ([run 40921642782](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40921642782), [evidence report](WINDOWS_CI_REPORT_2026-10-29.md)). Manual Qt Creator, full persisted rental-lifecycle and high-DPI testing remain **PENDING**. Offscreen automation does not replace them.

## Safety prerequisite

The original `RentalSystem` stores `vehicles.txt` and `rentals.txt` **beside the source files**, derived from `__FILE__`. This is a known design limitation. **Do not** point a new test build at an existing local project containing real customer data; a test could modify that data even if the build output is elsewhere.

Use a **new, disposable clone** of the review branch in a clearly named test folder. Keep your normal source checkout, local binaries, records and screenshots elsewhere and untouched. The repository's `demo/` fixtures are fictional.

## Latest automated Windows evidence (29 October 2026)

**PASSED:** [12-screen Windows screenshot and simulated DPI test run 40923616007](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40923616007) at source commit `630b8a53fdce2ab5413e7f0988505f3c04d3f307`: CMake/MSVC/Qt 6.8.3, CTest 1/1, 5 screens at 1500×860, the same 5 screens at 1280×720, Fleet simulated 125%, Rental simulated 150%; PNG integrity/dimensions checked and original fictional fixture hashes unchanged. The evidence artifact contains 12 PNG screenshots and can be downloaded from the run page. [Detailed recorded results](WINDOWS_SCREENSHOT_DPI_REPORT_2026-10-29.md).

**Still PENDING:** Windows Qt Creator interactive use on an actual monitor, physical scaling at 100/125/150%, full rent/return/restart/archive/delete through UI, owner visual approval. Automated capture success is not release sign-off.

## Automated Windows verification

Workflow: [`.github/workflows/windows-qt-review.yml`](../../.github/workflows/windows-qt-review.yml).

- Hosted GitHub `windows-2022` runner, Visual Studio 2022 C++ x64, Qt 6.8.3 (MSVC2022).
- CMake configure and Release build of actual Qt application and domain tests.
- CTest execution with `-C Release`.
- Five **non-destructive** UI smoke modes (Dashboard, Fleet, New Rental, History, Return) using Qt offscreen and fictional records, if the runner supports them.
- SHA-256 checks that `vehicles.txt` and `rentals.txt` are unchanged after smoke tests.
- **An offscreen runner is not a replacement for Windows Qt Creator interaction, real displays, high-DPI visual review or a deployed installer.**
- Failure in Qt installation, compilation, plugin startup or functional smoke is a blocker to be diagnosed, **not** silently reclassified as a pass.

## Windows manual procedure in a disposable clone

1. Create a new folder, then clone the **review branch** rather than stable `main`. Do not clone over your original working project.
2. Copy `demo/vehicles.txt` to the clone root as `vehicles.txt`, and `demo/rentals.txt` to `rentals.txt`, only after confirming that folder has no personal records.
3. Open this clone's `CMakeLists.txt` in Qt Creator. Select a compatible installed **Qt 6 x64 Desktop kit** with its associated MSVC or MinGW compiler, and a fresh build folder within the clone.
4. Record Windows version, Qt version, compiler, architecture, CMake version, Git commit SHA and build directory.
5. Configure/build in Qt Creator. With a separate command prompt using the **same compiler and Qt environment**, run:
   ```powershell
   cmake -S . -B build-acceptance -DBUILD_TESTING=ON
   cmake --build build-acceptance --config Release
   ctest --test-dir build-acceptance -C Release --output-on-failure
   ```
   The exact generator/configuration must match the installed kit; Qt Creator's own build may also be used when the CLI toolchain is not set up.
6. Run the **real Qt GUI** at Windows scale 100%; repeat the layout review at 125% and 150%, plus a **1280 × 720** window and a wider desktop window. Check the Dashboard, Fleet inspector/search/filter, New Rental estimate, Rental History and Return page. Record clipped text, keyboard focus, status text, disabled controls, image crops and unusual resize behaviour.
7. Test on **fictional data only**: add car and motorcycle, find IDs, reject duplicate/invalid inputs, rent an available vehicle, reject second simultaneous rental, close/reopen and verify availability and records. Return once, reject repeated return, archive returned record, verify an active rental cannot be archived, delete archived record, and verify a rented vehicle cannot be removed. Exercise keyboard Enter and confirmation dialogs. Use only disposable fixtures and take screenshots without personal details.
8. Check records are not rewritten merely by opening the application; compare hashes of the original fixture copies. Verify failed-save behaviour in a separate disposable *unwritable* location where safe, documenting the environment.
9. Capture user-visible evidence and outcome, including exact test commands, exit codes, failing use cases, reproduction steps, fixed commits and retest evidence. Upload a dated acceptance report to this review branch; **never** publish real customer data.
10. Obtain owner aesthetic approval. Only after all release criteria pass should this draft be considered for merge into `main`.

## Date-sensitive caveat

The demo rental fixtures are dated **October 2026**. The application processes **same-day** new rentals; do not treat hardcoded October fixture dates as valid dynamically on other dates. Record the date/time and whether a fixture must be regenerated before claiming a later runtime pass.

## Acceptance evidence template

| Field | Result |
| --- | --- |
| Test date and local timezone | PENDING |
| Windows OS / CPU architecture | PENDING |
| Qt Creator / Qt / compiler versions | PENDING |
| GitHub branch and commit SHA | PENDING |
| CMake Configure / Build / CTest | PENDING |
| Actual GUI smoke flows | PENDING |
| Fleet filters and quotes | PENDING |
| Persisted restart/reload, return/archive/delete | PENDING |
| High-DPI, keyboard and 1280×720 | PENDING |
| Screenshots/log links | PENDING |
| Defects found, commits and retests | PENDING |
| Owner visual approval | PENDING |

**Release decision: NOT YET APPROVED.**
