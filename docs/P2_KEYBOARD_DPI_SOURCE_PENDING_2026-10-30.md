# P2 native keyboard, live-resize and synthetic DPI verification

**30 October 2026 | Code staged, verification pending for latest source.**

- Latest P2 source commit: `eb7bb9e22c5e3a2bd2525068202ddd2899783ae7` on `spike/p2-qtquick-fleet-20261030`, reviewed through [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6).
- Last **verified** P2 native source remains `f45147d05d3449ffc89514fb1e685e2990c843fc`: [Linux/Windows Qt6.8.3 workflow 41043137443](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41043137443) with 5/5 Qt tests per platform and inspected exact-size Qt PNGs. Follow-up documentation-only SHA `137055e` also had green Actions (legacy and P2), but is **not evidence for the new keyboard/DPI additions**.

## Latest incremental source

New `--input-smoke` C++/QML path sends **real Qt Test keyboard events** to the compiled QQuickWindow: Space toggles Gallery to Table, Space selects a genuine Table delegate backed by C++ model, Escape clears the Inspector, and Space returns to Gallery. It then resizes the **same native window** to 1280×720, checks Inspector geometry against actual scene coordinates, and returns to 1500×860 without restart.

New `--dpi-smoke` tests at `QT_SCALE_FACTOR=1.25` and `1.5` use a logical 1024×660 native window, check `QWindow::devicePixelRatio()`, capture an actual Qt image, assert measured raster size against physical pixel size, and save `p2-qt-synthetic-*.png`. This is **synthetic DPI only**: no claim of owner hardware 100%, 125%, 150% screen validation.

The opt-in Qt target links `Qt6::Test`, the original `RentalSystem` still uses a disposable `QTemporaryDir` from committed fictional fixtures, and the spike exposes no rental-writing method, SQLite, API or external-data input. Original Qt Widgets app and tests are not modified.

## Verification ledger

| Evidence item | Result |
| --- | --- |
| GitHub commit and reviewed source contents | Confirmed |
| Basic C++/QML delimiter check, named QML controls, CTest names, temporary fixture isolation | Static review only, not compiler validation |
| Baseline Linux/Windows 5/5 tests at previous tested source `f45147d` | **PASS, historical checkpoint** |
| New keyboard + live resize on `eb7bb9e` | **NOT RUN / UNKNOWN** |
| New synthetic 125% and 150% Qt tests on `eb7bb9e` | **NOT RUN / UNKNOWN** |
| Physical owner's Windows Qt Creator, 100/125/150%, real monitor input/accessibility | **NOT RUN / UNKNOWN** |

At inspection time no GitHub Actions run was reported for `eb7bb9e` despite the open PR. Do not infer pass or failure; re-check [PR #6 Checks](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6/checks) or run the reproducible [P2 Windows instructions](../spikes/qtquick_p2/README.md) on an actual suitable Qt kit. If the test fails, inspect the failing step and correct the underlying code or viewport assumptions; do **not** disable it.

**Current weighted evidence remains 18.4%, P2 3/6, P1 7/10.** No gate exit, merge, aesthetic approval or release implied.

**Next action:** obtain exact-head `eb7bb9e` Qt6.8.3 Linux/Windows compile + CTest + screenshot evidence and fix any observed defects; after that finish owner hardware/manual Windows acceptance and P2 toolkit decision. Remain on one primary P2 phase.
