# Rental Studio 2.0 | Current AI/project handoff

**2 November 2026.** Read [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md), [CANONICAL STATE](PROJECT_STATE_CANONICAL.md), [2 Nov FULL AUDIT](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md), [ROADMAP](ROADMAP.md) and [TESTING](TESTING.md) first. [Evergreen reusable prompt](AI_CONTINUATION_PROMPT.md) is deliberately date-neutral.

## What is already true

The current active draft source is P7 PR #17 on feature/p7-sqlite-sandbox-20261102, stacked over P6 #14, P5 #12 and P4 #10. All drafts remain unmerged; main untouched. Latest exactly compiled P7-H source is [74fb9b3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/74fb9b39086215390dabe32ce4c422d5bffb6285). [Core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622337), [Linux and Windows native 108/108 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622338), Windows packaged PS7/PS5.1 PASS. Later docs-only heads are not newly source tested.

Qt Quick app has polished Overview/Fleet/Rentals, real C++-owned fictional booking/return/archive, strong cancellation/error guards, synthetic independent restart and Fleet snapshot. P5 eight original expectations representative-tested but 0/8 formal; P6 nine provisional groups technically demonstrated but 0/9 formal. P7-G proves a temporary SQLite interface to real C++ services; P7-H separately has normalized typed SQL rows and exact cents under OFF-by-default **test-only** compilation. The production Qt Quick app still uses generated fictional QSaveFile text and does NOT use P7-H.

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
