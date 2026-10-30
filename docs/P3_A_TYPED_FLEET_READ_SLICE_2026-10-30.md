# P3-A | First Typed Fleet Read Boundary

**Current status:** implementation in isolated `feature/p3-typed-fleet-read-20261030` branch, branched off the approved Qt Quick P2 source. **Owner approved Qt Quick/QML as presentation and C++ as authoritative business logic.** P1 and P2 outstanding physical and aesthetic checks remain OPEN. This slice does not close the P3 phase or authorize merging.

## What changed

- `src/application/fleet_read_service.h/.cpp` adds a small **read-only, typed C++ adapter** to existing `RentalSystem`.
- `FleetVehicleSummary` is a **value type**: vehicle ID, brand, model, type, details, legacy rate and availability. `FleetReadService::vehicles()` returns independent copies; `vehicleById()` preserves case-insensitive trimmed domain lookup and returns `std::optional`, never `Vehicle*` to QML.
- The existing native `FleetModel` uses by-value summaries rather than storing `QList<Vehicle*>`; the existing Inspector, Gallery and Table obtain selected data from the **same snapshot**. Existing `QSortFilterProxyModel`, stable selection ID and user-approved UX-CTRL-001 keyboard contract are unchanged.
- An independent Qt Core-only `vehicle_rental_p3_fleet_read` CTest covers fictional car/motorcycle typing and details, status, ID semantics, missing/empty fleet, no file mutations, snapshot surviving domain change/deletion/destruction.
- Build configuration adds the adapter to the optional Qt Quick target without making it compulsory for legacy Widgets builds; existing CTests remain.
- P2 review workflow accepts a **Draft PR targeting the P2 source branch**, so the full CTest suite runs in Qt6.8.3 Linux and Windows on the *exact* P3 code. The full Windows portable smoke and fictional-data tamper checks remain.

## Deliberate non-goals / follow-ups

- The P2 demo is deliberately read-only; **snapshots do not auto-refresh** if a caller later mutates `RentalSystem`. Typed refresh and command/result contracts belong to subsequent bounded P3/P5 work, not silently introduced in this slice.
- `legacyDailyRate` is still the domain's `double`, **not an integer-cents conversion**. Monetary precision and safe migration remain a separately approved P7 change.
- No new C++ business invariants, SQLite, source-adjacent storage migration, rental booking writes, date semantics, authentication or customer data.
- Test fixtures are fictional and temporary. Preserve stable `main`, Draft PR #6 and historic rejected UI PRs.

## Gate and review

A committed diff is not a completed milestone until exact-code CI passes. P3 was **0/7** at branch creation. Only change a predefined P3 acceptance criterion after independent evidence and owner review. **No release-readiness claim.**

**Working baseline before P3:** P0 5/5, P1 7/10, P2 3/6, P3 0/7, overall 15/74 weighted 18.4%. Formal Qt Quick direction GO given, but pending P1/P2 screenscale/keyboard/whole-design gates remain recorded.
