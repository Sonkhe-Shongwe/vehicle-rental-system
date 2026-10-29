# Current Project Handoff — Product Reset

**Checked:** 29 October 2026  
**Canonical decision:** [Master Product Rebuild Audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md)  
**Present stage:** product architecture/design ideation, **not implementation**.

## Current owner decisions

- Existing aesthetic **rejected comprehensively**. Do not continue small fixes to the previous graphite/lime Widget interface.
- Full teardown/refactor is permitted (UI, navigation, data architecture, code and platform presentation), with data integrity, functional parity, tests and rollback required.
- **Inviting light-first** visual system. No dark full-application theme. A muted sage/ivory/copper family is **only a candidate**, not an approved final palette.
- Navigation: **Overview, Fleet, Rentals**. Fleet must have gallery-first + equally capable table alternate, shared state and contextual vehicle drawer. Rental UX guided and validated.
- **Discuss, research and approve cohesive designs before major coding.** Need high-fidelity Overview, Fleet Gallery, Fleet Table, Drawer, New Rental/Review and Active/Return/History states at compact and wide desktop.
- Qt Quick/QML + existing/reworked C++ domain is **leading candidate requiring real Windows Qt Creator proof**. Qt Widgets remains existing working reference.
- Local-first developer loop; hosted CI an independent final gate, not required for every small edit.

## Ground truth

- **Last Qt Widgets reference code:** d1704ec3174b765e3dc82ff03a5531f09e8b507e. The most recently tested actual application code + photo commit: be184b6e1b5336c070fac412519d3c4c432adc2b.
- **Old Linux and Windows cross-platform verification:** PASS CTest 2/2 in [Linux 40944222722](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222722) and [Windows 40944222486](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222486); 10 Linux and 20 Windows offscreen captures. This **does not** certify the new UI design or real monitor DPI.
- **PR:** [Draft #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4) remains visually rejected, open, unmerged; **main** 64aac966631b262c8ced123f932496518ec9872e unchanged.
- **Doc reset branch:** docs/product-rebuild-reset-20261029, deliberately **no PR** to avoid unnecessary Actions triggers; contains decisions/docs only.
- **CI optimisation branch:** docs/ci-budget-development-strategy-20261029, includes staged workflow improvements and local Windows helper; **not integrated/CI-verified**. Owner reports Actions allowance expected reset 1 November; account-specific cause unverified.
- The prior “75% complete” estimate applied to rejected Qt milestone. **Not valid as new product completion.**

## Current technical constraints and risks

Old MainWindow ~2,384 lines, nine stacked views, global shared table and Qt stylesheet; default vehicles.txt/rentals.txt adjacent to source; QSaveFile atomic single-file saves but no transactional multi-file database. Existing domain provides Add/Search/Rent/Return/Archive/Delete, same-day 1–365 days, fake fixtures and disposable CTests. No API, payments, booking calendar, SQLite or final installer.

Photo permissions recorded in assets/README.md, but **visual suitability not approved**, motorcycle images absent. Keep fake demo customer data in all testing; do not expose original runtime customer files.

## Immediate next work, in order

1. Review coherent **light-first multi-screen design** and complete interaction specifications; get explicit aesthetic approval of the *whole* system.
2. Run small **QML + C++ binding feasibility** proof in user's real Windows Qt Creator kit, including keyboard, resizing and genuine UI.
3. Rebuild in bounded batches: shell/components → Fleet/Overview → complete rental lifecycle → data hardening if approved.
4. Verify local tests and exact-commit Linux/Windows independent CI when available; genuine physical Windows 100/125/150% and final owner approval before any merge/release.

## Documentation ownership

[Product audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md) = governing decisions. [Roadmap](ROADMAP.md) = future gates. [Architecture](ARCHITECTURE.md) = current/target separation. [Design spec](../design/DESIGN_SPEC.md) = experience acceptance. [Testing](TESTING.md) and [Windows acceptance](WINDOWS_ACCEPTANCE.md) = verification policy. [History](archive/README.md) = prior full logs/old UI. [Current continuity](CONTINUITY.md) = dated new decisions, not copied CI transcripts.

**Never claim new Qt Quick code or approved visuals exist when only the legacy Qt Widgets implementation exists.**
