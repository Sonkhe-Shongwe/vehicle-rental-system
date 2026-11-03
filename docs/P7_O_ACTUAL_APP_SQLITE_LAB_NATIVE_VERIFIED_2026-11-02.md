# P7-O | Owner-approved fictional-only SQLite Lab integrated into the actual Rental Studio Qt Quick executable

**Date:** 2 November 2026. **Exact compiled source:** [`4c63b6a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/4c63b6a34240c2c762f14976b928f5fb7b54078b). **Scope:** narrowly approved D1 engineering integration with generated fictional records only; [explicit owner decision record](P7_D1_OWNER_APPROVED_FICTIONAL_ONLY_SQLITE_INTEGRATION_2026-11-02.md). D2–D8 and real-data/commercial cutover remain **unapproved**.

## Exact owner decision

The owner answered **"YES I APPROVE"** to approving SQLite as the intended storage engine for **fictional-only integration into Rental Studio**, while keeping real customer data disabled and all remaining commercial/privacy decisions pending. This authorizes a controlled QtSql bridge for synthetic engineering only. It does NOT authorize blanket P7 acceptance, new real-data inputs, automatic migration, default storage switching, production use, P8 installer, P9 release or merging any draft PR.

## What actually changed

- `BUILD_P7_SQLITE_SANDBOX` remains **OFF by default**. The option is now declared before the Qt Quick subdirectory so that an explicitly enabled build can link **Qt6::Sql** and the existing generated-fictional typed repository/controller **into the actual `rental_studio_qtquick_spike` executable**. When disabled, no QtSql or SQLite repository is linked to that target.
- Ordinary application launches still show **three workspaces** with their prior QSaveFile-backed fictional C++ services. The special `--p7-fictional-sql-lab` option (compiled only with the P7 option) makes a **fourth, clearly isolated SQLite Lab** available. The parser refuses any combined runtime modes.
- The Lab is a `P7FictionalSqlLab.qml` component inside the existing real `Main.qml` StackLayout, not the previous separate `p7_fictional_preview.qml` application. It uses the existing `PreviewController` generated-fictional QTemporaryDir repository and C++ value-only `FictionalFleetSnapshot` plus shared `RentalListModel` projected from a single transactional read source.
- The Lab uses fictional C001 and exact booked cents, and offers preview, commit, return, archive and retire. It makes clear it is not a payment or commercial workflow. SQL operations update only the Lab's models **after COMMIT**, never the Overview/Fleet/Rentals legacy demo. The fictional database is temporary and deleted on process exit; no user-specified path, legacy import, customer fields, licence fields or external data.
- Existing sidebar Up/Down navigation can reach the optional fourth workspace. The normal three-route workflow, design and C++ domain source are preserved.

## Exact source CI verification

| Platform | Result |
|---|---|
| [Linux C++ core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41491428956) | **13/13 PASS** |
| [Linux GCC Qt 6.8.3 native](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41491428682) | **115/115 PASS** |
| [Hosted Windows MSVC Qt 6.8.3 native](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41491428682) | **115/115 PASS** |
| Hosted Windows packaged PowerShell 7/5.1 | **PASS** |
| Physical owner Qt Creator 6.10.2 MinGW, physical 100/125/150% scaling, Narrator | **NOT TESTED** |

**Two new native Qt Quick executable tests**, `rental_studio_p7_actual_app_lab_wide` and `_compact`, now run within the actual executable. They open the fourth lab at 1500×860 and 1280×720, verify genuine QML Fleet/Rentals read values, preview-only no-write, injected failed COMMIT with no false receipt, followed by successful booking, return, archive and retirement. They also independently reopen the generated-fictional SQLite repository and assert that the **original protected `vehicles.txt` and `rentals.txt` bytes and legacy model KPIs are unchanged**. All 113 previous native cases remain enabled.

## Important boundary and next work

**This is the first real-application integration seam, not a wholesale migration of the main three workspaces to SQLite.** Existing Overview/Fleet/Rentals controllers still use protected fictional QSaveFile ledgers. A later full workflow adapter/cutover must preserve all the original booking/return/selection/focus/error tests, must not expose customer contacts without D5 approval, and must not silently assume policy details in D2–D8. The generated lab cannot be mistaken for a durable commercial database.

**Formal acceptance remains unchanged:** P5 0/8, P6 0/9, P7 0/8; 28/74 total accepted and 40.6% weighted. All PRs remain draft/unmerged, `main` untouched, P8/P9 unstarted.
