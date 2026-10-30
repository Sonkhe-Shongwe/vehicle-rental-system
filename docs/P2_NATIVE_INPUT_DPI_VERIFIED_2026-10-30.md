# P2 Native Keyboard, Resize and Synthetic DPI | Verified Linux/Windows

**30 October 2026 | Source actually tested:** `eeb08485245ef127d6a9e53c2d80ec68bca66c0b`. **Current status: HOSTED QA PASSED; OWNER PHYSICAL WINDOWS GATE OPEN.**  
**GitHub Actions:** [41045646448](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045646448) — **SUCCESS**, Qt **6.8.3** on **Ubuntu 24.04/GCC** and **Windows Server 2022/MSVC2022**.

## Actual executed results

Both platforms compiled the unchanged Qt Widgets baseline plus the opt-in real C++17/Qt Quick Fleet executable. **8/8 CTests PASS on Linux; 8/8 PASS on Windows**:

1. `vehicle_rental_domain` — PASS.
2. `vehicle_rental_gui_lifecycle` — PASS, legacy Qt Widgets real tests.
3. `rental_studio_p2_model` — PASS, five fake vehicles, four available, shared C++ model filter/sort/selection, untouched source demo fixtures.
4. `rental_studio_p2_qml_wide` — PASS, genuine Qt Quick Gallery+Table capture 1500×860.
5. `rental_studio_p2_qml_compact` — PASS, genuine Qt Quick Gallery+Table capture 1280×720.
6. `rental_studio_p2_keyboard_resize` — PASS, `QTest::keyClick(QQuickWindow*)` Space Gallery→Table, Space selected native Table row, Escape cleared Inspector, Space restored Gallery, dynamic 1280×720→1500×860 resize with Inspector in scene bounds.
7. `rental_studio_p2_synthetic_125` — PASS, `QT_SCALE_FACTOR=1.25`, devicePixelRatio check, native PNG **1280×825 physical** from **1024×660 logical**.
8. `rental_studio_p2_synthetic_150` — PASS, `QT_SCALE_FACTOR=1.5`, devicePixelRatio check, native PNG **1536×990 physical** from **1024×660 logical**.

**Actual artifact evidence:** [workflow artifacts](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045646448). Windows artifact ID `12972023670`; Linux artifact ID `12971544723`. Each contains six real compiled Qt Quick `QQuickWindow::grabWindow()` PNGs: Gallery/Table × 2 sizes + synthetic 125/150%. All twelve file pixel dimensions inspected directly. Windows 150% and compact Table captures manually reviewed: legible fonts, no obvious toolbar/inspector overlap, accurate Corolla/Ranger/Honda identity and rates, intentional prototype-only generic vehicle symbols. Images are **NOT** HTML mockups or approved production photos.

## Regression history and fixes retained

- Earlier native CI [41045247197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045247197) was **FAILED (7/8 on both platforms)**. Keyboard test switched into Table but could not find the dynamically instantiated row with `QObject::findChild`. This was a real **test harness visibility/lookup defect**, not an acceptable PASS.
- Fixed C++ test to wait for Qt rendering and traverse `QQuickItem::childItems()` from the actual visible `fleetTable`; preserved the required real native row, Space selection and Escape assertions. [Source fix `eeb0848`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/eeb08485245ef127d6a9e53c2d80ec68bca66c0b).
- PR-only synchronize checks had not started for the new test commit, so the same full Qt6 workflow gained a **restricted `push` event on the single P2 branch** with unchanged test coverage, plus its existing Draft PR event. This produced the exact-source run above. Stable main's workflows were not modified.

## What these tests do NOT verify

Synthetic Qt scale factors are not physical monitor scaling. Hosted Windows Server is not the owner's physical PC or actual Qt Creator kit. The following are **not complete**: real human Tab/Shift+Tab navigation, physical Windows 100/125/150% OS settings and actual monitor interaction, screen reader, owner final Qt toolkit go/no-go, whole-product P1 visual owner approval, licensed model-matched photography, full rental workflow/persistence, SQLite or installer. The spike is intentionally **read-only** with temporary fictional demo records.

**P-phase gate remains P2 3/6 (50%)**, not 4/6: native keyboard and synthetic scaling provide supporting evidence within a composite acceptance criterion that still requires physical Windows. **Total weighted evidence remains 18.4%** (P0 100%, P1 70%, P2 50%, P3–P9 0), not release readiness.

## Next required action

Use [P2 Windows Qt Creator acceptance steps](../spikes/qtquick_p2/README.md) on the owner's real Windows kit, inspect genuine UI at both desktop sizes and real OS 100/125/150% display scaling, record keyboard and accessibility issues, then decide Qt Quick go/no-go. Do not advance to large-scale P3 rewrite or merge either Draft PR #4/#6 into main without explicit approval.
