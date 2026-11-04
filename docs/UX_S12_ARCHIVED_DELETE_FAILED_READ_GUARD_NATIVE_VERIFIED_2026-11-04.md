# UX-S12 | Fail-closed archived permanent deletion after failed rental read

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled and native-verified source:** [`bc35f6e86d9476a369ca7f61e09624ee829320a6`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/bc35f6e86d9476a369ca7f61e09624ee829320a6)  
**GitHub Actions:** [run 41773766894](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41773766894), **COMPLETED SUCCESS**  
**Working branch:** `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked against P6 PR #14, not merged.

## Issue

UX-S11 made the reused C++ rental snapshot model and ordinary Return/Archive controllers fail closed when a provider read failed, retaining previous buffered data only for recovery. The separate P6 **permanent archived deletion** presentation controller still based `canDeleteSelected()` and `permanentlyDelete()` on the retained selected ID and an independently readable domain, without requiring the last rental snapshot to be available. A caller could consequently attempt a destructive command using a stale/unverified selected record after a read outage. This is a proactively identified code path, not a reported real-world deletion.

The existing P6 guard for disposable-only sessions, exact canonical ID and typed `DELETE R002` phrase remains required. Snapshot availability is an additional prerequisite, not a replacement for those guards.

## Narrow correction

- `spikes/qtquick_p2/p6_archived_delete_controller.cpp`: `canDeleteSelected()` now returns false unless the current rental snapshot is available, the selected row is visible, the P6 session is disposable and the domain record is archived.
- `permanentlyDelete()` now refuses immediately on an unavailable rental snapshot, even when called directly with the correct selected ID and exact typed deletion phrase. It reports **"Rental data unavailable. Retry the read before permanently deleting."** and does not dispatch to `ArchivedDeleteService`.
- The controller now subscribes to `RentalListModel::snapshotAvailabilityChanged` and emits its usual `stateChanged`, making the existing QML delete button/modal confirmation enabled state respond to an outage or successful retry even when the selected rental ID remains unchanged.
- No domain persistence service, underlying delete transaction, SQL schema, image/media workflow, real-data permissions, C++ rental snapshot representation or QML layout was changed.

## Genuine native Qt regression

The existing `--p6-archived-delete-smoke` scenario in `spikes/qtquick_p2/main.cpp` was extended at both **1500×860 wide** and **1280×720 compact** sizes. After the real QML Archive action persists returned fictional rental R002, it creates a separate isolated `RentalListModel` using the actual C++ read service and an injected provider failure, and a real `P6ArchivedDeleteController` backed by that model:

1. With a healthy snapshot, selects R002 and verifies that an archived record is deletion-eligible.
2. Forces the provider to fail while R002 stays selected. Checks the availability signal disables deletion, a direct `permanentlyDelete("R002","DELETE R002")` returns false, the controller reports read unavailability, and the archived domain record, fleet bytes and rental ledger bytes remain unchanged.
3. Repeats the failed refresh and confirms there is no false availability re-arm or extra change notification.
4. Successfully retries the provider read and verifies deletion eligibility returns without deleting anything. Ledger and fleet bytes are still identical.
5. Continues the pre-existing real Qt exact-phrase, invalid phrase, Cancel, Escape, persistence failure rollback, fixed-session denial, eventual confirmed P6-only deletion, genuine Fleet-reference release, restart, focus and protected demo fixture checks.

No native CTest was removed or skipped; suite remains 123 tests.

## Exact-source evidence

[GitHub Actions 41773766894](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41773766894) completed **SUCCESS** for the exact commit `bc35f6e86d9476a369ca7f61e09624ee829320a6`:
- **Ubuntu 24.04 GCC, Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failures, total **155.91 seconds**. Real `rental_studio_p6_archived_delete_wide` #37 and `_compact` #38 PASS, including new outage and recovery assertions.
- **Hosted Windows Server 2022 MSVC, Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failures, total **172.19 seconds**. The same P6 tests #37–38 PASS.
- **Hosted relocated Windows executable:** **8/8 genuine fictional functional checks PASS**. P2/P4 packaged automation and both PowerShell 7 and Windows PowerShell 5.1 verification PASS.
- Artifacts expire **11 November 2026**: [Windows physical acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41773766894/artifacts/13296233114), [Windows native Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41773766894/artifacts/13296875045), [Linux native Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41773766894/artifacts/13296601049).

These are native hosted builds and tests, **not** physical Windows owner acceptance, Qt Creator/MinGW compilation on the owner's machine, actual Windows display scaling or Narrator accessibility testing.

## Preserved decisions and gates

**Formal owner acceptance remains 45/74 criteria, weighted 70.6%; P7 0/8.** P5/P6 remain accepted only within their narrow fictional/disposable scopes. The actual physical Windows UX-S1 Rentals scrolling/focus retest, Qt Creator/MinGW, 100/125/150% physical scaling, Narrator, P7 D2–D8 real-data/privacy/security/retention/backup owner decisions, P8 installer, P9 release, draft merges and public launch remain OPEN.

Final real fleet population, licensed photography and vehicle imagery remain reserved for the LAST project section. No customer PII, commercial data, real pricing or unauthorized persistent system was introduced.

The later documentation-only HEAD is **not** separately compiled or verified as an application source.
