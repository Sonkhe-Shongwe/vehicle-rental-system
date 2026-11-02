# P7-P | Fictional SQLite Fleet and Rentals record explorer within actual Qt Quick

**Date:** 2 November 2026. **Verified source:** [final corrected `31d1ce3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/31d1ce3120629861ed5979faee3828c1be02d801). This extends only the **explicitly opted-in generated-fictional SQLite Lab** of the real Rental Studio Qt Quick executable, pursuant to [limited D1 owner approval](P7_D1_OWNER_APPROVED_FICTIONAL_ONLY_SQLITE_INTEGRATION_2026-11-02.md). No real customer data, legacy import, commercial DB, installer, release or default application storage change is authorized.

## What was built

- The existing `p7fiction::FictionalFleetSnapshot` typed Fleet snapshot adapter now supports a C++-owned **All / Available / Unavailable** filter, visible Fleet rows, selection by case-insensitive stable vehicle ID, and a read-only inspected Fleet value map. This reuses the consistent SQL transaction read introduced by P7-L and projects purpose-limited values, not SQL objects or mutable domain pointers, into QML.
- The actual Qt Quick fourth `P7FictionalSqlLab.qml` workspace now has a scrollable, read-only **Fleet record explorer** and **Rental contracts explorer**. Rentals uses the existing shared `RentalListModel` for status filters **All / Active / History**, visible rows, selection and bounded contract details. Neither QML view may write a rental or invent customer information.
- When a Fleet filter hides the selected record, C++ clears its selection; invalid/hidden selection requests do not force it back. Rentals retains its existing same invariant. On a failed Fleet or Rentals read the UI must **hide unverified detail and counts**, retain last known-good rows internally and present retry only when needed. Both C++ adapters restore verified results after retry.
- The Lab is scrollable rather than truncating the new explorer at compact 1280×720. The other three Overview/Fleet/Rentals workspaces still use their independently protected fictional QSaveFile domain with identical original source bytes.

## Actual-source regression evidence

| Gate | Result |
|---|---|
| [Core C++ exact corrected commit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41497869038) | **13/13 PASS**, logs inspected |
| [Native Qt Linux GCC and hosted Windows MSVC exact corrected commit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41497869095) | **115/115 PASS on each platform**, exact logs inspected |
| Native new `rental_studio_p7_actual_app_lab_wide` and `_compact` | Both verified real Qt Quick 1500×860 / 1280×720 browser-independent application scenes |
| Native Windows packaged PowerShell 7 and 5.1 | PASS; not an installer/owner physical acceptance |
| Owner physical Qt Creator 6.10.2 MinGW, 100/125/150% display, Narrator | NOT TESTED |

The two existing real application P7 CTests now drive genuine QML Fleet and rental row **clicks** after the complete fictional booking/return/archive/retirement journey. They inspect selected C++ DTO values and QML labels, filter out hidden active/available rows, restore the history/unavailable view, inject fixed read faults in the C++ model providers, assert QML details/counts become **unverified**, click actual retry controls, and verify recovery. They also assert original protected demo files and legacy KPIs never change. No additional CTest count was introduced, and the 113 preceding cases remain in the full suite.

## Source correction recorded

An intermediate commit [`579132b`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/579132b3cd8a6b3304ba792fd4af214bb97e3574) mistakenly assembled QML+tests with an incomplete Fleet header. Its native Linux and Windows CI [failed to compile](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41496658177), correctly reporting missing C++ filter/selection methods. The next [`733a5a9`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/733a5a947060f30fb0954e72c30d1fb805dc35ab) restored the complete intended C++ header; [final `31d1ce3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/31d1ce3120629861ed5979faee3828c1be02d801) also fixed the QML Rentals dropdown to assign its writable statusFilter property. **Only final exact-source CI above is evidence**, never the failed interim source.

## Outstanding gates

This read-only explorer does **not** mean the original production-facing three-workspace commands are backed by SQLite. It does not settle D2–D8 price caps, lifetime imported IDs, historical retention/privacy, backup/migration policy or final acceptance. No production database path, PII or automatic import is exposed. All P7 8 formal criteria remain unaccepted, as do the remaining P5/P6 owner gates: **28/74 accepted, weighted 40.6%**, P7 0/8. Physical owner Windows MinGW/Narrator/scale, P8 offline installer, P9 final QA and formal release authorization are separate; PRs remain draft and `main` unchanged.
