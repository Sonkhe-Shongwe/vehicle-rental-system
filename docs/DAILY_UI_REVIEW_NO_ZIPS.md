# Rental Studio 2.0 | Daily UI review without downloading ZIPs

**Updated:** 6 November 2026  
**Branch:** `feature/p7-sqlite-sandbox-20261102`  
**Modern desktop target:** `rental_studio_qtquick_spike`  
**Latest native-tested Overview + Fleet executable source:** `7a7d6adfbf5c9763ddb6d835e1e8958cbfbc2a11` ([Actions #42178840695](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42178840695), **140/140 Linux + 140/140 Windows native CTests**, 8/8 Windows packaged checks, PowerShell 5.1 PASS). [Full continuation evidence](DIRECTION_A_OVERVIEW_FLEET_HANDOFF_AND_NATIVE_VERIFICATION_2026-11-06.md). **Physical user approval remains open.**

## Daily routine: no downloads

**One-time prerequisite:** Existing GitHub Desktop cloned repository, plus Qt Creator configured with the **Desktop Qt 6.10.2 MinGW 64-bit** kit. The [full setup document](LOCAL_QT_CREATOR_WORKFLOW_AND_SCRIPT_AUDIT_2026-11-04.md) contains the one-time procedure and troubleshooting. Do not assume the physical MinGW build has passed until you have run it.

1. Open **GitHub Desktop**. Ensure the selected repository is `vehicle-rental-system`, with **Current Branch: `feature/p7-sqlite-sandbox-20261102`**. If you have uncommitted changes, protect or commit them before pulling. Select **Fetch origin**, then **Pull origin**.
2. In **Qt Creator**, open the already configured project, or use **File → Open File or Project → repository-root `CMakeLists.txt`**. Select the **Desktop Qt 6.10.2 MinGW 64-bit** kit, not the legacy Widgets target.
3. Confirm the **run target `rental_studio_qtquick_spike`**. Click **Build/Run**, normally **Ctrl+R**. Qt Creator rebuilds only what it needs using the existing local source and build directory.
4. Review the actual Overview, Fleet, Rentals, sidebar expanded/collapsed, and New Rental workflow. Compare at normal desktop sizes and report specific observed issues with a screenshot, the source commit shown by GitHub Desktop, window size, and Windows Display scale.

### Once-only CMake setup details

- Use existing **`rental-studio-local`** preset if Qt Creator offers it. This configures an ignored local build directory: `build/rental-studio-local`.
- Otherwise configure **`BUILD_QTQUICK_P2_SPIKE=ON`**, **`BUILD_TESTING=ON`**, and **`BUILD_P7_SQLITE_SANDBOX=ON`** in Qt Creator's CMake settings. The SQLite Lab remains **fictional-only and separately opt-in**, not production data.
- The chosen Qt 6 MinGW kit must have the Quick, QuickControls2, QuickDialogs2, Test, and Sql modules.
- If the source switches CMake configuration, let Qt Creator reconfigure before building. Do **not** delete the build directory or reset Git history to solve ordinary sync errors.
- Verify you're running the modern Qt Quick target, not `VehicleRentalSystem_A3` (legacy Widgets app).

### If source and UI disagree

1. Ensure GitHub Desktop shows the expected feature branch and has no incoming commits.
2. Verify the current commit using `git rev-parse --short HEAD` from the repository root.
3. Verify Qt Creator's **active Run configuration** and correct kit.
4. Allow Qt Creator to finish reconfiguration and compile the modified QML files.
5. If still mismatched, record the error and a UI screenshot. Do not use destructive `git reset --hard` or `git clean -fdx`.

### How we'll review going forward

| Work cycle | How the owner reviews | Downloads? |
|---|---|---|
| Small UI change | GitHub Desktop Pull, Qt Creator Run | **No ZIP** |
| Native CI test | Inspect GitHub Actions run and results in browser | **No ZIP** |
| Screenshot comparison | Inspect targeted screenshots shared in chat or exact GitHub artifact | Only if useful |
| Significant owner acceptance | Rebuild locally; test physical screen, DPI, keyboard, Narrator | **No ZIP** |
| Portable clean-PC QA / troubleshooting | Use the tested Windows acceptance ZIP | Occasional larger ZIP |

No extra hot-reload service, executable replacement, updater, online media API or background process is needed. The standard local Qt Creator build and existing GitHub Actions pipeline remain the only supported flows.

## Safety boundary

Use only fictional portfolio records. Do not enable operational customer storage, install unsigned executables against device policy, or claim physical Windows success from hosted Qt 6.8.3 MSVC tests. `main` stays unchanged and PR #17 remains draft until explicitly approved.
