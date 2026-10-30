> **30 October 2026 | LATEST VERIFIED P2 ON-DEVICE TEST PACKAGE:** [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) source `3620d83518cc01bce047b6f0a17deab0b96079b6` passed [GitHub Actions run 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629): **8/8 native CTests each on Linux/GCC and hosted Windows/MSVC**, plus Windows **`windeployqt` portable review bundle**, relocated C++ self-test and native QML smoke PASS, and deliberately altered fictional-fixture rejection PASS. [Evidence report on P2 source branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_WINDOWS_PHYSICAL_KIT_VERIFIED_2026-10-30.md). Download **`p2-windows-physical-acceptance-kit`** from workflow artifacts (7-day retention) and follow `WINDOWS_PHYSICAL_ACCEPTANCE.md` on the user's own Windows PC. The kit contains only fake-demo records and QT DLL/QML components, **NOT a release**. **P2 stays 3/6 (50%), overall weighted 18.4%** until real user's Windows/Qt Creator kit, actual display scaling and toolkit approval are observed; P1 owner design/licensed imagery/accessibility remain pending. Stable main and Draft PR #4/#6 unmerged.

> **Latest P2 verification, 30 October 2026:** Isolated [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) source `eeb08485245ef127d6a9e53c2d80ec68bca66c0b` achieved **8/8 real native Qt6.8.3 CTests on both Linux/GCC and hosted Windows/MSVC2022** in [run 41045646448](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045646448). Added real Qt keyboard/row selection, Escape, dynamic window resize and **synthetic** `QT_SCALE_FACTOR=1.25/1.5` test captures. Windows/Linux PNG screenshots visually inspected at 1500×860, 1280×720, synthetic 1280×825 and 1536×990 pixels. Prior run [41045247197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045247197) **FAILED 7/8** due row lookup in a dynamic ListView; fixed with QQuickItem visual hierarchy without weakening keyboard assertions. [Full verified report](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_NATIVE_INPUT_DPI_VERIFIED_2026-10-30.md). **P2 3/6 (50%), overall weighted evidence 18.4%**: hosted/synthetic tests do not fulfill owner's physical Windows Qt Creator/100–150% DPI, final toolkit go/no-go or P1 design signoff. Stable main and both Draft PRs remain untouched/unmerged.

> **LATEST VERIFIED P2 CHECKPOINT | 30 October 2026:** Separate [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) source branch `spike/p2-qtquick-fleet-20261030` implemented read-only real C++/QML Fleet model and shared Gallery/Table/Inspector. **Exact tested code SHA `f45147d05d3449ffc89514fb1e685e2990c843fc`**: [GitHub Actions run 41043137443](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41043137443) PASS **5/5 CTests Linux Qt6.8.3/GCC** and **5/5 Windows Server 2022 Qt6.8.3/MSVC**; eight genuine compiled Qt screenshot PNGs inspected with precise 1500×860 and 1280×720 sizes. Windows tofu fonts and screenshot-size clipping fixed. Latest P2 branch docs checkpoint `137055e4bf7ebaa878ea4ce30f8eb0b2b61469a2`; [detailed P2 report on spike branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_QTQUICK_NATIVE_CI_VERIFIED_2026-10-30.md). **P2 3/6 (50%); overall weighted progress 18.4%**, not release readiness. **Still pending:** owner physical Windows Qt Creator kit, actual OS DPI 100/125/150%, keyboard/accessibility, toolkit go/no-go, final P1 design/image/owner signoff. Draft PR #6 and old Draft PR #4 remain OPEN/UNMERGED; stable main untouched. The older checkpoint lines below are dated history.

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
