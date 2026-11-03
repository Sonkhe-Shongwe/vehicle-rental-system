# Rental Studio 2.0 | Continuity protocol

**Reconciled 3 November 2026.** This file defines how to resume safely. The source-specific snapshot is [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md); current product decisions are in [PROJECT_STATE_CANONICAL](PROJECT_STATE_CANONICAL.md); no standalone memory or copied prompt outranks GitHub.

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

## Documentation roles and non-duplication

| File | Single responsibility |
|---|---|
| [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md) | Latest verified source/run, branch stack, current short blockers |
| [PROJECT_STATE_CANONICAL](PROJECT_STATE_CANONICAL.md) | Durable product/architecture/privacy decisions |
| [ROADMAP](ROADMAP.md) | P0-P9 priorities and acceptance gates |
| [TESTING](TESTING.md) | Actual OS/toolchain/commit/test evidence and limitations |
| [P0-P9 ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | Formal criterion counts, frozen weights and owner signoffs |
| [AI_HANDOFF_CURRENT](AI_HANDOFF_CURRENT.md) | Short cross-tab orientation |
| [AI_CONTINUATION_PROMPT](AI_CONTINUATION_PROMPT.md) | **Timeless** reusable instructions only |
| [AUDIT](AUDIT.md) and dated reports | Navigation and historical traceability |

After meaningful changes, update only the files whose responsibilities changed and cross-check that their newest facts agree. Dated evidence and [the previous full current-doc set at `22fd403`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/22fd40375ecc68c464e2bbb6a12e197a35e9a376/docs) preserve history. Do **not** grow each file with copies of every intermediate checkpoint.

At the end report what changed, precise refs, execution evidence, unverified areas, formal acceptance deltas **only when justified**, and the next practical priority.
