# Rental Studio 2.0 | P0–P9 formal acceptance and weighted progress

**Current verified ledger: 3 November 2026.** [Latest checkpoint](LATEST_CHECKPOINT.md) | [2 November full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md) | [canonical state](PROJECT_STATE_CANONICAL.md). Phase weights and total 74 criteria were **not changed** by this documentation audit.

## Two separate measures

- **Formally accepted criteria:** met with the required reproducible evidence and, where appropriate, owner signoff. A green CTest by itself does not award acceptance.
- **Weighted accepted coverage:** sum of phase weight × (formally accepted criteria / phase criteria). This is not code completion, commercial readiness, test-suite count, or percentage of time remaining.

## Current acceptance scorecard, 3 November 2026

**3 November 2026 P6 owner decision:** The owner explicitly ratified the [nine bounded P6 criteria and six intentional Qt Quick design differences](P6_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md), accepting **P6 9/9** for generated-fictional functionality. Current total **45/74 formally accepted, 70.6% weighted**; P5 remains 8/8. Based on [compiled source `8a7a1ed`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8a7a1ed587b05775d1528868b1db593ce73384d3), [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964414), [native Linux/hosted Windows Qt 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095). Not physical Windows MinGW/scaling/Narrator signoff, real-data authorization, PR merge or release. Earlier P5-only score notes below (56.6%) are dated intermediate state.

**3 November 2026 P5 owner decision:** The owner explicitly approved all eight original Corolla booking criteria after the evidence review. [Recorded signoff](P5_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md). **P5 8/8; total 36/74, weighted 56.6%** (previously 28/74, 40.6%). Exact source [8a7a1ed](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8a7a1ed587b05775d1528868b1db593ce73384d3) passed [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964414), [Linux/Windows Qt 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095). Functional acceptance based on evidence does **not** certify physical Windows MinGW, OS scale or Narrator tests and does not authorize release. Earlier 2 November 40.6% milestone remarks below are historical.

| Phase | Scope | Weight | Formally accepted | Weighted contribution | State and actual engineering evidence |
|---|---|---:|---:|---:|---|
| P0 | Recoverable baseline | 5% | 5/5 | 5.0% | Accepted |
| P1 | Design, usability, branding/accessibility | 12% | 7/10 | 8.4% | Partial; imagery, native a11y and whole-product owner signoff |
| P2 | Native Windows Qt Quick / C++ feasibility | 10% | 4/6 | 6.7% | Partial; exact local Qt Creator/MinGW and physical scale/focus |
| P3 | Typed C++ services/model boundary | 12% | 7/7 | 12.0% | Accepted |
| P4 | Shared native QML components and navigation | 12% | 5/7 | 8.6% | Partial; owner physical focus/Narrator |
| P5 | Genuine persisted Corolla rental vertical slice | 16% | 8/8 | 16.0% | **OWNER ACCEPTED 3 Nov 2026**, original eight fictional booking outcomes; physical checks tracked separately |
| P6 | Fleet/Rental full lifecycle and safe negative paths | 14% | 9/9 | 14.0% | **OWNER ACCEPTED 3 Nov 2026**: bounded rubric, functional parity and intentional modern Qt differences; physical device review separate |
| P7 | IDs, exact money, transactions, backup/migration | 9% | 0/8 | 0% | **IN PROGRESS**; owner-approved D1 fictional SQLite engine. Actual opt-in Qt Quick Lab now includes Fleet/Rentals filtered records and safe selection/retry, native 115/115 each; normal QSaveFile app unchanged. D2–D8 commercial policy, data security and migration still unapproved |
| P8 | Offline Windows installer, privacy/rights | 5% | 0/6 | 0% | Not started |
| P9 | Final native QA and release authorization | 5% | 0/8 | 0% | Not started |
| **TOTAL** | **74 fixed criterion units** | **100%** | **45/74** | **70.6%** | **NOT RELEASED** |

**Arithmetic:** 5.0 + 8.4 + (10 × 4/6 ≈ 6.6667) + 12 + (12 × 5/7 ≈ 8.5714) + 16.0 + 14.0 = **70.638…%, displayed as 70.6%**; P7–P9 currently contribute zero. Do not sum rounded component labels to infer a false discrepancy.

## Current engineering-to-acceptance boundary

- [P5 eight-criterion crosswalk](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md): original business outcomes have native representative tests, and [all eight accepted by the owner on 3 Nov](P5_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md), **formal P5 8/8**.
- [P6-N criteria evidence](P6_N_ACCEPTANCE_CLOSURE_DECISION_RECORD_2026-11-02.md), [P6-O bounded parity contract](P6_O_RESEARCH_REVISED_ACCEPTANCE_AND_FLEET_2026-11-02.md), [P6 owner approval 3 Nov](P6_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md): **formal P6 9/9 owner accepted**, restricted fictional-data parity; physical Windows checks remain separately open.
- [P7-A candidate eight-group rubric](P7_A_MIGRATION_AND_TEST_CONTRACT_2026-11-02.md) has not been owner-ratified. [P7-G actual domain/SQL blob test](P7_G_CPP_DOMAIN_SQLITE_TRANSPORT_NATIVE_VERIFIED_2026-11-02.md) is separate from [P7-H normalized SQL candidate](P7_H_NORMALIZED_SQLITE_REPOSITORY_NATIVE_VERIFIED_2026-11-02.md); neither is the normal application storage. **Formal P7 0/8**.
- **Current latest independently native-tested application source:** [`087c923`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/087c923fcde13f8a5515c22e53e7883a15b6d5b4) passed [Qt 6.8.3 native 117/117 CTests on Ubuntu 24.04 GCC and 117/117 on hosted Windows Server 2022 MSVC](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962), with strengthened real wide/compact Gallery and Inspector source/fallback labels, motorcycle fallback screenshots, and hosted Windows PowerShell checks. [UX-Q6 report](UX_Q6_FLEET_MEDIA_STATE_NATIVE_VERIFIED_2026-11-03.md). Prior [`8f1d8cc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8f1d8cc0afa00af2feb8930ab5f02d2d1cde76ea) and [run 41632213416](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41632213416) remain historical evidence. Prior `22fd403` and `f500de0` were documentation-only; their commits were not independently compiled application source results. P1 photo licencing/visual acceptance, physical Windows Qt Creator/MinGW/OS scale/Narrator and P7 production-data approvals remain open. The [separate nine-image sourcing run](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379) **FAILED** (Wikimedia HTTP 429 for all nine original media files; 0 originals retrieved). This does not change **45/74 formally accepted, 70.6% weighted**.
- **Historical 2 November P7-P compiled source** [P7-P `31d1ce3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/31d1ce3120629861ed5979faee3828c1be02d801): [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41497869038), [native Qt Linux/hosted Windows 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41497869095), hosted Windows package checks PASS. [P7-P real-app SQLite record explorer](P7_P_SQLITE_LAB_RECORD_EXPLORER_NATIVE_VERIFIED_2026-11-02.md) upgrades actual-app generated-fictional SQL Lab record filtering and inspected Fleet/Rentals rows; no new CTest count or formal acceptance increase. Intermediate `579132b` build failure is recorded in the dated report; later exact source corrected it.
- P1/P2/P4 physical owner/device gates remain untested or open; **P6 bounded fictional operator functionality is already owner accepted 9/9**. P7 D2-D8 customer-data policy is unapproved. P8/P9 require genuine offline installer and final release QA respectively.

## Historical P3/P4 checkpoints, reproduced as dated evidence

The sections below preserve historically valid milestone traces and old progress snapshots **at the dates of those events**. Their percentages or “next work” statements are not current status and must not supersede the living scorecard above. For the audit of conflicting old documentation see [2 November report](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md).

## P4 C++ OS motion preference and native QML automation: 5/7 accepted, 40.6% weighted programme

[Source a6867c1](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a6867c1c2830ea76074f1d0d4af3e32e27392d42) passed [13/13 Core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41265064162) and [41/41 Qt native tests on Linux and Windows EACH](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41265064168), Windows package verification, and 26 screenshots retained on each OS. Windows system animation flags and conservative fallback are covered in source; test-only injected live preference changes verified rendered Qt duration and instant focus with no disk mutations. No physical OS preference toggling or Narrator claim. P4 category #5 accepted as **source/automated acceptance**, #4 and #7 open. [Motion evidence report](P4_MOTION_PREFERENCE_VERIFIED_2026-11-01.md).

## P4 shared shell / focus-route verification: 4/7 accepted, 38.9% weighted programme

Exact source `4678aff` passed [Core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41264224785) and [native Linux/Windows 37/37 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41264224690). Tab/Shift+Tab, Fleet Search/filters and keyboard workspace activation, Return/Archive modal containment, Booking initial focus/Escape, byte-identical fictional data, two-size screenshots and Windows packaged checks verified. P4 gate #2 ACCEPTED within current native shell; #4, #5 and #7 OPEN. [Source and test report](P4_SHARED_SHELL_FOCUS_CLOSURE_2026-11-01.md).

## P4 reusable native forms and confirmations: 3/7 accepted, 37.2% weighted programme

New native shared field, C++-result, text-status and confirmation components pass [Core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41122908664) and [native Qt 35/35 on Linux and Windows each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41122908683), plus Windows portable safety and both 20-image screenshot archives. P4 category 3 now ACCEPTED; categories 2,4,5,7 remain open. [Full component audit](P4_REUSABLE_COMPONENTS_VERIFIED_2026-10-30.md).

## P4 native shell checkpoint: 2/7 accepted, 35.5% weighted programme

Source 03a0e66 passed [13/13 Core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41119721899) and [33/33 Qt native tests on Linux/Windows each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41119721897). Owner palette tokens and automated two-window native screenshot generation/upload are accepted. Five remaining P4 categories still partial/open; P4 is not finished. [Review](P4_SHARED_NATIVE_SHELL_ACCEPTANCE_2026-10-30.md).

## P3 FINAL: 7/7 checks accepted, overall 32.1%

Clock/repository source ca4a19f and typed fleet/admin source 94a6e45 passed Core 13/13, native Linux 31/31 and native Windows 31/31, with Windows packaged safety PASS. P3 typed command/results and independent injected clock/storage boundary now accepted alongside the five prior checks. **P3 7/7; overall 23/74; weighted 32.1%.** See [full final P3 report](P3_FINAL_ACCEPTANCE_VERIFIED_2026-10-30.md). All P1/P2 owner tests and P4-P9 remain open.

## P3-I verified C++ return transaction and synthetic-only QML confirmed action

[P3-I source `eb09681`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/eb096817ca8b34fd590d23978e34a9007e7104a6) passed [9/9 Core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41107908823) and [23/23 native Qt per Linux/Windows](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41107908887) including cancel/no-op, selected visible active rental return, domain-owned persistent return, rejected no-refresh, rollback on forced QSaveFile failure and selected row/availability consistency. The new QML return interaction is **only on SHA-pinned fictional fixtures copied to QTemporaryDir**, not real customer data; booking and archive remain absent. P3 **3/7**, programme **19/74**, weighted **25.2%** unchanged because full operational commands, injectable repository and real booking lifecycle remain open. [Full verification](P3_I_RETURN_ACTION_VERIFIED_2026-10-30.md).

## P3-H verified Active/History Qt read filtering, phase acceptance unchanged

[P3-H source `6c1703d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c1703d5a749d9bd87f8ebad1cf2fe5929b0deca), [test correction `02fc4cc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/02fc4cc755c77c18fe40d67b1d7173cc3489dc22), [Linux Core 8/8](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41104175400) and [Qt6.8.3 native Linux 20/20 and Windows 20/20](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41104175382) provide exact-source **8/8**, **20/20 Linux and Windows** independent CTest evidence and hosted Windows portable safety checks. C++ determines All/Active/History; Qt Quick only operates the filter and renders the results, with keyboard and ID selection native QML tests. Full operational rental workflow still missing. **P3 3/7, programme 19/74 and weighted 25.2% unchanged.** See [full P3-H evidence](P3_H_ACTIVE_HISTORY_FILTER_VERIFIED_2026-10-30.md).

## P3-F/G verified native Qt Rentals/Fleet synchronization, acceptance still partial

P3-F and P3-G implement read-only QML Rentals binding and a test-only dual-model refresh after authoritative C++ confirmation of fictional data. At subsequent docs-only revision `38e6c98` of the same production source, [Linux Core 7/7](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41101676959) and [Linux/Windows Qt 17/17 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41101676963) **passed**. Prior queued runs and a superseded canceled Windows build are explained in [the verified report](P3_F_G_INTEGRATION_VERIFIED_2026-10-30.md). A real user-facing command-driven Rentals workflow is not implemented; **P3 3/7, 19/74, weighted 25.2%** remain unchanged.

## Verified P3-E native Rental Qt model (score unchanged)

[P3-E read-only native Qt model](P3_E_RENTAL_QT_MODEL_VERIFIED_2026-10-30.md) at tested source `238761d` adds explicit model reset/refresh, stable-ID selection, count change notification, lifecycle/date/rate/due roles and no personal contact data. [Core Linux 7/7 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41098537217), [Linux/Windows full native Qt 15/15 each PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41098537453). Not wired to a real Qt Quick Rentals page or domain command notifications, so criterion 4 remains PARTIAL, and **P3 3/7, total 19/74, weighted 25.2%** remain unchanged.

## Verified P3-D read-model slice (score unchanged)

[Read-only typed rental status/date snapshots](P3_D_RENTAL_READ_VERIFIED_2026-10-30.md) passed 6/6 Linux Core and 14/14 real Qt CTests on Linux and Windows. It partially advances C++ Rentals model criterion 4 but does not provide operational Qt Quick live refresh/bindings. Therefore **P3 3/7 OPEN; 19/74 accepted; 25.2% weighted** unchanged.

## Formal P3 review: three accepted, four open

**Accepted:** domain characterization, no false receipt/commit success, model/domain regression testing. **Open:** complete typed command/result scope, injectable time and repository seam, operational C++ Fleet/Rentals models, and proof that future live QML Rentals delegates pricing/availability entirely to C++. See [criterion review](P3_ACCEPTANCE_REVIEW_2026-10-30.md) and exact CI. P3 phase remains OPEN; no owner Windows or final product approval implied.

## P2–P9 acceptance requirements

**P2:** record actual Windows Qt/Qt Creator/compile kit; genuine QML desktop launch; five typed C++ vehicle model values; live Fleet Gallery ↔ Table ↔ Inspector shared state; keyboard/live resize/physical Windows scaling; recorded go/no-go technology decision. No storage rewrite in spike.

**P3:** domain characterisation, typed command/results, injectable Clock and repository, actual C++ fleet/rental models, QML never owns booking price or availability, no fake write success, model/domain unit tests.

**NEW P2 FLEET STATE/FOCUS REGRESSION (30 Oct 2026):** [Verified fix at `0f5668d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0f5668d8ef359d84aa0901c0b5ccdb3ff8cb27df) now clears the selected Inspector if a filter hides the vehicle, keeps Gallery/Table keyboard `currentIndex` aligned to the stable C++ ID after query/filter/sort, and avoids stray boundary scrolling. Added real QML `rental_studio_p2_focus_edges` CTest. Initial [run 41064963032](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41064963032) FAILED 9/10 each due stale earlier model expectation; expectation fixed without disabling tests. [Run 41065470256](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41065470256) at exact source `0f5668d`: **Linux Qt6.8.3 10/10 PASS, Windows Qt6.8.3 10/10 PASS**, Windows portable packaging PASS. [Detailed test evidence](P2_FLEET_FOCUS_EDGES_VERIFIED_2026-10-30.md). **Owner's latest Qt6.10.2 MinGW physical focus smoothness and 150% app-at-scale review PENDING**, P2 3/6 (50%), weighted 18.4% unchanged. UX-CTRL-001 remains owner-approved design only, not full hardware gate.

**P4 approved design input, NOT an accepted check:** [Owner-approved native-first Keyboard, Focus and Interaction Contract, UX-CTRL-001](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) signed off 30 Oct 2026. Rules are specified now; the minimal shared implementation, real feature integration and acceptance tests still belong to P4 and later gates. **P4 remains 0/7; the owner GO raised only the separate P2 decision criterion, bringing current total to 16/74 = 20.1%.**

**P4:** native selected design tokens, robust shared Qt Quick shell, reusable list/card/table/field/quote/dialog/status components, focus and accessibility, reduced-motion behaviour, two-window-size/native screenshots, owner Qt design feedback.

**P5:** available Corolla selected, guided validated flow, authoritative R450 × 3 quote, actual durable confirmed save, Overview/Fleet/Active consistency, restart reconstruction, duplicate and declined actions, true write-failure rejection.

**P6:** Add Car/Motorcycle, search/filter/sort selection, deletion safeguards, active/overdue, return/repeat refusal, archive and delete in allowed states, cancellation non-mutation, restart and full domain parity tests on new UI.

**P7:** separate approved storage decision, nonreusable IDs, integer cents, malformed data diagnostics, QStandardPaths data dir, transactional SQLite if chosen, backups and migration reconciliation, crash/restart tests.

**P8:** runtime/QML/third-party licences, native deployment dependencies, installer/update/uninstall data retention, clean offline Windows PC execution, privacy and credits audit, packaged restart smoke.

**P9:** exact-source local and independent Linux/Windows test runs, native Windows OS 100/125/150%, keyboard/screen reader/performance, owner whole-product signoff, truthful portfolio artifacts, and explicit approval to merge/tag/release.

## Governance and evidence rubric

Each acceptance check requires: exact branch/SHA and date; toolchain/OS; real command, PASS/FAIL, output/screenshots; safe fictional-only fixtures; regression and rollback notes; any owner decision recorded separately. Never convert “designed” into “implemented”, “browser tested” into “Qt tested”, or “candidate” into “approved”. No arbitrary percentage increases for document writing or time spent. Maintain editable detailed checklist and formula-driven XLSX supplied in conversation.

**Next accepted action:** Qt Quick technology GO is already signed by the owner. Continue bounded P3-A typed C++ adapter review (Draft PR #7) while independently retaining the remaining physical Windows Qt Creator exact SHA/CTest, supported OS Settings scale, keyboard/resize/focus evidence. P2 Qt Quick already BUILT and RUN on hosted platforms and on the owner's Windows computer. P1 whole-product image/accessibility/final owner design gate remains open in parallel. Do not restart the approved theme search, prematurely rewrite Qt models, or start SQLite/installer/API/AI.
