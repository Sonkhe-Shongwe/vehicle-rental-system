# Windows Desktop Acceptance — New Light-First Rebuild

**New acceptance protocol:** 29 October 2026  
**Reference:** [Product Rebuild Audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md)  
**Status:** **NOT STARTED FOR REPLACEMENT UI**. Older completed hosted Windows runs and manual procedures are preserved in [Windows Legacy Archive](archive/WINDOWS_ACCEPTANCE_QT_WIDGETS_2026-10-29.md).

## Safety before anything

1. Use the owner's Windows PC with a compatible installed Qt Creator kit; record exact Qt and compiler details. Qt Quick/QML modules must be installed and detected if we choose that toolkit.
2. Export/clone **tracked source** to a brand-new disposable folder; seed demo/vehicles.txt and demo/rentals.txt only. The old runtime stores source-adjacent data; **never launch in a folder containing actual customer records**.
3. Confirm the exact local Git ref/SHA, output directory and original fixture checksums before destructive test operations.
4. Keep GitHub Actions separate; local acceptance must work even when hosted runs are unavailable. The optional isolated Windows helper is staged at [optimisation branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/docs/ci-budget-development-strategy-20261029), **not yet verified by successful Windows execution**.

## A. Feasibility check — before replacing the entire UI

- [ ] Real Qt Quick/QML Hello + genuine C++ model binding builds using the installed Windows Qt kit.
- [ ] Prototype opens Overview, Fleet Gallery, Fleet Table and selected drawer with **real fictional domain data**, no hardcoded unavailable badges.
- [ ] Gallery↔Table switch preserves query/filter/selection, correct vehicle ID and status.
- [ ] No serious rendering/driver/layout regressions at 1280×720 and 1500×860.
- [ ] Keyboard focus, Escape drawer closing, hover/press/disabled and scroll behave.
- [ ] Logs, environment, performance notes and screenshots recorded. No claim of full parity yet.

If this fails, **stop and reconsider toolkit choice** rather than rewriting rental persistence simultaneously.

## B. Native OS display and interaction (real hardware)

For each **Windows Settings → System → Display → Scale** of **100%, 125%, 150%** (where supported and safe to switch; restart application as needed):

- [ ] Overview content visible and meaningful; cards, due-return attention, activity.
- [ ] Fleet Gallery shows correct number of columns or scroll; cards and status readable.
- [ ] Fleet Table columns and sorting/filtering work with keyboard.
- [ ] Vehicle details drawer fits, traps/restores focus appropriately and closes with Escape.
- [ ] New Rental Vehicle → Customer → Review: quote and validation remain visible.
- [ ] Active/History/Return workflow, modals, toasts, confirmation and error states are accessible.
- [ ] Drag-resize both ways; no hidden essential controls, horizontal clipping or overlapping text.
- [ ] Tab / Shift+Tab / Enter / Escape and screen-reader-accessible names are meaningful.
- [ ] Reduced motion if supported; motion does not delay business action.

**Qt synthetic QT_SCALE_FACTOR screenshot is not proof of physical OS monitor scaling.** Record real results with OS scale, machine and source SHA.

## C. Functional and data-safety smoke in disposable folder

- [ ] Add car, add motorcycle, reject duplicate ID, search/filter.
- [ ] Create an available rental, verify price/days, refuse duplicate booking.
- [ ] Restart and verify active contract and vehicle occupancy.
- [ ] Decline/cancel create/return/archive/delete and confirm **no storage mutation**.
- [ ] Return active rental, reject repeated return, archive returned record and delete archived record only.
- [ ] Deliberately test invalid input and safe error display; never edit real customer files.
- [ ] Check imagery copyrights, vehicle mismatch disclosures and owner aesthetic review.

## D. Evidence and approval

Save screenshot/log and a structured record for each native scale, including Qt version, compiler, Windows version, window size, pass/fail, defects and photo source. Correct defects and repeat failed checks.

**Cannot mark APPROVED until owner expressly confirms:** real UI is beautiful, inviting and coherent across workspaces; no dark software shell, complete parity, data protection, local functional tests and independent CI on final SHA. Any missing Actions tests remain **BLOCKED**, not waived.

**Historical note:** the previous Qt Widgets app passed two CTests and 20 offscreen Windows screenshots in run [40944222486](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222486); its aesthetics are **owner-rejected** and do not grant signoff here.
