# Rental Studio 2.0 | Current physical Windows review sheet

**Prepared:** 6 November 2026. **Status:** AWAITING OWNER-DEVICE EVIDENCE; every new physical check below is **NOT TESTED**. This is a current-source companion to [the already-approved single-session P1/P2/P4 review process](P1_P2_P4_ONE_SESSION_PHYSICAL_REVIEW_2026-11-03.md), not a new milestone, feature or acceptance scheme.

## Exact source and safety

- **Repo:** `Sonkhe-Shongwe/vehicle-rental-system`; **working branch:** `feature/p7-sqlite-sandbox-20261102`; **draft PR:** [#17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), based on the unmerged P6 branch.
- **Last exact-source hosted-verified executable:** [`db005e21e426a19932ff1afc708b7ba2c0239b46`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/db005e21e426a19932ff1afc708b7ba2c0239b46), [Actions #42199989157](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42199989157): Linux GCC and Windows MSVC 140/140 Qt native CTests **each**, Windows packaged fictional 8/8 and PS5.1 PASS. **Not a physical MinGW result.**
- **Source HEAD when prepared:** `2f7044b6835563ff7a80b724f542525e808fb7f4`, a **documentation-only** commit after the tested executable. Fetch live branch HEAD and log the actual local SHA before executing; if HEAD changes, confirm whether it changes compiled source.
- **Owner's kit to inspect:** Qt Creator 6.10.2, Desktop Qt 6.10.2 MinGW 64-bit, locally compiled `rental_studio_qtquick_spike`. Do not run the legacy Widgets app by mistake. P7 SQLite remains opt-in generated-fictional-only. No genuine customer information, real licence records, live payments or production database.

## First run, using existing local source checkout

1. In **GitHub Desktop**, verify the repository and **Current Branch** `feature/p7-sqlite-sandbox-20261102`. Check **Changes** first and save/stash any uncommitted work; **Fetch origin**, then **Pull origin** only when safe. Do **not** merge any PR, switch to `main`, reset/clean hard or overwrite protected fixtures.
2. Select **Repository → Open in Explorer**. If needed, open Qt Creator → **File → Open File or Project** → repo-root `CMakeLists.txt`.
3. Select the existing **Desktop Qt 6.10.2 MinGW 64-bit** kit, the `rental-studio-local` CMake preset if offered, or verify equivalent cache flags: `BUILD_QTQUICK_P2_SPIKE=ON`, `BUILD_TESTING=ON`, `BUILD_P7_SQLITE_SANDBOX=ON`. Expected private ignored build folder `build/rental-studio-local`. Do not disable a failed required module silently.
4. Choose **Run target** `rental_studio_qtquick_spike` and **Build/Run** in Qt Creator (typically Ctrl+R). Confirm **Overview, Fleet, Rentals** are the only main workspaces and **New Rental** is a command. Record whether configuration, build and startup succeeded.
5. Record read-only local identity from GitHub Desktop History or a terminal in the repo root: `git branch --show-current`, `git rev-parse HEAD`, `git status --short`. Do not mistake the docs-only HEAD for a separately hosted-tested executable.
6. If there is a failure, keep the first error line(s), kit, SHA, and application-only screenshot. Do not modify source, image licences or the fixture files to bypass a test.

## Physical observations to perform, in order

Use the actual Windows **Settings → System → Display** scale. The prior owner baseline was 1920×1080 pixels at 150%; at that scale the available **logical** desktop may be around 1280×720 *before* taskbar, so a 1500×860 logical window cannot fit physically without changing scaling or resolution. Check **1280×720** logical composition at current 150% where feasible; separately check **1500×860** at a scale/resolution with sufficient work area. Other 100%/125% scales only if Windows supports them and the owner is comfortable changing them.

| ID | Actual on-device action / expected observation | Result (PASS / FAIL / NOT TESTED) | Evidence or defect |
|---|---|---|---|
| PC-01 | Qt Creator 6.10.2 MinGW configures, builds and launches the current `rental_studio_qtquick_spike` without modifying protected demo fixtures | NOT TESTED | |
| PC-02 | Overview: source-backed totals, active booked **contractual** value (not collected revenue), recent rental and overdue state read correctly; no clipped information or invented records | NOT TESTED | |
| PC-03 | Fleet: Gallery ↔ Table, selected same C++ vehicle ID, search/filter/sort, rented status disables Book, correct reference image or honest silhouette | NOT TESTED | |
| PC-04 | Fleet photo: Reference/Illustration label, creator/licence source, uncropped full view, Close/Escape focus return and View full/Restore default remain separated | NOT TESTED | |
| PC-05 | Rentals: statuses and due-timing are distinct; register/inspector show correct contract, all lower controls reachable without clipped archived Delete; New Rental remains command | NOT TESTED | |
| PC-06 | Keyboard: Tab/Shift+Tab/Enter/Space/arrows/Escape traverse all three workspaces, fields preserve caret arrows, selected ID never silently switches, modal Cancel/Close restores focus | NOT TESTED | |
| PC-07 | Display: real OS 150% baseline and 100%/125% where supported, practical window dimensions, no clipping, fuzzy content, input target overlap or unreadable text | NOT TESTED | |
| PC-08 | Narrator: Win+Ctrl+Enter on/off; announced workspace/button/field names, selected status, contract value and dialogs are meaningful; no focus trap | NOT TESTED | |
| PC-09 | Editorial Automotive Light: premium light Navy/Emerald/Cloud hierarchy, information density, appropriate representative model photography, honest attribution, professional layout approved or specific issues recorded | NOT TESTED | |
| PC-10 | Optional native test run using correctly configured local Qt/MinGW build: `cmake --build --preset rental-studio-local-all`, then `ctest --preset rental-studio-local-all`; exact count/output retained; skipped if toolchain shell unavailable | NOT TESTED | |

The current native hosted suite is **140 tests per OS**, but **do not prefill local CTest** with hosted results. Running Ctrl+R only proves build/run, not CTest. For Narrator, record actual spoken behaviour, not simply the presence of accessibility names in QML. For a failure, write: **ID, steps, expected, actual, scale, window size, local SHA, kit and cropped app-only screenshot/log**.

## Review-to-acceptance mapping, unchanged criteria

| Open existing review handle | Current formal status | Relevant physical evidence |
|---|---|---|
| P1 images | OPEN | PC-03/04/09; requires actual licensed cohesive image set plus owner acceptance, not just existing image-source metadata |
| P1 whole-product visual | OPEN | PC-02/03/04/05/07/09 and explicit owner verdict |
| P1 broad accessibility | OPEN | PC-06/07/08 |
| P2 exact local kit | OPEN | PC-01, optional PC-10, recorded source SHA/compiler |
| P2 physical scaling and Fleet input | OPEN | PC-03/06/07 |
| P4 #4 actual whole-product keyboard/Narrator | OPEN | PC-06/08 |
| P4 #7 physical Windows accessibility/motion | OPEN | PC-06/07/08 and OS motion preference observation |

**Formal score before review:** P1 7/10, P2 4/6, P4 5/7; overall **45/74 criteria, weighted 70.6%, P7 0/8**. **No new criterion is accepted by preparing this sheet.** Evidence plus the owner's explicit criterion-specific decision is required; do not infer all seven checks are cleared just because one screenshot looks good. P5 8/8 and P6 9/9 prior signoffs stay intact.

## Review record (owner can share sanitized output in chat)

- **Local branch:** NOT RECORDED
- **Local HEAD:** NOT RECORDED
- **Qt Creator / kit / compiler:** NOT RECORDED
- **Windows version / monitor resolution:** NOT RECORDED
- **Actual current OS scale:** NOT RECORDED
- **Local build and launch:** NOT TESTED
- **First application-only screenshot / error:** NOT RECEIVED
- **Owner physical verdict:** PENDING
- **Next exact action:** owner performs PC-01: safe GitHub Desktop pull, Qt Creator Build/Run on current feature branch and shares **Overview app screenshot or first build error**, plus kit/scale/SHA information. Then record results sequentially; do not promote formal scores until eligible owner decision.

Refer to [day-to-day source pull workflow](DAILY_GITHUB_DESKTOP_QT_CREATOR_NO_ZIP_WORKFLOW_2026-11-05.md), [existing physical review methodology](P1_P2_P4_ONE_SESSION_PHYSICAL_REVIEW_2026-11-03.md), [verified checkpoint](LATEST_CHECKPOINT.md), and [live handoff](LIVE_HANDOFF_STATE.md).
