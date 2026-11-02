# Rental Studio 2.0 | Windows physical and operator acceptance

**Current 2 November 2026:** The new polished P6/P7 stacked Qt Quick application has passing hosted Linux/Windows native CI, but **has not completed a consolidated owner physical-device review** at actual Windows 100/125/150% scaling, Qt Creator 6.10.2 MinGW, keyboard/focus and Narrator. The current physical evidence is earlier P2 local Qt Creator screenshots and two later P6 static Fleet screenshots, not a complete physical test matrix. [Current checkpoint](LATEST_CHECKPOINT.md) | [P6-P compiled UI evidence](P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md) | [Full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md).

## Next single consolidated owner review (NOT YET EXECUTED)

Use the **last verified generated-fictional** Windows review kit linked from a current native CI run, not a historical expired artifact. Capture exact source SHA and Windows/Qt kit version before relying on observations. Check Overview, Fleet Gallery/Table/filter/selection/empty, Add vehicle, Rentals quote/confirm/cancel/stale/duplicate, Return/History/Archive, domain restart, and the actual keyboard/scale/Narrator/clip behavior. Distinguish each criterion as PASS, FAIL or NOT TESTED. Do not enter or upload genuine customers. A packaged hosted Windows acceptance kit is **not an installer or release**. No formal P5/P6 or final physical acceptance has been recorded.

## Historical P2 owner physical evidence (30 October 2026)

### Historical P2 physical observation log

**Status: PARTIALLY VERIFIED on owner's PC, 30 October 2026.** [Current state](PROJECT_STATE_CANONICAL.md) · [Evidence audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md).

**Actually observed on owner's Windows Qt Creator:** Qt Quick P2 read-only Fleet compiled and launched using **Desktop Qt 6.10.2 MinGW 64-bit Debug**. Screenshots show Corolla C001 selected in Gallery/Inspector (4 doors, R450/day, Available), unchanged C001 selection in Table, four available vehicles when filtered (rented Ford Ranger excluded), ascending Rate Honda R280 → Yamaha R300 → Hyundai R400 → Corolla R450, and **Escape clears the Inspector**. This evidence is PASS only for those pictured/confirmed operations.

**New real physical Windows display-settings evidence (30 October 2026):** User screenshot of **Settings → System → Display** confirms **150% (Recommended)** scale, **1920 × 1080 (Recommended)** physical resolution and Landscape orientation. The Settings screenshot contains personal account identifiers, so only its technical values are logged on [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5#issuecomment-6523145162), never the full image. This verifies the OS **setting**, not a simultaneous Qt app rendering at that scale, physical 100/125% behavior, full keyboard support or a measured 1500×860 logical viewport. At 150% the nominal logical desktop is ~1280×720 before taskbar, so a 1500×860 logical window cannot fit fully; don't call that clipping a UI defect. **P2 still 3/6, weighted 18.4%.**

**Adopted interaction direction:** [UX-CTRL-001 contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) is owner-approved, but the source's latest Fleet arrow/focus implementation still requires actual local Qt6.10.2 MinGW feel/smoothness testing. Test arrows selecting vehicles (not free-scrolling), responsive column changes, filtered/last-row boundaries, Inspector identity, Tab/Shift+Tab target sequence and visible focus, native search/dropdown editing and dismiss priority. Use real Windows 150%/1920×1080 baseline without forcing 1500×860 logical window to fit. **Do not interpret policy approval as physical test PASS.**

**NEW P2 FLEET STATE/FOCUS REGRESSION (30 Oct 2026):** [Verified fix at `0f5668d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0f5668d8ef359d84aa0901c0b5ccdb3ff8cb27df) now clears the selected Inspector if a filter hides the vehicle, keeps Gallery/Table keyboard `currentIndex` aligned to the stable C++ ID after query/filter/sort, and avoids stray boundary scrolling. Added real QML `rental_studio_p2_focus_edges` CTest. Initial [run 41064963032](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41064963032) FAILED 9/10 each due stale earlier model expectation; expectation fixed without disabling tests. [Run 41065470256](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41065470256) at exact source `0f5668d`: **Linux Qt6.8.3 10/10 PASS, Windows Qt6.8.3 10/10 PASS**, Windows portable packaging PASS. [Detailed test evidence](P2_FLEET_FOCUS_EDGES_VERIFIED_2026-10-30.md). **Owner's latest Qt6.10.2 MinGW physical focus smoothness and 150% app-at-scale review PENDING**, P2 3/6 (50%), weighted 18.4% unchanged. UX-CTRL-001 remains owner-approved design only, not full hardware gate.

## Physical acceptance outstanding

| Item | Status / next evidence |
|---|---|
| Exact local git SHA and Qt Creator application version | Not supplied; record from local checkout and About Qt Creator |
| Local full CTest output | Not supplied; run against the actual Debug build directory |
| Windows physical Display Scale at 100%,125%,150% | **150% Recommended, 1920×1080 Recommended, Landscape confirmed** by owner's real Settings screenshot (30 Oct 2026). Application-at-scale test and supported 100%/125% comparisons remain **NOT TESTED**. Never infer scale from Qt PNG pixel size |
| Actual 1500×860 and 1280×720 logical Qt window, live drag resize | Screenshots show a usable compact window, not a formally measured two-size run |
| Manual Tab/Shift+Tab, Enter/Space and arrow/focus controls | User confirms Tab and Shift+Tab worked in prior MinGW build; new Gallery/Table arrow selection **hosted 9/9 PASS**, but latest local build and focus smoothness/accuracy still NOT TESTED |
| Accessibility/zoom/screen reader | Not independently audited |
| Final Qt Quick technology go/no-go | OWNER DECISION PENDING |

**Safe test:** GitHub Desktop selects `spike/p2-qtquick-fleet-20261030`, Fetch/Pull origin. Open **root CMakeLists.txt** in Qt Creator (Qt Quick modules installed), set **BUILD_QTQUICK_P2_SPIKE=ON**, **BUILD_TESTING=ON** and use a fresh CMake build directory after relocation. Run target **rental_studio_qtquick_spike**. Record source commit via `git rev-parse HEAD`; capture local CTest output and application-only screenshots with no customer data. Do not force unsupported Windows display scaling or edit live rental files.

**Keyboard direction:** Gallery Up/Down/Left/Right and Table Up/Down native selection ARE NOW IMPLEMENTED in P2 source with 9/9 Linux/Windows hosted tests, but user must pull/retest on their Qt6.10.2 MinGW Windows PC. P4 will extend the pattern to the complete product. Tab/Shift+Tab user-confirmed, full focus order and smoothness still open. No nearest-pixel global handler or stolen TextField arrow keys.

**Observation to investigate:** top Gallery row partly out of frame in one selected vehicle screenshot, possibly retained list scroll; not proven bug.

**Portable alternative:** [GitHub Actions 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629) produced a `windeployqt` Windows QA ZIP that passed hosted relocation/model/QML/fixture-tamper smoke; artifact retention is limited. It is **not** an installed local Qt Creator kit, a finished app or a production installer.

Owner Qt Quick technology GO is now recorded; remaining physical evidence is still needed before closing P2; P1 image/accessibility/final owner visual acceptance remains separate. **P2 3/6, weighted 18.4% remain unchanged.**
