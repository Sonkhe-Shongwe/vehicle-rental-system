# UX-Q4 | Safe, clear Fleet photo replacement: exact-source native verification

**Date:** 3 November 2026, Africa/Johannesburg. **Source:** [`c38ffbe4`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c38ffbe4dd92e75308a0189bc2d537e348f0d808) on `feature/p7-sqlite-sandbox-20261102`, open stacked draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17). **Evidence:** [GitHub Actions run 41608995578](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41608995578), completed **SUCCESS**. This report is engineering verification, **not** owner visual approval, physical Windows certification, data-policy authorization or release.

## Why this functional change was needed

The previously displayed **Change photo** button used a QML `FileDialog.onAccepted` callback that called `fleetPhotos.saveStagedFor(selectedId)`, a plain public C++ method **not exposed through Qt's QML meta-object**. It then immediately discarded staged data and its failure message. Earlier UX-Q3 automated photo tests covered initial seeded media and the Add Vehicle path but **did not exercise the Inspector replacement callback**. UI intent alone was not evidence of a working replacement.

## Code and behavior

- `FleetPhotoStore::replaceFor(vehicleId, localFile)` is now a purpose-limited `Q_INVOKABLE` operation. Its new replacement permission defaults to **disabled**; the normal temporary fictional session enables it explicitly, and the fixed fictional-only session does not.
- A replacement reuses strict local URL/image format/metadata checks and `QSaveFile` atomic sidecar writes. No general storage import, network photo fetch or production data path is introduced. Failed replacements preserve the previous media; staging is cleared without erasing the rejection reason.
- The QML FileDialog captures its target ID *before* opening. The `applySelectedFleetPhoto` callback checks current workspace/session and matching selected ID at acceptance, rejecting stale selection rather than changing the wrong vehicle.
- The operator receives a true success or failure message using the existing accessible Fleet message lane, with no additional cramped Inspector rows. Cancelling the native dialog does not mutate data; the notice resets on a new Fleet selection.
- The previous C++ `saveStagedFor` helper remains available to `FleetAddController`, but is **not** made generally invokable from QML. Original C++ booking, return, archive, fleet persistence, and fictional-data protections are unchanged.

## Actual test results

[Run 41608995578](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41608995578) on source `c38ffbe4dd92e75308a0189bc2d537e348f0d808`:

| Job | Toolchain | Result |
|---|---|---|
| Qt native Linux | Ubuntu 24.04 / GCC / Qt 6.8.3 | **117/117 CTests PASS** |
| Qt native hosted Windows | Windows Server 2022 / MSVC / Qt 6.8.3 | **117/117 CTests PASS** |
| Wide and compact photo smoke, both jobs | Actual Qt Quick, 1500x860 and 1280x720 | Both photo CTests pass on each OS |
| Portable Windows QA kit | Hosted Windows; PowerShell 7 and Windows PowerShell 5.1 | **PASS** |

The existing `rental_studio_fleet_photo_wide` and `_compact` tests were **strengthened**, not removed or replaced. The genuine QML callback is invoked with a generated local replacement PNG and checked for a visible **Photo updated for C001** notice plus image pixel, sidecar and `Image.Ready` evidence. Rejected remote URLs must show **Photo unchanged** and retain identical sidecar bytes; changing selection while the native dialog is conceptually open cannot rewrite the old target; a fixed-fictional store refuses replacement. Existing protected fixture byte-equality and previous Gallery/Inspector regressions remain enabled and passed.

**Testing boundary:** This verifies the application's real Qt/QML acceptance callback and deterministic generated-photo behavior, **not a physical click through the Windows OS file chooser**, Narrator, Qt Creator MinGW, OS scale 100/125/150%, or all image licence decisions. Hosted Windows MSVC is not the user's local Windows kit.

## Acceptance and next priority

P5 **8/8** and P6 **9/9** were previously owner accepted. The frozen formal ledger remains **45/74 criteria, weighted 70.6%**. The car images are still illustrative candidates; Honda/Yamaha retain neutral silhouettes. P1 photo/model/crop and whole-product visual approval, physical P2/P4 accessibility/scale, P7 D2-D8 real-data policy, P8/P9 packaging/release and all draft PR merges remain **open**.

**Next recommendation:** conduct an owner-oriented visual selection of the three existing illustrative car photos plus licence-cleared Honda/Yamaha candidates, then complete the consolidated physical Windows P1/P2/P4 checks without changing the accepted fictional-data architecture.
