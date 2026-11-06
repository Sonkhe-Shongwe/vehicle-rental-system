# Rental Studio 2.0 | Direction A Overview and Fleet | 6 November 2026

## Exact current source and verified state

- **Latest executable source:** [`7a7d6adfbf5c9763ddb6d835e1e8958cbfbc2a11`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/7a7d6adfbf5c9763ddb6d835e1e8958cbfbc2a11), head of `feature/p7-sqlite-sandbox-20261102` at documentation preparation.
- **Latest successful native run:** [GitHub Actions #42178840695](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42178840695), exact SHA above, completed **success**.
- **Qt 6.8.3 CTests:** **140/140 passed on Linux GCC**, **140/140 passed on Windows MSVC**. Windows packaged fictional functional checks **8/8 PASS**; Windows PowerShell 5.1 verification **PASS**.
- **Previous exact-source evidence:** Overview refinement [`c247517`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c247517dd8e8d5d5403f6aa2730e97901991cc72) with [run #42157184007](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42157184007); first Fleet/name improvement [`a3ee614`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a3ee6142118a1485f271126e38205ab64dbfad9d) with [run #42177489316](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42177489316). Both passed 140/140 native Qt tests per OS. The earlier Overview regression repair [`e7d20f5`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/e7d20f5a0863383834812f4bdf188e2c92959a36) passed [run #42155933311](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42155933311). An intermediate run [#42114370312](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42114370312) failed 9 legacy tests on both OS; subsequent explicit Fleet workspace entry and updated expected heading fixed it without disabling native coverage.
- **Formal acceptance remains unchanged:** 45/74 criteria, fixed-weight 70.6%; experimental P7 SQLite 0/8. CI success does not count as physical owner approval.

## What actually changed

**Direction A selected.** Owner chose Editorial Automotive Light. [Direction contract](../design/r1/DIRECTION_A_EDITORIAL_LIGHT_SELECTION_AND_IMPLEMENTATION_CONTRACT_2026-11-05.md) and [design tokens](../design/r1/DIRECTION_A_EDITORIAL_LIGHT_PENPOT_TOKENS_2026-11-05.json) are source-controlled, but companion Penpot-ready SVG/PNG reference kit is not a native interactive Penpot file and has not been owner-approved pixel-by-pixel.

**Overview implemented in real Qt Quick:**
1. Now the default landing workspace (`workspace=0`) with an operational hero. It identifies the oldest overdue active rental only when the authoritative typed C++ snapshot supports that fact; unavailable data has an explicit fail-closed message.
2. Fleet readiness adjacent to the hero, truthful active contract booked value (not paid revenue), compact KPI strip, most recent contracts and source-backed available vehicle previews.
3. Hero navigation still reaches existing Rentals/Fleet workflows with keyboard routing. No unapproved payment, customer, GPS or new business workflow was introduced.
4. Recent-contract rows show true vehicle make/model names through the unfiltered C++ `FleetController.vehicleNames` property; the fallback is the vehicle ID when its name is no longer in the fleet. Real native Overview checks compare the rendered name against source C++ values.

**Fleet refinements implemented:**
1. Clearer `Vehicle collection` header, two live availability state indicators on wide screens, tighter toolbar and no empty message row.
2. Real Gallery/Table switch, search, status, sort, C++ selection, read-only inspector, photo/source disclosures and management action remain.
3. A new editorial heading `Your fleet, beautifully organised.` and more compact 272-px gallery cell / 257-px card / 154-px image region allow the five-vehicle protected fictional demo to fit better in two gallery rows at 1500x860 while preserving the two-column 1280x720 view and existing navigation.
4. No permanent portfolio count or customer dataset is inferred from the five-record protected test fixture. The normal fiction-only showcase separately has 131 vehicles and 70 distinct model families; 48 new provisional reference-image associations remain subject to final photo quality and rights/owner review.

## Real visual evidence

Run #42178840695 contains the real native Qt screenshot artifacts `p2-qtquick-linux-screenshots` and `p2-qtquick-windows-screenshots` for the exact source SHA, including `pa-overview-002-1500x860.png`, `pa-overview-002-1280x720.png`, `pa-fleet-003-gallery-1500x860.png` and `pa-fleet-003-gallery-1280x720.png`. Windows disposable physical-acceptance kit is available in that run as an artifact. Screenshots were inspected for the major desktop composition and clipping; screenshot inspection is not formal owner acceptance or proof of every physical DPI/Narrator state.

## Unfinished gates and next work

- **Rentals Direction A redesign is next:** move contract register forward, compact filters, contextual actions while retaining actual booking, return, archive, delete/review confirmation, protected fixture and keyboard flows. Implement in reversible slices and compare real Qt screenshots at 1500x860 and 1280x720.
- **Fleet inspector and media quality still need refinement:** improve inspector-to-gallery visual integration and consistency/identity/provenance of reference images; do not misrepresent illustrative photos as actual stock vehicles.
- **Physical owner acceptance remains open:** real Windows Qt Creator 6.10.2 MinGW on owner's machine, 100/125/150% Windows scaling where available, keyboard focus traversal, Narrator, meaningful visual quality and actual image approval. Do not infer signoff from hosted CI.
- **PR stack safety:** PR [#17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) remains DRAFT based on `feature/p6-fleet-create-disposable-20261101`; `main` protected/unmodified. P7 SQLite is fictional-only opt-in, not activated for commercial data.
- **No fake completion:** 140 test results are native engineering checks, not the 74-criterion owner acceptance ledger. Keep that ledger unchanged until independently justified and owner-approved.

## Resume workflow and handoff-maintenance rule

Read [`LATEST_CHECKPOINT.md`](LATEST_CHECKPOINT.md), [`AI_HANDOFF_CURRENT.md`](AI_HANDOFF_CURRENT.md), [`CONTINUITY.md`](CONTINUITY.md), [`ROADMAP.md`](ROADMAP.md), [`TESTING.md`](TESTING.md), then inspect *live* PR/head/CI/code. Historical docs may describe earlier executables; do not read older "latest" paragraphs as current facts.

After every meaningful, **verified** development increment, update the short live handoff/checkpoint, update `TESTING.md` for new evidence and `ROADMAP.md` only for changed priorities, and link to one detailed dated milestone report. Use exact source SHA, actual CI conclusion, explicit outstanding owner gates, and next task. A new docs-only SHA never retroactively becomes the executable SHA whose tests passed. Updates occur during active development work, not automatically in the background.
