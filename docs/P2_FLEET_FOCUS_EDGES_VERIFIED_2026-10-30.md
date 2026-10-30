# P2 Fleet Focus and Filtering Consistency: Verified Native Regression

**30 October 2026 | Status:** SOURCE AND HOSTED CI VERIFIED, owner physical Qt 6.10.2 MinGW latest-build review still PENDING. **Authoritative separate decision:** [UX-CTRL-001 owner-approved control contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md). No whole-P2 go/no-go or product release.

## Problem grounded in the actual Qt Quick source

The P2 Fleet application showed two subtle inconsistencies despite the earlier [9/9 Linux and Windows baseline](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41059423971):

1. A selected vehicle could remain visible in the **Inspector** after search/status filtering removed it from the vehicle list. This violated the approved rule that current visible selection and Inspector must agree.
2. After a sort/filter operation, the `GridView` or `ListView.currentIndex` could point at a different proxy row from the selected authoritative C++ vehicle ID, leaving keyboard focus out of sync.
3. At horizontal/vertical boundaries, pressing an arrow with no valid neighbor unnecessarily called `positionViewAtIndex`, potentially disturbing Gallery scroll even though selection did not change.

## Narrow source correction

- [Source fix `3b33d888eb736e0b43c1b5c909d6bdf6cc457aea`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3b33d888eb736e0b43c1b5c909d6bdf6cc457aea): C++ `clearHiddenSelection()` reconciles search/status filtering, QML `syncCurrentVehicle()` synchronizes both collection current indices with selected C++ visible proxy row after selection/query/status/sort signals, and `navigateVehicles` skips scrolling at an unchanged boundary. Adds real `--focus-edges-smoke` executable mode and CTest `rental_studio_p2_focus_edges`.
- The first [CI run 41064963032](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41064963032) **FAILED (9/10 CTests, both platforms)** because the historic `rental_studio_p2_model` self-test still asserted that a **filtered-out** Honda ID should remain selected. The new actual focus-edge test and all other tests passed. **This was a real test expectation conflict and not silently waived.**
- [Test assertion correction `0f5668d8ef359d84aa0901c0b5ccdb3ff8cb27df`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0f5668d8ef359d84aa0901c0b5ccdb3ff8cb27df): update historical model CTest to assert selection *clears* when filter hides selected Honda, then deliberately reselect a visible Honda after resetting filter and ensure C++ identity is valid. All ten tests retained, none skipped.

## Exact passing verification

[GitHub Actions run 41065470256](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41065470256), **tested exact source SHA `0f5668d8ef359d84aa0901c0b5ccdb3ff8cb27df`**:

| Platform | Qt kit | Result |
|---|---|---|
| Ubuntu/GCC hosted Linux | Qt 6.8.3 | **10/10 CTests PASS**, 0 failed |
| Windows Server hosted MSVC | Qt 6.8.3 | **10/10 CTests PASS**, 0 failed |
| Windows portable review bundle | `windeployqt` | Workflow job **SUCCESS**, bundled smoke/fictional-fixture safety verification retained |

The new tenth test drives the **real compiled Qt Quick window** and verifies: filtering out selected Ranger clears Inspector; a still-matching Toyota ID survives search/filter; sorted keyboard focus finds the same C++ proxy row; Right at a row boundary does not wrap/scroll; empty search does not select anything; reflow from two to three Grid columns changes arrow movement correctly; text-input Left does not steal Fleet selection. Earlier tests still cover Gallery/Table consistency, keyboard arrows, Tab/Backtab, resize and synthetic DPI.

**Physical Windows acceptance NOT YET DONE for this exact source:** owner must Fetch/Pull `spike/p2-qtquick-fleet-20261030`, rebuild in Qt Creator **Desktop Qt 6.10.2 MinGW 64-bit Debug**, verify smoothness, no unexpected scroll, selected-ID/Inspector match, focus ring, sort/filter/empty results at recommended **150% Windows Settings / 1920×1080**. Hosted Windows Qt 6.8.3 success is not the owner's local Qt 6.10.2 result.

**Progress unchanged:** P0 5/5, P1 7/10, P2 3/6, P3–P9 0, **15/74, weighted 18.4%**, not release ready. This is a source reliability increment, not acceptance of complete P2 hardware/technology or P4 whole-product controls. Stable `main`, historic Draft PR #3/#4 and active Draft PR #6 unmerged. No rental write path or real customer files touched.
