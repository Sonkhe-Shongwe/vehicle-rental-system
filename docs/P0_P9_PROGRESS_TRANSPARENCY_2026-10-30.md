> **30 October 2026 | LATEST VERIFIED P2 ON-DEVICE TEST PACKAGE:** [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) source `3620d83518cc01bce047b6f0a17deab0b96079b6` passed [GitHub Actions run 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629): **8/8 native CTests each on Linux/GCC and hosted Windows/MSVC**, plus Windows **`windeployqt` portable review bundle**, relocated C++ self-test and native QML smoke PASS, and deliberately altered fictional-fixture rejection PASS. [Evidence report on P2 source branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_WINDOWS_PHYSICAL_KIT_VERIFIED_2026-10-30.md). Download **`p2-windows-physical-acceptance-kit`** from workflow artifacts (7-day retention) and follow `WINDOWS_PHYSICAL_ACCEPTANCE.md` on the user's own Windows PC. The kit contains only fake-demo records and QT DLL/QML components, **NOT a release**. **P2 stays 3/6 (50%), overall weighted 18.4%** until real user's Windows/Qt Creator kit, actual display scaling and toolkit approval are observed; P1 owner design/licensed imagery/accessibility remain pending. Stable main and Draft PR #4/#6 unmerged.

> **Latest P2 verification, 30 October 2026:** Isolated [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) source `eeb08485245ef127d6a9e53c2d80ec68bca66c0b` achieved **8/8 real native Qt6.8.3 CTests on both Linux/GCC and hosted Windows/MSVC2022** in [run 41045646448](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045646448). Added real Qt keyboard/row selection, Escape, dynamic window resize and **synthetic** `QT_SCALE_FACTOR=1.25/1.5` test captures. Windows/Linux PNG screenshots visually inspected at 1500×860, 1280×720, synthetic 1280×825 and 1536×990 pixels. Prior run [41045247197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045247197) **FAILED 7/8** due row lookup in a dynamic ListView; fixed with QQuickItem visual hierarchy without weakening keyboard assertions. [Full verified report](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_NATIVE_INPUT_DPI_VERIFIED_2026-10-30.md). **P2 3/6 (50%), overall weighted evidence 18.4%**: hosted/synthetic tests do not fulfill owner's physical Windows Qt Creator/100–150% DPI, final toolkit go/no-go or P1 design signoff. Stable main and both Draft PRs remain untouched/unmerged.

> **LATEST VERIFIED P2 CHECKPOINT | 30 October 2026:** Separate [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) source branch `spike/p2-qtquick-fleet-20261030` implemented read-only real C++/QML Fleet model and shared Gallery/Table/Inspector. **Exact tested code SHA `f45147d05d3449ffc89514fb1e685e2990c843fc`**: [GitHub Actions run 41043137443](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41043137443) PASS **5/5 CTests Linux Qt6.8.3/GCC** and **5/5 Windows Server 2022 Qt6.8.3/MSVC**; eight genuine compiled Qt screenshot PNGs inspected with precise 1500×860 and 1280×720 sizes. Windows tofu fonts and screenshot-size clipping fixed. Latest P2 branch docs checkpoint `137055e4bf7ebaa878ea4ce30f8eb0b2b61469a2`; [detailed P2 report on spike branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_QTQUICK_NATIVE_CI_VERIFIED_2026-10-30.md). **P2 3/6 (50%); overall weighted progress 18.4%**, not release readiness. **Still pending:** owner physical Windows Qt Creator kit, actual OS DPI 100/125/150%, keyboard/accessibility, toolkit go/no-go, final P1 design/image/owner signoff. Draft PR #6 and old Draft PR #4 remain OPEN/UNMERGED; stable main untouched. The older checkpoint lines below are dated history.

# Rental Studio 2.0 | P0–P9 Acceptance and Progress Governance

**30 October 2026 | Evidence-based programme baseline, not a release forecast.**

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

**Historical initial baseline** was 12/74 and 13.4% before P2 native verification. Current counts are in the table above.\n\n**P1 verified seven:** three-workspace IA, owner-selected PDF theme, actual 1500×860 and 1280×720 browser screens, gallery/table/rental browser smoke, declined/empty/error states, keyboard/focus/state regressions. **Three unfinished:** broad screen-reader/zoom/native accessibility audit, model-matched licensed vehicle photography, explicit whole-product owner approval.

**P2 verified three:** [Exact-source hosted Windows/Linux 8/8 native QML and interaction/DPI checks](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_NATIVE_INPUT_DPI_VERIFIED_2026-10-30.md), excluding physical Windows scaling and toolkit signoff.\n\n## P2–P9 acceptance requirements

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
