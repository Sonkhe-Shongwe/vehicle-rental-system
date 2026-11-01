# P5-A | Functional Operational Overview, verified 1 November 2026

## Authorization and staging

The owner explicitly requested moving away from repetitive manual P4 acceptance scripts and back to actual product functionality. P4 remained **5/7 formally accepted**, with full physical Narrator/Qt Creator/design review pending. To prevent premature acceptance or unintentional mixing of branches, P5-A was built as **[Draft PR #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12)** on `feature/p5-operational-overview-20261101`, stacked on the **unmerged** P4 Draft PR #10. Stable `main` and P4 source were not modified.

## Actual delivered behavior

The previous Overview was a temporary Fleet-only feasibility panel: two vehicle cards and a message deliberately omitting rental value and due-state. P5-A now presents a genuinely useful operational Overview using **live read-only C++ summary data**:

| Native Overview area | Source and meaning |
|---|---|
| Available vehicles | Existing C++ `FleetController.availableCount`; no separate QML inventory |
| Active rentals | `RentalListModel.activeCount` across all authoritative records |
| Overdue rentals | Active C++ rental summaries with `RentalDueState::Overdue` |
| Due today | Active C++ rental summaries with `RentalDueState::DueToday` |
| Returned or archived | Nonactive summaries, no customer contact in view |
| Active booked contract value | Sum of `legacyTotal` for active rental summaries. **Contract value only, not paid revenue/cash, invoice or deposit** |

- New reusable **`spikes/qtquick_p2/OverviewMetricCard.qml`** honors approved navy/teal/cloud tokens, responds in two or four columns by window width, and includes accessible metric names.
- Actual `Review active rentals` and `Open Fleet` Qt buttons change the native workspace and C++-owned Rentals filter through existing interfaces.
- `RentalListModel` exposes `activeCount`, `historyCount`, `overdueCount`, `dueTodayCount`, `activeBookedValue` as read-only Qt properties and emits `metricsChanged` after an explicit refresh from **an already committed** domain transaction. Applying All/Active/History UI filters does not affect the aggregate source. No wall-clock polling, optimistic booking, QML lifecycle logic, new file input paths or second persistence channel.
- No customer names, phone numbers, protected demo originals or real-person rental data are exposed or modified. Test mutations use the app's existing disposable `QTemporaryDir` and SHA-256-validated fictional fixtures.

## Executed verification at exact source

Source: [`d478bf424ecf395368612d5f0cc49d00f8071f1a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/d478bf424ecf395368612d5f0cc49d00f8071f1a), and [CI base registration `2f629451ca1044ad1d8242e600bc14f482d0ffa4`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2f629451ca1044ad1d8242e600bc14f482d0ffa4).

| Environment | Exact source run | Observed result |
|---|---|---|
| Ubuntu Core and legacy C++ | [41290057874](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41290057874) | **13/13 CTests PASS** |
| Linux GCC native Qt Quick 6.8.3 | [41290057891](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41290057891) | **45/45 CTests PASS**, including two new P5 operational Overview cases |
| Windows Server 2022 MSVC native Qt Quick 6.8.3 | [41290057891](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41290057891) | **45/45 CTests PASS**, same two P5 cases |
| Windows packaged review, legacy source validation | Same Windows job | **PASS**, swapped fictional demo fixture rejected |
| Windows portable P4 verification | Same Windows job | **4/4 P4 checks PASS** under PowerShell 7 and separately Windows PowerShell 5.1 |
| Native screenshots | Same native run | Linux and Windows screenshot artifacts include `p5-qt-operational-overview-1500x860.png` and `p5-qt-operational-overview-1280x720.png` |

The new real `--p5-overview-smoke` uses a compiled `QQuickWindow`, tests initial C++ KPIs against the source fictional ledger, renders the actual Overview screenshot at both sizes, changes Rentals status filters and confirms overview totals remain unchanged, then **books the available fictional Corolla C001 for 3 days** through the existing `RentalBookingController` and **authoritative durable C++ confirm service**, confirming Active KPIs, R450/day × 3 booked value, Available Fleet count and live visible card bindings. It then returns fictional R001 through the existing `RentalReturnController`, checks updated status/contract totals and working keyboard Overview shortcuts, and verifies the original demo source files remain **byte-identical** while disposable test ledger changed.

All prior native CTests stayed enabled and passed. Linux and Windows test logs were inspected; each reported `100% tests passed, 0 tests failed out of 45`. Hosted tests do **not** establish physical owner visual/aesthetic acceptance.

## Formal milestone accounting and next implementation

**P5 remains 0/8 formally accepted** pending its complete real persisted Corolla vertical slice including restart reconstruction and negative durability/duplicate/declined pathways. P4 still **5/7**, programme **28/74**, phase-weighted **40.6% evidence coverage**, not actual ship readiness. Pending P1/P2 owner design/device checks also remain unchanged. [Tracking Issue #13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/13) lists the eight full P5 requirements. No authorization to merge PR #12 or P4 ancestors, activate actual customer storage, install, release or advance to payments.

**Next engineering increment:** Add explicit restart/reconstruction verification and clear, real persisted booking success feedback in the native UI using the existing C++ service. Keep reversible changes and automated CI. Save owner's manual effort for a consolidated visual review instead of multiple PowerShell sessions.
