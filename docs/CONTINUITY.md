# Rental Studio 2.0 | Continuity protocol

**Continuity protocol strengthened 6 November 2026.** This file defines how to resume safely. The source-specific snapshot is [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md); current product decisions are in [PROJECT_STATE_CANONICAL](PROJECT_STATE_CANONICAL.md); no standalone memory or copied prompt outranks GitHub.

## Live discovery at the start of each conversation

1. Inspect the repository and current development branch HEAD; read [checkpoint](LATEST_CHECKPOINT.md), [handoff](AI_HANDOFF_CURRENT.md), [roadmap](ROADMAP.md), [testing](TESTING.md), [acceptance ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) and the relevant code/PR/issue.
2. Inspect all open and draft PR **head/base pairs**. As observed 3 November: draft #17 -> #14 -> #12 -> #10 -> previous staged P3/P2, with `main` separate. Never assume this hierarchy remains unchanged.
3. Distinguish executable source commit from later documentation-only HEAD. Check run status, job logs and any failures; do not attribute a previous run to a new source SHA.
4. Select work based on the **user's present request**. Product-code work must have a narrow acceptance criterion and reversible changes; research/design/doc requests must not trigger unrelated code changes.

## Safe execution and governance

- No unapproved merge, force push, `main` changes, release or automatic customer-data enablement.
- Current fictional-only Qt Quick/C++ authority, data-integrity and privacy boundaries remain binding. The opt-in P7 SQLite Lab is not a production switch.
- Real native Qt CI is useful but is not owner physical Windows Qt Creator/MinGW, OS scaling or Narrator verification.
- P5 8/8 and P6 9/9 are **already owner accepted**. Do not request the same signoff again. Other gates remain open; see the dated [checkpoint](LATEST_CHECKPOINT.md).
- Record failures and blockers, especially the [nine HTTP 429 photography failures](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379), rather than repeating unsuccessful remote requests.

## Mandatory active-session handoff cadence

**Owner requirement (6 November 2026): the handoff must be updated continuously during active development, not merely after major releases.** "Continuously" means at each meaningful state transition, not every keystroke or unobserved clock tick:

1. **Session entry:** inspect the actual GitHub PR/branch HEAD and CI, then reconcile [LIVE_HANDOFF_STATE](LIVE_HANDOFF_STATE.md) before meaningful changes.
2. **Material decision, commit or code/design change:** record the new planned, in-progress or pending-CI state, exact source SHA when known, the effect and the next step. Keep the live handoff brief and update it in the same code commit where feasible or in an immediate documentation commit.
3. **Failure, blocker or changed assumptions:** update the live handoff as soon as known, with failed run and mitigation. Never conceal a failing head behind older green evidence.
4. **Completed CI/visual/owner gate:** update the verified checkpoint and testing evidence with the **exact tested source SHA and run**, and adjust roadmap, canonical decisions and formal acceptance only when necessary. Mark physical Windows/Narrator/photo/design approvals independently.
5. **Before finishing a response or switching tasks:** confirm the handoff states what is done, what is pending, the latest passing executable, current branch head and the precise next action. If any intended documentation push failed, report it.
6. **No unattended activity:** documentation is maintained during active work; without an automation explicitly created and supported, it cannot update itself between chats.

Use a short, replace-in-place live status rather than repeatedly prepending bulky history. Preserve dated reports for audited evidence and the existing stable guide as a reusable prompt. A docs-only SHA is not a new executable verification.

## Documentation roles and non-duplication

| File | Single responsibility |
|---|---|
| [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md) | Latest verified source/run, branch stack, current short blockers |
| [PROJECT_STATE_CANONICAL](PROJECT_STATE_CANONICAL.md) | Durable product/architecture/privacy decisions |
| [ROADMAP](ROADMAP.md) | P0-P9 priorities and acceptance gates |
| [TESTING](TESTING.md) | Actual OS/toolchain/commit/test evidence and limitations |
| [P0-P9 ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | Formal criterion counts, frozen weights and owner signoffs |
| [AI_HANDOFF_CURRENT](AI_HANDOFF_CURRENT.md) | Short cross-tab orientation |
| [LIVE_HANDOFF_STATE](LIVE_HANDOFF_STATE.md) | **Actively updated** current work status: head, tested SHA, CI phase, blockers and next action |
| [AI_CONTINUATION_PROMPT](AI_CONTINUATION_PROMPT.md) | **Timeless** reusable instructions only |
| [AUDIT](AUDIT.md) and dated reports | Navigation and historical traceability |

At each material work-state transition during active development, refresh the live handoff; update the other files only when their responsibilities changed and cross-check their newest facts. **Checkpoint handoff trigger:** before reporting a newly CI-verified milestone complete, confirm that `LATEST_CHECKPOINT.md`, `AI_HANDOFF_CURRENT.md` and any affected `TESTING.md` / `ROADMAP.md` reflect the exact *executable* SHA, job conclusion, owner limitations, next step, and dated evidence link. A newly pushed documentation-only commit must not be mistaken for the source commit that passed tests. Updates happen during active collaborative work, not automatically between conversations. Dated evidence and [the previous full current-doc set at `22fd403`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/22fd40375ecc68c464e2bbb6a12e197a35e9a376/docs) preserve history. Do **not** grow each file with copies of every intermediate checkpoint.

At the end report what changed, precise refs, execution evidence, unverified areas, formal acceptance deltas **only when justified**, and the next practical priority.
