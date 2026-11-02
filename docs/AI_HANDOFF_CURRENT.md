# Rental Studio 2.0 | Current AI/project handoff

**2 November 2026.** Read [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md), [CANONICAL STATE](PROJECT_STATE_CANONICAL.md), [2 Nov FULL AUDIT](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md), [ROADMAP](ROADMAP.md) and [TESTING](TESTING.md) first. [Evergreen reusable prompt](AI_CONTINUATION_PROMPT.md) is deliberately date-neutral.

## What is already true

Active P7 draft PR #17 on feature/p7-sqlite-sandbox-20261102 remains stacked over P6 #14, P5 #12, P4 #10, all unmerged, main untouched. Latest **compiled** source [P7-M `9d8a063`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9d8a063c78ce0a5d5ab0d7d742e98535334c80c5): [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41483914359), [native Qt Linux/hosted Windows 113/113 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41483914095), Windows packaged PS7/PS5.1 PASS. The P6-Q normal Qt Quick UX change sits on the existing P7 stacked draft branch, not the P6 PR branch.

Normal Qt Quick app retains polished Overview/Fleet/Rentals and fictional QSaveFile storage. P7-G is domain C++/SQL blob, P7-H typed normalized SQL, P7-I real opt-in Qt Quick commands and [P7-J shared read-model verification](P7_J_SHARED_RENTALS_READ_MODEL_QT_SQL_NATIVE_VERIFIED_2026-11-02.md) the **existing Rentals read model** over validated SQL snapshots, with commit-only refresh and KPI/selection parity. P7-K [P7-K native verified report](P7_K_SNAPSHOT_FAILURE_VISIBLE_NATIVE_VERIFIED_2026-11-02.md) adds visible failed-read state and retry in the opt-in QML review. P7-L [P7-L consistent Fleet SQLite snapshot](P7_L_FLEET_SNAPSHOT_NATIVE_VERIFIED_2026-11-02.md) ensures Fleet availability is built from one transactional SQL vehicle-and-rental snapshot, with a native competing-writer regression. P6-Q [P6-Q cross-workspace Fleet search shortcut](P6_Q_FLEET_QUICK_FIND_NATIVE_VERIFIED_2026-11-02.md) adds Ctrl+F Fleet Quick Find from Overview/Rentals without stealing modal focus or writing records. P7-M [P7-M impossible return-date read guard](P7_M_RETURN_DATE_READ_GUARD_NATIVE_VERIFIED_2026-11-02.md) rejects impossible historical return dates in both SQL read projections; [P7 owner decision brief](P7_OWNER_DECISION_BRIEF_2026-11-02.md) is ready for owner review but is NOT approved. No actual `Main.qml` SQL storage, no real PII or migrations, and no formal P5/P6/P7 acceptance.

## Do not conflate

- Source CI success ≠ actual Windows Qt Creator 6.10.2 MinGW, monitor 100/125/150%, Narrator, keyboard and owner signoff.
- Demo/portable kit ≠ commercial installer.
- P7 normalized fictional repository ≠ approved live commercial storage or data migration.
- Original generic vector silhouettes ≠ licensed model-specific vehicle photography.
- Booked value ≠ collected revenue.
- 28/74 formal and 40.6% evidence-weighted ≠ product development percentage.

## Current decisions needed

Review [P7 owner decision brief](P7_OWNER_DECISION_BRIEF_2026-11-02.md) and the underlying provisional [P7-A storage ADR](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md) for SQLite selection, exact cents and owner-set caps, lifetime C/M/R IDs, retirement/history retention, contacts/old licence policy, filesystem path, protected backups and fail-closed migration. Do not activate P7 data use without approval. Continue toward an actual application-facing typed repository in a fictional-only gated mode once policies are settled. Batch the P4/P5/P6 physical review rather than request manual screenshots after each incremental commit. P8 and P9 remain unstarted.

## Collaborative safety and maintenance

Inspect live PR head, CI and actual code before edits. Keep one authoritative short checkpoint rather than repeated banners. Update relevant dated evidence only if source or verified results actually change; write audit results into a new dated audit file. Commit to the existing draft branch without force, merge, release, importing real contacts or writing to main. Record exact source SHA, platform, test outcome, unresolved gates and owner-approved formal criteria separately.
