# P4 Reduced Motion Source and Native Evidence | 1 November 2026

**Exact validated source:** [`a6867c1c2830ea76074f1d0d4af3e32e27392d42`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a6867c1c2830ea76074f1d0d4af3e32e27392d42), stacked [Draft PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10) on unmerged P3 Draft PR #9; default main untouched.

## Verified implementation

- `spikes/qtquick_p2/motion_policy.h/.cpp`: injectable C++ `MotionPolicy` publishes `reducedMotion` and `selectionFadeMs`. Windows startup queries `SystemParametersInfoW(SPI_GETUIEFFECTS)` and `SystemParametersInfoW(SPI_GETCLIENTAREAANIMATION)`. A failed query disables cosmetic animations. `WM_SETTINGCHANGE` queues refresh and application-state changes refresh again.
- Qt 6.8.3 CI and owner Qt 6.10.2 MinGW do **not** expose `QAccessibilityHints::motionPreference`, which was added in Qt 6.12. Non-Windows builds therefore default to reduced animation until a supported system preference API is available. No claim of reading GNOME/KDE/macOS preferences.
- `FocusFrame.qml` keeps focus border width/color changes immediate. Only selection surface tint gets a brief 90ms `ColorAnimation` when OS effects are enabled, otherwise 0ms; no moving transitions, auto-play effects, kinetic navigation or delayed domain actions were introduced.
- Test-only flags `--p4-motion-smoke` and `--p4-reduce-motion` are confined to synthetic fixtures; without the smoke flag the application reads the actual supported system setting. Test cases switch preference live, verify the QML root and visible focus frame's durations, keyboard selection, and byte-identical source/temporary rental ledgers.

## Executed native checks

| Test environment | Source run | Exact result |
|---|---|---|
| Linux Core and legacy | [41265064162](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41265064162) | **13/13 CTests PASS** |
| Linux GCC Qt 6.8.3 QQuickWindow | [41265064168](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41265064168) | **41/41 CTests PASS**, motion ordinary/reduced × wide/compact all pass |
| Windows MSVC Qt 6.8.3 QQuickWindow | [41265064168](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41265064168) | **41/41 CTests PASS**, motion ordinary/reduced × wide/compact all pass |
| Windows packaged automatic integrity | Same Windows job | **PASS**; physical Windows Settings still NOT manually tested |
| CI artifacts | Same native run | Linux and Windows each uploaded **26 screenshots**, including ordinary/reduced at 1500×860 and 1280×720; disposable Windows physical acceptance kit separately uploaded |

## P4 source acceptance and limitations

P4 category **#5 reduced-motion implementation and automated behavior: ACCEPTED**. Previous accepted #1 design tokens, #2 existing shell navigation, #3 existing reusable components and #6 actual two-window screenshots remain accepted. P4 now **5/7**; programme **28/74** criteria accepted, weighted **40.6%**.

Weighted arithmetic: P0 5 × 5/5 = 5%; P1 12 × 7/10 = 8.4%; P2 10 × 4/6 = 6.6667%; P3 12 × 7/7 = 12%; P4 12 × 5/7 = 8.5714%; P5–P9 zero accepted. Sum 40.6381%, rounded 40.6%. This is evidence coverage rather than percentage of code or product release readiness.

Still OPEN: P4 **#4 full accessibility including keyboard, Narrator and focus-review edge cases**, P4 **#7 physical owner Qt Creator 6.10.2 MinGW, actual Windows reduced-animation setting and 100/125/150% scaling, aesthetic/UX feedback**. P1/P2 owner visual/device gates and P5–P9 remain separate. Test-only simulated preference changes do not prove actual OS configuration changes on a person's device.

Do not expose live customer files, arbitrary data directories, payments, schema migration, SQL, permanent deletion in QML or release. All work remains on stacked draft PRs with SHA-pinned fictional files copied to QTemporaryDir and protected source files unchanged.

**Next:** P4 accessibility audit and owner physical Windows acceptance evidence. Do not self-certify Narrator or OS-level reduced-motion preference merely from CI results.
