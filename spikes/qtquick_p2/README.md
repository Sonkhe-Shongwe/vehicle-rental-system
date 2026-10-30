# P2 Qt Quick Fleet Spike | Current Native Test Reference

**30 October 2026: SOURCE COMPILED AND HOSTED TESTS GREEN; USER WINDOWS QT CREATOR APP LAUNCHED; FINAL P2 GATE OPEN.**

**Read the synchronized project documents first:** [Current State](../../docs/PROJECT_STATE_CANONICAL.md), [Full Audit](../../docs/FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md), [Universal Continuation Prompt](../../docs/AI_CONTINUATION_PROMPT.md), [Current Windows checklist](../../docs/WINDOWS_ACCEPTANCE.md).

This branch's `spikes/qtquick_p2/` is a real, read-only C++/Qt Quick **Fleet feasibility** target, **not** the full rental product. `BUILD_QTQUICK_P2_SPIKE=ON` enables it; OFF is the legacy default. Source uses actual `RentalSystem` through typed `QAbstractListModel`/`QSortFilterProxyModel`; Gallery/Table share filter/sort/selected vehicle ID and right Inspector. Only fictional SHA-256-pinned fixtures are loaded into disposable temporary storage. No real new rental writes, production images, SQLite, API or installer.

**Hosted Qt6.8.3:** [Actions run 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629) 8/8 CTests Linux GCC and 8/8 Windows MSVC, plus `windeployqt` portable QML smoke and altered fictional data rejection. Owner's **Desktop Qt6.10.2 MinGW 64-bit Debug** locally compiled/launched Qt Quick; screenshots confirm C001 Corolla R450/day, Gallery/Table selection parity, four Available, Rate sort and Escape dismissal. Local Qt Creator version, SHA/CTest, Qt app-at-scale and owner Qt Quick go/no-go remain UNVERIFIED; owner's Windows Settings screenshot now confirms 150% Recommended, 1920×1080 Recommended physically, but does not certify the app's rendering at that scale. **P2 3/6; overall 18.4% weighted, NOT release readiness.**

**Owner's local steps:** GitHub Desktop on `spike/p2-qtquick-fleet-20261030` → Fetch/Pull → Qt Creator open root `CMakeLists.txt`, kit Qt6.10.2 MinGW 64-bit Debug, options `BUILD_QTQUICK_P2_SPIKE=ON` and `BUILD_TESTING=ON`, new CMake build directory if moved, build and run `rental_studio_qtquick_spike`. Test manual keyboard/real Windows Display Settings 100%,125%,150% where supported, 1280×720/1500×860 live resizing, and record local source SHA/CTest. Full [on-device checklist](WINDOWS_PHYSICAL_ACCEPTANCE.md). **Do not force unsupported scales or edit real customer data.**

**Future native keyboard rule:** group-local Arrow navigation, Tab/Shift+Tab between regions, Enter/Space activation, Escape dismiss, preserve text-input caret. P4 design target, not already implemented globally. A partly scrolled Gallery top row is a possible usability observation, not established defect.

**Do not merge this Draft PR #6, old PR #3/#4 or stable main without explicit owner consent.** Previous early “not compiled” notes are preserved in [historical spike README](README_PRE_CANONICAL_AUDIT_2026-10-30.md).

## Current arrow-key vehicle selection (native P2)

**Implemented and verified in hosted Qt6.8.3 CI:** [source f486c8a](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f486c8a32b156ddeec1816b2ab2a4811c2c45431), [run 41059423971](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41059423971), **9/9 CTests Linux and Windows**. Gallery Up/Down/Left/Right selects the adjacent displayed C++ vehicle; Table Up/Down selects previous/next row; the Inspector changes alongside selection; scrolling only reveals selected items, never substitutes for vehicle navigation. Tab/Shift+Tab moves between groups, visible Navy border marks keyboard focus, normal search/ComboBox arrows unaffected. Source contains an additional real native `rental_studio_p2_arrows_focus` CTest and `--arrows-smoke` CLI mode.

**Owner verification still needed:** In GitHub Desktop Fetch/Pull on `spike/p2-qtquick-fleet-20261030`, rebuild in Qt Creator Qt 6.10.2 MinGW. Click the Ford card to give Gallery focus, then press Right (Honda), Down (Corolla), Left (Hyundai), Up (Ford). Switch Table, select a row and use Down/Up. Verify focus outline, selection and rate/Inspector match each key, plus Tab and Shift+Tab don't trap. Report input smoothness/accuracy. The owner confirmed Tab/Shift+Tab work in prior build, but **that prior local code scrolled for arrows**; do not claim the new code already owner-approved. P2 remains 3/6, overall weighted 18.4%.

