# Rental Studio 2.0 | Current AI/project handoff

**2 November 2026.** Read [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md), [CANONICAL STATE](PROJECT_STATE_CANONICAL.md), [2 Nov FULL AUDIT](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md), [ROADMAP](ROADMAP.md) and [TESTING](TESTING.md) first. [Evergreen reusable prompt](AI_CONTINUATION_PROMPT.md) is deliberately date-neutral.

## What is already true

Active P7 draft PR #17 on feature/p7-sqlite-sandbox-20261102 remains stacked on P6 #14, P5 #12 and P4 #10, all draft/unmerged; main untouched. Latest exactly compiled source is [P7-I b2edee6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/b2edee62f94a1283c6750451348ed4acbf11c47a), with [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41466363812) and [Linux/Windows native 110/110 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41466363800), packaged Windows PS7/PS5.1 PASS. Documentation-only heads are not fresh source builds.

Normal Qt Quick app retains polished Overview/Fleet/Rentals and fictional QSaveFile storage. P5 original eight expectations representative-tested (formal 0/8); P6 full lifecycle source-tested (formal 0/9). P7-G is real C++ domain/SQLite blob transport, P7-H is a separate normalized SQLite C++ repository, and [P7-I Qt Quick/normalized SQL preview](P7_I_QTQUICK_NORMALIZED_REPOSITORY_PREVIEW_NATIVE_VERIFIED_2026-11-02.md) is a distinct opt-in Qt Quick/C++/SQLite fictional preview with UI-driven booking/return/archive/retire and rollback verification. **The normal `Main.qml` does not use P7-H/I; real-data policies and P7 approval remain open.**

## Do not conflate

- Source CI success ≠ actual Windows Qt Creator 6.10.2 MinGW, monitor 100/125/150%, Narrator, keyboard and owner signoff.
- Demo/portable kit ≠ commercial installer.
- P7 normalized fictional repository ≠ approved live commercial storage or data migration.
- Original generic vector silhouettes ≠ licensed model-specific vehicle photography.
- Booked value ≠ collected revenue.
- 28/74 formal and 40.6% evidence-weighted ≠ product development percentage.

## Current decisions needed

Review the provisional [P7-A storage ADR](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md) for SQLite selection, exact cents and caps, lifetime C/M/R IDs, retirement and archive retention, purpose-limited customer contact/older driver licence policy, filesystem path, protected backups and fail-closed migration. Do not activate P7 data use without approval. Continue toward an actual application-facing typed repository in a fictional-only gated mode once policies are settled. Batch the P4/P5/P6 physical review rather than request manual screenshots after each incremental commit. P8 and P9 remain unstarted.

## Collaborative safety and maintenance

Inspect live PR head, CI and actual code before edits. Keep one authoritative short checkpoint rather than repeated banners. Update relevant dated evidence only if source or verified results actually change; write audit results into a new dated audit file. Commit to the existing draft branch without force, merge, release, importing real contacts or writing to main. Record exact source SHA, platform, test outcome, unresolved gates and owner-approved formal criteria separately.
