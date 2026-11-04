# Rental Studio 2.0 | Permanent local Qt Creator workflow and Windows script audit

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Scope:** Source development workflow only. No real customer-data approval, production storage activation, installer, merge, or physical hardware PASS.  
**Repository:** [Sonkhe-Shongwe/vehicle-rental-system](https://github.com/Sonkhe-Shongwe/vehicle-rental-system)  
**Working branch:** `feature/p7-sqlite-sandbox-20261102`, stacked [draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) on P6.  
**Baseline last native-tested executable source:** `f273d038be2bce0398241f6e5950f3938a13f6d1`; [125/125 on Linux and hosted Windows and 8/8 Windows package checks](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41815907017).  
**Baseline branch documentation-only checkpoint before this improvement:** `f992d8c219a340793e4932aeedd84919720209c4`.  
**Owner acceptance:** still **45/74, fixed-weight 70.6%; P5 8/8, P6 9/9, P7 0/8**. Actual owner Qt Creator 6.10.2 MinGW and accessibility/scaling gates remain open.

## Decision and outcome

For everyday development, use **one working GitHub Desktop checkout plus Qt Creator's local build and Run button**. GitHub Desktop fetch/pull updates the source; Qt Creator rebuilds and launches from that source, not from separately downloaded hosted Windows QA ZIPs. Keep GitHub Actions for regression and portable packaging, requesting physical owner reviews only at substantial acceptance milestones or unresolved hardware/UI questions.

A new repository-root `CMakePresets.json` declares one explicit **fictional-only** configuration `rental-studio-local` with `BUILD_QTQUICK_P2_SPIKE=ON`, `BUILD_TESTING=ON`, and `BUILD_P7_SQLITE_SANDBOX=ON`. It uses a private, Git-ignored `build/rental-studio-local` directory. The full experimental P7 SQLite Lab still requires deliberate opt-in inside the application and remains generated-fictional-only. This is **not** P7 production integration.

The preset intentionally supplies no absolute Qt, compiler, CMake generator, Windows user or filesystem path. Qt Creator's selected kit supplies Qt 6.10.2 MinGW toolchain and Qt package discovery. The root CMake project is the required entry point; the old Qt Widgets executable (`VehicleRentalSystem_A3`) is not the intended modern GUI. Actual desktop CMake build and test results are **not** claimed until the owner runs them.

## One-time setup on the owner's Windows PC

1. In GitHub Desktop, open the existing `vehicle-rental-system` **local cloned working repository**, not a previously downloaded QA ZIP. Use **Current Branch** to select exactly `feature/p7-sqlite-sandbox-20261102`. If a branch is not already checked out, fetch and choose it without merging. Check the Changes tab first and **save/commit/stash any personal uncommitted edits** before Pull.
2. Use **Fetch origin → Pull origin** on that branch. In GitHub Desktop, use **Repository → Open in Explorer** to locate the actual clone. The repository root contains `CMakeLists.txt`, `CMakePresets.json`, `demo/` and `spikes/`.
3. Open **Qt Creator** → **File → Open File or Project** → choose the **root** `CMakeLists.txt` (NOT `spikes/qtquick_p2/CMakeLists.txt` alone). Select the already configured **Desktop Qt 6.10.2 MinGW 64-bit** kit (Debug is suitable for local debugging). Qt 6 Quick, Controls, QuickDialogs2, Test and Sql modules must be installed for the selected P7-enabled preset. Do not configure with the hosted Windows MSVC toolchain.
4. In Qt Creator's project configuration, use the **`rental-studio-local`** CMake configure preset if offered. Confirm these exact cache values in **Projects → Build Settings → CMake**: `BUILD_QTQUICK_P2_SPIKE=ON`, `BUILD_P7_SQLITE_SANDBOX=ON`, `BUILD_TESTING=ON`. Build directory is `<clone>/build/rental-studio-local`, which Git ignores. If Qt Creator does not expose configure presets on the chosen kit, enter those three `ON` CMake options directly in the kit's CMake configuration and use a fresh build directory under `build/`.
5. Select the executable/run target **`rental_studio_qtquick_spike`** in Qt Creator, build and press **Run** (usually Ctrl+R with Qt Creator). It is the modern **Rental Studio 2.0** Overview/Fleet/Rentals GUI despite the historical P2 target name. Do **not** select `VehicleRentalSystem_A3`, the historical Widgets UI.
6. This creates a persistent Qt Creator local project; for future changes use **GitHub Desktop Fetch/Pull on the SAME branch → Qt Creator Build/Run**. Do not download or extract any new Windows QA ZIP for routine edits. If Git changes CMake structure or options, let Qt Creator reconfigure and rebuild. The Qt Creator version/toolchain and local physical test results must be recorded separately from hosted MSVC CI.

**Troubleshooting:** An error about Qt6::Sql, Qt6::Quick or other packages requires checking the chosen Qt Creator kit and installing the matching Qt module if missing. Do not silently flip the intended P7 test option and call it an equivalent test. If an old CMakeCache was created with another Qt/compiler, configure a **new ignored directory under `build/`** rather than mixing MinGW/MSVC caches. If the tool opens the Widgets interface, change the selected run target to `rental_studio_qtquick_spike`. If the app runs but looks different, first record `git rev-parse HEAD`, selected kit, window/display scale and screenshot.

## Native regression commands (optional; not a replacement for physical testing)

From a Windows terminal that has the selected Qt/MinGW/CMake toolchain available, in the **repository root**, after configuration:

```powershell
# Build the app only after the Qt kit configured the preset.
cmake --build --preset rental-studio-local-app

# Local UX-CTRL-002 wide + compact tests after building the app.
ctest --preset rental-studio-local-ux-ctrl-002

# To run the entire native suite, first compile ALL targets:
cmake --build --preset rental-studio-local-all
ctest --preset rental-studio-local-all
```

Qt Creator's Build/Run UI is the normal workflow and does not require these shell commands. On a multi-configuration generator, `--config Debug` / `-C Debug` may be required; the existing single-config MinGW/Ninja kit typically does not require it. A local 125/125 PASS is **not** assumed from the hosted MSVC result. Before changing a persistent application behavior, run targeted tests; before an acceptance milestone, run relevant full native tests on hosted Linux/Windows again. No unverified on-device screenshots or measurements are claimed.

## Complete tracked batch / PowerShell audit (current P7 branch)

The Git tree at `f992d8c219a340793e4932aeedd84919720209c4` contains exactly **two tracked `.cmd` files**, **zero tracked `.bat`**, and **two tracked `.ps1`** files. Every file is **actively referenced** in `.github/workflows/p2-qtquick-review.yml`. None is an obsolete local-development launcher.

| File | Audit | Disposition |
|---|---|---|
| `spikes/qtquick_p2/Launch-Rental-Studio.cmd` | Portable QA kit launcher; checks full packaged EXE, fictional fixtures, `SOURCE_COMMIT.txt`, resets inherited Qt environment; `--verify` used by hosted Windows CI | **KEEP**. Packaged QA use, not required for Qt Creator daily Run |
| `spikes/qtquick_p2/Check-Rental-Studio.cmd` | Runs 8 genuine fictional-only portable functional checks, creates unique evidence directory, preserves previous outcomes; hosted CI invokes it | **KEEP**. Not an unused duplicate of the launcher |
| `spikes/qtquick_p2/Verify-P2-Windows.ps1` | Packaged self-test and Qt Quick smoke; hashes fictional source before/after; optional owner scaling review; hosted CI uses `-VerifyOnly` | **KEEP**. Different acceptance responsibility |
| `spikes/qtquick_p2/Verify-P4-Windows.ps1` | Packaged accessibility/focus/motion assertions and PowerShell 5.1 compatibility; CI invokes it with both PS7 and PS5.1 | **KEEP**. Deleting regresses hosted verification |

**Conclusion:** No tracked batch scripts qualify for safe deletion in this checkpoint. Do not delete them merely to make the repository look cleaner. No historical scripts were added by this workflow; instead we use one built-in Qt Creator Run action and a CMake preset. This avoids untested modifications to the successful Windows packaging checks.

**Why it is safe to keep them:** GitHub Actions copies those source scripts into a **separate** portable Windows kit at packaging time. They are not extra background services on the owner's computer and do not control a Qt Creator Run. The physical owner need not run them for routine coding or UI review.

## What Git pull deletes, and what it does not

- **Tracked repository file deleted in an incoming commit:** when you pull that commit on the matching branch and the working-tree update succeeds, Git removes that tracked file from the local clone. Tracked renames/updates also propagate. Git often blocks a pull or checkout that would overwrite conflicting local modifications.
- **Untracked files:** locally created `.bat`/`.cmd`, extracted ZIP directories, screenshots, generated acceptance evidence and private files that were never committed are **not** deleted by ordinary `git pull`.
- **Ignored build/IDE files:** `build/`, `*.user` and other patterns from `.gitignore` remain local. Normal pulls do not wipe a local Qt Creator build.
- **Downloaded QA ZIPs outside the clone:** not managed by Git and will remain until the owner deletes/moves them manually.
- **GitHub branches:** pulling this P7 feature branch does **not** merge PR #17 or change `main`. Verify the Current Branch label before Pull.

Read-only commands for examining the local clone:

```powershell
git branch --show-current
git rev-parse HEAD
git status --short --untracked-files=all
git ls-files "*.bat" "*.cmd" "*.ps1"
# Preview ignored files. DO NOT execute git clean -fdx.
git clean -ndX
```

**Never run `git clean -fdx`, `git reset --hard`, or delete `build/` automatically to “tidy” the project.** Such operations can destroy uncommitted work, ignored outputs, local logs or test evidence. If multiple obsolete QA folders sit in Downloads/Desktop, review those individually and delete only duplicates that are no longer needed; GitHub Desktop cannot remove files outside the repository.

## Verified work vs next owner gate

- **Verified from remote source:** four tracked scripts and exact GitHub Actions references; CMake root options and modern Qt Quick target; ignored `build/` root; commit and branch protections. `CMakePresets.json` syntax locally checked using CMake 3.31's configure/build/test preset listing. That check does **not** compile Qt.
- **Not executed here:** owner's actual Windows Qt Creator/MinGW CMake configure/build, binary launch, CTests, screen scaling, Narrator or keyboard acceptance.
- **Next milestone:** owner Fetch/Pull the latest feature branch, open the root CMake project, select the MinGW 64-bit Qt 6.10.2 kit and `rental_studio_qtquick_spike`, run UI, then physically validate UX-CTRL-002 at available Windows scaling.
- **Governance:** draft PR #17 unchanged as draft; stable `main` untouched; formal owner rubric remains 45/74, 70.6%, P7 0/8. No P7 production-data integration authorized.
