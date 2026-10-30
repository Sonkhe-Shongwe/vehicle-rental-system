# Rental Studio 2.0 | P0–P9 Acceptance and Progress Governance

**30 October 2026 | Current evidence-weighted programme score.** [Canonical state](PROJECT_STATE_CANONICAL.md) · [Full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md). Historical preliminary 13.4% is superseded; the operative verified score below is 18.4%. This is NOT release readiness.

## Two independent statuses

- **Phase %:** percentage of predefined acceptance checks whose **Verified** status is supported by real dated, reproducible evidence.
- **Gate decision:** COMPLETED / OWNER SIGNED OFF / OPEN / BLOCKED. A phase with 70% progress is **not accepted** while owner/sign-off requirements remain.
- **Overall weighted delivery coverage:** \(\Sigma(phaseWeight \times verifiedChecks / totalChecks)\). The phase weights are planning allocations, not historic staff-hours or quantified cost forecasts. Freeze/revision-control weights once adopted. This metric is **not software release readiness**.

## Current verified P-phase scorecard (30 October 2026)

| P | Deliverable | Planned weight | Verified checks | Phase completion | Weighted contribution | Gate |
|---|---|---:|---:|---:|---:|---|
| P0 | Recoverable baseline, historical C++/Qt behaviour and data safety | 5% | 5/5 | **100%** | 5.0% | Historical baseline documented |
| P1 | Whole-product design, usability, assets, owner approval | 12% | 7/10 | **70%** | 8.4% | OPEN |
| P2 | Native Windows Qt Quick/QML and typed C++ feasibility | 10% | 3/6 | **50%** | 5.0% | OPEN: owner physical Windows/toolkit decision |
| P3 | C++ domain/application/services, models and safe result boundary | 12% | 0/7 | 0% | 0% | Not started |
| P4 | Shared Qt Quick components, navigation, focus and motion | 12% | 0/7 | 0% | 0% | Not started |
| P5 | Single persisted Corolla rental vertical slice end to end | 16% | 0/8 | 0% | 0% | Not started |
| P6 | Complete fleet + rental lifecycle parity, negative paths | 14% | 0/9 | 0% | 0% | Not started |
| P7 | Stable IDs, money, storage, backup/migration hardening | 9% | 0/8 | 0% | 0% | Not started |
| P8 | Offline Windows deploy/installer, privacy/licensing | 5% | 0/6 | 0% | 0% | Not started |
| P9 | Native QA, independent latest-SHA CI and owner release | 5% | 0/8 | 0% | 0% | Not started |
| **Total** | 74 source-gated acceptance checks | **100%** | **15/74** | Not a simple average | **18.4%** | **NOT RELEASED** |

**P0 evidence:** domain audit, safety/rule specification, fictional data, verified branch safety, historic compiled Qt Widgets Linux run 40944222722 and Windows run 40944222486 (CTest 2/2 on previous code SHA). Legacy UI passes must not be reused for Qt Quick.

**Historical initial baseline** was 12/74 and 13.4% before P2 native verification. Current counts are in the table above.

**P1 verified seven:** three-workspace IA, owner-selected PDF theme, actual 1500×860 and 1280×720 browser screens, gallery/table/rental browser smoke, declined/empty/error states, keyboard/focus/state regressions. **Three unfinished:** broad screen-reader/zoom/native accessibility audit, model-matched licensed vehicle photography, explicit whole-product owner approval.

**Owner physical Windows partial proof:** local Qt Creator 6.10.2 MinGW Debug compiled/launched the actual read-only Fleet spike; user screenshots verified Corolla Inspector, Gallery/Table selected vehicle, available-only four, correct Rate sort and Escape clear. A later real Windows Settings screenshot **now confirms 150% Recommended at 1920×1080 Recommended**, but does NOT prove Qt application behaviour at that scale, other supported scales, whole keyboard accessibility, local CTest SHA or toolkit owner go/no-go, so **P2 remains 3/6**.

**P2 verified three:** [Exact-source hosted Windows/Linux 8/8 native QML and interaction/DPI checks](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_NATIVE_INPUT_DPI_VERIFIED_2026-10-30.md), excluding physical Windows scaling and toolkit signoff.

## P2–P9 acceptance requirements

**P2:** record actual Windows Qt/Qt Creator/compile kit; genuine QML desktop launch; five typed C++ vehicle model values; live Fleet Gallery ↔ Table ↔ Inspector shared state; keyboard/live resize/physical Windows scaling; recorded go/no-go technology decision. No storage rewrite in spike.

**P3:** domain characterisation, typed command/results, injectable Clock and repository, actual C++ fleet/rental models, QML never owns booking price or availability, no fake write success, model/domain unit tests.

**P4:** native selected design tokens, robust shared Qt Quick shell, reusable list/card/table/field/quote/dialog/status components, focus and accessibility, reduced-motion behaviour, two-window-size/native screenshots, owner Qt design feedback.

**P5:** available Corolla selected, guided validated flow, authoritative R450 × 3 quote, actual durable confirmed save, Overview/Fleet/Active consistency, restart reconstruction, duplicate and declined actions, true write-failure rejection.

**P6:** Add Car/Motorcycle, search/filter/sort selection, deletion safeguards, active/overdue, return/repeat refusal, archive and delete in allowed states, cancellation non-mutation, restart and full domain parity tests on new UI.

**P7:** separate approved storage decision, nonreusable IDs, integer cents, malformed data diagnostics, QStandardPaths data dir, transactional SQLite if chosen, backups and migration reconciliation, crash/restart tests.

**P8:** runtime/QML/third-party licences, native deployment dependencies, installer/update/uninstall data retention, clean offline Windows PC execution, privacy and credits audit, packaged restart smoke.

**P9:** exact-source local and independent Linux/Windows test runs, native Windows OS 100/125/150%, keyboard/screen reader/performance, owner whole-product signoff, truthful portfolio artifacts, and explicit approval to merge/tag/release.

## Governance and evidence rubric

Each acceptance check requires: exact branch/SHA and date; toolchain/OS; real command, PASS/FAIL, output/screenshots; safe fictional-only fixtures; regression and rollback notes; any owner decision recorded separately. Never convert “designed” into “implemented”, “browser tested” into “Qt tested”, or “candidate” into “approved”. No arbitrary percentage increases for document writing or time spent. Maintain editable detailed checklist and formula-driven XLSX supplied in conversation.

**Next accepted action:** finish the remaining real Windows Qt Creator exact SHA/CTest, manually supported OS Settings 100/125/150% scaling, keyboard/resize/focus evidence and explicit toolkit go/no-go. P2 Qt Quick already BUILT and RUN on hosted platforms and on the owner's Windows computer. P1 whole-product image/accessibility/final owner design gate remains open in parallel. Do not restart the approved theme search, prematurely rewrite Qt models, or start SQLite/installer/API/AI.
