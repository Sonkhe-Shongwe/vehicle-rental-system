# Rental Studio 2.0 | Live work handoff

**Reconciled:** 6 November 2026, within the current active ChatGPT development session. This file is the first-stop, replace-in-place resume pointer. It is updated **during active collaborative work at each material state transition**, not automatically between chats.

## Exact state

- **Repository:** `Sonkhe-Shongwe/vehicle-rental-system`; current draft development PR [#17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17).
- **Current development branch:** `feature/p7-sqlite-sandbox-20261102`, based on `feature/p6-fleet-create-disposable-20261101`. Confirm current actual HEAD from GitHub before coding; the documentation-only checkpoint preceding this policy update is `cd6cd548a3454d4655ca9e0851080482d37f7bb9`.
- **Last verified executable source (not docs HEAD):** `7a7d6adfbf5c9763ddb6d835e1e8958cbfbc2a11` [exact-source successful CI #42178840695](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42178840695).
- **Tests/evidence:** Qt 6.8.3 native CTest **140/140 Linux GCC** and **140/140 Windows MSVC**, packaged fictional Windows **8/8**, PowerShell 5.1 PASS; CI contains native 1500x860 / 1280x720 screenshot artifacts.
- **Current activity:** `VERIFIED DESIGN IMPLEMENTATION` for Editorial Automotive Light **Overview and Fleet**; `DOCUMENTATION GOVERNANCE UPDATED` for this live handoff/continuation contract. No new executable source or rerun is implied by documentation edits.
- **Next authorized implementation focus:** Direction A **Rentals** composition, with dense contract-first register, compact status filtering and contextual actions, preserving C++ booking/return/archive, accessible navigation and protected fixtures. Then improve Fleet selection inspector composition and reference-photo consistency.
- **Unverified/owner gates:** Physical owner's Qt Creator 6.10.2 MinGW on Windows, 100/125/150% DPI as available, Narrator, photographic identity/licences and final visual acceptance. Owner's approval of a design direction is not final per-screen or product approval.
- **Formal owner acceptance:** **45/74 criteria, fixed weighted 70.6%, P7 experimental 0/8**, unchanged. Draft PR #17 is unmerged; `main` untouched.
- **No unapproved changes:** no merge/force-push/release, no real customer data or commercial SQLite activation, no invented workspace, payment or revenue claims.

## Required update cycle

For each meaningful step during active coding/design/review: write a fresh **Current activity** status and exact HEAD, record in-progress or failed CI immediately, and record the next action. On a completed exact-source verification, reconcile [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md) and [TESTING](TESTING.md). Update [AI_HANDOFF_CURRENT](AI_HANDOFF_CURRENT.md) for changed cross-chat context, [ROADMAP](ROADMAP.md) when priorities change, and [P0-P9 criterion ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) only on actual justified acceptance.

**New-chat entry:** inspect this file, then [AI_HANDOFF_CURRENT](AI_HANDOFF_CURRENT.md), [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md), [CONTINUITY](CONTINUITY.md), [ROADMAP](ROADMAP.md), [TESTING](TESTING.md), the design contract and the live PR. If GitHub has moved since this file, reconcile **before** trusting its snapshot.

**Reusable copy-ready prompt:** [AI_CONTINUATION_PROMPT](AI_CONTINUATION_PROMPT.md). **Detailed current design evidence:** [Direction A handoff](DIRECTION_A_OVERVIEW_FLEET_HANDOFF_AND_NATIVE_VERIFICATION_2026-11-06.md).
