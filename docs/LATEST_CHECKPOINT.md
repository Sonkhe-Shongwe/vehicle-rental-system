# Rental Studio 2.0 | Current verified checkpoint

**Audited 2 November 2026, Africa/Johannesburg.** [Full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md) | [Canonical state](PROJECT_STATE_CANONICAL.md) | [Roadmap](ROADMAP.md) | [Acceptance matrix](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | [Testing](TESTING.md).

## Live source and review stack

Repository: [Sonkhe-Shongwe/vehicle-rental-system](https://github.com/Sonkhe-Shongwe/vehicle-rental-system) (**public**). Latest development branch at audit start **feature/p7-sqlite-sandbox-20261102**, code-source commit **74fb9b39086215390dabe32ce4c422d5bffb6285**, subsequent documented-state commit **4e46dd56a7f72e8c3988654c3b67284dea36412e**. Draft [P7 PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) sits on draft [P6 #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), [P5 #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12), [P4 #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10), all **unmerged**. Recheck live heads; audit commits are docs-only, not fresh source verification. No merge/tag/release approval.

## Implemented product and exact evidence

- **Overview, Fleet and Rentals Qt Quick UI:** guided fictional quote/confirm/return/history/archive, complete-Fleet Gallery/Table/search/filter, original generic vehicle silhouette artwork, selected Inspector, clarified Fleet occupancy and quote **NOT A PAYMENT**, action hierarchy and no-results handling. [P6-P polished UI evidence](P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md): P6 source bfb591c, Linux/Windows native **74/74 each**. Current P7 source includes the same polished app.
- **P5 original eight expectations:** [representative automated evidence for 8/8](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md); formal **0/8** until operator acceptance.
- **P6 nine provisional groups:** P6-01 through P6-08 representative native test coverage; P6-09 real integrated three-process journey tested, full parity/owner rubric not accepted. [P6-O bounded review](P6_O_RESEARCH_REVISED_ACCEPTANCE_AND_FLEET_2026-11-02.md), [P6-M integrated](P6_M_THREE_PROCESS_INTEGRATED_NATIVE_VERIFIED_2026-11-02.md), formal **0/9**.
- **P7-A–K synthetic-only SQL integration:** P7-G C++ domain/SQL blob transport, P7-H typed normalized SQLite, P7-I real Qt Quick booking preview, and **P7-J existing production-facing `RentalListModel` reading validated fictional SQLite snapshots**, with active/history KPIs, selection, due states, commit-only refresh and safe failed reads. [P7-J shared read-model verification](P7_J_SHARED_RENTALS_READ_MODEL_QT_SQL_NATIVE_VERIFIED_2026-11-02.md). **NOT** the normal application SQL runtime or commercial data activation.
- **P7-K snapshot recovery:** [P7-K native verified report](P7_K_SNAPSHOT_FAILURE_VISIBLE_NATIVE_VERIFIED_2026-11-02.md) verifies that a failed shared Rentals read keeps last verified rows and selection, hides unverifiable metrics in the opt-in Qt preview, and provides a genuine QML Retry action.
- **Latest compiled P7-K source:** [P7-K `5785020`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/5785020bc6eb95ed23b63bfc16768db712143cff); [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41474440150); [native Qt 6.8.3 Linux/hosted Windows 111/111 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41474440071); Windows packaged PowerShell 7/5.1 PASS. Documentation-only heads are not new compiled source tests.

## Acceptance: 28/74, weighted 40.6%, NOT a release percentage

| Phase | Accepted | Phase state |
|---|---:|---|
| P0 | 5/5 | Closed |
| P1 | 7/10 | Design/imagery/accessibility signoff open |
| P2 | 4/6 | Owner device/kit signoff open |
| P3 | 7/7 | Accepted C++ domain boundary |
| P4 | 5/7 | Physical focus/accessibility approval open |
| P5 | 0/8 | Representative test coverage; owner acceptance open |
| P6 | 0/9 | Implemented lifecycle, provisional rubric/owner review open |
| P7 | 0/8 | Candidate tested; **commercial runtime not integrated** |
| P8 | 0/6 | Offline installer not started |
| P9 | 0/8 | Release QA not started |

## Hard prohibitions and immediate next meaningful work

No real customer data, licence imports, destructive commercial history deletion, arbitrary filesystem open/import, live SQLite cutover, release packaging/install or merging without explicit owner approval. Protected fictional QSaveFile runtime remains the normal app path. P7 normalized candidate has **no customer contact fields** and is compiled only by opt-in tests. Owner physical Qt Creator **6.10.2 MinGW**, supported OS 100/125/150% scale and Narrator, current application keyboard/UX and P5/P6 signoff remain unverified. Owner's earlier Windows screenshots establish partial static UI observations only.

**Next:** obtain one consolidated P7 architecture/privacy/retention/ID/money/backup/cutover decision; then connect approved typed storage to a fictional-only runtime and complete P8 offline packaging and P9 physical/final acceptance. Manual operator testing remains batched into one later consolidated candidate session.

Keep this short. Never prepend a long chain of historical banners; place historical proofs in their dated report and link them from here.
