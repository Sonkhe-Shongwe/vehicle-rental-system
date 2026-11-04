# UX-S16 | Keyboard paging in the opt-in fictional SQLite Lab

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled source:** [`a2a3b798a395444a616424ba7e5a108283913796`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a2a3b798a395444a616424ba7e5a108283913796)  
**Actual GitHub Actions:** [run 41794199968](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41794199968), **COMPLETED SUCCESS**, source SHA `a2a3b798a395444a616424ba7e5a108283913796`  
**Branch / review:** `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked on draft P6 PR #14; no merge.

## Observed operator gap and bounded fix

The existing Rentals page supported PageUp and PageDown keyboard scrolling to reach its lower controls. The taller fourth workspace, enabled only by the explicitly opted-in generated-fictional SQLite Lab, exposed a Flickable and scrollbar but did not share the page-key access.

- `spikes/qtquick_p2/Main.qml`: reuses a single bounded `scrollOperationsPage(direction)` for the active Rentals page or enabled SQLite Lab `Loader.item`. Existing modal exclusions still guard shortcuts; scrolling never selects a rental, runs a booking command, or changes persisted data.
- The opt-in Lab Loader now has a QML `id` for direct reference. It remains disabled in ordinary protected QSaveFile sessions.
- `spikes/qtquick_p2/main.cpp`: strengthens **existing** actual-app P7 Lab wide/compact CTests, with native keyboard `Qt::Key_PageDown` and `Qt::Key_PageUp` events, actual viewport movement/clamping assertions, and return-to-top verification. No existing tests were removed, weakened, or newly counted.

## Exact-source execution evidence

| Environment | Completed outcome |
|---|---|
| Ubuntu 24.04 hosted GitHub runner, Qt 6.8.3, GCC | **123/123 native CTests PASS**, zero failures. `rental_studio_p7_actual_app_lab_wide` #14 and `_compact` #15 PASS. |
| Windows Server 2022 hosted GitHub runner, Qt 6.8.3, MSVC | **123/123 native CTests PASS**, zero failures. Same actual-app Lab wide/compact tests #14/#15 PASS. |
| Relocated hosted Windows fictional executable | **8/8 functional journey checks PASS**, including disposable operations and guarded persistence. |
| Hosted Windows packaged checks | P2/P4 automation and PowerShell 7 / 5.1 PASS. |

Both jobs also exercised P6 Fleet removal and archived-delete wide/compact CTests #35–38 and shared QML components #69–70. Native screenshot artifacts were produced by CI; this report does not assert independent human visual approval.

## Safety, limits and status

No C++ business rules, SQLite repository, schema, enabled data scope, photos, protected QSaveFile files, branch/PR hierarchy, release artefacts or stable `main` changed. The D1 approval still covers **only opt-in, generated-fictional SQLite Lab**. All real-data P7 D2–D8 decisions remain unresolved.

This hosted evidence is **not** the owner's physical Qt Creator 6.10.2 MinGW build, Windows 100/125/150% OS display-scaling, Narrator evaluation or UX-S1 on-device scrolling retest. Final Fleet Population/Photos, P8 installation and P9 release also remain open. **Formal acceptance unchanged: 45/74 accepted, weighted 70.6%, P7 0/8**. That percentage is not product or release readiness.

**Next development priority:** verify the owner's already-reported Rentals UX-S1 scroll/focus behaviour on the physical Windows device when practical; fix any reproduced defect. Advance commercial P7 identity, privacy, backup, migration and retention only after explicit owner D2–D8 decisions. Do not revisit unrelated photography work.
