# P2 Qt Quick Fleet Spike | Current Native Test Reference

**30 October 2026: SOURCE COMPILED AND HOSTED TESTS GREEN; USER WINDOWS QT CREATOR APP LAUNCHED; FINAL P2 GATE OPEN.**

**Read the synchronized project documents first:** [Current State](../../docs/PROJECT_STATE_CANONICAL.md), [Full Audit](../../docs/FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md), [Universal Continuation Prompt](../../docs/AI_CONTINUATION_PROMPT.md), [Current Windows checklist](../../docs/WINDOWS_ACCEPTANCE.md).

This branch's `spikes/qtquick_p2/` is a real, read-only C++/Qt Quick **Fleet feasibility** target, **not** the full rental product. `BUILD_QTQUICK_P2_SPIKE=ON` enables it; OFF is the legacy default. Source uses actual `RentalSystem` through typed `QAbstractListModel`/`QSortFilterProxyModel`; Gallery/Table share filter/sort/selected vehicle ID and right Inspector. Only fictional SHA-256-pinned fixtures are loaded into disposable temporary storage. No real new rental writes, production images, SQLite, API or installer.

**Hosted Qt6.8.3:** [Actions run 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629) 8/8 CTests Linux GCC and 8/8 Windows MSVC, plus `windeployqt` portable QML smoke and altered fictional data rejection. Owner's **Desktop Qt6.10.2 MinGW 64-bit Debug** locally compiled/launched Qt Quick; screenshots confirm C001 Corolla R450/day, Gallery/Table selection parity, four Available, Rate sort and Escape dismissal. Local Qt Creator version, SHA/CTest, real Windows OS scaling and owner Qt Quick go/no-go remain UNVERIFIED. **P2 3/6; overall 18.4% weighted, NOT release readiness.**

**Owner's local steps:** GitHub Desktop on `spike/p2-qtquick-fleet-20261030` → Fetch/Pull → Qt Creator open root `CMakeLists.txt`, kit Qt6.10.2 MinGW 64-bit Debug, options `BUILD_QTQUICK_P2_SPIKE=ON` and `BUILD_TESTING=ON`, new CMake build directory if moved, build and run `rental_studio_qtquick_spike`. Test manual keyboard/real Windows Display Settings 100%,125%,150% where supported, 1280×720/1500×860 live resizing, and record local source SHA/CTest. Full [on-device checklist](WINDOWS_PHYSICAL_ACCEPTANCE.md). **Do not force unsupported scales or edit real customer data.**

**Future native keyboard rule:** group-local Arrow navigation, Tab/Shift+Tab between regions, Enter/Space activation, Escape dismiss, preserve text-input caret. P4 design target, not already implemented globally. A partly scrolled Gallery top row is a possible usability observation, not established defect.

**Do not merge this Draft PR #6, old PR #3/#4 or stable main without explicit owner consent.** Previous early “not compiled” notes are preserved in [historical spike README](README_PRE_CANONICAL_AUDIT_2026-10-30.md).
