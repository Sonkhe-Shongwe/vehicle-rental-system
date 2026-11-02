# Rental Studio 2.0 | Current verified checkpoint

**Audited 2 November 2026, Africa/Johannesburg.** [Full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md) | [Canonical state](PROJECT_STATE_CANONICAL.md) | [Roadmap](ROADMAP.md) | [Acceptance matrix](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | [Testing](TESTING.md).

## Live source and review stack

Repository: [Sonkhe-Shongwe/vehicle-rental-system](https://github.com/Sonkhe-Shongwe/vehicle-rental-system) (**public**). Active development branch **feature/p7-sqlite-sandbox-20261102**. The latest **compiled** source and results are recorded below; documentation-only follow-ups are separate from source-validated commits. Draft [P7 PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) sits on draft [P6 #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), [P5 #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12), [P4 #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10), all **unmerged**. Recheck live heads; audit commits are docs-only, not fresh source verification. No merge/tag/release approval.

## Implemented product and exact evidence

- **Overview, Fleet and Rentals Qt Quick UI:** guided fictional quote/confirm/return/history/archive, complete-Fleet Gallery/Table/search/filter, original generic vehicle silhouette artwork, selected Inspector, clarified Fleet occupancy and quote **NOT A PAYMENT**, action hierarchy and no-results handling. [P6-P polished UI evidence](P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md): P6 source bfb591c, Linux/Windows native **74/74 each**. Current P7 source includes the same polished app.
- **P5 original eight expectations:** [representative automated evidence for 8/8](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md); formal **0/8** until operator acceptance.
- **P6 nine provisional groups:** P6-01 through P6-08 representative native test coverage; P6-09 real integrated three-process journey tested, full parity/owner rubric not accepted. [P6-O bounded review](P6_O_RESEARCH_REVISED_ACCEPTANCE_AND_FLEET_2026-11-02.md), [P6-M integrated](P6_M_THREE_PROCESS_INTEGRATED_NATIVE_VERIFIED_2026-11-02.md), formal **0/9**.
- **P7-A–P synthetic-only SQL integration:** P7-G C++ domain/SQL blob transport, P7-H typed normalized SQLite, P7-I real Qt Quick booking preview, and **P7-J existing production-facing `RentalListModel` reading validated fictional SQLite snapshots**, with active/history KPIs, selection, due states, commit-only refresh and safe failed reads. [P7-J shared read-model verification](P7_J_SHARED_RENTALS_READ_MODEL_QT_SQL_NATIVE_VERIFIED_2026-11-02.md). The normal three-workspace app is NOT commercially switched to SQL; its separate generated-fictional Lab is now an explicitly activated fourth workspace, never real-data storage.
- **P7-K snapshot recovery:** [P7-K native verified report](P7_K_SNAPSHOT_FAILURE_VISIBLE_NATIVE_VERIFIED_2026-11-02.md) verifies that a failed shared Rentals read keeps last verified rows and selection, hides unverifiable metrics in the opt-in Qt preview, and provides a genuine QML Retry action.
- **P7-L atomic read consistency:** [P7-L consistent Fleet SQLite snapshot](P7_L_FLEET_SNAPSHOT_NATIVE_VERIFIED_2026-11-02.md) wraps normalized-SQL Fleet vehicle and rental reads in one SQLite snapshot. A native competing-writer test proves the two collections cannot come from mixed-time committed states.
- **P6-Q actual product UX:** [P6-Q cross-workspace Fleet search shortcut](P6_Q_FLEET_QUICK_FIND_NATIVE_VERIFIED_2026-11-02.md) adds modal-guarded Ctrl+F to focus Fleet search from Overview or Rentals in the polished normal fictional Qt Quick application; the existing wide/compact native focus CTests now exercise it.
- **P7-M historical read integrity:** [P7-M impossible return-date read guard](P7_M_RETURN_DATE_READ_GUARD_NATIVE_VERIFIED_2026-11-02.md) rejects impossible pre-start actual return dates in both Rentals and Fleet candidate SQL projections; a new native synthetic corruption scenario is added without modifying the database schema or normal UI.
- **P7-N visible Fleet projection:** [P7-N real QML Fleet SQL projection](P7_N_REAL_QML_FLEET_SQL_PROJECTION_NATIVE_VERIFIED_2026-11-02.md) replaces the hard-coded fictional vehicle banner in the OFF-by-default Qt Quick preview with validated, transactional SQLite Fleet read values. Genuine native QML verifies commit-only availability refresh, failure-visible metrics, retry and no false UI receipt.
- **P7-O actual application integration:** [P7 D1 owner approval](P7_D1_OWNER_APPROVED_FICTIONAL_ONLY_SQLITE_INTEGRATION_2026-11-02.md) authorizes the intended SQLite engine for **generated-fictional engineering only**. [P7-O actual-app SQLite Lab](P7_O_ACTUAL_APP_SQLITE_LAB_NATIVE_VERIFIED_2026-11-02.md) adds an explicit opt-in fourth SQLite Lab to actual `Main.qml`; the default Overview/Fleet/Rentals retain protected QSaveFile data. Native tests verify rollback, booking/return/archive/retire, real UI and unchanged original files.
- **P7-P SQL read-only explorer in the actual app:** [P7-P real-app SQLite record explorer](P7_P_SQLITE_LAB_RECORD_EXPLORER_NATIVE_VERIFIED_2026-11-02.md) adds C++ Fleet availability filtering and selected value inspector, real shared Rentals filtered rows and contract details, scrollable wide/compact Qt Quick, and failure-visible read retry. The existing generated-fictional SQL Lab remains separately opted in; normal QSaveFile workspaces unchanged.
- **Latest compiled exact source:** [P7-P `31d1ce3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/31d1ce3120629861ed5979faee3828c1be02d801); [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41497869038); [native Qt Linux/hosted Windows 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41497869095); hosted Windows packaged PowerShell 7/5.1 checks PASS. Documentation-only commits are not a new compiled-source test.

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

**Next:** Continue owner-approved D1 generated-fictional adapter parity from [P7-P real-app SQLite record explorer](P7_P_SQLITE_LAB_RECORD_EXPLORER_NATIVE_VERIFIED_2026-11-02.md) toward reuse of actual Fleet/Rentals/Overview components, keeping the three normal QSaveFile workspaces unchanged until a separate authorized cutover. D2–D8 commercial money/ID/retention/privacy/backup/migration/rubric remain unapproved. P8/P9 and physical MinGW/Narrator/scaling acceptance remain open.

Keep this short. Never prepend a long chain of historical banners; place historical proofs in their dated report and link them from here.
