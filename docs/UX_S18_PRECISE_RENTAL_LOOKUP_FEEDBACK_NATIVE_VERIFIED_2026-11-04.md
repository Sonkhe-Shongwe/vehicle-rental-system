# UX-S18 | Precise general rental lookup results and accessible feedback

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled source:** [`0acce4a65e37ab806fa811a8a24e614655fbf5ff`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0acce4a65e37ab806fa811a8a24e614655fbf5ff)  
**Native CI:** [GitHub Actions 41801001349](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41801001349) **COMPLETED SUCCESS** against exact source `0acce4a65e37ab806fa811a8a24e614655fbf5ff`  
**Scope:** existing fictional-only Rentals workspace. Draft PR #17 remains stacked on P6 PR #14. No `main` mutation.

## Demonstrated operator defect and implementation

UX-S17 had already added safe unique vehicle-ID lookup to normal Rentals, but QML displayed one combined failure message for unknown IDs and vehicle IDs with multiple historical contracts. A failed snapshot also looked like an unknown record. The response was placed in a one-line `Text.ElideRight` Label, so important guidance could be clipped at compact sizes. After a failed read, a prior success message could also remain visible because the model retained buffered selection and did not emit `modelReset`.

- `src/application/rental_list_model.cpp/.h`: a single typed C++ lookup path `locateForOperator` returns one of `Selected`, `Empty`, `NotFound`, `Ambiguous` or `Unavailable`. Existing boolean `locateById` delegates to the same path, preserving all legacy callers and exact rental-ID priority. Missing/ambiguous/unavailable results preserve selection, filter and storage. A successful exact or unique vehicle match reveals the contract, including when hidden by a lifecycle or search filter. No PII or domain writes.
- `spikes/qtquick_p2/Main.qml`: distinct plain-English guidance for each failure, and clear successful selection confirmation. Lookup feedback moves to a conditional, full-width, word-wrapping line below the input row. On rental snapshot availability change, old success messages clear; pending Return/Archive reviews become invalid on unavailability.
- `tests/p3_rental_model_tests.cpp`: read-only empty and not-found outcomes preserve existing selected rental; ambiguous vehicle history refuses a guessed contract; unavailable snapshot refuses lookup, and recovery restores a successful lookup.
- `spikes/qtquick_p2/main.cpp`: strengthens the existing actual Qt Quick Rentals filter tests, verifying the missing-ID error string and visible response geometry at wide and compact viewports, blank guidance and legacy unique vehicle route. The test accesses the Label via its QML object ID because it is intentionally hidden before an operator enters a lookup.

No new registered tests, skipped tests, external input files or real-customer paths.

## Exact-source validation

| Host | Result |
|---|---|
| Hosted Ubuntu 24.04 GCC / Qt 6.8.3 | **123/123 native CTests PASS, 0 failed**, including model #7 and real Rentals filter QML wide #47 and compact #48. |
| Hosted Windows Server 2022 MSVC / Qt 6.8.3 | **123/123 native CTests PASS, 0 failed**, including #7, #47, #48 and Returns #49/#50. |
| Hosted Windows relocated fictional executable | **8/8 functional checks PASS**, portable package verification and PowerShell 7/5.1 PASS. |

Exact logs and downloadable artifacts: [Actions 41801001349](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41801001349). The [Windows screenshot artifact 13308361673](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41801001349/artifacts/13308361673) was downloaded and inspected for the compact `p3-qt-rentals-archived-1280x720.png` and `ux-s1-rentals-bottom-1280x720.png`. Those frames show baseline archived-rental layout, filter and bottom-record reachability, **not a separate post-error lookup capture**. The conditional error Label's visibility and geometry were verified by actual event-driven QML CTests (#47 and #48). Hosted tests and screenshots do not prove physical Qt Creator/MinGW, Windows scaling or Narrator signoff.

## Intermediate failures, fully retained

- [Run 41799944666](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41799944666) **FAILED** in the earlier source `d331b77c`: C++ model #7 incorrectly expected a missing search to clear selection instead of preserving it; actual QML wide/compact #47/#48 sought a new hidden-until-feedback Label using a visible-only helper.
- [Run 41800108641](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41800108641) **FAILED** in intermediate source `8b4d4e05`: fixed the selection expectation, so #7 passed, but #47/#48 still could not discover the initially hidden Label.
- [Source `0acce4a65e37ab806fa811a8a24e614655fbf5ff`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0acce4a65e37ab806fa811a8a24e614655fbf5ff) corrects discovery through the actual QML object's ID, then asserts that the feedback becomes visible after the operator searches. [Run 41801001349](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41801001349) passes both OS suites completely. No history was rewritten and failures are not characterized as successful tests.

## Acceptance and explicit limits

This is engineering completion of one safe fictional UX issue, **not** owner signoff. Formal status remains **45/74 owner accepted criteria, fixed weighted 70.6%, P7 0/8**. P5/P6 prior owner approvals stand. UX-S1 physical Windows scroll/focus, Qt Creator 6.10.2 MinGW, 100/125/150% scaling, Narrator, P7 D2–D8 user-data/security/privacy/retention/backup/migration decisions, P8 installer, P9 release and final Fleet Population/Photos remain OPEN. Draft PR #17 and `main` are not merged or modified; no production customer records, arbitrary import paths, payments or other real data used.

**Next:** continue demonstrable C++-owned operations or accessibility recovery issues with actual native regression checks. Physical owner testing and separate policy authorization are still required before those gates can close.
