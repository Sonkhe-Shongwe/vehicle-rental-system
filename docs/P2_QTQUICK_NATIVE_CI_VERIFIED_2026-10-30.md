# P2 Qt Quick Fleet | Verified hosted native build and visual smoke

**Checkpoint: 30 October 2026 | Technical source SHA:** `f45147d05d3449ffc89514fb1e685e2990c843fc`  
**Branch:** `spike/p2-qtquick-fleet-20261030` · **Draft PR:** [#6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) (targets reset documentation branch, **NOT main**)  
**Independent P2 workflow:** [run 41043137443](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41043137443) **SUCCESS on both platforms**.  
**Unchanged original baseline CI:** [run 41043137394](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41043137394) SUCCESS (2/2 legacy CTests).

## Exactly what was verified

| Platform | Toolchain | Build | CTest | Compiled Qt Quick PNG sizes |
| --- | --- | --- | --- | --- |
| Linux hosted | Ubuntu 24.04, Qt 6.8.3, GCC | PASS | 5/5 PASS | Gallery and Table at 1500×860, 1280×720 |
| Windows hosted | Windows Server 2022, Qt 6.8.3, MSVC2022 | PASS | 5/5 PASS | Gallery and Table at 1500×860, 1280×720 |

The same tests ran on each platform: `vehicle_rental_domain`, `vehicle_rental_gui_lifecycle`, `rental_studio_p2_model`, `rental_studio_p2_qml_wide`, `rental_studio_p2_qml_compact`.

The **real native Qt screenshots**, generated with `QQuickWindow::grabWindow()`, were downloaded and manually inspected from the Actions artifacts. Both image archives contain four genuine PNGs at exact dimensions, not HTML/browser captures. Windows glyphs are readable and Table after search `Honda` shows `Honda CB500F / M001`, `471 CC`, `R280/day` and available status in the selected Inspector. Gallery displays source model-backed five fictional vehicles including rented Ford Ranger and available Corolla.

The C++ model test verified five fleet entries, four available, R450 Corolla, Honda search, rented filter, sorting/selection stability, clearing selected ID and byte-identical committed demo source files. No user/customer records used. Read-only `QTemporaryDir` isolation and opt-in CMake default OFF remain.

## Discovered defects and actual corrections

1. Initial hosted Windows Qt `offscreen` QPA plugin generated square placeholder glyphs even though UI smoke returned success. **Corrected** Windows UI environment to native Windows QPA and retained Qt Quick software backend; manually checked resulting readable screenshots.
2. Initial 1280/1500 hosted Windows captures were only ~1028 px wide because runner virtual desktop was too small. **Corrected** hosted Windows display to 1920×1080 using `Set-DisplayResolution`, and added mandatory exact-image-dimension assertions to both Qt UI tests. Final PNG sizes are correct on Linux and Windows. No false 1280/1500 screenshot pass survives.
3. Compact Linux Qt screenshot had overflowing toolbar and Inspector labels; split toolbar search and view controls, constrained Inspector wrapping, made close control compact/conditional. Final Windows and Linux images inspected at both sizes.

All three failures/issues are part of the engineering review history, not silently skipped or weakened tests.

## Objective acceptance progress

The [P0–P9 verified-check plan](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) now records **P2 3/6 = 50%**, completing:
- Standalone QML app compiles and launches through hosted Qt6 native runtime.
- Real typed C++ five-vehicle domain model drives Gallery and Table.
- Search, sort, filter, selected-ID parity and Inspector content proven in C++ and actual QML UI smoke.

**Still PENDING (3 checks):** owner's exact Windows Qt Creator/compiler/module kit, physical user-interaction/resizing and 100/125/150% OS display scaling (including keyboard/screen-reader evaluation), and final Qt Quick go/no-go decision on owner's Windows machine. Hosted Windows Server CI is not a replacement for physical Windows acceptance.

**P0 = 5/5; P1 = 7/10 (owner design, imagery, accessibility still open); P2 = 3/6; P3–P9 = 0. Overall weighted evidence coverage = 18.4%. NOT release readiness.**

## Next priority

Run the exact [P2 Windows acceptance instructions](../spikes/qtquick_p2/README.md) in owner's Qt Creator environment, log Qt Creator/Qt/Windows kit, use only fictional disposable records, examine actual application at 1500×860 and 1280×720 and **physical** 100%,125%,150% scales and keyboard focus/selection. Fix findings, capture screenshots and obtain technical go/no-go. Retain final P1 aesthetic/photo/accessibility approval as a separate open gate. Do not merge old Draft PR #4, Draft PR #6 or stable main automatically; do not begin P3 or SQLite migration while this proof remains open.
