# Rental Studio 2.0 | Editorial Contrast R2 shell native verification

**Date:** 6 November 2026. **Verified executable source:** [`7c9a7f6b2fb2f2a36fd07df7b477f4f2e98e26be`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/7c9a7f6b2fb2f2a36fd07df7b477f4f2e98e26be). **Exact-source CI:** [#42226245697](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42226245697) completed **SUCCESS**. **PR:** [draft #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), branch `feature/p7-sqlite-sandbox-20261102`; protected `main` not modified.

## Scope completed

Implemented owner-approved Editorial Contrast **shared desktop shell only**, without pretending that the full Overview/Fleet/Rentals concepts are reproduced. Sidebar charcoal `#151B1B`, white/cloud application `#F7F8FA`, pale-mint selected navigation, emerald primary New Rental, responsive logo and toggle, deep-green footer decoration, consistent original Canvas glyph strokes and native fallback Segoe UI where installed. Maintained existing main content, independent Qt window controls, accessible/focusable nav/actions and C++ authoritative rental status/booking/return/archive/delete. No licensed Inter binaries, Lucide assets, new reference photos, production SQLite, payments, real data or new modules added.

## Three distinct sources, preserve failures

1. `ef16a0c`, [failed initial CI #42222446402](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42222446402) because `Main.qml` assigned `color` twice. Do not cite as a native pass.
2. `2403a0d`, [native CI #42222747709](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42222747709) succeeded 140/140 on each OS, Windows packaged 8/8 and PS5.1. **But genuine Linux 1280×720 and 1500×860 images exposed brand/header toggle clipping**, a visual defect not caught by the original tests.
3. Final `7c9a7f6`, [native #42226245697](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42226245697), repaired header constraint and text elision; extended real Qt test asserts brand and toggle stay **separate and contained** at both required sizes. No test removed or lowered.

## Verified results

| Native check | Linux GCC Qt 6.8.3 | Hosted Windows MSVC Qt 6.8.3 |
|---|---|---|
| Full CTest suite | **140/140 PASS** | **140/140 PASS** |
| Real shell expanded/collapsed UI and brand/toggle geometry | **PASS** | **PASS** |
| Windows packaged disposable fictional operations | N/A | **8/8 PASS** |
| PowerShell 5.1 packaged verification | N/A | **PASS** |

**Source-exact screenshots:** [Linux artifact #13506053412](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42226245697/artifacts/13506053412), [Windows artifact #13505723045](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42226245697/artifacts/13505723045). Compiled app images reviewed at **1500×860 and 1280×720** in Overview expanded, Fleet gallery, Rentals register and sidebar-collapsed states on both platforms. In final source captures, the brand name is elided rather than colliding with collapse button, sidebar/action/nav are visually contained, and charcoal/white composition remains consistent.

**Caveat:** Hosted Qt screenshot fixtures use the protected **five-vehicle fictional test data**, whereas the owner's normal app can display the separate **131-vehicle portfolio demonstration**. This is intentional and does not indicate data loss. The concept screenshot may show unavailable vehicles as available; application C++ state always wins.

## Visual quality not yet accepted

The new shell improves the appearance but **does not satisfy final R2 reference parity**: Overview still has three KPI cards instead of target four and an earlier hero/metric ordering; Fleet gallery/inspector composition and Rentals dense single-register/evergreen-inspector layout have not been rebuilt; exact licensed vector icon pack and font comparison remain outstanding. Native tests guarantee safeguards, not subjective fidelity. The owner still needs to review actual Windows Qt Creator 6.10.2 MinGW, 100/125/150% scaling where feasible, keyboard/Narrator, final reference-photo accuracy and all three workspaces.

**Next:** licensed icon/font pilot with reproducible offline assets, then source-backed fourth Overview metric and target composition, verify both OS and sizes before Fleet and Rentals. **Formal owner acceptance remains 45/74, weighted 70.6%, P7 0/8; P5/P6 retained.** PR #17 stays draft; no release.

[Approved R2 master](../design/r2/EDITORIAL_CONTRAST_VISUAL_MASTER_2026-11-06.md) | [Live handoff](LIVE_HANDOFF_STATE.md) | [Latest checkpoint](LATEST_CHECKPOINT.md) | [Testing](TESTING.md).
