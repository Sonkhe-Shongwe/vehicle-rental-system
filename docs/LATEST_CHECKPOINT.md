> **P5/P6 FORMAL ACCEPTANCE RECONCILIATION, 1 NOV 2026:** [Original-requirement evidence review](P5_P6_ACCEPTANCE_RECONCILIATION_2026-11-01.md) finds **P5 8/8 representative native automated-covered, but formal 0/8 until documented owner/acceptance approval**. P6's *provisional*, explicitly unratified nine-capability grouping finds **7 representative automated-pass, 1 partial (full cross-process P6 restart coverage), 1 wider lifecycle-parity gap**. P6 formal remains 0/9. Former `Not started` milestone labels corrected to `IN PROGRESS`. The formal **28/74, 40.6% evidence-weighted** tally remains unchanged deliberately. Next: ratify the nine-check P6 rubric, design a non-destructive commercial vehicle-retirement/retention policy, close broader lifecycle parity, and consolidate P5 owner review. This is not a release score.

# Rental Studio 2.0 | Latest working checkpoint

**Audited:** 1 November 2026 (Africa/Johannesburg). This is a short index of the **current** development state, not a replacement for [canonical criteria](PROJECT_STATE_CANONICAL.md), [testing policy](TESTING.md), [dated evidence](P6_B_NATIVE_FLEET_REMOVAL_VERIFIED_2026-11-01.md), or live GitHub. Recheck live branches, PRs, tracking issues and CI on every continuation. Do not treat any dated SHA as an evergreen branch HEAD.

## Current GitHub stack and ownership

- Repository: [`Sonkhe-Shongwe/vehicle-rental-system`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system).
- Latest development branch: `feature/p6-fleet-create-disposable-20261101`.
- [Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), stacked on P5 [Draft PR #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12), stacked on P4 [Draft PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10). All are open and unmerged.
- Stable `main` remains unmodified by this stack. Never merge, rebase destructively, force-push, or modify stable `main` without explicit owner authorization.
- Latest exact **tested implementation source**: `ec5859a06682caaf658f7f43e7a5a06ec801a815` (P6-D). Subsequent documentation heads are not used as substitute evidence for changed code.

## Product and current implementation

**Name:** Rental Studio. The previously preferred key/calendar/car logo is a **concept**, not a finalized licensed/trademark-checked production brand asset. Qt Quick/QML desktop with navy/emerald/cloud-white design and authoritative C++ rental rules. Continue functional/commercial readiness deliberately; no real customer records, payments, installer, cloud service, or general-purpose production storage is approved.

P5 includes a tested operational Overview, guided fictional rental booking/return and lifecycle workflows, stale quote and cancellation safeguards, an actionable overdue review route, a fixed synthetic-only persistent session with a single-writer guard, and native restart/failed-write evidence. [P5 evidence crosswalk](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md).

P6 has **four implemented and CI-verified increments** in Draft PR #14:
- **P6-A:** Qt Quick Add Car/Motorcycle via typed `FleetWriteService` and post-commit Fleet selection/refresh. [Evidence](P6_A_FLEET_CREATE_NATIVE_VERIFIED_2026-11-01.md).
- **P6-B:** selected available vehicle removal after exact case-sensitive `REMOVE <ID>` confirmation, active-rental refusal, Cancel/Escape/no-write, failed-write rollback, reopened disposable domain and focus restoration. [Evidence](P6_B_NATIVE_FLEET_REMOVAL_VERIFIED_2026-11-01.md).
- **P6-C:** permanent removal of an **already archived** fictional rental using the existing `ArchivedDeleteService`, an exact `DELETE <ID>` phrase, modal cancellation protections, rejected-write rollback, selection/focus and separate-process-style domain reopen checks. Never enabled in the fixed persistent fictional session. [Evidence](P6_C_ARCHIVED_DELETE_NATIVE_VERIFIED_2026-11-01.md).
- **P6-D:** C++ domain rejects removal of vehicles referenced by *any surviving rental*, including returned/archived history; typed rejection and Qt inspector hint, legacy Widgets message and native archive/delete/Fleet removal/reopen checks. [Evidence](P6_D_HISTORICAL_VEHICLE_REFERENCES_VERIFIED_2026-11-01.md).

These P6 Fleet/Rentals destructive mutations work **only on temporary fictional data**, not the opt-in fixed persistent fictional session. That restriction is enforced again in C++, not only UI. Historical **returned-rental references** to a removed vehicle are an unresolved integrity/design concern for future commercial storage; do not silently change policy or claim it production-safe.

## Latest verified CI at P6-D implementation source

- [Core run 41339190637](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41339190637): **13/13 PASS**.
- [Native Qt Linux GCC and hosted Windows MSVC run 41339190640](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41339190640): **66/66 CTests PASS on each OS**, including P6-D history protection exercised through Fleet remove and archived delete wide/compact, plus relocated Windows P4 packaged checks under PowerShell 7 and Windows PowerShell 5.1.
- Hosted CI is **not** physical owner PC/Qt Creator validation or owner accessibility/aesthetic signoff. Physical Windows scaling and Narrator remain open.

## Formal progress and next functional boundary

**P4 5/7 formally accepted; P5 0/8; P6 0/9; overall 28/74 accepted and 40.6% evidence-weighted coverage.** Verified implementation and passing automated tests are not equivalent to full milestone acceptance. These numbers are **not percentage of finished software or commercial release readiness**. Recalculate only against [74-criterion matrix](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) when evidence justifies an acceptance change.

Next meaningful P6 work, if the owner asks to continue development: close remaining Fleet/Rentals lifecycle parity with targeted native interaction and restart checks, particularly the **full independent process restart and domain/UI lifecycle parity**. The fictional-only historical reference safeguard is now verified; commercial vehicle retirement and legal data retention remain separate design decisions. Before production approval explicitly settle referential integrity and address the P7–P9 storage, release, rights, privacy, Windows packaging and owner acceptance gates. Work on the user's present task takes priority over this example.

## Handoff order

Start with this file, `docs/PROJECT_STATE_CANONICAL.md`, `docs/AI_HANDOFF_CURRENT.md`, `docs/ROADMAP.md`, `docs/TESTING.md`, `docs/CONTINUITY.md` and the **evergreen** [continuation prompt](AI_CONTINUATION_PROMPT.md). Inspect the relevant dated acceptance report, live source code, tracking issue, PR and actual GitHub Actions logs before editing. Record source commit, verification run, limits and formal owner-acceptance distinction. Update the current checkpoint and related living documents after genuine changes without piling status paragraphs into the evergreen prompt.

## Documentation audit and visibility

The evergreen continuation prompt was rebuilt to remove outdated P2/P3 assumptions. The handoff, canonical state, roadmap, continuity, testing, milestone matrix, root/source READMEs and Windows checklist now link back to this checkpoint. Their older dated history is retained rather than silently rewritten. GitHub currently reports the repository visibility as **public**; do not assume access is private when planning commercial release, sharing internal details or storing data. Visibility changes require the owner's decision.
