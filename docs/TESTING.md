# Rental Studio 2.0 | Current Testing and Evidence Policy

**Audited 30 October 2026.** [Canonical state](PROJECT_STATE_CANONICAL.md) · [Full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) · [P2 owner physical Windows checklist](WINDOWS_ACCEPTANCE.md).

**Evidence levels must not be conflated:** proposed ≠ source written ≠ built ≠ CTest PASS ≠ inspected compiled UI ≠ owner physical evidence ≠ owner signoff ≠ released. Record exact branch/commit, Qt/compiler/OS, commands, real results (including failures), screenshots and fixtures.

| Evidence | Verified | Limitation |
|---|---|---|
| Old Widgets baseline | Linux run [40944222722](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222722), Windows [40944222486](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222486), 2/2 legacy CTests historically green | Does not approve rejected UI or new QML |
| R1 browser-only owner-theme prototype | 19/19 original and 63/63 further checks, seven key screens at 1500×860 and 1280×720 | HTML in-memory, not Qt |
| P2 native exact code | [41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629), tested SHA `3620d83518cc01bce047b6f0a17deab0b96079b6`: Qt 6.8.3 Ubuntu/GCC **8/8** and Windows/MSVC **8/8** | Hosted and synthetic scale only |
| P2 portable Windows QA | `windeployqt` runtime, moved-folder self-test and compiled QML compact smoke, altered fake demo refused in 41047388629 | Not a full installer nor owner's manual screen/DPI |
| Later P2 docs head | [41048156914](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41048156914) green at `e5474d6` | Docs-only commit, not a new feature gate |
| Native P2 owner's PC | Qt Creator Desktop Qt **6.10.2 MinGW Debug** built and displayed Fleet; Corolla Inspector, Gallery→Table shared selection, Available filter 4, correct Rate sort and **Esc dismissal** verified by actual screenshots/user | No local exact SHA/CTest transcript; Windows Settings scale not recorded; full keyboard/resize and owner go/no-go open |

**Failure history, never hide:** Native Windows initial offscreen glyph boxes and hosted screenshot width clipping fixed; first expanded Qt keyboard CI run [41045247197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045247197) was **7/8 FAIL on both platforms**, due QQuickItem delegate lookup; following [41045646448](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045646448) passed **8/8 on both** after fixing actual rendered-delegate traversal, no test waiver.

**Synthetic Qt `QT_SCALE_FACTOR=1.25/1.5` is not physical monitor scaling.** User-provided PNG pixel dimensions are not Windows Display Settings percentage. An assistant does not have local Qt Creator control.

## Immediate remaining P2 test evidence

On owner's Windows PC: `git rev-parse HEAD`, Qt Creator app version, actual Kit compiler/Qt version, local CTest output from real build directory, Windows Settings physical 100/125/150% where supported, real resize at 1500×860 and 1280×720 if available, Tab/Shift+Tab/Space/Enter/Escape manual focus and keyboard inspection, screen reader/zoom when feasible and recorded owner toolkit go/no-go. Do not repeat already passed Corolla, shared view, four-vehicle filter, rate sort and Esc unless investigating a regression.

P1 separately requires licensed model-correct images, owner whole-product aesthetic signoff and broader accessibility. Future P4 requires predictable **group-local** arrow movement with visible focus and preserved text-input caret behavior. Do not mark it implemented in P2.

## Test governance

Use fictional-only disposable fixtures and rollback plans. Keep exact-source independent Linux/Windows CI and local CMake/CTest where feasible, with controlled runner budget but never hidden failures or fabricated test counts. No source change of C++/QML occurred in this documentation audit, so **no new compile pass is attributed to these docs**. [P0–P9 acceptance matrix](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md): P2 3/6, overall weighted 18.4% until a required criterion genuinely clears.
