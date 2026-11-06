# Rental Studio 2.0 | Direction A Rentals redesign verified | 6 November 2026

## Verified executable and protected scope

- Executable source: [`e215c4cddf2ecb152c7aedcbaa754fad6bd774e8`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/e215c4cddf2ecb152c7aedcbaa754fad6bd774e8).
- Exact-source GitHub Actions [run #42191631534](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42191631534): **SUCCESS**. Native Qt 6.8.3 CTest **140/140 Linux GCC** and **140/140 Windows MSVC**, with **zero failures**; packaged Windows fictional functional journey **8/8 PASS** and Windows PowerShell 5.1 **PASS**.
- Both runners produced real Qt Quick screenshot artifacts, including Rentals controls at 1500×860 and 1280×720 and the archived selected-contract state at 1280×720. Native screenshots on both platforms inspected: the **Delete archived** button is fully visible within the compact viewport with a selected archived rental. No photoreal design render was substituted for the executable.
- Branch: `feature/p7-sqlite-sandbox-20261102`, draft PR #17, base `feature/p6-fleet-create-disposable-20261101`, `main` unmodified. No merge, release, real customer import or commercial SQLite activation.

## Implemented Direction A Rentals composition

- Three factual, C++-bound read-only indicators: Active Contracts, Overdue Returns, Returned/Archived. Derived due states remain distinct from stored lifecycle statuses.
- Contract-first register with status/history/due-timing filters, ID lookup, visible record count, due-state labels and booked values (not payment revenue).
- Selected-contract inspector beside the register/filter column, displaying actual source C++ contract ID, status, model name when available, due date and booked value, with existing review/return/archive/delete controls and return lookup.
- Verified existing C++ lifecycle and confirmation/rollback logic retained; protected five-record vehicle fixture and rental records remain synthetic-only. New Rental and existing Qt dialog/keyboard routes remain.

## Failed intermediate tests and repair

1. Initial Rentals visual source [`a9e2810`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a9e281082f8b011e26a382022519c677a2fd65ee), run [#42185714955](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42185714955): four native test failures out of 140 on each OS. These were archived-delete viewport clipping at both sizes and feedback visibility for return lookup at both sizes.
2. Follow-up [`6267124`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6267124f097d284154d2c61dcd2e3fccb903e32c), run [#42186984140](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42186984140): **139/140 passed per OS**; only `rental_studio_p6_archived_delete_compact` still failed because the Delete Archived action was at scene position approximately y=713 in a 720-px-high window.
3. Final [`e215c4c`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/e215c4cddf2ecb152c7aedcbaa754fad6bd774e8), run [#42191631534](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42191631534): solved by removing the full-height stretch from the selected-contract inspector and assigning its preferred height from the intrinsic content. The inspector remains top-aligned, all contractual actions remain visible, and the complete 140-test suite passes per OS. No tests were weakened or disabled.

## Honest remaining boundaries

- Direction A Rentals **engineering-verified**, not owner design-signoff or pixel-identical Penpot implementation. The screen still has a compact but dense controls/filters section, and the selected-contract inspector can benefit from final spacing/visual polish. No new features are approved by this verification.
- Windows physical Qt Creator 6.10.2 MinGW, 100/125/150% scaling, Narrator and owner visual approval remain open.
- Photo identity, licence/provenance and final premium visual quality for Fleet remain open. Selected layout direction A is not blanket owner approval of all layouts.
- Formal acceptance ledger unchanged: **45/74 criteria, fixed-weight 70.6%, P7 0/8**. The 140 native tests are engineering evidence, not 140 acceptance criteria.
- **Next authorized priority:** Fleet selected-inspector composition and photo consistency, followed by owner physical visual review of all three Direction A workspaces. Keep all native data, focus/keyboard and modal confirmation tests intact.

**Resume:** read [LIVE_HANDOFF_STATE](LIVE_HANDOFF_STATE.md), [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md), [TESTING](TESTING.md) and live PR/CI before changing source.
