# P6-D | Historical rental references protect Fleet vehicles

**Engineering verification date:** 1 November 2026. **Exact source tested:** `ec5859a06682caaf658f7f43e7a5a06ec801a815` on `feature/p6-fleet-create-disposable-20261101`, Draft [PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14) stacked on P5 Draft #12. **Commercial product:** Rental Studio.

## Problem and conservative interim policy

Previously a returned or archived rental could still contain a `vehicleId` after the corresponding vehicle had been deleted from Fleet. The original domain prevented deletion while a vehicle was rented or had an active rental, but **did not prevent deleting a vehicle with historical returned/archived contracts**, resulting in dangling references.

For the current **fictional-only** app the safe interim rule is **no vehicle removal while ANY surviving rental references that vehicle ID**, regardless of whether the rental is active, returned or archived. This applies to the authoritative C++ domain, not only the Qt Quick presentation. Historical contracts are **not** automatically deleted; the rule is fail-closed and does not rewrite rental files.

Removing an otherwise unreferenced vehicle is still supported. If an already archived fictional rental is independently and deliberately deleted through the existing exact `DELETE <ID>` workflow, then its former vehicle may become removable, provided no other contracts reference it. Real commercial records need a **separate retention/retirement policy**; do **not** recommend erasing legitimate customer financial or legal rental history simply to delete a vehicle. A future non-destructive Retire/Inactive vehicle status is a product option, **not yet implemented or approved**.

## Implementation boundaries

- `RentalSystem::hasRentalHistoryForVehicle` scans all loaded rental records and normalizes IDs using the existing trimmed, case-insensitive convention. `RentalSystem::removeVehicle` refuses any referenced vehicle **before** mutating memory or attempting the atomic Fleet write.
- `FleetWriteService::remove` reports a distinct `FleetWriteError::VehicleReferencedByRental`, leaving the pre-existing `VehicleInUse` result for an active rental. No false success and no file write occur.
- `FleetRemoveController` exposes `hasRentalHistory` and `canRemoveVehicle` for current selection. The real Qt Quick Fleet inspector disables Remove and displays a clear hint for a selected, available but historically referenced vehicle. Its command path still enforces the domain rule even if called directly.
- The older Qt Widgets removal UI now explains the new guard rather than incorrectly suggesting only an active rental could block removal.
- No new database schema, arbitrary file chooser, real contacts, billing, auto-cascade deletion or production data path. The fixed persistent fictional demo session's original no-fleet-write restriction remains intact.

## Exact-source regression evidence

| Check | Run | Result |
|---|---|---|
| Core C++ / legacy domain | [41339190637](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41339190637) | **13/13 CTests PASS** |
| Qt 6.8.3 Linux GCC native | [41339190640](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41339190640) | **66/66 CTests PASS** |
| Qt 6.8.3 Windows MSVC native | [41339190640](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41339190640) | **66/66 CTests PASS** |
| Hosted Windows packaged regression | Same run | PowerShell 7 and Windows PowerShell 5.1 portable P4 checks **PASS**; no physical owner Windows/Narrator/100–150% scaling acceptance claimed |

In core tests: a returned vehicle reference refuses **direct domain** and **typed service** removal; the attempted change leaves vehicle/rental bytes identical. The guard persists through domain reconstruction and protects archived records with normalized IDs. After the explicitly confirmed archived-rental deletion, the guard releases. Existing injected failed Fleet writes are still exercised using an **unreferenced** test motorcycle, not spuriously blocked before persistence. Older P3 read-model tests were updated to preserve their history/selection assertions **without expecting intentionally orphaned references**.

In real native Qt wide **1500×860** and compact **1280×720** tests: the operator cannot remove an available C001 Corolla while returned R002 references it, a visible accessible history hint appears, and direct C++ command refusal leaves original bytes unchanged. Unreferenced C003 can still be removed with the `REMOVE C003` phrase. A second cross-workspace test archives and explicitly deletes fictional R002, then uses the real Fleet removal modal to remove now-unreferenced C001, reopens the temporary file domain and checks C002's remaining active rental, unchanged original checked-in seed bytes and stable rental ledger. No earlier CTests were removed or weakened; the 66-test suite remains green.

Initial intermediate source commits failed old tests that assumed historical orphaning was allowed; those outdated expectations were corrected, and **only the final passing source SHA above** supports this verification claim.

## Formal acceptance, scope and next decisions

This closes the specific **technical integrity defect** highlighted in [Issue #15](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/15). It does **not** approve a commercial retention strategy or formally ratify P6's nine unnumbered original checks.

The existing [P5/P6 acceptance reconciliation](P5_P6_ACCEPTANCE_RECONCILIATION_2026-11-01.md) previously described provisional P6 #3 as partial specifically for historical dangling references. Under the current **fictional-only conservative protection policy** there is now representative native automated evidence for that group, resulting in a **provisional diagnostic inventory of 7 covered / 1 partial / 1 open**. This remains *not* a new formal acceptance count and should be revised if the owner selects a more demanding commercial retirement policy.

**Official status unchanged:** P4 **5/7**, P5 **0/8**, P6 **0/9**, overall **28/74 formally accepted criteria and 40.6% evidence-weighted coverage**. The phase weights are not product-completion percentages. Hosted native CI is not physical owner design, accessibility or release approval. `main` is untouched and Draft PR #14 remains unmerged.

Next work: explicitly establish the nine individual P6 criteria; audit full Fleet/Rentals Qt Quick versus legacy workflow parity and P6 cross-process restart; plan a commercial **vehicle retirement, historical retention and data migration** model in P7 before enabling real records.
