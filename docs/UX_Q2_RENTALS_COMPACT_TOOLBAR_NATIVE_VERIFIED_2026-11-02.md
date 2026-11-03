# UX-Q2 | Compact Rentals toolbar with distinct filter and lookup rows

**Date:** 2 November 2026. **Exact source compiled and verified:** [`8a7a1ed`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8a7a1ed587b05775d1528868b1db593ce73384d3). **Scope:** ordinary main Rentals workspace in the native Qt Quick Windows desktop app, generated-fictional data only.

## Improvement

- Before: lifecycle filter buttons, search feedback, rental-ID input and submit action competed for space in one cramped horizontal row at the 1280×720 compact size.
- Now: a deliberate **Status** row contains All / Active / Returned / Archived / History choices and an accessible, live **N matching contracts** count, while a separate **Find rental** row holds the existing rental-ID field, submit action and search feedback.
- The old keyboard-accessible IDs and QML object names of all five filter buttons, `rentalLookupField`, `rentalLookupButton` and `rentalLookupFeedback` remain stable; the new rows have `rentalStatusRow` and `rentalLookupRow` markers for actual-application checks. The extra count reflects the authoritative C++ `rentalsModel.count` and updates after lifecycle filtering.
- The C++ rental list and domain model, selection/lookup behavior, actual booking/return/archive/delete confirmation flows, source fixture protections and original QSaveFile storage are unchanged. No SQL Lab changes, writes, customer records, imports or deployment changes.

## Exact-source automated results

| Gate | Run | Final result |
|---|---|---|
| Core C++ regressions | [41517964414](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964414) | **13/13 PASS** |
| Qt 6.8.3 native Linux GCC | [41517964095](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095) | **115/115 PASS** |
| Qt 6.8.3 native hosted Windows MSVC | Same native run | **115/115 PASS** |
| Hosted Windows portable-kit PowerShell 7/5.1 checks | Same native run | **PASS** |
| Real Rentals wide 1500×860 and compact 1280×720 | Existing `rentals-filter-smoke` CTests | **PASS**, extended geometry and dynamic counts; no tests removed or inflated |

The existing native filter tests now require both rows and the lookup controls to be visible, nonoverlapping and inside the window, the rental list to retain usable height, and the live count to change from two to one and zero as a real operator changes lifecycle filters.

**Genuine initial failure preserved:** Initial source [`fb08a33`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fb08a33cd3c46673e137cc385036af932da2262b) passed core C++ 13/13 in [run 41517391007](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517391007), but its native Qt build [run 41517390985](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517390985) failed compilation on both platforms because the new C++ test-scenario local variables `lookupField` and `lookupButton` collided with existing declarations later in the same lambda. Corrected source `8a7a1ed` renamed only those geometry-check variables. The full 115-test suites subsequently passed on both operating systems.

## Product-quality and remaining acceptance boundaries

"Commercial-grade" is the owner's **professional-quality benchmark**, not a requirement to sell or publicly release the software. Next work should continue improving the main Overview/Fleet/Rentals operator experience, accessibility, layout and reliability on protected fictional data.

Hosted CI is **not** physical Windows Qt Creator **6.10.2 MinGW** testing, 100/125/150% OS scaling, Narrator review or owner visual acceptance. The **formal frozen acceptance ledger remains 28/74, weighted 40.6%**, which is not a quality-completion percentage. No PR merges, tags, force pushes, stable `main` edits, production data pathways or release actions were performed.
