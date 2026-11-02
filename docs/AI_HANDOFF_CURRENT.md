# Rental Studio 2.0 | Current AI/project handoff

**2 November 2026.** Read [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md), [CANONICAL STATE](PROJECT_STATE_CANONICAL.md), [2 Nov FULL AUDIT](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md), [ROADMAP](ROADMAP.md) and [TESTING](TESTING.md) first. [Evergreen reusable prompt](AI_CONTINUATION_PROMPT.md) is deliberately date-neutral.

## What is already true

**Latest native-verified main UI, UX-Q2:** [corrected `8a7a1ed`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8a7a1ed587b05775d1528868b1db593ce73384d3), [core 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964414), [Qt 6.8.3 Linux GCC and hosted Windows MSVC 115/115 EACH PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095). [UX-Q2 exact-source/failure/correction report](UX_Q2_RENTALS_COMPACT_TOOLBAR_NATIVE_VERIFIED_2026-11-02.md). Rentals now has separate Status and ID lookup rows, with live matching-contract counts and native wide/compact geometry assertions. The first `fb08a33` native run failed to compile from duplicate C++ test-local names; fixed in `8a7a1ed` and complete native suites rerun green. Formal **28/74 accepted, 40.6% weighted** unchanged; owner physical MinGW/scaling/Narrator review open.

**Earlier native-verified main UI, UX-Q1:** [`cd9492f`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/cd9492fc18c82d80e2a81940dbaf9ab26ca6a75b), [core 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41515463954) and [Qt 6.8.3 native Linux GCC and hosted Windows MSVC 115/115 each PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41515463962), including real 1500×860 and 1280×720 Rentals filter/keyboard tests. [UX-Q1 full source evidence](UX_Q1_RENTALS_EMPTY_STATE_NATIVE_VERIFIED_2026-11-02.md). Main Rentals now shows contextual empty filter messages and an accessible, non-mutating **Show all rentals** action; prior P7-S Lab remains unchanged. Formal **28/74, weighted 40.6%** unchanged; no physical MinGW/scaling/Narrator owner acceptance.

**Earlier P7-S source-verified:** [`062ee985`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/062ee985b879208de9b561a9298940df754f7c6c), [core 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41512827219), [native Qt Linux GCC / hosted Windows MSVC 115/115 each PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41512827186). [P7-S shared QML cards and two-row explorers](P7_S_REUSABLE_QML_EXPLORER_NATIVE_VERIFIED_2026-11-02.md); no new test count. Compiled-source SHA is distinct from later docs-only commits. D1 fictional-only, commercial D2–D8 unapproved, formal 28/74 weighted 40.6% unchanged; physical owner Windows checks remain open.

**Owner product-quality objective:** “Commercial-grade” describes the desired professional standard of the Windows desktop experience, feature completeness, reliability, maintainability and accessibility. It **does not imply an imminent sale, public release, real customer-data onboarding or a production database cutover**. Fictional-data quality improvements are the current priority; release/distribution and real-data policy gates remain a separate future track. Formal P0–P9 acceptance weighting is not a product-quality score.

**P7-R exact-source verified:** [corrected `de47e0f`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/de47e0f2f0355750f429f929f4997b63d23b2495), [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41509775107), [native Qt Linux/hosted Windows 115/115 EACH](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41509775180), Windows packaged checks PASS. [P7-R engineering report](P7_R_FICTIONAL_SQLITE_OVERVIEW_NATIVE_VERIFIED_2026-11-02.md). [P7-Q search](P7_Q_FICTIONAL_FLEET_SEARCH_NATIVE_STATUS_2026-11-02.md) was independently verified at `260794b`. Generated-fictional D1 only, D2–D8 open, no physical owner MinGW/scaling/Narrator acceptance, formal **28/74 and weighted 40.6% unchanged**.

Active P7 draft PR #17 remains stacked on P6 #14, P5 #12 and P4 #10, all unmerged, main unchanged. Earlier **compiled** source [P7-P `31d1ce3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/31d1ce3120629861ed5979faee3828c1be02d801): [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41497869038), [native Qt Linux/hosted Windows 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41497869095), hosted Windows PowerShell 7/5.1 PASS. D1 approves **generated-fictional SQLite integration only**, with the isolated fourth Lab enabled under an explicit opt-in build and special launch switch; the original three workspaces remain QSaveFile.

Normal Qt Quick Overview/Fleet/Rentals still use protected fictional QSaveFile domain and P5/P6 commands. P7-A–O established typed normalized SQL, safe model reads, commit-only refresh and real-application Lab lifecycle. **P7-P [P7-P real-app SQLite record explorer](P7_P_SQLITE_LAB_RECORD_EXPLORER_NATIVE_VERIFIED_2026-11-02.md) now adds real filtered Fleet/Rentals record explorers and selection, hide-on-read-failure, actual QML row clicks and retry at both sizes**. D2–D8, customer PII/imports, commercial cutover and formal P7/P6/P5 acceptance remain open.

## Do not conflate

- Source CI success ≠ actual Windows Qt Creator 6.10.2 MinGW, monitor 100/125/150%, Narrator, keyboard and owner signoff.
- Demo/portable kit ≠ commercial installer.
- P7 normalized fictional repository ≠ approved live commercial storage or data migration.
- Original generic vector silhouettes ≠ licensed model-specific vehicle photography.
- Booked value ≠ collected revenue.
- 28/74 formal and 40.6% evidence-weighted ≠ product development percentage.

## Current decisions needed

Review [P7 D1 limited owner authorization](P7_D1_OWNER_APPROVED_FICTIONAL_ONLY_SQLITE_INTEGRATION_2026-11-02.md) and the [P7 D2–D8 decision brief](P7_OWNER_DECISION_BRIEF_2026-11-02.md) for pricing ceilings, historic ID and retention, customer privacy, backup, migration and approval. Next engineering work should integrate only **fictional-only** C++ model parity into actual UI, not silently switch default storage. Batch physical owner MinGW/scaling/Narrator/P5/P6 review later; P8/P9 not started.

## Collaborative safety and maintenance

Inspect live PR head, CI and actual code before edits. Keep one authoritative short checkpoint rather than repeated banners. Update relevant dated evidence only if source or verified results actually change; write audit results into a new dated audit file. Commit to the existing draft branch without force, merge, release, importing real contacts or writing to main. Record exact source SHA, platform, test outcome, unresolved gates and owner-approved formal criteria separately.
