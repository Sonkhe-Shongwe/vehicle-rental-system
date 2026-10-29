# Design Workspace — New Light-First Rental Studio

**Owner direction updated:** 29 October 2026  
**Status:** **Conceptual product direction agreed, exact visuals/technical toolkit not yet approved**  
**Master decisions:** [Product Rebuild Audit](../docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md)  
**Current design brief:** [Light-First Experience Specification](DESIGN_SPEC.md).

## Approved design direction

- Bright, inviting, neatly structured software; **no dark application shell**.
- Three primary workspaces: Overview, Fleet, Rentals.
- **Fleet gallery-first with table alternative**; common search/filter/selection and contextual vehicle drawer.
- Meaningful dynamic Dashboard: actual availability, due/overdue attention, bounded activity and no invented revenue.
- Guided rentals and returns; obvious validation, clear confirmations, subtle purposeful transitions.
- Owner can approve total code/UI replacement, but not silent loss of safeguards, privacy or tests.

**Not approved yet:** final brand name, exact sage/copper palette and typography, photography set, detailed screens, animations, Qt Quick/QML migration, source/persistence rewrite or final visual signoff.

## Required design set before code migration

| Experience | Review states |
|---|---|
| Overview | normal, empty, due/overdue, activity and CTA |
| Fleet Gallery | available/rented, missing images, selection and filters |
| Fleet Table | same exact query/selection/sort, compact operational density |
| Vehicle Drawer | available vs rented actions, correct specifications, close/Escape |
| New Rental | Vehicle → Customer → Review, live quote, validation, No/Cancel |
| Active / History / Return | status changes, return confirmation, archival guard |

Review wide **1500×860**, compact **1280×720**, keyboard accessibility and actual native Windows DPI possibilities. Designs must be coherent across all workspaces—not a beautiful Dashboard followed by unrelated forms.

## Previous research / rejected baselines (retain for learning, not implementation guidance)

- [Original blue/white V1 prototype](prototype.html), [V1 gallery](dashboard.png), [V1 Fleet](fleet.png), [V1 rental form](rentals.png).
- [V2 comparisons](v2/COMPARISON.md) and their **unapproved** A/B/C screenshots: [Atelier](v2/atelier.png), [Nocturne](v2/nocturne.png), [Editorial](v2/editorial.png).
- [Actual Qt Widgets screenshots](qt-spike/VISUAL_REVIEW.md): compiled and tested, **aesthetically rejected by owner**.
- [Archived old spec](archive/DESIGN_SPEC_PRE_RESET_2026-10-29.md) and [old asset strategy](archive/ASSET_STRATEGY_PRE_RESET_2026-10-29.md).

The new work should draw lessons from these earlier explorations, **not inherit their graphite/sidebar, lime hero or table-based shell**.
