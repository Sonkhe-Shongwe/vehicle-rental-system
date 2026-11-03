# Rental Studio 2.0 | Current AI handoff

**Current photo review route:** [PHOTO-P1-E source `f768514`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f76851460600b8379a160e1643265ca4032c0d57), [offline CI run 41647940737](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41647940737): 12/12 local-only synthetic tests **each** Linux and hosted Windows, no media downloads, no Qt asset writes, no rights approval. Start with the [Hyundai i20 local-original preflight guide](../design/photo_review/OFFLINE_REVIEW_README.md) and [PHOTO-P1-E verification](PHOTO_P1_E_OFFLINE_CANDIDATE_PREFLIGHT_VERIFIED_2026-11-03.md) when lawful original file bytes are available. Keep [Qt source `2995ddc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2995ddcef5e89cba7ffd7600e6aee45354be59eb) as last native-compiled source; Python-only `f768514` is not a new Qt test. Formal owner signoffs unchanged.

**P1-D screenshot follow-up:** [Current native photo review addendum](PHOTO_P1_D_FIVE_MODEL_NATIVE_BASELINE_2026-11-03.md) records independently seen Qt examples: Hyundai multi-car ambiguity, Ranger showroom clutter, Corolla background clutter and identical neutral motorcycle art. All five existing media states and controls passed native tests on both hosted OS. Do not treat visual review as owner asset approval or physical Windows certification. Future sessions should begin from this source-evidence shortlist instead of repeating blocked image retrieval.

**Reconciled 3 November 2026.** This is a short orientation, not a second acceptance ledger. First open [Latest checkpoint](LATEST_CHECKPOINT.md), [canonical product state](PROJECT_STATE_CANONICAL.md), [roadmap](ROADMAP.md), [test evidence](TESTING.md), [formal progress](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) and the [timeless continuation prompt](AI_CONTINUATION_PROMPT.md).

## Where to resume

- Repository: `Sonkhe-Shongwe/vehicle-rental-system`. At this audit the newest stacked development branch was `feature/p7-sqlite-sandbox-20261102`; draft PR #17 targets the **P6 development branch**, not `main`. Verify actual live branch heads and PR bases before working.
- Latest verified **compiled** application source: [source `2995ddc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2995ddcef5e89cba7ffd7600e6aee45354be59eb), [native Actions 41641573481](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481): **117/117 native Qt CTests PASS each** on Ubuntu 24.04 GCC and hosted Windows Server 2022 MSVC, Qt 6.8.3, including the complete five-ID Fleet photo reference/fallback evidence at both window sizes and Windows portable PS7/5.1. [PHOTO-P1-D evidence](PHOTO_P1_D_FIVE_MODEL_NATIVE_BASELINE_2026-11-03.md). Earlier source `087c923` remains historical; latest branch documentation-only commits were not freshly compiled.
- Current formal signoffs: P5 8/8 and P6 9/9 owner accepted for bounded fictional-data functionality. Total **45/74 criteria, weighted 70.6%**, not release readiness.
- PHOTO-P1-C improves the original neutral motorcycle fallback and native evidence. The photographic image-source review [failed with HTTP 429](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379), so the five-model photo approval remains open.
- P1/P2/P4 physical owner Qt Creator/MinGW/OS scaling/Narrator acceptance is open. P7 D2-D8, production data, P8/P9, release and merges remain unauthorized.

## Rules for the next session

Follow the **present user request**. For a coding task, inspect the exact source, choose one bounded unfinished quality problem, make reversible branch-local changes, run/inspect real tests and record the source SHA. For a documentation or design task, work on that task directly without manufacturing a coding milestone. Do not demand repeated PowerShell work for tests supported by CI.

Keep any new verified source result in **LATEST_CHECKPOINT** and **TESTING**; reflect a changed durable product boundary in **PROJECT_STATE_CANONICAL**; reflect next actions in **ROADMAP**; record only relevant history in dated reports. Never copy today’s test totals, PR number, branch or acceptance percentage into **AI_CONTINUATION_PROMPT**. Keep all PRs draft and `main` untouched absent explicit authorization.

## Session exit record

State changes, affected branch/commit/PR, exact OS/toolchain/tests and failures, owner acceptance gates, any justified progress changes, and next recommended product-quality task. Preserve [dated milestone evidence](AUDIT.md) and [historical Git text](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/22fd40375ecc68c464e2bbb6a12e197a35e9a376/docs) rather than appending obsolete “latest” status banners.
