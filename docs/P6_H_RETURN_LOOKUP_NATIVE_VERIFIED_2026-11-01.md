# P6-H | Safe active return lookup by rental ID or vehicle ID

**Date:** 1 November 2026. **Product:** Rental Studio. **Verified implementation:** [`8467701`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/84677015f335b1624652d0367dfde52802e5e436), including initial implementation [`33d9b1b`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/33d9b1b9f7837a58b3712f47abccb855caf13b28). **Branch:** `feature/p6-fleet-create-disposable-20261101`. [Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14) stacked on unmerged P5 Draft #12 and P4 Draft #10. Stable `main` unchanged.

## Original operator gap and bounded implementation

Legacy Qt Widgets accepted an active **rental ID or vehicle ID** in its return form. Qt Quick previously required operators to identify an active contract by navigating and selecting a row, with no dedicated vehicle-ID return search.

Added an explicit **Return lookup** entry and keyboard-accessible **Locate return** control to native Qt Quick. This is navigation and eligibility review, never an automatic return. The preexisting **Return selected rental** button and explicit **Confirm return** dialog remain mandatory. The authoritative C++ `RentalReturnService` and `RentalSystem::completeRental` continue to own final eligibility, today's date, atomic write, rejection and rollback.

The new `RentalListModel::locateActiveReturn` is a read-only, trim/case-insensitive lookup over the existing C++ snapshot. It accepts a rental ID or vehicle ID for **exactly one active rental**; multiple active matches are rejected, not guessed. A successful lookup switches the presentation to **Active**, selects the canonical rental ID, scrolls it into view and focuses the separate return action. Invalid, blank and historical IDs **clear any previously selected rental**, which disables the return action rather than permitting an accidental stale-target confirmation. Typing a new target into the form similarly clears the old selection. Neither lookup nor failed input writes files, exposes customer names/phones to QML, or changes full-snapshot dashboard KPIs.

After a successful confirmed return, the formerly active rental disappears from the Active filter, the selection clears, and the returned record remains visible in History. Qt Quick's former read-only rental-ID lookup and All/Active/Returned/Archived/History filters remain available.

## Real tests and exact-source verification

| Gate | Result | Evidence |
|---|---|---|
| Ubuntu 24.04 core Qt/C++ CTests | **13/13 PASS** | [Workflow 41352847944](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41352847944), including expanded `vehicle_rental_p3_rental_model` |
| Qt 6.8.3 Linux GCC native Qt Quick | **68/68 PASS** | [Workflow 41352847881](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41352847881); both `rental_studio_p3_return_qml_wide` and `_compact` PASS |
| Qt 6.8.3 Windows Server 2022 MSVC native Qt Quick | **68/68 PASS** | [Same native workflow](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41352847881); wide 1500×860 and compact 1280×720 return lookup tests PASS |
| Hosted Windows relocated P4/fixture package checks | **PASS** | [Same native workflow](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41352847881); PowerShell 7 and Windows PowerShell 5.1 |

The expanded real QML test keyboard-activates the lookup to resolve `c002` to active `R001` from a History filter without writing. It verifies real return-button focus; tries returned/historical, unknown and empty targets; requires stale selection to clear; locates `r001` separately without committing; then exercises genuine Cancel and explicit Confirm on the existing dialog. It checks returned vehicle availability, no repeat return, History status, persisted disposable ledger bytes and untouched original SHA-pinned demonstration fixtures on both native platforms. Core tests check both ID forms, history rejection, stale-target disarm, KPI consistency and byte equality in isolated `QTemporaryDir` storage.

## Initial native failure and correction, retained as evidence

On [initial implementation `33d9b1b`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/33d9b1b9f7837a58b3712f47abccb855caf13b28), [core 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41352391178). The initial native [run 41352391182](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41352391182) produced **two Linux return-smoke failures (66/68)**. Diagnostic: the new explicit lookup correctly switched the native view to `Active` and the domain return persisted successfully, but the **old P3-I test** expected `R001` to remain selected and displayed in an unfiltered list after its status changed to Returned. The test logged `P3-I committed return did not refresh real QML models "" 5`: empty selected ID and five available fleet vehicles reflected the proper Active-only post-commit state. This was an assertion-model mismatch, not evidence that the authoritative return failed.

Corrected [`8467701`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/84677015f335b1624652d0367dfde52802e5e436) **strengthens**, rather than disables, native assertions: Active must have zero records, no selected ID and a disabled return action; History must display the persisted Returned rental; domain vehicle availability and original fixture protection remain required. Retested the entire core/Linux/Windows suite to green. Do **not** claim the first native source passed or infer production safety from hosted CI.

## Formal acceptance and next gates

P6's nine original criteria remain grouped provisionally and still require owner ratification; the full capability-by-capability legacy versus Qt Quick parity and separate physical owner visual/accessibility review are **not yet closed** by a single lookup feature. Provisional P6 remains **8 automated-covered / 0 partial / 1 full-parity gap**. **Formal P4 5/7, P5 0/8, P6 0/9, programme 28/74 accepted with 40.6% evidence-weighted coverage unchanged**. This is not software percentage completion or commercial release readiness.

The next P6 scope should be a **consolidated full lifecycle-parity and operator acceptance audit** to find any remaining genuine gaps, not invent new functionality solely to increase milestone counts. Commercial non-destructive vehicle retirement, lawful historical-rental retention, P7 production storage, P8 packaging/release, and P9 physical Windows QA remain separate. The fixed synthetic-only persistence, explicit disposable-only Fleet/destructive actions, single authoritative C++ writer, disabled real contact imports and stable `main` are unchanged.
