> **P6-E VERIFIED | 1 NOV 2026:** [Three separate native Qt launches](P6_E_THREE_PROCESS_NATIVE_RESTART_VERIFIED_2026-11-01.md) prove isolated fictional Fleet creation, rental archive/delete, vehicle removal and third-launch Overview/Fleet/Rentals reconstruction. Exact implementation `7fe971d`: [Core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41344420812), [Linux 68/68 and Windows 68/68 native](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41344420876) PASS; Windows packaged P4 regression PASS. Fixed first-open Add Car default (8 to intended 4 doors). P5 **8/8 representative automated-covered**, P6 **8 covered / 0 partial / 1 unproven full-parity** in an unratified rubric. **Formally P5 0/8, P6 0/9, overall 28/74 and 40.6% weighted unchanged.** Commercial vehicle retirement, full legacy/QML parity and owner physical QA remain open.

# Rental Studio 2.0 | Latest working checkpoint

**Audited:** 1 November 2026 (Africa/Johannesburg). This is a short index of the **current** development state, not a replacement for [canonical criteria](PROJECT_STATE_CANONICAL.md), [testing policy](TESTING.md), [dated evidence](P6_B_NATIVE_FLEET_REMOVAL_VERIFIED_2026-11-01.md), or live GitHub. Recheck live branches, PRs, tracking issues and CI on every continuation. Do not treat any dated SHA as an evergreen branch HEAD.

## Current GitHub stack and ownership

- Repository: [`Sonkhe-Shongwe/vehicle-rental-system`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system).
- Latest development branch: `feature/p6-fleet-create-disposable-20261101`.
- [Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), stacked on P5 [Draft PR #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12), stacked on P4 [Draft PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10). All are open and unmerged.
- Stable `main` remains unmodified by this stack. Never merge, rebase destructively, force-push, or modify stable `main` without explicit owner authorization.
- Latest exact **tested implementation source**: `7fe971d9397d8f19388696ceb5a7ac8e5ce71845` (P6-E). Subsequent documentation heads are not used as substitute evidence for changed code.

## Product and current implementation

**Name:** Rental Studio. The previously preferred key/calendar/car logo is a **concept**, not a finalized licensed/trademark-checked production brand asset. Qt Quick/QML desktop with navy/emerald/cloud-white design and authoritative C++ rental rules. Continue functional/commercial readiness deliberately; no real customer records, payments, installer, cloud service, or general-purpose production storage is approved.

P5 includes a tested operational Overview, guided fictional rental booking/return and lifecycle workflows, stale quote and cancellation safeguards, an actionable overdue review route, a fixed synthetic-only persistent session with a single-writer guard, and native restart/failed-write evidence. [P5 evidence crosswalk](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md).

P6 has **five implemented and CI-verified increments** in Draft PR #14:
- **P6-A:** Qt Quick Add Car/Motorcycle via typed `FleetWriteService` and post-commit Fleet selection/refresh. [Evidence](P6_A_FLEET_CREATE_NATIVE_VERIFIED_2026-11-01.md).
- **P6-B:** selected available vehicle removal after exact case-sensitive `REMOVE <ID>` confirmation, active-rental refusal, Cancel/Escape/no-write, failed-write rollback, reopened disposable domain and focus restoration. [Evidence](P6_B_NATIVE_FLEET_REMOVAL_VERIFIED_2026-11-01.md).
- **P6-C:** permanent removal of an **already archived** fictional rental using the existing `ArchivedDeleteService`, an exact `DELETE <ID>` phrase, modal cancellation protections, rejected-write rollback, selection/focus and separate-process-style domain reopen checks. Never enabled in the fixed persistent fictional session. [Evidence](P6_C_ARCHIVED_DELETE_NATIVE_VERIFIED_2026-11-01.md).
- **P6-D:** C++ domain rejects removal of vehicles referenced by *any surviving rental*, including returned/archived history; typed rejection and Qt inspector hint, legacy Widgets message and native archive/delete/Fleet removal/reopen checks. [Evidence](P6_D_HISTORICAL_VEHICLE_REFERENCES_VERIFIED_2026-11-01.md).
- **P6-E:** genuine three-launch Qt Quick cross-process Fleet/Rentals/Overview restart at wide+compact sizes; fixed first-open Add Car four-door default. [Evidence](P6_E_THREE_PROCESS_NATIVE_RESTART_VERIFIED_2026-11-01.md).

These P6 Fleet/Rentals destructive mutations work **only on temporary fictional data**, not the opt-in fixed persistent fictional session. That restriction is enforced again in C++, not only UI. Historical **returned-rental references** to a removed vehicle are an unresolved integrity/design concern for future commercial storage; do not silently change policy or claim it production-safe.

## Latest verified CI at P6-E implementation source

- [Core run 41344420812](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41344420812): **13/13 PASS**.
- [Native Qt Linux GCC and hosted Windows MSVC run 41344420876](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41344420876): **68/68 CTests PASS on each OS**, including two real three-process P6-E wide/compact restart scenarios plus prior Fleet/history checks, plus relocated Windows P4 packaged checks under PowerShell 7 and Windows PowerShell 5.1.
- Hosted CI is **not** physical owner PC/Qt Creator validation or owner accessibility/aesthetic signoff. Physical Windows scaling and Narrator remain open.

## Formal progress and next functional boundary

**P4 5/7 formally accepted; P5 0/8; P6 0/9; overall 28/74 accepted and 40.6% evidence-weighted coverage.** Verified implementation and passing automated tests are not equivalent to full milestone acceptance. These numbers are **not percentage of finished software or commercial release readiness**. Recalculate only against [74-criterion matrix](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) when evidence justifies an acceptance change.

Next meaningful P6 work, if the owner asks to continue development: close remaining Fleet/Rentals lifecycle parity with targeted native interaction and restart checks, particularly the **remaining full domain/UI lifecycle parity audit**. The scoped three-process P6 restart is now automated-verified. The fictional-only historical reference safeguard is now verified; commercial vehicle retirement and legal data retention remain separate design decisions. Before production approval explicitly settle referential integrity and address the P7–P9 storage, release, rights, privacy, Windows packaging and owner acceptance gates. Work on the user's present task takes priority over this example.

## Handoff order

Start with this file, `docs/PROJECT_STATE_CANONICAL.md`, `docs/AI_HANDOFF_CURRENT.md`, `docs/ROADMAP.md`, `docs/TESTING.md`, `docs/CONTINUITY.md` and the **evergreen** [continuation prompt](AI_CONTINUATION_PROMPT.md). Inspect the relevant dated acceptance report, live source code, tracking issue, PR and actual GitHub Actions logs before editing. Record source commit, verification run, limits and formal owner-acceptance distinction. Update the current checkpoint and related living documents after genuine changes without piling status paragraphs into the evergreen prompt.

## Documentation audit and visibility

The evergreen continuation prompt was rebuilt to remove outdated P2/P3 assumptions. The handoff, canonical state, roadmap, continuity, testing, milestone matrix, root/source READMEs and Windows checklist now link back to this checkpoint. Their older dated history is retained rather than silently rewritten. GitHub currently reports the repository visibility as **public**; do not assume access is private when planning commercial release, sharing internal details or storing data. Visibility changes require the owner's decision.
