# PHOTO-P1-A | Live model identity for fictional Fleet reference photographs

**3 November 2026.** Source: [`f0332a8`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f0332a81a75849fd5013ce89cc302dee110772f9) in draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17). QA: [native run 41618236689](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41618236689), completed SUCCESS for that **exact source**, not a documentation-only follow-up. Mission: [3/10 to 10/10 photography standard](../design/FLEET_PHOTOGRAPHY_10_OF_10_MISSION_2026-11-03.md).

## Why

Previously the photo store assigned images by ID number alone: C001=Corolla, C002=Ranger, C003=i20. Since `RentalSystem` allocates IDs from currently stored vehicles, deleting then adding a different vehicle could reuse an ID and display the old brand/model photo. Successful rendering did not guarantee truthful identity.

## Correction

The Qt photo store now uses a C++ identity lookup from `RentalSystem::findVehicleById`. The three offline reference images are selected by the live trimmed, case-insensitive make/model pair, not merely an ID. Deleted, unknown or missing-identity IDs fail closed; unrelated models fall back to the original vehicle-class silhouettes. Custom photo sidecars also require a live vehicle identity before display/replace/reset. No real customer media, cloud access, new asset binaries or production persistence were introduced. This is make/model matching only; no exact year, trim, registration or VIN claim.

## Native verification

| Host | Result | Coverage |
|---|---|---|
| Ubuntu 24.04, GCC, Qt 6.8.3 | **117/117 CTests PASS** | Wide and compact real Qt photo smoke including negative identity cases |
| Hosted Windows Server 2022, MSVC, Qt 6.8.3 | **117/117 CTests PASS** | Same wide and compact photo tests, Windows portable kit and PowerShell 5.1 QA PASS |

The added regressions simulate a reused C001 as a different Demo Motors model, confirm no Toyota photo appears, confirm correct Toyota Corolla lookup survives harmless casing/spacing variation, and confirm unregistered/orphan sidecar lookups fail closed. Prior Add Vehicle, Change, Restore default, sidecar tamper detection, protected fixture integrity, booking and rental tests remained enabled and passed. The simulated identity resolver test is not a full destructive-delete/reinsert end-to-end test.

Actual Qt native captures: [Windows screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41618236689/artifacts/13222487912) and [Linux screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41618236689/artifacts/13223400527). They are time-limited. No asset imagery was redesigned in this source change.

## Remaining owner gates

The three original car photographs remain **illustrative candidates**, and Honda CB500F and Yamaha MT-07 use generic silhouettes. They are not owner-approved, and the subjective 3/10 visual score has **not** been reassessed. The required five-photo artistic shortlist, crop/layout rebuild, actual physical Windows MinGW/scaling/Narrator checks, and all P7 real-data/release gates remain open. Formal acceptance **45/74, weighted 70.6%**, unchanged. Stable `main` unchanged; no PR merge or release.

**Source-screening warning:** Commons [`20250701 Honda CB500F in Lucca.JPG`](https://commons.wikimedia.org/wiki/File:20250701_Honda_CB500F_in_Lucca.JPG) describes a classic Honda **CB500 Four**, not the modern **CB500F**. Reject it despite its misleading filename.
