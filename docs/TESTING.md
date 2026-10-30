> **30 October 2026 | NEW P2 PORTABLE WINDOWS ON-DEVICE REVIEW KIT (latest):** Source `3620d83518cc01bce047b6f0a17deab0b96079b6` on [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) compiled and passed **8/8 real CTests Linux Qt6.8.3 and 8/8 Windows Qt6.8.3** in [Actions 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629). Additionally Windows used `windeployqt` to build a self-contained **review-only** portable kit, with only fictional SHA-256-pinned demo data and on-device PowerShell validation script. **PASS** packaged real C++ model and QML compact smoke after relocation, deliberate tampered-demo rejection and ZIP integrity. [Portable kit evidence](P2_WINDOWS_PHYSICAL_KIT_VERIFIED_2026-10-30.md); Windows Actions artifact `p2-windows-physical-acceptance-kit` ID `12972169619` (7-day retention). **Owner's physical Windows/Qt Creator and 100/125/150% OS scaling still NOT TESTED**, no toolkit go/no-go; **P2 remains 3/6 (50%), weighted overall 18.4%**. P1 licensed imagery/accessibility/owner full-design approval still OPEN. Both Draft PRs unmerged; main untouched. Previous older lines below are dated history.

> **30 October 2026 | CURRENT VERIFIED P2 NATIVE KEYBOARD/DPI CHECKPOINT:** New actual source `eeb08485245ef127d6a9e53c2d80ec68bca66c0b` passed [Linux+Windows Qt6.8.3 Actions run 41045646448](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045646448): **8/8 CTests on each** including C++ Fleet, compiled QML Gallery/Table at 1500×860 and 1280×720, **real Qt Test Space/Escape selection**, live resizing, and **synthetic Qt scaling 125/150%**. Twelve real Qt Quick PNGs across both platforms inspected for actual dimensions and representative layouts. Initial run [41045247197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045247197) **FAILED 7/8**, fixed actual QML ListView delegate test lookup and reran without weakening assertions. [Detailed latest report](P2_NATIVE_INPUT_DPI_VERIFIED_2026-10-30.md). **P2 still 3/6 (50%), weighted total still 18.4%**, because physical owner's Windows 100/125/150%, Qt Creator kit and toolkit go/no-go are NOT VERIFIED. P1 imagery/accessibility/owner signoff remains open. PR #6 stays draft; PR #4 unmerged; main untouched. Earlier dated source-unverified notes below are superseded.

> **30 October 2026 | LATEST P2 SOURCE AHEAD OF VERIFIED RUN:** New native QTest keyboard/live-resize and synthetic 125%/150% DPR smoke paths were committed at `eb7bb9e22c5e3a2bd2525068202ddd2899783ae7` on Draft PR #6. [Exact source-stage report](P2_KEYBOARD_DPI_SOURCE_PENDING_2026-10-30.md). GitHub source/static review verified, **but no new Actions run for that SHA was reported at inspection**: do NOT reuse prior passes as evidence for these new tests. Previous compiled P2 CI at `f45147d` remains Linux/Windows 5/5; **P2 3/6 (50%) and weighted 18.4% unchanged**. Physical owner Windows Qt Creator/DPI and owner P1 signoff remain pending. Main and old Draft PR #4 remain untouched.

> **30 October 2026 CURRENT native Qt Quick P2 evidence (supersedes earlier missing-SDK notes):** [Verified test report](P2_QTQUICK_NATIVE_CI_VERIFIED_2026-10-30.md) for source SHA `f45147d05d3449ffc89514fb1e685e2990c843fc`. Hosted Ubuntu 24.04/GCC/Qt6.8.3 and Windows Server 2022/MSVC2022/Qt6.8.3 each **5/5 CTests PASS** in [run 41043137443](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41043137443); legacy baseline 2/2 PASS in [41043137394](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41043137394). Eight real compiled Qt Quick screenshot PNGs inspected, strict actual **1500×860 / 1280×720** dimensions. Physical Windows Qt Creator, 100/125/150%, real keyboard/screen-reader, production persistence and release **NOT VERIFIED**.

> **30 October 2026 P2 blocker:** [QML Fleet source and native-test plan](P2_QTQUICK_SPIKE_SOURCE_REPORT_2026-10-30.md). CMake probe for Qt6 6.5+ Core/Gui/Qml/Quick/QuickControls2 **FAILED** due missing Qt6Config. No compiled Qt Quick application, no P2 self-test execution, no Qt Creator Windows or physical DPI run; source-only checks cannot satisfy P2 acceptance.

> **30 October 2026 corrected R1 browser-only regression checkpoint:** [Independent design and usability evidence](../design/r1/FINAL_VISUAL_AUDIT_2026-10-30.md). Corrected HTML source SHA `0de4376e35b08ef073399da23455ce8fe860e502b2207b145529435f055a3363`. Debian 13 Chromium 144 Playwright headless PASS **19/19 original + 63/63 new targeted checks**, with clean wide/compact browser captures. This is **NOT a CMake, CTest, QML, Windows/native DPI, persistence or release result**. Formal [P0–P9 evidence and progress policy](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) now governs completion claims.

> **30 October 2026 R1 browser review evidence (NOT Qt evidence):** [Full owner-theme interactive review and checks](../design/r1/OWNER_THEME_FULL_PRODUCT_BROWSER_REVIEW_2026-10-30.md). Source was tested under Debian 13 / Chromium 144 / Playwright on fictional browser-memory data, with 14 principal viewport captures and checks for search, guided quote, cancel, create, return, empty, long text and simulated failure. **No new CMake/CTest, Qt Quick, physical Windows DPI, disk persistence or owner final aesthetic acceptance occurred.** Older source Qt Widgets CI pass remains historical only.

# Testing Policy and Evidence — Product Rebuild

**Decision date:** 29 October 2026  
**Status:** new testing policy; **no new presentation code tested**.  
**Governing source:** [Master Rebuild Audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md).

## What is actually verified, and what is not

**Historical Qt Widgets source only:** exact implementation/photo revision be184b6 has:
- [Ubuntu/Qt6/GCC run 40944222722](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222722): build, CTest **2/2**, ten genuine compiled Qt offscreen captures.
- [Windows Server 2022/MSVC2022/Qt6.8.3 run 40944222486](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222486): build, CTest **2/2**, **20** genuine compiled Qt offscreen screenshots across five screens, two standard sizes and synthetic 125/150% QT_SCALE_FACTOR rendering, original demo fixture SHA-256 unchanged.
- Existing tests cover domain lifecycle, duplicate booking rejection, restart, no/decline confirmation, some keyboard input, status contrast and geometry.

**Not verified:** rebuilt QML UI (doesn't exist), real native Windows Qt Creator human interactions, physical 100/125/150% Windows display scale, redesigned full-page visual quality, final photography, installer, migrations, production recoverability or owner signoff.

The prior detailed test results are preserved **exactly** at [Historical Qt Testing](archive/TESTING_QT_WIDGETS_PRE_RESET_2026-10-29.md). Do not reframe those runs as acceptance of future code.

## Testing pyramid for the new presentation

1. **Pure domain and use case tests:** availability, pricing, date handling, unique identifiers, create/return/archive/delete state transitions, invalid values and persistence on failure. Deterministic fictional data.
2. **Application boundary/model tests:** QAbstractListModel and exposed QObject properties/commands if QML selected; correct selection/filter, date/price binding, signal emissions, non-mutating cancel and error messages.
3. **Real UI interaction tests:** Qt Quick Test / QTest as appropriate for chosen stack; Gallery↔Table state preservation, drawer, keyboard, stepper validation, rental review and return. Test actual compiled UI, not a browser concept.
4. **Visual/state checks:** screenshot comparison at controlled platform/size/font versions, geometry/visibility, long text, state variants, source image appropriateness. PNG CRC alone is insufficient; human design review mandatory.
5. **Physical Windows acceptance:** actual Qt Creator kit and native monitor scale. Record screenshots and observed issues locally; no fake passing rows.
6. **Cross-platform independent CI:** CMake + domain/UI tests on Linux/Windows (when Actions/account allowance permits) on the exact build candidate, never inferred from a previous SHA.

## Minimum functional parity

- Add Car/Motorcycle; generated unique IDs; duplicate and invalid input rejection.
- Fleet search/filter and correct available/rented status; selection reflected in both Gallery and Table.
- Same-day 1–365 day rental; correctly recomputed quote, duplicate booking refusal, future due date and restart persistence.
- Return existing rental; reject double return; archive only returned; delete only archived.
- Declined or Escape-confirmation actions leave in-memory state **and on-disk files** unchanged.
- Invalid/failed data write produces visible actionable error; do not silently claim success.
- No personally identifying user data in tests, assets, screenshots, PR artifacts or build logs.

## CI usage and source management

No Actions runs for documentation-only updates while owner-reported usage limit is unresolved. This repository is public (normal standard GitHub-hosted runner cost may differ from account-specific limits), so identify the actual notice before asserting quota exhaustion. Do local Qt Creator/CMake/CTest first. Staged [CI optimisation branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/docs/ci-budget-development-strategy-20261029) includes artifact-first screenshots, conservative docs-only CI classification, concurrency and local Windows helper; **staged only, not hosted-tested or integrated**.

## New evidence record per significant change

| Field | Value |
|---|---|
| Commit SHA | exact source to reproduce |
| Date, kit, Windows version, physical scale | actually observed |
| Test commands | real commands, with pass/fail |
| Evidence | log / screenshot / artifact (fake data only) |
| Behaviour and UX states inspected | explicit positive + negative cases |
| Blockers | unverified or failed gates |
| Owner visual approval | explicit yes/no, not inferred |
| Branch status | whether merged/released |

**Release condition:** all required tests, actual Windows acceptance, aesthetic signoff and separately validated persistence/migration. The new UI does **not** inherit acceptance from old Qt Widgets screenshots.
