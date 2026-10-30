# Rental Studio 2.0 | Current Windows P2 Physical Acceptance

**Status: PARTIALLY VERIFIED on owner's PC, 30 October 2026.** [Current state](PROJECT_STATE_CANONICAL.md) · [Evidence audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md).

**Actually observed on owner's Windows Qt Creator:** Qt Quick P2 read-only Fleet compiled and launched using **Desktop Qt 6.10.2 MinGW 64-bit Debug**. Screenshots show Corolla C001 selected in Gallery/Inspector (4 doors, R450/day, Available), unchanged C001 selection in Table, four available vehicles when filtered (rented Ford Ranger excluded), ascending Rate Honda R280 → Yamaha R300 → Hyundai R400 → Corolla R450, and **Escape clears the Inspector**. This evidence is PASS only for those pictured/confirmed operations.

**New real physical Windows display-settings evidence (30 October 2026):** User screenshot of **Settings → System → Display** confirms **150% (Recommended)** scale, **1920 × 1080 (Recommended)** physical resolution and Landscape orientation. The Settings screenshot contains personal account identifiers, so only its technical values are logged on [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5#issuecomment-6523145162), never the full image. This verifies the OS **setting**, not a simultaneous Qt app rendering at that scale, physical 100/125% behavior, full keyboard support or a measured 1500×860 logical viewport. At 150% the nominal logical desktop is ~1280×720 before taskbar, so a 1500×860 logical window cannot fit fully; don't call that clipping a UI defect. **P2 still 3/6, weighted 18.4%.**

## Physical acceptance outstanding

| Item | Status / next evidence |
|---|---|
| Exact local git SHA and Qt Creator application version | Not supplied; record from local checkout and About Qt Creator |
| Local full CTest output | Not supplied; run against the actual Debug build directory |
| Windows physical Display Scale at 100%,125%,150% | **150% Recommended, 1920×1080 Recommended, Landscape confirmed** by owner's real Settings screenshot (30 Oct 2026). Application-at-scale test and supported 100%/125% comparisons remain **NOT TESTED**. Never infer scale from Qt PNG pixel size |
| Actual 1500×860 and 1280×720 logical Qt window, live drag resize | Screenshots show a usable compact window, not a formally measured two-size run |
| Manual Tab/Shift+Tab, Enter/Space and arrow/focus controls | Not fully tested; preserve normal text caret behavior |
| Accessibility/zoom/screen reader | Not independently audited |
| Final Qt Quick technology go/no-go | OWNER DECISION PENDING |

**Safe test:** GitHub Desktop selects `spike/p2-qtquick-fleet-20261030`, Fetch/Pull origin. Open **root CMakeLists.txt** in Qt Creator (Qt Quick modules installed), set **BUILD_QTQUICK_P2_SPIKE=ON**, **BUILD_TESTING=ON** and use a fresh CMake build directory after relocation. Run target **rental_studio_qtquick_spike**. Record source commit via `git rev-parse HEAD`; capture local CTest output and application-only screenshots with no customer data. Do not force unsupported Windows display scaling or edit live rental files.

**Keyboard design choice for later P4:** predictable focus groups: Tab/Shift+Tab between regions, Up/Down in lists/tables, Left/Right for appropriate sibling items, Enter/Space activate and Escape dismiss. No global nearest-pixel arrow handler, no hijacking TextField arrow keys. Escape is confirmed; more arrows are **not implemented/approved today**.

**Observation to investigate:** top Gallery row partly out of frame in one selected vehicle screenshot, possibly retained list scroll; not proven bug.

**Portable alternative:** [GitHub Actions 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629) produced a `windeployqt` Windows QA ZIP that passed hosted relocation/model/QML/fixture-tamper smoke; artifact retention is limited. It is **not** an installed local Qt Creator kit, a finished app or a production installer.

After real physical evidence and explicit owner go/no-go, only then close P2; P1 image/accessibility/final owner visual acceptance remains separate. **P2 3/6, weighted 18.4% remain unchanged.**
