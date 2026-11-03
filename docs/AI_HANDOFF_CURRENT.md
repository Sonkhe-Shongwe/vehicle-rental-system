# Rental Studio 2.0 | Current AI handoff

**Reconciled 3 November 2026.** This is a short orientation, not a second acceptance ledger. First open [Latest checkpoint](LATEST_CHECKPOINT.md), [canonical product state](PROJECT_STATE_CANONICAL.md), [roadmap](ROADMAP.md), [test evidence](TESTING.md), [formal progress](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) and the [timeless continuation prompt](AI_CONTINUATION_PROMPT.md).

## Where to resume

- Repository: `Sonkhe-Shongwe/vehicle-rental-system`. At this audit the newest stacked development branch was `feature/p7-sqlite-sandbox-20261102`; draft PR #17 targets the **P6 development branch**, not `main`. Verify actual live branch heads and PR bases before working.
- Latest verified **compiled** application source: [`087c923`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/087c923fcde13f8a5515c22e53e7883a15b6d5b4). [native Actions 41637857962](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962): Qt 6.8.3, **117/117 CTests on Ubuntu 24.04 GCC and 117/117 on hosted Windows Server 2022 MSVC**, including strengthened Fleet Gallery/Inspector photo-state native tests, with hosted Windows portable PS7/5.1 verification. [UX-Q6 details](UX_Q6_FLEET_MEDIA_STATE_NATIVE_VERIFIED_2026-11-03.md). Previous PHOTO-P1-C `8f1d8cc` is historical source evidence, not the newest build.
- Current formal signoffs: P5 8/8 and P6 9/9 owner accepted for bounded fictional-data functionality. Total **45/74 criteria, weighted 70.6%**, not release readiness.
- PHOTO-P1-C improves the original neutral motorcycle fallback and native evidence. The photographic image-source review [failed with HTTP 429](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379), so the five-model photo approval remains open.
- P1/P2/P4 physical owner Qt Creator/MinGW/OS scaling/Narrator acceptance is open. P7 D2-D8, production data, P8/P9, release and merges remain unauthorized.

## Rules for the next session

Follow the **present user request**. For a coding task, inspect the exact source, choose one bounded unfinished quality problem, make reversible branch-local changes, run/inspect real tests and record the source SHA. For a documentation or design task, work on that task directly without manufacturing a coding milestone. Do not demand repeated PowerShell work for tests supported by CI.

Keep any new verified source result in **LATEST_CHECKPOINT** and **TESTING**; reflect a changed durable product boundary in **PROJECT_STATE_CANONICAL**; reflect next actions in **ROADMAP**; record only relevant history in dated reports. Never copy today’s test totals, PR number, branch or acceptance percentage into **AI_CONTINUATION_PROMPT**. Keep all PRs draft and `main` untouched absent explicit authorization.

## Session exit record

State changes, affected branch/commit/PR, exact OS/toolchain/tests and failures, owner acceptance gates, any justified progress changes, and next recommended product-quality task. Preserve [dated milestone evidence](AUDIT.md) and [historical Git text](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/22fd40375ecc68c464e2bbb6a12e197a35e9a376/docs) rather than appending obsolete “latest” status banners.
