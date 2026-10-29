# Current Source + Product Audit — Index and Risk Register

**Updated:** 29 October 2026 · **Status:** NEW product audit governs old source audit.  
**Full authority:** [Master Rebuild Audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md).  
**Preserved initial audit:** [Historical Source Audit](archive/AUDIT_INITIAL_2026-10-29.md).

## Current position

The source branch is a functional C++17/Qt Widgets rental application with independent CTest evidence. **Its visual design has been rejected by its owner.** The next product is a light-first, inviting automotive operations app with Overview/Fleet/Rentals and Fleet gallery+table. Permission to replace all source/UI architecture is granted, subject to functional, privacy and rollback gates.

| Area | Risk | Status / response |
|---|---|---|
| Appearance | Current UI feels generic, static and dark; nine CRUD nav items and unbalanced Dashboard | **Critical product failure; design reset approved**, new high-fidelity whole-system spec required |
| Architecture | One ~2,384-line MainWindow drives many widgets and cross-page state | Replace/pivot to reusable view models and Qt Quick candidate only after Windows proof |
| Core booking and fleet logic | Functional and tested, but interfaces are coupled to old UI | Preserve behavioural parity even if implementation rewritten |
| Storage | Legacy source-relative records; per-file atomic save, not multi-file transactions | Separate backed-up AppData/migration decision; no user data changes without tests |
| Data quality | Missing/weak parse diagnostics, ID reuse risk, double precision for money | Track in architecture and migration acceptance |
| UX | Gallery/table state, drawer, guided checkout, meaningful returns missing | Approved direction; **not implemented** |
| Quality evidence | Old hosted Qt tests pass, real physical Windows not signed off | Keep historic evidence, rebuild new UI acceptance from zero |
| Art | Rights recorded for 3 car images; missing 2 motorcycle images, poor photographic cohesion | Re-review aesthetics and model fit, preserve rights register |
| CI | Owner reports Actions limit / expected 1 Nov; long self-updating screenshot workflows | Local-first, staged independent CI efficiency work; not deployed |
| Delivery | Draft PR #4 visually rejected/unmerged; stable main unchanged | No merge or misleading portfolio claim |

## What the audit does not claim

It does not claim source vulnerabilities have been exploited, that previous hosted builds failed, that QML runs on the owner's kit, that SQLite exists, that an installer is ready, or that the new owner-approved design exists.

See [Roadmap](ROADMAP.md), [Experience Specification](../design/DESIGN_SPEC.md), [Architecture](ARCHITECTURE.md), [Testing](TESTING.md), and [Windows Acceptance](WINDOWS_ACCEPTANCE.md).
