# Rental Studio 2.0 | UX-CTRL-002 implementation and native verification

**Evidence date:** 4 November 2026 (Africa/Johannesburg)  
**Decision authority:** [Owner-approved UX-CTRL-002 specification](UX_CTRL_002_OWNER_APPROVED_DIRECTIONAL_NAVIGATION_SEMANTIC_COLORS_CONTRACT_DETAIL_2026-11-04.md)  
**Exact compiled source:** [`f273d038be2bce0398241f6e5950f3938a13f6d1`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f273d038be2bce0398241f6e5950f3938a13f6d1)  
**Successful exact-source workflow:** [GitHub Actions #41815907017](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41815907017) (push, completed, success).  
**Branch:** `feature/p7-sqlite-sandbox-20261102`; stacked [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) against `feature/p6-fleet-create-disposable-20261101`.  
**Stable main at verification:** `9bfca8786af1c64b0284a5a1bb3e2186573147a4`, untouched.  
**Classification:** **Implemented and hosted-native verified; manual visual/keyboard/Narrator/Windows scaling OWNER ACCEPTANCE OPEN.** No commercial, installer or release approval.

## 1. Actual implemented source

Reviewed `spikes/qtquick_p2/Main.qml`, `WorkspaceNavButton.qml`, `DesignTokens.qml`, `main.cpp` and UX-CTRL-002 specification at the named commit.

- Navigation uses bounded explicit QML focus routes. Sidebar Up/Down changes focus without changing workspace; Return/Enter activates the focused workspace, and Right from an active entry enters the corresponding actions. The final commit explicitly routes Return/Enter through the scoped button `clicked()` signal rather than assuming Qt Quick treats Return as Space.
- Overview actions occur in the owner-approved order: Review active rentals, Open Fleet, Review overdue. Right traverses and Left reverses to sidebar. Fleet keeps native text caret movement, Gallery/Table navigation, and record inspection without booking.
- Rentals status focus moves All, Active, Returned, Archived, History. Down from All reaches Overdue; Down reaches Find and then the visible rental list. Enter on a focused rental opens read-only contract details, not Return, Archive or Delete. The existing separate action confirmation safeguards remain in place.
- `DesignTokens.qml` holds the approved Navy `#17324D`, Emerald `#0F766E`, warning `#FFF2D5`/`#965A0A`, destructive `#B42318`/`#912018`, Mint `#E8F5F0`, neutral hover, disabled and focus tokens. QML hover and active-focus are used, not CSS. Permanent removal and archived deletion are destructive actions; Return and Archive are not automatically red.
- The contract modal uses the existing narrow C++ `selectedContract` projection: identity and lifecycle/due indicators, duration/rate, start/expected dates, actual return, Mint BOOKED CONTRACT TOTAL, read-only disclaimer and Close. Escape restores the invoker's focus; selection/snapshot invalidation closes stale details. **The total is a booked value, not a payment receipt.** No new personal fields or payment capability were added.
- Existing C++ domain/storage authority, protected fictional fixtures and explicit business confirmation remain the source of truth. The P7 production-data storage decision is unchanged.

## 2. Exact-source CI verification

| Verification | Environment | Result |
|---|---|---|
| Native Qt CTest suite | Ubuntu 24.04, GCC, Qt 6.8.3 | **125/125 PASS, zero failures** |
| Native Qt CTest suite | Windows Server 2022, MSVC, Qt 6.8.3 | **125/125 PASS, zero failures** |
| UX-CTRL-002 actual Qt Quick tests #61/#62 | 1500x860 and 1280x720 logical windows, each OS | **PASS on both OSes** |
| Relocated portable Windows fictional demo | Hosted Windows functional checks | **8/8 PASS** |
| Windows P2/P4 packaged scripts and PowerShell 5.1 check | Hosted Windows CI | **PASS** |
| Owner physical Qt Creator 6.10.2 MinGW | Windows laptop | **NOT TESTED** |
| Actual OS scaling 100%, 125%, 150%; Narrator | Physical Windows device | **NOT TESTED** |

Native test implementation `spikes/qtquick_p2/main.cpp`, option `--ux-ctrl-002-smoke`, exercises real QML key delivery, destination activation, Fleet caret exception and Enter inspection, Overview route, Rentals route, contract identity and R 1,400.00 backed total, Mint panel, Escape focus return, red removal state and before/after bytes of original fictional files. Actual keyboard native tests #61 and #62 are added to the complete 125 CTest matrix, not simulated JS-only claims.

Job evidence: [Linux job #126526505371](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41815907017/job/126526505371) and [Windows job #126526505004](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41815907017/job/126526505004). Both logs explicitly report `100% tests passed, 0 tests failed out of 125`. Windows job reports `P4 Windows PowerShell 5.1 subprocess verification PASS`.

## 3. Transparent corrections of earlier runs

These superseded runs are deliberately retained in the audit trail. **They were not successful and must not be described as successful source builds.**

| Run | Source commit | Observed result | Correction |
|---|---|---|---|
| [#41813106258](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41813106258) | `ae5a55cb` | Both platforms failed compilation; `FleetController::query` was treated as a member rather than called | Corrected native smoke source |
| [#41813946359](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41813946359) | `85fb7c63` | 123/125 CTests Linux; new #61/#62 failed to discover real keyboard targets | Corrected native QML object discovery and visibility timing |
| [#41814762509](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41814762509) | `766f846b` | 123/125 CTests Linux; #61/#62 reproduced owner complaint: focused Enter did not activate Fleet | Added explicit Return/Enter click handling in `f273d038`; full suites rerun green |
| [#41815907017](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41815907017) | `f273d038` | **125/125 both platforms; Windows 8/8** | Authoritative successful exact-source checkpoint |

The intermediate cancelled attempts are not counted as completed regression passes. Documentation-only follow-up commits are not new executable test results.

## 4. Actual screenshot and QA archive inspection

Three artifacts from run #41815907017 were confirmed **existing and non-expired** on 4 November:

- Windows portable QA kit: `p2-windows-physical-acceptance-kit`, artifact **13315845199**, 38,633,965 bytes, expires **11 November 2026**.
- Windows screenshots: `p2-qtquick-windows-screenshots`, artifact **13314832815**, 12,863,698 bytes.
- Linux screenshots: `p2-qtquick-linux-screenshots`, artifact **13315096714**, 13,634,119 bytes.

The Windows screenshot ZIP was downloaded and opened. It contains **64 PNGs**, including Overview `p5-qt-operational-overview-1500x860.png` / `1280x720`, Fleet `p4-qt-focus-route-*`, Rentals `p3-qt-rentals-*`, and the reached-bottom `ux-s1-rentals-bottom-*`. The captures show the three Overview quick actions in the requested left-to-right order; Fleet actions and controls are visible at the two supported logical sizes; the Rentals bottom view reveals records and the View contract details control when scrolled.

**Visual limitation, critical:** The generated screenshot collection contains **no captured open UX-CTRL-002 rental-contract modal** and does not prove rendered modal card layout, hover transition, keyboard focus color, or 100%/125%/150% real OS scaling. No screenshot-based visual contract acceptance is claimed. Source inspection shows a fixed-size modal and conditional one-/two-column GridLayout, but compact clipping, intrinsic content scrolling, long localized text, screen reader spoken state and usability require physical observation. If clipping is found, fix it with dedicated native layout and screenshot regression evidence before owner signoff.

The Windows QA ZIP was separately downloaded and validated as a structurally readable ZIP with **1,393 entries**. Its `SOURCE_COMMIT.txt` equals `f273d038be2bce0398241f6e5950f3938a13f6d1`; it includes `RentalStudioP2Review.exe`, `Launch-Rental-Studio.cmd`, `Check-Rental-Studio.cmd`, `Verify-P2-Windows.ps1`, `Verify-P4-Windows.ps1`, `START_HERE_FUNCTIONAL_DEMO.md`, Qt runtime files and protected fictional `demo/` fixtures. The packaged EXE SHA-256 from the extracted ZIP is `7c376053632849de3e6fc7882d8856f66aa0c6ad63e7189d6e53a5d92d6b5df6`. This is an **unsigned fictional preview, not an installer**. No physical Windows execution is claimed here.

## 5. Physical owner acceptance script: next priority

1. Download the exact artifact above from [successful run #41815907017](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41815907017). Extract **all** files outside any operational data directory; inspect `SOURCE_COMMIT.txt`. Double-click `Launch-Rental-Studio.cmd` for the disposable fictional GUI. Optionally double-click `Check-Rental-Studio.cmd` for eight isolated checks.
2. **Sidebar:** on Overview press Down; Fleet receives focus but Overview stays. Press Enter; Fleet opens. Press Right; Fleet Search focuses. From active Rentals press Right to focus All. Test Up/Down reverse and selected-vs-focused visual states.
3. **Overview:** focus active Overview entry, press Right through Review active rentals, Open Fleet, Review overdue, press Left backward and return to sidebar. Press Enter on each action separately; verify the route executes. If overdue is unavailable, check disabled explanation.
4. **Fleet:** native caret Left/Right in Search; Tab through filters and Gallery/Table. Press arrows on Gallery/Table records and Enter to inspect; verify Inspector identity and that no rental was created. Inspect remove vehicle red/hover and confirmation without executing removal.
5. **Rentals:** from active sidebar Right to All, Right to Active without changing filter until Enter. Return to All; Down to Overdue, Down to Find, Down to R001. Enter opens **read-only** details, not Return or Archive. Confirm header, two card rows, actual return, Mint booked total, explicit not-a-receipt caption and Close. Escape returns focus to the rental list; verify no underlying mutation.
6. Test the modal and button states at supported **100%, 125%, 150% actual Windows display scaling**; narrow/compact available window; mouse hover; disabled items; keyboard outlines; Narrator announcement of destinations/records/contract/Close. Record each **PASS, FAIL or NOT TESTED** with reproducible steps and safe app-only screenshots.
7. If the portable preview fails, keep logs and original zip intact and do not bypass Windows security policy. Perform Qt Creator 6.10.2 MinGW build and screenshots as a separate named physical gate.

## 6. Owner acceptance and restrictions

**Formal status unchanged: 45/74 owner-accepted; fixed-weight 70.6%; P5 8/8, P6 9/9, P7 0/8.** Engineering PASS is not owner UX approval. P1/P2/P4 remaining accessibility, Narrator, scaling, Qt Creator/MinGW, P7 D2-D8 data policy, final Fleet photography/population, P8 signed installer and P9 release remain open. Continue UX-CTRL-002 physical acceptance before additional P7 implementation.

**No actions here authorize:** merging draft PRs, changing stable main, real customer/contact/driver records, production SQLite migration, payments, fixture tampering, installer distribution or release.
