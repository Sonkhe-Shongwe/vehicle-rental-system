# UX-S15 | Fleet removal confirmation review invalidation

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled and native-tested source:** [`a7894847029b77da46e1472576f6f2b4fa981260`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a7894847029b77da46e1472576f6f2b4fa981260)  
**GitHub Actions:** [run 41790788779](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41790788779), **COMPLETED SUCCESS**  
**Branch:** `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked on P6 PR #14; no merge.

## Operator safety issue

The P6 disposable-fictional **Remove vehicle** modal captures the selected Fleet vehicle ID and exact `REMOVE <ID>` confirmation. Its original enabled condition only required a disposable session and nonempty captured ID; it did **not** check that Fleet still selected that ID. The captured ID and typed phrase could remain valid if an operator or model changed selected Fleet vehicle while the modal was open, or if the authoritative Fleet snapshot refreshed. Unlike archived deletion, `FleetRemoveController::removeVehicle` intentionally takes an explicit ID and checks canonical identity, exact phrase, availability/history and persistence, but does not own the live Fleet UI selection. Thus stale modal review was a meaningful operator-consent gap, not an asserted real-world removal incident.

UX-S15 requires a continuously valid UI review before allowing an existing domain command to execute, while preserving the already enforced C++ rental-history protections and fictional-only scope.

## Bounded implemented fix

- `spikes/qtquick_p2/FleetRemoveDialog.qml`: receives `fleetController` explicitly from Main.qml, has a one-way `reviewInvalidated` latch and first-cause `reviewInvalidationReason`, and watches the real C++ Fleet `selectionChanged` plus `fleetChanged` signals.
- When the selected ID departs from the captured target, the open modal is permanently invalidated even if selection later returns to the same ID (**A → B → A**). When the C++ Fleet snapshot refreshes, even if its selected ID survives, the modal also invalidates. The first reason remains visible until the modal is closed.
- Confirm now requires `!reviewInvalidated`, the current Fleet selected ID strictly equal to the reviewed target, and current C++ `canRemoveVehicle(targetId)` eligibility as well as the existing disposable-session gate. The click handler independently rechecks the same identity/eligibility before calling the unchanged C++ exact-phrase `removeVehicle` command.
- An accessible visible message states **"Selection changed."** or **"Fleet data refreshed."** and instructs the operator to close and reopen the dialog for new consent.
- Cancel/Escape clears the typed phrase, frozen target and invalidation state. Reopening re-arms a fresh eligible target only; no deferred action or automatic removal is performed.
- `spikes/qtquick_p2/Main.qml`: injects the real context Fleet object into the dialog using the unambiguous property name `fleetController`, avoiding a binding to a same-named local property. No C++ domain mutation service, SQL schema, protected source file, booking flow or other modal changed.

## Native Qt regression

The existing `--p6-fleet-remove-smoke` wide/compact tests in `spikes/qtquick_p2/main.cpp` now:
1. Open real Fleet removal dialog on eligible fictional vehicle C003 and verify the initial Confirm is enabled, no warning appears, and captured target text says C003.
2. Fill exact `REMOVE C003`, change the live Fleet selection away using the real C++ controller and verify Confirm disables and the warning appears with frozen C003 target.
3. Re-select C003, verify it remains eligible in the C++ service but the same modal stays invalid, and all rental/fleet fixture bytes remain unchanged.
4. Cancel and open a fresh modal: phrase and old warning cleared, current eligible C003 Confirm rearmed.
5. Trigger genuine C++ `fleet.refreshAfterCommit()` with the same selected C003, verify stale review invalidates and Fleet file bytes remain intact; Escape and reopen require a fresh review.
6. Continue all original blank/wrong-case confirmations, Cancel, Escape, real guarded deletion, restored keyboard focus, rollback injection, no orphaned active/history rentals, persistent-mode denial and protected original files.

No registered test was skipped, deleted or added; full suite remains 123 tests.

## Failed intermediate run, explicitly excluded from acceptance

The initial source [`878086a4`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/878086a4f681bd03e5076a64d8c81cda8f469841) used `fleet: fleet` in the QML dialog, an ambiguous property/context self-binding. In [intermediate Actions 41790681362](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41790681362), **both Linux and Windows failed 8/123 CTests**, starting at Fleet removal #35/#36 with fresh Confirm incorrectly disabled, and cascading into downstream P6 workflow tests. This run **is not passing evidence**. The follow-up source commit [`a7894847`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a7894847029b77da46e1472576f6f2b4fa981260) renamed the local dialog dependency `fleetController` and binds it to the external `fleet` context. The full corrected run is the **only** authoritative success for UX-S15.

## Exact-source verification

[GitHub Actions 41790788779](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41790788779) **COMPLETED SUCCESS** against exactly `a7894847029b77da46e1472576f6f2b4fa981260`:
- **Ubuntu 24.04 GCC / Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failures, total **161.20 seconds**. Real Fleet remove QML wide #35 and compact #36 PASS, as do archived deletion wide/compact #37/#38 and all other registered tests.
- **Hosted Windows Server 2022 MSVC / Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failures, total **188.63 seconds**. The same native Fleet remove and related P6 scenarios PASS.
- **Relocated Windows packaged executable:** **8/8 real fictional-app functional checks PASS**. P2/P4 package automation and both PowerShell 7 / Windows PowerShell 5.1 checks PASS.
- Generated acceptance/evidence artifacts expire **11 November 2026**: [portable Windows physical acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41790788779/artifacts/13303653526), [hosted Windows native Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41790788779/artifacts/13303793170), [Linux native Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41790788779/artifacts/13304170933).

These are **hosted** native/packaged tests, NOT physical Windows owner acceptance, a local Qt Creator MinGW build, actual 100/125/150% Windows scaling or Narrator testing.

## Preserved gates

**Formal owner acceptance still 45/74 criteria, weighted 70.6%; P7 0/8.** P5/P6 remains accepted only within the prior fictional/disposable restrictions. Actual physical UX-S1 Rentals scrolling and focus, MinGW, scaling, Narrator, P7 D2–D8 production/privacy/security/retention/backup decisions, P8 installer, P9 release and all PR merges remain OPEN. Final Fleet Population/Photos/licensing remains **LAST**. No real customer data, production prices, commercial records, operational backup or public release introduced.

Any subsequent documentation-only HEAD is **not separately compiled** as an application source.
