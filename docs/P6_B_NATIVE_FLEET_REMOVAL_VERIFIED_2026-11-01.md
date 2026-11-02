# P6-B | Safe native Fleet vehicle removal

**1 November 2026 | Draft PR #14 | exact tested source `4eb88704bbf0ebe9008c2f4495713b480e729168`**

## Product change
Rental Studio's native Qt Quick Fleet inspector now exposes **Remove selected vehicle**, available only for an available selected vehicle in the ordinary disposable fictional-data demonstration. A modal presents the exact vehicle ID and requires the operator to enter the case-sensitive phrase `REMOVE <canonical-ID>` (example `REMOVE C003`). Confirm, Cancel and Escape are separate keyboard-accessible paths; neither dismissal nor a mistaken phrase touches the ledger. After an actual successful removal the selected item disappears and keyboard focus returns to the still-enabled Add Vehicle control.

## Architecture and safety
- New `FleetRemoveController` is a QObject adapter to the already-established `FleetWriteService::remove`; it validates a currently existing **canonical** ID and exact confirmation string before delegating. No independent file writes or business rules are implemented in QML.
- Existing authoritative C++ domain refuses a rented vehicle or one with an active rental. The domain's atomic-write failure path restores the in-memory vehicle. Only after a successful domain commit does the adapter clear Fleet selection and refresh the model.
- This action is disabled in persistent fictional-only mode in the UI **and refused again in C++**. It operates only on disposable `QTemporaryDir` copies of SHA-protected fictional demonstration files, never original seed files or real customer records.
- Future commercial hardening must explicitly decide whether vehicles referenced by **historical returned rentals** may be removed; this increment preserves the existing domain policy, which currently guards active rentals. Do not claim general historical referential-integrity certification or production-readiness.

## Actual exact-source CI
| Gate | Source evidence | Outcome |
|---|---|---|
| Core C++/legacy | [Run 41321197645](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41321197645) | **13/13 PASS** |
| Linux GCC Qt 6.8.3 | [Run 41321197715](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41321197715) | **64/64 native CTests PASS**, P6 removal wide and compact each PASS |
| Windows Server 2022 MSVC Qt 6.8.3 | Same native run | **64/64 native CTests PASS**, P6 removal wide and compact each PASS |
| Packaged Windows P4 regression | Same native run | PowerShell 7 and Windows PowerShell 5.1 packaged checks PASS. Physical owner Narrator/OS scaling signoff NOT TESTED. |

Both native QML tests use keyboard activation on real QQuickWindow controls at **1500×860** and **1280×720** and verify: initially unavailable action without selection; C002 active-rental action disabled; C003 available action; visible button within viewport; invalid/case-wrong confirmation and cancellation do not change file bytes; Escape leaves fleet untouched; exact confirmation removes C003 and reconciles Fleet totals and selection; reopened C++ domain reflects deletion and existing active rental; injected failed-writer removal of C001 rolls back without changing disk bytes; forbidden persistent-mode command does not write; checked-in vehicle/rental fictional seed bytes remain identical; and successful dismissal restores keyboard focus to a valid enabled control.

Superseded in-progress code-head CI runs were cancelled after successive focused fixes and are **not** used for passing claims. The exact implementation source above and its genuine logs are the evidence.

## Status and continuation
[P6 Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14) remains stacked on unmerged [P5 Draft PR #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12). No merge, force-push or `main` modification. Rental Studio product name remains unchanged, and the preferred car/key/calendar logo is still a design candidate rather than a final production asset.

**P6 formally 0/9; P5 formally 0/8; P4 formally 5/7; programme 28/74 formally accepted criteria, 40.6% evidence-weighted coverage unchanged.** These figures are not a software-completion percentage or formal owner approval.

Next functional P6 priority: make archived rental deletion available only after verified archive state with exact ID confirmation, native negative/restart tests and the same fictional-only safeguards; resolve historical vehicle references before any future real-data release. Batch physical design, focus, Narrator and scaling review rather than repeatedly requesting PowerShell steps.
