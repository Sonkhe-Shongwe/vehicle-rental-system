# P7-R | Transactionally consistent fictional SQLite operational Overview

**Date:** 2 November 2026. **Final verified compiled source:** [de47e0f](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/de47e0f2f0355750f429f929f4997b63d23b2495). Owner authorization remains **D1 generated-fictional opt-in integration only**. This is not commercial storage, a customer data path, migration or acceptance.

## Real product improvement

- New C++ `FictionalOperationsSnapshot` consumes the existing normalized SQLite `Repository::fleetRows()` transaction, so vehicle occupancy, active/history contract counts and booked contract value all come from one committed snapshot.
- Active booked value is aggregated in signed 64-bit integer **cents**, with overflow and duplicate-active-vehicle refusal. QML receives a preformatted amount; it does not calculate revenue or execute SQL.
- Real `P7FictionalSqlLab.qml` shows a read-only operational summary: total/available fleet, active rentals, returned/archived history and active booked value prominently labelled **NOT collected revenue or payment**.
- The Overview is refreshed only on the existing post-COMMIT signal; a failed read retains last known-good C++ data internally but hides every unverified Overview figure and provides a visible retry. No false booking receipt or uncommitted count is exposed.
- Initial layout revealed that a new Overview above the action row pushed booking controls below the usable compact viewport. The corrected layout retains booking/return actions above Overview; the real Qt test scrolls to the read-only retry control rather than bypassing the UI.
- Existing ordinary Overview/Fleet/Rentals workspaces, protected fictional QSaveFile fixtures and default OFF `BUILD_P7_SQLITE_SANDBOX` remain unchanged. No contact, licence, import, general file picker, payment, backup or production database path was added.

## Exact-source cross-platform evidence

| Gate | Evidence | Actual result |
|---|---|---|
| Core C++ | [run 41509775107](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41509775107) | **13/13 PASS** |
| Native Linux GCC, Qt 6.8.3 | [run 41509775180](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41509775180) | **115/115 PASS** |
| Hosted Windows MSVC, Qt 6.8.3 | Same native run | **115/115 PASS** |
| Real QML actual-app wide and compact | Native tests `rental_studio_p7_actual_app_lab_wide` and `_compact` | Both PASS on both platforms |
| Hosted Windows portable-kit / PowerShell | Same native run | Windows PowerShell 5.1 and packaged checks PASS; **not** installed commercial release |

The two existing real-app native CTests were expanded, not removed or bypassed. They check initial values, rejected booking, committed R001 booked value **R 1350.00**, return/archive/retirement, failed-read concealment and operator retry, while maintaining protected original source bytes. No new test count was introduced.

**Correction record, retained:** First source [5103d9e](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/5103d9e76e6b39619fab5124e1a80f262967bd68) passed [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41508676151) but native [run 41508676114](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41508676114) failed **1/115** on each platform in the real compact Lab QML journey. The new Overview occupied visible space above the action row. The focused [de47e0f correction](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/de47e0f2f0355750f429f929f4997b63d23b2495) restored compact action accessibility and reran the **full unchanged suite**, now passing both OS platforms. Neither intermediate failure nor its tests were hidden.

## Remaining authorization and release gates

D2–D8 pricing limits, ID high-water and never-reuse rules, retention, customer/contact and legacy licence privacy, secure backup, migration, final rubric and commercial rollout remain **unapproved**. No owner physical Qt Creator 6.10.2 MinGW or Windows 100/125/150%/Narrator signoff was performed. P5 **0/8**, P6 **0/9**, P7 **0/8**, programme **28/74 accepted** and **40.6% evidence-weighted**, unchanged. P8/P9 unstarted. PRs draft/unmerged, main untouched.
