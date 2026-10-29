# Windows Acceptance Procedure | Qt Visual Review

**Checkpoint:** 29 October 2026  
**Active review:** [Draft PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4)  
**Branch:** `feature/qt-hybrid-visual-spike-20261029`  
**Status:** A Windows-hosted CI workflow has been added, but this document does not claim its result until a completed workflow is verified. Manual Qt Creator testing remains mandatory and is **not** replaced by offscreen automation.

## Safety prerequisite

The original `RentalSystem` stores `vehicles.txt` and `rentals.txt` **beside the source files**, derived from `__FILE__`. This is a known design limitation. **Do not** point a new test build at an existing local project containing real customer data; a test could modify that data even if the build output is elsewhere.

Use a **new, disposable clone** of the review branch in a clearly named test folder. Keep your normal source checkout, local binaries, records and screenshots elsewhere and untouched. The repository's `demo/` fixtures are fictional.

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
