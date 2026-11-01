# Rental Studio 2.0 | Latest working checkpoint

**Audited:** 1 November 2026 (Africa/Johannesburg). This is a short index of the **current** development state, not a replacement for [canonical criteria](PROJECT_STATE_CANONICAL.md), [testing policy](TESTING.md), [dated evidence](P6_B_NATIVE_FLEET_REMOVAL_VERIFIED_2026-11-01.md), or live GitHub. Recheck live branches, PRs, tracking issues and CI on every continuation. Do not treat any dated SHA as an evergreen branch HEAD.

## Current GitHub stack and ownership

- Repository: [`Sonkhe-Shongwe/vehicle-rental-system`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system).
- Latest development branch: `feature/p6-fleet-create-disposable-20261101`.
- [Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), stacked on P5 [Draft PR #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12), stacked on P4 [Draft PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10). All are open and unmerged.
- Stable `main` remains unmodified by this stack. Never merge, rebase destructively, force-push, or modify stable `main` without explicit owner authorization.
- Last source/evidence documentation head audited here: `58a80169c140484b3529ce666784b3e8b77de326`. Later documentation-only commits are not new tested production-feature evidence.

## Product and current implementation

**Name:** Rental Studio. The previously preferred key/calendar/car logo is a **concept**, not a finalized licensed/trademark-checked production brand asset. Qt Quick/QML desktop with navy/emerald/cloud-white design and authoritative C++ rental rules. Continue functional/commercial readiness deliberately; no real customer records, payments, installer, cloud service, or general-purpose production storage is approved.

P5 includes a tested operational Overview, guided fictional rental booking/return and lifecycle workflows, stale quote and cancellation safeguards, an actionable overdue review route, a fixed synthetic-only persistent session with a single-writer guard, and native restart/failed-write evidence. [P5 evidence crosswalk](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md).

P6 has **two implemented and CI-verified increments** in Draft PR #14:
- **P6-A:** Qt Quick Add Car/Motorcycle via typed `FleetWriteService` and post-commit Fleet selection/refresh. [Evidence](P6_A_FLEET_CREATE_NATIVE_VERIFIED_2026-11-01.md).
- **P6-B:** selected available vehicle removal after exact case-sensitive `REMOVE <ID>` confirmation, active-rental refusal, Cancel/Escape/no-write, failed-write rollback, reopened disposable domain and focus restoration. [Evidence](P6_B_NATIVE_FLEET_REMOVAL_VERIFIED_2026-11-01.md).

These fleet mutations work **only on temporary fictional data**, not the opt-in fixed persistent fictional session. That restriction is enforced again in C++, not only UI. Historical **returned-rental references** to a removed vehicle are an unresolved integrity/design concern for future commercial storage; do not silently change policy or claim it production-safe.

## Latest verified CI at source+docs checkpoint

- [Core run 41321845349](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41321845349): **13/13 PASS**.
- [Native Qt Linux GCC and hosted Windows MSVC run 41321845432](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41321845432): **64/64 CTests PASS on each OS**, including P6 removal wide/compact, plus relocated Windows P4 packaged checks under PowerShell 7 and Windows PowerShell 5.1.
- Hosted CI is **not** physical owner PC/Qt Creator validation or owner accessibility/aesthetic signoff. Physical Windows scaling and Narrator remain open.

## Formal progress and next functional boundary

**P4 5/7 formally accepted; P5 0/8; P6 0/9; overall 28/74 accepted and 40.6% evidence-weighted coverage.** Verified implementation and passing automated tests are not equivalent to full milestone acceptance. These numbers are **not percentage of finished software or commercial release readiness**. Recalculate only against [74-criterion matrix](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) when evidence justifies an acceptance change.

Next meaningful P6 work, if the owner asks to continue development: **guarded permanent deletion of an already archived fictional rental** with exact ID confirmation, C++ state checks, canceled/failed write protections, real Qt wide+compact negative and restart tests. Before production approval also resolve whether historical returned-rental references block vehicle removal, and address the P7–P9 storage, release, rights, privacy, Windows packaging and owner acceptance gates. Work on the user's present task takes priority over this example.

## Handoff order

Start with this file, `docs/PROJECT_STATE_CANONICAL.md`, `docs/AI_HANDOFF_CURRENT.md`, `docs/ROADMAP.md`, `docs/TESTING.md`, `docs/CONTINUITY.md` and the **evergreen** [continuation prompt](AI_CONTINUATION_PROMPT.md). Inspect the relevant dated acceptance report, live source code, tracking issue, PR and actual GitHub Actions logs before editing. Record source commit, verification run, limits and formal owner-acceptance distinction. Update the current checkpoint and related living documents after genuine changes without piling status paragraphs into the evergreen prompt.

## Documentation audit and visibility

The evergreen continuation prompt was rebuilt to remove outdated P2/P3 assumptions. The handoff, canonical state, roadmap, continuity, testing, milestone matrix, root/source READMEs and Windows checklist now link back to this checkpoint. Their older dated history is retained rather than silently rewritten. GitHub currently reports the repository visibility as **public**; do not assume access is private when planning commercial release, sharing internal details or storing data. Visibility changes require the owner's decision.
