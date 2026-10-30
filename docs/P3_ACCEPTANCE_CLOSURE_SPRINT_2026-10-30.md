# P3 acceptance-closure sprint, 30 October 2026

## Outcome

At source a00b9e0f04d5cdb38c1494a15d1794e84a4d232a, two additional P3 checks are accepted on the actual compiled synthetic Qt Quick implementation. P3 advances from 3/7 to **5/7**, programme from **19/74 to 21/74** and weighted coverage from **25.2% to 28.6%**. This metric is not release readiness.

## What was actually tested

- [Guided booking implementation](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/5eb29d2d5da414f5d94bdff9c5c2f71c212474d9) uses C++ RentalQuoteService for vehicle/rate/expected return/total, C++ RentalConfirmService for independent stale quote and availability revalidation, and domain QSaveFile for the only booking commit. QML is a view, not a calculator, rule engine or alternate writer. No optimistic receipt or model refresh after rejection.
- [Qt Quick test driver correction](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/85394be1f46cc0206e07c29fa7e8b426d7ac29d8) replaces an unsupported QQuickWindow keyClicks overload. Original new native Linux compile failed solely at that smoke-test call; corrected source passed Core 10/10 and Linux/Windows 26/26 each.
- [Non-destructive archive command](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a00b9e0f04d5cdb38c1494a15d1794e84a4d232a) adds typed C++ command and a cancelable QML confirmation for returned rentals. It calls legacy archiveRental and refreshes the Rental model only after a saved ledger commit. Forced QSaveFile failure rolls back without false refresh, and archived contract remains in History. No permanent deletion UI.
- Existing return command completes the C++-owned booking, return and archive lifecycle in the restricted fictional preview. Stable rental IDs and Fleet/Rentals snapshots stay synchronized.

## Latest source CI evidence

| Evidence | Exact job output |
| --- | --- |
| [Ubuntu Core run 41111055252](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41111055252) | **11/11 PASS**, includes guided booking failure/rollback and archive failure/restart |
| [Native Linux and Windows run 41111055285](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41111055285) | **Linux 29/29 PASS; Windows 29/29 PASS**, real wide/compact booking, return, archive, keyboard/history and legacy regression |
| Hosted Windows packaging in same run | **Packaged automatic checks PASSED**, physical Windows/manual scaling NOT TESTED |
| Workflow artifacts | Linux/Windows screenshot archives and Windows physical-review kit uploaded |

## Formal P3 gate decisions

| Check | Verdict |
| --- | --- |
| 1. Characterized domain | ACCEPTED, unchanged |
| 2. Complete typed commands/results | PARTIAL / OPEN: remaining lifecycle coverage and irreversible delete guard need review |
| 3. Injectable clock and repository | PARTIAL / OPEN: legacy date and direct file ownership not injectable end to end |
| 4. Actual Qt Fleet/Rental models | **ACCEPTED**: real C++ models, ID navigation, history filter, C++ booking/return/archive and commit-only refresh in native QML |
| 5. No QML pricing/availability truth | **ACCEPTED**: real guided quote/confirm delegates pricing, eligibility and persistence to C++ domain |
| 6. No false successful write | ACCEPTED, unchanged |
| 7. Native/domain tests | ACCEPTED, unchanged |

## Frozen weighting

P0: 5% x 5/5 = 5.0%; P1: 12% x 7/10 = 8.4%; P2: 10% x 4/6 = 6.6667%; P3: 12% x 5/7 = 8.5714%; P4 through P9 have no accepted checks. **Exact sum 28.6381%, displayed 28.6%.**

## Strict safety and next decisions

This opt-in spike refuses arbitrary operational files, verifies SHA-256 fictional demo fixtures and writes only isolated QTemporaryDir copies. Real customer use, P5 single production slice, P6 full feature parity, money/storage migration, permanent deletion user controls, P1 design and owner physical Windows Qt Creator/MinGW/100-150% OS scaling signoff remain OPEN. All stacked PRs draft/unmerged; stable main untouched.

**Next: close P3 check 2** by characterizing all operational commands, validating typed results and rejecting irreversible deletion without explicit confirmed action; **then check 3** via an injectable clock and repository interface without altering legacy storage or existing business outcomes.
