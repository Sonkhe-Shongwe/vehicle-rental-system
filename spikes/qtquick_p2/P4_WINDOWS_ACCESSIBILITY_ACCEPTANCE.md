# Rental Studio P4 | Physical Windows Accessibility Review

**Purpose:** Review the exact built P4 Qt Quick application on the owner's Windows machine. The included executable runs only with pinned, fictional `demo/vehicles.txt` and `demo/rentals.txt` copied into a temporary directory. No live customer files, cloud resources or administrator permissions are needed.

**Status:** This document is a manual procedure, not an executed owner acceptance report. `Verify-P4-Windows.ps1` runs the packaged native accessibility, keyboard/confirmation and normal/reduced-motion injection checks, checks the bundled fictional files remain identical, and writes `acceptance-evidence/P4_WINDOWS_ACCESSIBILITY_RESULTS.txt`. It never silently marks Narrator or operating-system display scaling as passed.

## Start with the correct source

1. Download the `p2-windows-physical-acceptance-kit` artifact from the latest green GitHub Actions run for **Draft PR #10**, not the obsolete P2 branch. Extract it to a disposable folder separate from any operational data. Preserve the whole folder and `SOURCE_COMMIT.txt`.
2. In PowerShell, inside that extracted folder, inspect then run `.\Verify-P4-Windows.ps1 -VerifyOnly`. Review the results file and four command logs. A failed command is a FAIL, not an owner's acceptance.
3. If using Qt Creator instead, check out `feature/p4-shared-shell-focus-20261030`; record `git rev-parse HEAD` and the exact kit/compiler and Qt Creator version. Build the **root CMakeLists.txt** with `BUILD_QTQUICK_P2_SPIKE=ON`, `BUILD_TESTING=ON` in a fresh build folder. Run `rental_studio_qtquick_spike` and `ctest --test-dir <your-build-folder> -C Debug --output-on-failure` using the actual Debug/Release configuration. The portable review executable from hosted Windows Qt 6.8.3 MSVC does **not** prove the local Qt 6.10.2 MinGW result. Record the two SHAs separately if they differ.

## Manual Narrator and keyboard matrix

Use **Win + Ctrl + Enter** to enable/disable Windows Narrator if supported. For each check, record **PASS**, **FAIL** or **NOT TESTED**, and the precise audible phrase when possible. If the screen reader says only "button" without the selected state, do not mark that case PASS. Only enter invented/test customer details, not actual names or phone numbers.

| Test | Expected observable behaviour | Owner result |
|---|---|---|
| Sidebar navigation | Overview, Fleet, Rentals announce meaningful destinations **and which workspace is checked/selected**; Tab/Shift+Tab and Space activate without unrelated actions | NOT TESTED |
| Fleet Gallery/Table | Two options announce distinguishable names, and the **currently selected** option. Switching via Space updates what Narrator announces | NOT TESTED |
| Fleet search/status/sort | Input names announce clearly; caret arrows edit Search, ComboBox arrows change options, with visible focus | NOT TESTED |
| Fleet card/table selection | Arrow keys select the visible vehicle with C++ ID retained; Inspector and highlight agree; Escape clears selected vehicle only in visible Fleet | NOT TESTED |
| Rentals All/Active/History | Each option announces its name and selected/checked state; changing via Space updates the announcement | NOT TESTED |
| Rentals list | One Tab stop for the list; arrows navigate records; rental ID, vehicle, status, **due-state, total amount and currently selected record** are announced without exposing customer names or phone numbers | NOT TESTED |
| New rental dialog | Initial focus on Vehicle ID, labeled Days/Customer/Phone fields, quote/Cancel/Confirm actions. Escape cancels and restores focus | NOT TESTED |
| Return/Archive confirmations | Modal focus begins on Cancel, Tab/Shift+Tab remain inside; Escape cancels and returns to the correct action. Never submit a real transaction | NOT TESTED |
| Reduced motion | Test Windows system animation setting as supported; focus remains immediate; only optional selection tint fade changes | NOT TESTED |

## Native display and visual acceptance

- Record **Settings > System > Display** monitor resolution, actual OS Scale and screen orientation. Start with the existing **150% / 1920 × 1080** owner baseline; test 100% and 125% only if supported and safe. Do not alter settings automatically or force unsupported monitor modes.
- At each supported scale, run the compiled Qt application and exercise live mouse resize, focus rings, all dialog buttons, label legibility, table/gallery overflow and any clipping. Check the two supported logical viewport targets (1500×860 and 1280×720) only where the current logical desktop area fits. At 150% on 1920×1080 the usable logical desktop height may be **less than 720** because of the taskbar.
- Record **PASS / FAIL / NOT TESTED** separately for each supported scale. A screenshot of Windows Settings proves a setting, not simultaneous Qt rendering.
- Keep screenshots cropped to application content with invented records only. Do not upload Settings screenshots containing account names or other identifiers. Never change production rental files for this review.

## Evidence and acceptance decision

Capture the source SHA, Qt version/compiler, Qt Creator version (if used), Windows edition, actual scale, window sizes, keyboard/Narrator observations, failures and application-only screenshots. Keep the **generated report and logs local** until you inspect them for private information. Share only sanitized evidence.

A PASS on packaged automation is **not** Narrator PASS. A Qt accessible role/checked-state test is **not** audible screen-reader proof. A physical screen-reader failure requires a specific defect and a tested fix. **P4 #4 and #7 remain OPEN** until exact-source manual evidence and explicit owner approval. Stable `main`, stacked Draft PR #10 and original customer files must remain untouched.
