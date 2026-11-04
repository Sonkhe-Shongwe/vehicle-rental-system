# Rental Studio 2.0 | UX-CTRL-003 bidirectional keyboard implementation: exact-source native verification

**Date:** 4 November 2026, Africa/Johannesburg.  
**Approved specification:** [UX-CTRL-003 owner navigation contract](UX_CTRL_003_OWNER_APPROVED_SEAMLESS_BIDIRECTIONAL_NAVIGATION_2026-11-04.md), refining UX-CTRL-002.  
**Exact compiled source:** [`922674c9e253fca2c8ef75b1c3e95fe51a8dd94b`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/922674c9e253fca2c8ef75b1c3e95fe51a8dd94b).  
**Final successful hosted run:** [GitHub Actions #41839473216](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41839473216), push event, completed **success**, exact `head_sha` `922674c9e253fca2c8ef75b1c3e95fe51a8dd94b`.  
**GitHub branch:** `feature/p7-sqlite-sandbox-20261102`, stacked [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) based on P6.  
**Protected main verification baseline:** `9bfca8786af1c64b0284a5a1bb3e2186573147a4`.  
**Classification:** **Source implementation and native hosted regression PASS; physical owner keyboard/scaling/Narrator/Qt Creator acceptance OPEN.**

## 1. Actual source scope

Inspected and updated `spikes/qtquick_p2/Main.qml` for bounded, local focus transitions:

- **Rentals**: Up from Status All (or another chip) returns to the last focused Return lookup input/button; Up from Return lookup enters the last enabled lifecycle action or New rental. Down reverses those transitions. Status and due-timing chips remember valid prior positions; Due Up returns to the remembered status, Find Up returns to Due. From a first visible rental record Up returns to Find rental. Down from the final record reaches enabled **View contract details**, whose Up returns to the selected list. Enter on a rental opens existing **read-only** contract details; Escape restores list focus.
- **Fleet**: Search Down focuses the active Gallery/Table choice, then Down enters its collection. Up from the **top gallery row** or first Table record exits to the matching view choice. Down re-enters, using the C++ selected vehicle ID when visible. Deeper gallery rows retain their real Up/Down behavior. Text-field caret keys and native ComboBoxes remain unchanged.
- **Overview**: quick actions Down focuses the first recent contract (if one exists), with Up from its first row returning to the previously focused quick action; siblings retain local arrows and Enter activation.
- **Focus visibility**: active group targets are revealed in the Rentals page scroller without changing records. Focus memory is separate from C++ contract/vehicle selection. All existing Return/Archive/Delete/Remove review permissions and confirmation dialogs remain authoritative.

Two real native CLI smoke tests `--ux-ctrl-003-smoke` wide/compact and their CTests were added in `spikes/qtquick_p2/main.cpp` and `CMakeLists.txt`. The older UX-CTRL-002 Fleet Search native test was adapted to the **owner-approved new intermediate Gallery/Table choice**; no test was disabled or removed.

No customer PII, payment feature, new financial data field, production SQLite cutover, fixture replacement, installer or main change.

## 2. Exact-source test matrix

| Test evidence | Platform | Result |
|---|---|---|
| Complete real Qt CTests | Ubuntu 24.04 GCC, Qt 6.8.3 | **127/127 PASS, 0 failed** |
| Complete real Qt CTests | Windows Server 2022 MSVC, Qt 6.8.3 | **127/127 PASS, 0 failed** |
| Existing UX-CTRL-002 tests #61 and #62 | Both OSes, 1500x860 and 1280x720 | **PASS** |
| New UX-CTRL-003 tests #63 and #64 | Both OSes, 1500x860 and 1280x720 | **PASS** |
| Relocated Windows portable fictional app functional checks | Hosted Windows | **8/8 PASS** |
| Packaged Windows PowerShell 5.1 subprocess verification | Hosted Windows | **PASS** |
| Actual owner Qt Creator 6.10.2 MinGW current source | Physical Windows PC | **NOT TESTED at this source commit** |
| Owner subjective seamlessness, scaling 100/125/150%, Narrator | Physical Windows PC | **OPEN, no new acceptance** |

Logs specifically report on Linux `100% tests passed, 0 tests failed out of 127`, total real 167.49 seconds; Windows `100% tests passed, 0 tests failed out of 127`, total real 192.70 seconds. Both tests #63/#64 passed on each OS, preserving all 125 prior tests. The Windows packaged command logged `ALL 8 REAL APP FUNCTIONAL CHECKS PASSED` and `P4 Windows PowerShell 5.1 subprocess verification PASS`.

The native UX-CTRL-003 tests deliver actual Qt key events in the application to verify region re-entry, status choice without unintended filter action, first rental Up, C++ R001/R002 selection memory, Fleet Ford Ranger C002 re-entry, Gallery/Table internal moves, Overview recent actions, read-only contract Enter/Escape, and **before/after byte-identical protected fictional vehicle/rental source files**. They do **not** prove user-perceived motion smoothness, all Narrator spoken names, or real Windows display scaling.

## 3. Artifacts and transparent evidence boundary

All three artifacts were returned as existing and nonexpired by the successful workflow:
- Windows fictional QA kit: **13328457172**, `p2-windows-physical-acceptance-kit`.
- Windows screenshots: **13328547218**, `p2-qtquick-windows-screenshots`.
- Linux screenshots: **13329385238**, `p2-qtquick-linux-screenshots`.

**Important:** These artifacts were listed, not downloaded or visually inspected in this verification session. Do not infer screenshot approval, a captured UX-CTRL-003 focus route, or a new physical PC run. The owner now has a working **GitHub Desktop Pull → Qt Creator Build/Run** workflow, so do not ask for repeated QA-kit downloads for ordinary development.

**Failure history for this milestone:** There were no failed completed CI runs for `922674c9e253fca2c8ef75b1c3e95fe51a8dd94b` in the verified [#41839473216](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41839473216) run. Prior UX-CTRL-002 failed intermediate builds remain transparently documented in [UX-CTRL-002 implementation report](UX_CTRL_002_IMPLEMENTATION_AND_NATIVE_VERIFICATION_2026-11-04.md); they are not misclassified as UX-CTRL-003 failures.

## 4. Owner's next physical test, not automatic acceptance

After fetching/pulling branch `feature/p7-sqlite-sandbox-20261102` in GitHub Desktop, open the repository **root CMakeLists.txt**, select **Qt 6.10.2 MinGW 64-bit**, the `rental-studio-local` configuration, build/run `rental_studio_qtquick_spike`. Do not use a stale downloaded portable QA kit. Confirm `git rev-parse HEAD` for source provenance, noting any later **docs-only** commit.

1. Rentals: on **All**, press Up to Return lookup; press Down to All. From Find Down into R001; Up returns to Find; Down returns to R001; use R001→R002 and back; last record Down reaches View details; Up returns to R002.
2. Fleet: focus Search, Down should reach Gallery control, Down again Ford Ranger; Up returns to Gallery, Down restores Ford. Move a row down/up, change Table and confirm same C++ vehicle selection persists.
3. Overview: focus quick action and Down to recent rental, Up back to the same quick action. Confirm Enter activates only deliberate focused actions.
4. Confirm the window scrolls to reveal focused controls, focus is visibly distinct from selected/hover, search caret Left/Right remains native and no arrow activates Return/Archive/Delete. If possible, assess actual scaling 100/125/150%, Narrator and keyboard-only operation. Report PASS/FAIL/NOT TESTED with small app-only screenshots for any defect.

**No formal acceptance change:** exactly **45/74 accepted, fixed weighted 70.6%**, P5 8/8, P6 9/9, P7 0/8. P1/P2/P4 remaining physical gates, P7 D2-D8 real-data decisions, P8 installer, P9 release, final fleet photography and all merges are still open. Keep PR #17 draft on unmerged P6 and stable main untouched.
