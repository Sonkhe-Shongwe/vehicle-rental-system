# Rental Studio 2.0 | Live work handoff

**Reconciled:** 6 November 2026 after completed exact-source Fleet attribution native verification and Windows/Linux screenshot review.

## Exact state

- **Repository / branch:** `Sonkhe-Shongwe/vehicle-rental-system`, active `feature/p7-sqlite-sandbox-20261102`, draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), base `feature/p6-fleet-create-disposable-20261101`; `main` untouched.
- **Latest passing verified executable source:** `db005e21e426a19932ff1afc708b7ba2c0239b46`, [SUCCESS #42199989157](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42199989157): **140/140 native Qt CTests each Linux and Windows**, packaged Windows fictional **8/8**, PowerShell 5.1 PASS. Actual **1500×860 and 1280×720** Qt screenshots inspected on both platforms; the previous green source `b3625f5` had a screenshot-detected overlapping photo credit, corrected in this source. [Dated report](DIRECTION_A_FLEET_EXACT_PHOTO_ATTRIBUTION_NATIVE_VERIFIED_2026-11-06.md).
- **Current activity:** `FLEET EXACT-IMAGE OFFLINE PHOTO ATTRIBUTION / VERIFIED`. The C++ FleetPhotoStore and existing Inspector/Full View now disclose the chosen reference's author, licence and Commons source, using locally bundled manifest data. Fictional custom images report **unverified** and silhouettes do not claim a photo licence. Native CTests now reject an inspector credit overlapping the Reference label or View full. No new photograph, domain logic, record storage, P7 policy or screen added. This handoff updates Git docs but does **not** recompile source. Draft PR #17/main protected.
- **Next authorized development work:** physical owner Windows **Qt Creator 6.10.2 MinGW** Build/Run of all three Direction A workspaces, 1500×860 and 1280×720 viewport, 100/125/150% display scaling where supported, keyboard and Narrator, Gallery/Inspector/full-photo image credit readability and final premium visual acceptance. Record exact findings, then fix only reproducible issues. No new photo acquisition, real-data P7, merge, release or acceptance-score promotion without authorization.
- **Open owner boundaries:** Qt Creator 6.10.2 MinGW physical Windows device, 100/125/150% scaling where supported, Narrator, final photographs/branding and premium-design acceptance. Experimental P7 SQLite remains opt-in fictional-only.
- **Formal owner acceptance:** **45/74 criteria, fixed 70.6%, P7 0/8**; unchanged. P5/P6 previous signoffs are already accepted. No PR merge/release/production-data activation.

## Required update cycle

For each meaningful step during active coding/design/review: write a fresh **Current activity** status and exact HEAD, record in-progress or failed CI immediately, and record the next action. On a completed exact-source verification, reconcile [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md) and [TESTING](TESTING.md). Update [AI_HANDOFF_CURRENT](AI_HANDOFF_CURRENT.md) for changed cross-chat context, [ROADMAP](ROADMAP.md) when priorities change, and [P0-P9 criterion ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) only on actual justified acceptance.

**New-chat entry:** inspect this file, then [AI_HANDOFF_CURRENT](AI_HANDOFF_CURRENT.md), [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md), [CONTINUITY](CONTINUITY.md), [ROADMAP](ROADMAP.md), [TESTING](TESTING.md), the design contract and the live PR. If GitHub has moved since this file, reconcile **before** trusting its snapshot.

**Reusable copy-ready prompt:** [AI_CONTINUATION_PROMPT](AI_CONTINUATION_PROMPT.md). **Detailed current design evidence:** [Direction A handoff](DIRECTION_A_OVERVIEW_FLEET_HANDOFF_AND_NATIVE_VERIFICATION_2026-11-06.md).
