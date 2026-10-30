> **LATEST P2 FLEET KEYBOARD CHECKPOINT (30 October 2026):** Owner confirms **Tab and Shift+Tab worked** locally but reports **Gallery arrows merely scrolled instead of selecting vehicles** in the previous Qt Creator build. [Source fix `f486c8a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f486c8a32b156ddeec1816b2ab2a4811c2c45431) now makes Gallery arrows select spatially adjacent C++ vehicle IDs (Up/Down/Left/Right), Table Up/Down select rows, and keyboard focus visibly distinct from selection. Text field/combo arrows retain native behaviour, Tab/Backtab traverse groups. [Qt6.8.3 Actions run 41059423971](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41059423971) **PASS 9/9 native CTests Linux AND 9/9 Windows**, including new real keyboard arrows, no stand-alone Gallery scroll, search caret noninterference, filter parity, Tab/Shift+Tab, and previously verified portable fake-fixture safeguards. **New source has NOT yet been pulled/rebuilt/accepted on owner's Qt6.10.2 MinGW PC:** focus order/smoothness, hardware scale and full-product accessibility pending. **P2 remains 3/6 (50%), weighted coverage 18.4%**, not release readiness. Historical 8/8 results or 'no arrows implemented' text below represent an earlier code stage.

# Rental Studio 2.0 | Windows C++/Qt Vehicle Rental System

**Audited current status: 30 October 2026. The rebuilt product is NOT RELEASED.**

**Start here:** [Canonical state](docs/PROJECT_STATE_CANONICAL.md) | [Complete evidence and document audit](docs/FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) | [General-purpose AI continuation prompt](docs/AI_CONTINUATION_PROMPT.md) | [P0–P9 evidence-weighted plan](docs/P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | [Windows acceptance](docs/WINDOWS_ACCEPTANCE.md).

## Product

Offline-first professional Windows desktop vehicle-rental management. One owner-selected **light** visual system: Midnight Navy, Emerald Teal and Cloud White, Ice Blue sidebar and Soft Mint quotation surface. **Overview = operations; Fleet = vehicles and linked Gallery/Table/Inspector; Rentals = guided Vehicle → Customer → Review with Active/History/Return.** The earlier graphite/lime Qt Widgets aesthetic was rejected. New design direction is selected, but final whole-product owner signoff, matching licensed car/motorbike imagery and accessibility remain pending.

## Actual code and evidence

The existing C++17 **Qt Widgets** application is a working reference for fleet/rental/return/history/archive rules, NOT the approved replacement UI. Risks remain around source-adjacent storage, nontransactional multi-file saves, ID reuse, floating-point money and one large MainWindow.

The new read-only **Qt Quick/C++ Fleet P2 spike** is implemented on the separate branch [spike/p2-qtquick-fleet-20261030](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/spike/p2-qtquick-fleet-20261030) and [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6). It uses real C++ domain models, shared Gallery/Table search/filter/sort and selected Inspector, temporary hash-pinned fictional fixtures. There is **no live new rental workflow or persistence write path** in the spike, and it is not merged into stable main.

**Hosted Qt 6.8.3:** [run 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629) passed **8/8 Linux and 8/8 Windows CTests**, plus Windows portable bundle, model/QML smoke and altered demo rejection. [Run 41048156914](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41048156914) passed the later docs-only spike branch head. The owner also **compiled/launched the real Qt Quick app locally** using Desktop Qt **6.10.2 MinGW Debug** in Qt Creator, and verified selected Corolla, synchronized Gallery/Table, Available filter, Rate sort and Escape clearing Inspector, all in actual Windows screenshots.

**Not proved on owner machine:** native Qt app behavior at the now-confirmed **150% Recommended / 1920×1080 Recommended** Windows Settings baseline and supported 100%/125% scales, full Tab/Shift+Tab and arrow focus, local full CTest log, exact local SHA or formal Qt Quick go/no-go. Synthetic hosted DPI is not real monitor acceptance.

## Side-by-side Qt Creator workflow

In GitHub Desktop choose the vehicle-rental-system repo and P2 spike branch; Fetch/Pull origin. Open the **root CMakeLists.txt** in Qt Creator with installed Qt Quick modules and Desktop Qt6 kit; CMake options **BUILD_QTQUICK_P2_SPIKE=ON**, **BUILD_TESTING=ON**. Use a fresh build folder if the repository location moved, build, then select run target **rental_studio_qtquick_spike**. User's repository was last shown inside **C:\Users\Lenovo\Downloads\Github Projects\vehicle-rental-system**; old directory paths may have become invalid. See [source-branch instructions](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/spikes/qtquick_p2/README.md).

For upcoming P2 acceptance record local source SHA, Qt Creator/version/kit, manual supported Windows display scale, keyboard and live resize with screenshots, then seek final owner technology decision. The downloaded P2 Windows ZIP is an **expiring testing kit, not source checkout or installer**.

**Progress as evidenced:** P0 5/5, P1 7/10, P2 3/6, P3–P9 zero. **18.4% weighted acceptance coverage; NOT 18.4% release readiness.** P1 design and P2 final gates remain open. Never silently add payments, pending reservations, save-draft persistence, API/cloud, SQLite or merge Draft PR #3/#4/#6 or main.

**Tracking:** [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5); older README [preserved in archive](docs/archive/README_PRE_CANONICAL_AUDIT_2026-10-30.md). The planning branch intentionally has NO spike source directory; the spike branch holds the implementation.
