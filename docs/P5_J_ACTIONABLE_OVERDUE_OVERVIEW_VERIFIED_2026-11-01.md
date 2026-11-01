# P5-J | Overview to Oldest Overdue Rental: Native Product Workflow
**1 November 2026 | Draft PR #12 | Source commits `0b6e642` + `5493c1c`**

## Concrete visual/product finding

Review of the genuine hosted Windows and Linux screenshot artifacts from the previous source showed a working but static overdue metric on the Rental Studio Overview. Staff would need to click through to Rentals and search the active contracts to identify the urgent return, even though the C++ read service already knows the due-state. The 1280×720 window also left little space below the overview lifecycle panel for any added action, so simply appending a large card would have clipped the existing fictional/demo disclosure.

## What was implemented

- [`0b6e642`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0b6e64277057d8780255d2b2be81b93486cf4c54) adds a C++ `RentalListModel::oldestOverdueRentalId` property and `selectOldestOverdue()` method. It considers the entire authoritative read snapshot, selects an active overdue contract with the earliest expected return date, and uses rental ID as a deterministic tie-break. Selecting from a History filter switches to Active and locates the correct stable rental ID. This is read-only navigation and cannot return, book, archive or rewrite any record. No contact PII was added to QML roles.
- The existing native QML Overview lifecycle section now identifies the oldest overdue contract and offers a keyboard-accessible **Review overdue** action. It opens Rentals, selects the correct C++ contract, scrolls it into view and restores keyboard focus to the rental list. The button is disabled when the C++ snapshot contains no overdue active contract. Returns still require the existing separate explicit confirmation.
- [`5493c1c`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/5493c1c0b393cd2cbf31dfd6381244315afce36e) makes the lifecycle panel compact rather than growing past the 1280×720 bottom edge. Real QQuickWindow tests assert that both the new action and the demo/payment disclosure remain fully on screen in wide and compact views.
- New core tests assert filter-independent oldest overdue selection, no ledger writes during navigation, and no action after the overdue rental is returned. Real native QML keyboard tests navigate from a History-filtered state to the overdue rental and check correct selected ID, Active filter, live count continuity and disabled overdue action after commit.

## Actual exact-source CI `5493c1c0b393cd2cbf31dfd6381244315afce36e`

| Gate | Evidence | Outcome |
|---|---|---|
| Core C++/domain | [41315680089](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41315680089) | **13/13 CTests PASS** |
| Linux GCC Qt Quick 6.8.3 | [41315679868](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41315679868) | **60/60 native CTests PASS**, `rental_studio_p5_overview_wide` and `_compact` PASS |
| Windows Server 2022 MSVC Qt Quick 6.8.3 | Same native run | **60/60 native CTests PASS**, `rental_studio_p5_overview_wide` and `_compact` PASS |
| Relocated Windows package P4 safeguard | Same native run | P4 packaged automation passed under PowerShell 7 and Windows PowerShell 5.1; physical owner Narrator/scale testing remains NOT TESTED |
| Real native screenshots | Same native run, `p2-qtquick-linux-screenshots` and `p2-qtquick-windows-screenshots` | Generated 1280×720 and 1500×860 Overview images were downloaded and visually inspected; oldest-overdue action and disclosure are visible within screen. This is hosted desktop evidence, not owner aesthetics signoff. |

The earlier initial feature source `0b6e642` passed 13/13 core tests but its native attempt was superseded by the compact-layout correction. Do not cite that cancelled attempt as a native pass. Final outcomes above refer only to the exact corrected source. No pre-existing test assertion was removed or weakened.

## Acceptance and continuation

Original P5 eight-criterion crosswalk retains representative automated evidence, now with an extra actionable overdue operator route. This feature does **not** create a ninth formal criterion or clear P5 without owner review. **P5 formally 0/8, P4 formally 5/7, programme 28/74 and 40.6% evidence-weighted acceptance remain unchanged.** Separate physical Windows Qt Creator 6.10.2 MinGW, Microsoft Narrator, real 100/125/150% OS scaling and owner visual acceptance remain OPEN.

Draft [PR #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12) stays stacked on unmerged P4 Draft [PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10). No merges, `main` change, real customer records, payments or general persistent storage. Next: consolidate P4/P5 product review evidence and fix any specifically observed UI defects without repeated PowerShell requests; advance to P6 roadmap scope only with milestone boundaries and preserved safeguards.
