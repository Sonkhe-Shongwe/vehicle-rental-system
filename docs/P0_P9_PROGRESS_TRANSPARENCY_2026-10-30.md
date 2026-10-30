> **30 October 2026 | LATEST P2 SOURCE AHEAD OF VERIFIED RUN:** New native QTest keyboard/live-resize and synthetic 125%/150% DPR smoke paths were committed at `eb7bb9e22c5e3a2bd2525068202ddd2899783ae7` on Draft PR #6. [Exact source-stage report](P2_KEYBOARD_DPI_SOURCE_PENDING_2026-10-30.md). GitHub source/static review verified, **but no new Actions run for that SHA was reported at inspection**: do NOT reuse prior passes as evidence for these new tests. Previous compiled P2 CI at `f45147d` remains Linux/Windows 5/5; **P2 3/6 (50%) and weighted 18.4% unchanged**. Physical owner Windows Qt Creator/DPI and owner P1 signoff remain pending. Main and old Draft PR #4 remain untouched.

> **30 October 2026 verified phase increment:** P2's three hosted-native acceptance checks for QML compile/launch, five-vehicle typed domain model and Gallery/Table/Inspector shared state passed [exact-source Linux/Windows CI](P2_QTQUICK_NATIVE_CI_VERIFIED_2026-10-30.md). **P0 5/5, P1 7/10, P2 3/6 (50%), P3–P9 0**; weighted evidence coverage **18.4%**, NOT release readiness. Real owner Windows Qt Creator/physical scaling/toolkit go-no-go pending. Formula-driven Excel tracker updated and delivered in conversation. Previous 13.4% table below is the historical 30 October morning baseline and is superseded by this checkpoint; do not double-count it.

> **30 October 2026 P2 implementation status:** [Source prepared, Qt6 configure blocked](P2_QTQUICK_SPIKE_SOURCE_REPORT_2026-10-30.md). Do not count uncompiled new code toward verified progress. **Baseline unchanged:** P0 5/5, P1 7/10, P2 0/6, weighted delivery coverage **13.4%**. Owner design signoff and licensed photos remain open.

# Rental Studio 2.0 | P0–P9 Acceptance and Progress Governance

**30 October 2026 | Evidence-based programme baseline, not a release forecast.**

## Two independent statuses

- **Phase %:** percentage of predefined acceptance checks whose **Verified** status is supported by real dated, reproducible evidence.
- **Gate decision:** COMPLETED / OWNER SIGNED OFF / OPEN / BLOCKED. A phase with 70% progress is **not accepted** while owner/sign-off requirements remain.
- **Overall weighted delivery coverage:** \(\Sigma(phaseWeight \times verifiedChecks / totalChecks)\). The phase weights are planning allocations, not historic staff-hours or quantified cost forecasts. Freeze/revision-control weights once adopted. This metric is **not software release readiness**.

## Initial P-phase scorecard

| P | Deliverable | Planned weight | Verified checks | Phase completion | Weighted contribution | Gate |
|---|---|---:|---:|---:|---:|---|
| P0 | Recoverable baseline, historical C++/Qt behaviour and data safety | 5% | 5/5 | **100%** | 5.0% | Historical baseline documented |
| P1 | Whole-product design, usability, assets, owner approval | 12% | 7/10 | **70%** | 8.4% | OPEN |
| P2 | Native Windows Qt Quick/QML and typed C++ feasibility | 10% | 0/6 | 0% | 0% | Not started |
| P3 | C++ domain/application/services, models and safe result boundary | 12% | 0/7 | 0% | 0% | Not started |
| P4 | Shared Qt Quick components, navigation, focus and motion | 12% | 0/7 | 0% | 0% | Not started |
| P5 | Single persisted Corolla rental vertical slice end to end | 16% | 0/8 | 0% | 0% | Not started |
| P6 | Complete fleet + rental lifecycle parity, negative paths | 14% | 0/9 | 0% | 0% | Not started |
| P7 | Stable IDs, money, storage, backup/migration hardening | 9% | 0/8 | 0% | 0% | Not started |
| P8 | Offline Windows deploy/installer, privacy/licensing | 5% | 0/6 | 0% | 0% | Not started |
| P9 | Native QA, independent latest-SHA CI and owner release | 5% | 0/8 | 0% | 0% | Not started |
| **Total** | 74 source-gated acceptance checks | **100%** | **12/74** | Not a simple average | **13.4%** | **NOT RELEASED** |

**P0 evidence:** domain audit, safety/rule specification, fictional data, verified branch safety, historic compiled Qt Widgets Linux run 40944222722 and Windows run 40944222486 (CTest 2/2 on previous code SHA). Legacy UI passes must not be reused for Qt Quick.

**P1 verified seven:** three-workspace IA, owner-selected PDF theme, actual 1500×860 and 1280×720 browser screens, gallery/table/rental browser smoke, declined/empty/error states, keyboard/focus/state regressions. **Three unfinished:** broad screen-reader/zoom/native accessibility audit, model-matched licensed vehicle photography, explicit whole-product owner approval.

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

**Next action:** close P1 owner visual/accessibility/imagery requirements, then perform bounded P2 real Windows Qt Quick feasibility. Separate later SQLite, installer, AI/cloud and other unrelated architecture work.
