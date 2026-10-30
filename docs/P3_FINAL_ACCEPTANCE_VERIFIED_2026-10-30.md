# P3 Final Acceptance, 30 October 2026

**Source:** `94a6e45fb77eb50a5df72586e7631359e11b98ff`, branch `feature/p3-rental-confirm-20261030`, unmerged Draft PR #9 stacked on #8/#7/#6.

**Formal outcome:** P3 **7/7** accepted C++ application-layer gates; **23/74** programme-wide accepted criteria, **32.1%** weighted evidence coverage, versus previous P3 5/7 and overall 28.6%. Not release readiness.

## Executed exact-source verification

| Environment | Evidence | Result |
|---|---|---|
| Linux Core/legacy and typed command tests | [GitHub run 41113952556](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41113952556) | **13/13 PASS** |
| Linux GCC Qt6.8.3 and real QML | [GitHub run 41113952541](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41113952541) | **31/31 PASS** |
| Windows MSVC Qt6.8.3 and real QML | [Same run 41113952541](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41113952541) | **31/31 PASS** |
| Windows packaged source/fixture checks | [Same Windows job](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41113952541) | **PASS**; physical/manual Windows DPI not tested |

Actual CI logs include the new `vehicle_rental_p3_injection` and `vehicle_rental_p3_admin_commands` tests, plus all existing wide/compact Qt Quick Fleet and Rental smoke tests.

## Last two P3 gates

**Check 3, injectable clock and persistence repository:** [source ca4a19f](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/ca4a19f275beb3f026989cb60e25cd3783b7e280) allows RentalSystem to receive `Today` and a `RentalStorage` read/writeAtomic implementation for the legacy vehicles and rentals text. Default file implementation keeps original path names and QSaveFile atomic replacement. In-memory test independently demonstrates historical-date booking and return, archive, save/reload, injected write failures, rollback, and absence of disk writes. C++ quote, read and return default to the injected domain clock.

**Check 2, typed operational commands and results:** [source 94a6e45](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/94a6e45fb77eb50a5df72586e7631359e11b98ff) adds `FleetWriteService` with typed additions and removals and `ArchivedDeleteService` with exact confirmation phrase and typed rejections. Together with prior typed quote, booking confirmation, return and archive services this covers the existing GUI write verbs as C++ API contracts. Tests validate bad input, duplicate IDs, occupied vehicle, active/returned deletion rejection, missing/incorrect confirmation, forced QSaveFile failure, retry and persistence after restart. Permanent deletion is **not exposed to Qt Quick**. Widgets handlers remain direct legacy calls and their migration is **P6**, not claimed here.

## Other five already verified checks

1. Domain characterization and disposable persistence. 4. Typed C++ Fleet/Rental QAbstractListModel and real Qt Quick wiring. 5. QML defers pricing/availability/dates to authoritative C++. 6. No false successful writes. 7. Exact-source automated tests on Qt Core and native Linux/Windows.

## Frozen weighted progress

| Phase | Weight | Accepted checks | Weighted contribution |
|---|---:|---:|---:|
| P0 | 5% | 5/5 | 5.0% |
| P1 | 12% | 7/10 | 8.4% |
| P2 | 10% | 4/6 | 6.7% |
| P3 | 12% | **7/7** | **12.0%** |
| P4-P9 | 61% | zero accepted | 0.0% |

Exact weighted sum: 5 + 12×7/10 + 10×4/6 + 12×7/7 = 32.0667%, rounded to **32.1%**, **23/74** accepted.

## Safety and future scope

Opt-in Qt Quick preview uses SHA-pinned fictional demo data copied to QTemporaryDir, not live customer storage. The domain's current injected store is an interface for existing text serialization, not new backup, database, migration, money representation or multi-file transactions. The legacy Qt Widgets GUI has not been migrated to the typed application API. P1 final image/a11y/design approval, P2 owner's physical Qt Creator Qt6.10.2 MinGW, real 100/125/150% DPI and keyboard input, P4 shared components, P5 end-to-end production-like slice, P6 full parity, P7 storage hardening, P8 installer and P9 final release/independent verification remain OPEN. Stable main is unchanged and stacked PRs remain unmerged.

**Next milestone priority:** P4 shared Qt Quick components/navigation/focus acceptance, with separate owner-side P1/P2 hardware signoff, rather than restarting P3 or presenting this score as production readiness.
