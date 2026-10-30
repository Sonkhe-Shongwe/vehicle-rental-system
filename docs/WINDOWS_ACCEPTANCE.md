> **LATEST P2 FLEET KEYBOARD CHECKPOINT (30 October 2026):** Owner confirms **Tab and Shift+Tab worked** locally but reports **Gallery arrows merely scrolled instead of selecting vehicles** in the previous Qt Creator build. [Source fix `f486c8a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f486c8a32b156ddeec1816b2ab2a4811c2c45431) now makes Gallery arrows select spatially adjacent C++ vehicle IDs (Up/Down/Left/Right), Table Up/Down select rows, and keyboard focus visibly distinct from selection. Text field/combo arrows retain native behaviour, Tab/Backtab traverse groups. [Qt6.8.3 Actions run 41059423971](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41059423971) **PASS 9/9 native CTests Linux AND 9/9 Windows**, including new real keyboard arrows, no stand-alone Gallery scroll, search caret noninterference, filter parity, Tab/Shift+Tab, and previously verified portable fake-fixture safeguards. **New source has NOT yet been pulled/rebuilt/accepted on owner's Qt6.10.2 MinGW PC:** focus order/smoothness, hardware scale and full-product accessibility pending. **P2 remains 3/6 (50%), weighted coverage 18.4%**, not release readiness. Historical 8/8 results or 'no arrows implemented' text below represent an earlier code stage.

# Rental Studio 2.0 | Current Windows P2 Physical Acceptance

**Status: PARTIALLY VERIFIED on owner's PC, 30 October 2026.** [Current state](PROJECT_STATE_CANONICAL.md) · [Evidence audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md).

**Actually observed on owner's Windows Qt Creator:** Qt Quick P2 read-only Fleet compiled and launched using **Desktop Qt 6.10.2 MinGW 64-bit Debug**. Screenshots show Corolla C001 selected in Gallery/Inspector (4 doors, R450/day, Available), unchanged C001 selection in Table, four available vehicles when filtered (rented Ford Ranger excluded), ascending Rate Honda R280 → Yamaha R300 → Hyundai R400 → Corolla R450, and **Escape clears the Inspector**. This evidence is PASS only for those pictured/confirmed operations.

**New real physical Windows display-settings evidence (30 October 2026):** User screenshot of **Settings → System → Display** confirms **150% (Recommended)** scale, **1920 × 1080 (Recommended)** physical resolution and Landscape orientation. The Settings screenshot contains personal account identifiers, so only its technical values are logged on [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5#issuecomment-6523145162), never the full image. This verifies the OS **setting**, not a simultaneous Qt app rendering at that scale, physical 100/125% behavior, full keyboard support or a measured 1500×860 logical viewport. At 150% the nominal logical desktop is ~1280×720 before taskbar, so a 1500×860 logical window cannot fit fully; don't call that clipping a UI defect. **P2 still 3/6, weighted 18.4%.**

**Adopted interaction direction:** [UX-CTRL-001 contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) is owner-approved, but the source's latest Fleet arrow/focus implementation still requires actual local Qt6.10.2 MinGW feel/smoothness testing. Test arrows selecting vehicles (not free-scrolling), responsive column changes, filtered/last-row boundaries, Inspector identity, Tab/Shift+Tab target sequence and visible focus, native search/dropdown editing and dismiss priority. Use real Windows 150%/1920×1080 baseline without forcing 1500×860 logical window to fit. **Do not interpret policy approval as physical test PASS.**

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

After real physical evidence and explicit owner go/no-go, only then close P2; P1 image/accessibility/final owner visual acceptance remains separate. **P2 3/6, weighted 18.4% remain unchanged.**
