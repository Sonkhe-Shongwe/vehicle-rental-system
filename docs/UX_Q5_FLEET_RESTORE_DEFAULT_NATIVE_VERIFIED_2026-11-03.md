# UX-Q5 | Restore original Fleet image with confirmation: native verified

**Date:** 3 November 2026. **Exact Qt/C++ source:** [`c04a4c4`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c04a4c4b9ec8c57a05102b71f4497170cfb4c975). **Branch:** `feature/p7-sqlite-sandbox-20261102` in open draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), based on draft P6 #14.

## Product improvement

Previously, the Inspector could replace an illustrative photo but could not revert to its original image without deleting the vehicle. UX-Q5 adds a visible **Reset** (compact) or **Restore default** (wide) action only when a safe local custom-photo override exists. The action opens a confirmation dialog that explicitly warns that the custom photo itself cannot be recovered after the reset. **Keep photo** cancels without removing any bytes; confirming removes the custom PNG sidecar and refreshes the photo store revision. Original repo illustrative images C001–C003 then reappear; other vehicles use the neutral silhouette.

The C++ `FleetPhotoStore::restoreDefaultFor` and `hasCustomPhoto` methods are deliberately narrow. Reset defaults to disabled, and the fixed-fictional-only session never enables it. Safe vehicle IDs, photo-directory/symlink guards and removal failure feedback remain in C++. QML snapshots the selected ID before the dialog; a changed selection or wrong workspace is rejected. The original business vehicle, rates, rental history, booking state, QSaveFile fixture files and isolated SQLite Lab are unaffected.

## Exact source and actual tests

[Hosted GitHub Actions 41614666826](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41614666826) completed **SUCCESS** at source `c04a4c4b9ec8c57a05102b71f4497170cfb4c975`:

| Test host | Toolchain | Verified outcome |
|---|---|---|
| Ubuntu 24.04 | GCC, Qt 6.8.3, actual Qt Quick scene | **117/117 CTests PASS** |
| Windows Server 2022 | MSVC, Qt 6.8.3, actual hosted Windows Qt Quick | **117/117 CTests PASS** |
| Wide/compact photo smoke | Native 1500×860 and 1280×720 | **Both passed on both hosts**, including reset button, Keep photo cancellation, confirmation, seeded-image recovery and fixed-fictional-mode refusal |
| Windows package QA | Portable acceptance-kit checks including Windows PowerShell 5.1 | **PASS** |

The [hosted Windows screenshots artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41614666826/artifacts/13220807432) and [Linux screenshots artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41614666826/artifacts/13220852261) are real Qt grabs, not conceptual mockups. The imported-vehicle Inspector screenshot at both viewport sizes was inspected: **Change photo**, **Reset / Restore default**, available-state and Book/Remove controls remain visible. The screenshots show synthetic generated green test media, not proposed production artwork. Artifacts are time-limited.

The native tests also retain the earlier custom-photo replacement success/failure, stale-target rejection, corrupt/oversized sidecar denial, fixed source fixture byte-equality and vehicle lifecycle tests. No tests were disabled or weakened.

## Acceptance boundaries and next priority

This is automated engineering verification, **not** owner acceptance of model-specific photography or the broader P1 design. No physical Windows Qt Creator/MinGW, operating-system scaling at 100/125/150%, Narrator or native OS file chooser manual operation was claimed. A confirmation dialog was exercised through the Qt UI harness; human usability acceptance is still pending.

P5 **8/8** and P6 **9/9** retain their earlier owner signoffs. **Overall formal acceptance: 45/74 criteria, weighted 70.6%, unchanged**. P1 final vehicle imagery and design, P2/P4 physical/accessibility checks, P7 D2–D8 real-customer-data policies, P8/P9 commercial packaging and release, and draft PR merges remain open.

**Recommended next priority:** evaluate the car photo examples and rights-cleared actual-model Honda/Yamaha artwork with the owner, then use the consolidated Windows physical accessibility and scale review. Do not install unapproved visuals or enable real customer data.
