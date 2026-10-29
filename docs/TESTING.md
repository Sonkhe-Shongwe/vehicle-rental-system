## Verified contrast regression and screenshot acceptance | 29 October 2026

**Exact tested source:** `c5c1e7885c80c3b7f88c0b40adf891fb2d9a2c91`. New Qt GUI lifecycle CTest checks actual table widget item status foreground colours for **Available, Rented, Returned and Archived**, against the table backgrounds `#FFFEFA` and `#F5F7F0`, asserting normal-text contrast ratio at least **4.5:1**. It also retains all real Qt lifecycle, modal, restart and persistence checks in isolated `QTemporaryDir`.

- [Linux Ubuntu 24.04 Qt6 GCC visual workflow 40932934420](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40932934420): **PASS** configure/build, CTest **2/2**, ten compiled Qt renders at 1500x860 and 1280x720, real screenshot commit [`48c4c87`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/48c4c873b7485f55a2d718f1807383ac996a6a43).
- [Windows Server 2022 MSVC2022 Qt6.8.3 workflow 40932934337](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40932934337): **PASS** configure/Release build, CTest **2/2**, ten compiled Qt captures at 1500x860 and 1280x720, two simulated DPI cases (Fleet 125%, Rent 150%), PNG checks and SHA-256 unchanged demo fixtures.

**Test boundary:** A programmable Qt contrast assertion is not an automated full visual-accessibility or keyboard audit. Real Windows Qt Creator at 100/125/150% native screen scaling, interaction/focus and owner aesthetic approval are still **NOT RUN/NOT APPROVED**. Previous compile failure at `fdecb35` remains recorded as a failed precursor, not overwritten.

## Windows + Linux exact-source verification update | 29 October 2026

**Source SHA `aaf2ceee22dbe4fd782c142c1a0999e54d59d816`:**
- [Windows Actions 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521): **PASS**, GitHub-hosted Windows Server 2022, MSVC 2022, Qt 6.8.3, CMake Release. CTest **2/2**: `vehicle_rental_domain` and `vehicle_rental_gui_lifecycle`; ten compiled Qt UI renders at two sizes and two synthetic DPI, complete PNG/dimensions/integrity verification, fictional demo fixture hashes unchanged.
- [Linux Actions 40931662760](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931662760): **PASS**, Ubuntu 24.04 GCC/Qt6 CMake Release, CTest **2/2**. The Linux failure on earlier `fdecb35` is not reclassified as passing.

**Remaining tests not executed:** genuine Windows Qt Creator interaction with native keyboard, focus, confirmation and physical display scale at 100/125/150%; user visual approval; crash/power-loss. Hosted offscreen tests are execution evidence, not desktop sign-off.

## New regression evidence | 29 October 2026

**Source commit:** `aaf2ceee22dbe4fd782c142c1a0999e54d59d816`. **Platform:** GitHub-hosted Ubuntu 24.04, Qt 6 (system qt6-base-dev), GCC, CMake/Ninja, Release. **Run:** [40931662760](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931662760).

**PASS: CMake compile and CTest 2/2:** `vehicle_rental_domain` and new `vehicle_rental_gui_lifecycle`. The new test renders the compiled Qt Widgets `MainWindow` offscreen and uses only `QTemporaryDir` for persistent data. It clicks the existing vehicle/rental buttons and exercises expected confirmation/warning dialogs; verifies customer gating, quote, no double booking, disk reload and byte-preserving GUI restart, rejected premature archive/delete, return and repeated-return rejection, archive, delete and final disk-state checks. It does not use the repository's source-adjacent operational storage. It is **not** a manual mouse/keyboard test or a physical Windows high-DPI sign-off.

**Known failed precursor:** [commit `fdecb35`, Linux 40931501438](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931501438) failed compilation on a `QAbstractButton*` / `QPushButton*` mismatch in the new test; fixed in `aaf2cee`, then the complete suite passed. Earlier failed workflows remain failed in the audit trail.

**Windows status for `aaf2cee`:** [Windows review run 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521) was running when this checkpoint was authored. Do not claim a Windows pass without checking its final conclusion and logs. Earlier verified Windows automated checks are documented in `WINDOWS_SCREENSHOT_DPI_REPORT_2026-10-29.md`. **Manual Qt Creator flow, real monitor scaling, keyboard and owner aesthetic approval: PENDING.**

# Test Plan and Evidence Register

## Current execution status - 29 October 2026

- Source review: **complete** for central domain, persistence and UI event paths.
- Privacy screening of historical raw data: **complete**; removed from handoff.
- Local audit container CMake configure: **BLOCKED: Qt development packages unavailable**; separate GitHub-hosted Ubuntu 24.04 Qt 6 configure **PASSED**.
- Linux Qt 6 compilation: **PASSED** in GitHub Actions run [40872123623](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40872123623), commit `253918f`.
- Linux CTest `vehicle_rental_domain`: **PASSED** in the same GitHub Actions run.
- Windows interactive UI run: **NOT RUN**.
- Crash/power-loss recovery: **NOT RUN**.

Do not relabel prepared tests as passed until their exact commands have been executed.

## Verified hosted CI checkpoint

- Date: 29 October 2026.
- OS/toolchain: GitHub-hosted `ubuntu-24.04`, `qt6-base-dev`, CMake/Ninja, GCC.
- Source revision: `253918f7b765e82df17bc5b25eec584fc11e9672`.
- Run: https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40872123623
- Passed steps: public fixture hygiene, configure, build, CTest. These **do not** validate GUI runtime, Windows-specific behaviour or crash resilience.

## Automated checks

```powershell
cmake -S . -B build -DBUILD_TESTING=ON
cmake --build build --config Release
ctest --test-dir build -C Release --output-on-failure
```

The `vehicle_rental_tests` binary covers isolated add/duplicate/reject, record separator injection, rental lifecycle, no double booking, bad totals, future return refusal, restart occupancy reconstruction, archiving, deletion, failed-save in-memory rollback and read-only startup.

## Manual Windows smoke test (disposable demo data only)

- [ ] Qt Creator configures and compiles the app with known kit/version.
- [ ] Dashboard opens without warnings; resizing and navigation work.
- [ ] Add a car and motorcycle, search both IDs and reopen them after restart.
- [ ] Reject duplicate IDs, invalid prices and invalid fields.
- [ ] Rent an available vehicle; amount and expected date are correct.
- [ ] Attempt a second rental of the same vehicle; must reject.
- [ ] Close and reopen app; active rental remains and vehicle stays unavailable.
- [ ] Return by rental ID, then repeat return; first succeeds, repeat rejects.
- [ ] Archive returned rental; cannot archive an active rental.
- [ ] Delete only archived records after confirmation.
- [ ] Remove an available vehicle; block removal while active rental exists.
- [ ] Confirm application files do not change merely by opening the app.
- [ ] Test a failed save in an isolated unwritable folder; no false success.
- [ ] Confirm all public screenshots and demo data have fictional identities.

## Test record template

Date, OS, Qt version, compiler, CMake version, commit SHA, test command, exit code, failed case IDs, reproduction steps, expected vs actual result, screenshot or sanitized log and fix/issue link.
