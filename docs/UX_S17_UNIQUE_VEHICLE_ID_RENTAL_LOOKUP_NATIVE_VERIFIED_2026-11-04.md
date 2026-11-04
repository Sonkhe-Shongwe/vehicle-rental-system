# UX-S17 | Unique vehicle-ID lookup for normal fictional Rentals

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled and tested source:** [`99d4c6511aabc2e255e0dffc3a688af7c12311cf`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/99d4c6511aabc2e255e0dffc3a688af7c12311cf)  
**Actual Actions:** [run 41797474837](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41797474837) **COMPLETED SUCCESS** for exact source `99d4c6511aabc2e255e0dffc3a688af7c12311cf`  
**Development branch:** `feature/p7-sqlite-sandbox-20261102`, stacked draft PR #17 based on draft P6 PR #14. Stable `main` unchanged.

## Functional gap and bounded implementation

The main Rentals workspace's existing `Find rental` accepted only exact rental IDs, despite the separate Return lookup already supporting vehicle IDs. An operator with a vehicle ID could not use the non-destructive general lookup to find a unique contract hidden by a lifecycle filter.

- `src/application/rental_list_model.cpp/.h`: the read-only `locateById()` first resolves an exact rental ID; otherwise it finds a vehicle ID **only if exactly one record matches across all active and historical contracts**. It refuses missing or ambiguous vehicle IDs, preserving current filter and selection. Exact rental ID remains usable when vehicle history is ambiguous.
- `spikes/qtquick_p2/Main.qml`: the normal Rentals field and accessibility descriptions now explain rental/vehicle ID lookup. Nonunique or missing lookups show a safe clarification instead of making a guess. The existing C++ selection, explicit quote, return, archive, delete and financial/storage rules are unchanged.
- `tests/p3_rental_model_tests.cpp`: verifies hidden unique-vehicle reveal, ambiguous historical vehicle refusal and exact-ID fallback with byte-identical fictional source files.
- `spikes/qtquick_p2/main.cpp`: strengthens the existing real Qt Quick wide/compact Rentals filter CTests with an actual `Find rental` button interaction using `C001` to reveal archived `R002`. Existing unknown/blank response and UX-S10 feedback checks remain active.

No separate new test registered and no existing test disabled.

## Finished exact-source verification

| Host/toolchain | Result |
|---|---|
| Hosted Ubuntu 24.04 / GCC / Qt 6.8.3 | **123/123 native CTests PASS**, zero failures. Core `vehicle_rental_p3_rental_model` #7 and actual QML `rental_studio_p3_filter_qml_wide` #47/`_compact` #48 PASS. |
| Hosted Windows Server 2022 / MSVC / Qt 6.8.3 | **123/123 native CTests PASS**, zero failures, including the same #7/#47/#48 and real return QML #49/#50. |
| Hosted Windows relocated fictional demo | **8/8 functional checks PASS**, including persisted fictional workflows, stale-quote and cancellation refusals. |
| Hosted Windows packaged automation | P2/P4 checks, PowerShell 7 and PowerShell 5.1 **PASS**. |

[Native job/run logs and artifacts](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41797474837) are the evidence, not a claim of local Qt Creator testing. Hosted Windows screenshot artifact [13306841004](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41797474837/artifacts/13306841004) was downloaded and actual compact `p3-qt-rentals-archived-1280x720.png` and `ux-s1-rentals-bottom-1280x720.png` inspected. The updated field and record rows appear without clipping in those frames. The screenshots are captured at UI checkpoints rather than after the new vehicle lookup; actual clicked behavior is proven by #47/#48 Qt event tests, not by a dedicated post-lookup screenshot.

## Safety, acceptance and next gates

This feature is confined to read-only **fictional** Rentals navigation. It neither imports real customer data nor changes SQL Lab approval, QSaveFile persistence, source fixtures, pricing, business commands, PR hierarchy, migration, images or installer. A vehicle ID with multiple past contracts is deliberately **not** resolved: the operator must enter the exact rental ID. No data was lost, deleted or modified by this lookup.

**Formal acceptance remains 45/74 criteria, fixed-weight 70.6%, P7 0/8.** P5/P6 owner decisions stand, but this engineering pass is not additional owner signoff. The owner's physical Windows UX-S1 scroll/focus, Qt Creator 6.10.2 MinGW, 100/125/150% scaling and Narrator evaluations remain open, alongside P7 D2–D8 production-data/privacy/security/retention/backup/migration choices, P8/P9 deployment/release and deferred final Fleet Population/Photos. PR #17 remains draft/unmerged, `main` unaffected.

**Recommended next:** prioritize physical UX-S1 on-device validation when the owner can genuinely perform it; meanwhile repair demonstrable operational defects with native cross-platform regression tests. Do not promote P7 real-data or release scope without the distinct owner decisions.
