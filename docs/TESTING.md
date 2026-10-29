## Verified negative GUI confirmation paths | 29 October 2026

**Source:** `74139274a35380c380fd5ce68c31631f0422f3f5`. Existing `vehicle_rental_gui_lifecycle` compiled-Qt test now drives explicit **No** selections for Rental Creation, Return Processing, Archive and Permanent Deletion, checking both file **existence** and **byte-for-byte contents** unchanged, as well as separately reloaded rental/vehicle state. It also tests approved actions afterward and retains prior keyboard events, layout geometry at 1280x720/1500x860, status AA contrast, restart, duplicate booking and repeat-return assertions. All test data stays fictional in a `QTemporaryDir`.

- **Linux Ubuntu 24.04/GCC/Qt6:** [run 40939283826](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40939283826) **PASS**, configure/build, CTest **2/2**, published README screenshot validation **5/5**, real Qt screenshot capture **10/10**.
- **Windows Server 2022/MSVC2022/Qt6.8.3:** [run 40939283757](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40939283757) **PASS**, Release configure/build, CTest **2/2**, Qt compiled offscreen screenshots **10/10** at two sizes plus **2/2** simulated DPI, demo fixture hashes unchanged.
- **Not tested:** physical Windows Qt Creator / native modal keyboard/mouse flow, actual 100%/125%/150% display scaling, owner's visual/photo signoff. These hosted offscreen regression passes must not be recorded as manual desktop signoff.

## Five-screen README screenshot provenance verification | 29 October 2026

**Exact tested source:** `5faa5536bbd798c30d9d3022bfec25395d94340c`. New standard-library script `tests/verify_readme_screenshots.py` verifies each of the README's five `design/qt-spike/*.png` links exists and each **1500×860** image passes `tests/verify_qt_png.py` PNG signature, CRC/stream integrity, dimensions and basic content diversity checks. A README edit now triggers the Linux Qt visual CI; the validation executes **before** new captures are generated. This tests already published evidence without assuming subjective aesthetic quality or freshness relative to all source commits.

- [Linux 40937998505](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40937998505): **PASS**, Ubuntu 24.04/GCC/Qt6 CMake build and CTest **2/2**, added image-reference verification **5/5**, generated ten real compiled-Qt screenshots at 1500×860 and 1280×720.
- [Windows 40937998171](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40937998171): **PASS**, Windows Server 2022/MSVC2022/Qt 6.8.3 Release compile and CTest **2/2**, twelve compiled Qt offscreen/synthetic-DPI scenarios and preserved demo-file SHA-256.
- **Not performed:** real Windows Qt Creator desktop use, physically adjusted 100/125/150% monitor scale, aesthetics/photography signoff. Published screenshots are real compiled Qt, not browser prototypes; source-revision-of-capture is not cryptographically tied to every image, so do not claim screenshot recency beyond the recorded workflows.

## Verified two-size Qt layout geometry gate | 29 October 2026

**Source tested:** `9f6dd7c32b2f3feb14aa85a1f3c4c5329de19e50`. The same compiled Qt Widgets GUI lifecycle test now resizes a separate disposable `MainWindow` to **1280×720 and 1500×860**, visits Dashboard, Fleet Inventory, New Rental, Rental History and Return Processing, and asserts: major visible widgets within window bounds, primary horizontal/vertical sections do not overlap, essential form fields and buttons remain contained within their panels, and stacked panels precede the table heading. The test selects only the **visible** RentalActionPanel because both History and Return deliberately share a stylesheet object name. Prior saved-data lifecycle/keyboard/AA contrast checks all remain executed.

- [Linux visual 40936435098](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40936435098): **PASS**, GitHub Ubuntu 24.04 Qt6/GCC CMake Release, CTest **2/2**, five compiled Qt pages at each target size.
- [Windows 40936435292](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40936435292): **PASS**, Windows Server 2022 / MSVC2022 / Qt6.8.3 CMake Release, CTest **2/2**, twelve compiled Qt offscreen screenshot/DPI smoke cases and unchanged SHA-256 of fictional demonstration fixtures.
- Failed predecessor [Linux 40936385120](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40936385120) at `2ea9e10`: the new test incorrectly inspected a hidden panel with repeated style identifier. Fixed in `9f6dd7c` without skipping or weakening checks; previous failure remains part of audit.

**Coverage boundary:** no physical Windows Qt Creator resizing, no actual display-scale setting at 100/125/150%, no long text/dynamic localisation stress test, no user visual approval. The CI test verifies the explicitly checked rectangles, not general accessibility or every possible widget overlap.

## New Qt keyboard regression verified | 29 October 2026

**Source revision:** `525099b09114748159a06220d2565990d72ee50b` (test harness correction; implementation `49db913`). The compiled real Qt Widgets lifecycle test sends `QKeyEvent` to the visible New Rental vehicle field to assert Tab advances to customer name, then Enter on Return Rental ID to submit a real disposable rental return and reject repeated return. Full add/rent/restart/archive/delete, 4.5:1 table-status contrast and temporary-file isolation assertions are retained, not skipped. Production UI has new explicit visible button focus styles.

- **Linux verified:** [40935419732](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40935419732), hosted Ubuntu 24.04, Qt6/GCC, Release configure/build, CTest **2/2**, ten real Qt screenshot captures at 1500x860 and 1280x720.
- **Windows verified:** [40935419768](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40935419768), hosted Windows Server 2022, MSVC2022/Qt6.8.3, Release configure/build, CTest **2/2**, ten 1500x860 and 1280x720 offscreen captures and two synthetic DPI cases (Fleet 125%, New Rental 150%); PNG validation and unchanged SHA-256 fictional demo files.
- **Precursor failures:** `49db913` and `bfe8848` keyboard GUI lifecycle tests failed because the Qt offscreen test window had no active focus owner, then failed after modal dialogs. Corrected test setup via explicit Qt application focus activation in `e44ca84` and `525099b`. These failures remain recorded, not rewritten as passes. `bfe8848` also made Linux visual CI run on test-only changes.
- **Unverified:** physical Windows Qt Creator input, visible focus appearance on a monitor, real native 100/125/150% monitor scaling, full manual acceptance and owner approval. A QKeyEvent in Qt offscreen mode does not prove actual user-input accessibility.

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
