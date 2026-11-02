# Rental Studio 2.0 | Current architecture

**Audited 2 November 2026.** [Canonical status](PROJECT_STATE_CANONICAL.md) | [Full documentation audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md) | [P7 storage ADR, PROPOSED](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md).

## Running application boundary

- **Qt Quick / QML presentation:** Overview operational cards, Fleet Gallery/Table/Inspector, Rentals guided quote/confirm/return/history, shared focus/controls. Product styling is owner-selected navy, teal and light surfaces. Scoped displays were inspected in hosted Windows screenshots, but owner physical scaling/Narrator approval is pending.
- **Application C++ services:** typed Fleet reads/writes, Rental Quote and Confirm, return/archive and controller callbacks. C++ RentalSystem is authoritative and refuses uncommitted success, stale quote, double booking and unsafe fictional destructive actions.
- **Current active runtime persistence:** synthetic-only vehicle and rental UTF-8 text ledgers under a protected temporary or pinned fictional workspace using the existing RentalStorage/QSaveFile interface. Separate file writes are not joint transactions; money still uses double; existing live IDs can be reused after historical deletion. These risks are **not** solved in the running app.
- **Physical OS boundary:** packaged hosted Windows Qt 6.8.3 MSVC checks are green; no verified on-owner-machine Qt Creator 6.10.2 MinGW release validation, monitor-scale/Narrator or offline installer.

## Separate P7 prototypes, not interchangeable

| Source | Mechanism | Demonstrated | Excluded |
|---|---|---|---|
| [P7-G proof](P7_G_CPP_DOMAIN_SQLITE_TRANSPORT_NATIVE_VERIFIED_2026-11-02.md) | Test-only synthetic SQL storage implementing existing byte-oriented RentalStorage | Real C++ quote/confirm/return/archive service integration | Normalized transactional commercial model |
| [P7-H candidate](P7_H_NORMALIZED_SQLITE_REPOSITORY_NATIVE_VERIFIED_2026-11-02.md) | Typed C++ Repository under src/application/p7_sandbox, linked **only** to opt-in Qt Core/Sql CTest; SQLite vehicles/rentals/counters | int64 cents; transaction-scoped issued IDs; occupancy uniqueness; return/archive/retire; future-schema/lock/rollback checks | Actual Qt Quick RentalSystem adapter; customer name/phone/licence fields; real files/import; production backup/restore |
| [P7-I Qt Quick/normalized SQL preview](P7_I_QTQUICK_NORMALIZED_REPOSITORY_PREVIEW_NATIVE_VERIFIED_2026-11-02.md) | Separate opt-in Qt Quick Controls window + QObject PreviewController + P7-H Repository, all in temporary generated-fictional sandbox | UI-to-typed SQLite quote/confirm/return/archive/retire, no receipt before durable COMMIT; genuine QML click and rollback native tests | NOT normal `Main.qml` or its commercial application service linkage, NO PII and NO production migration |
| [P7-A ADR](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md) | Proposed local SQLite via Qt SQL production architecture | Policy and implementation plan | Owner ratification, lawful contact/retention or final schema approval |

**Latest exact test evidence:** [P7-I source b2edee6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/b2edee62f94a1283c6750451348ed4acbf11c47a), [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41466363812), [native Qt 6.8.3 Linux 110/110 and Windows 110/110 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41466363800), Windows packaged PS7/PS5.1 PASS. This covers a distinct opt-in QML test preview; the normal Qt Quick application still has no QtSql dependency.

## Gated next layer

Before P7 commercial runtime linking, ratify monetary caps, nonreusable C/M/R IDs and legacy ID conflict treatment, vehicle retirement/history deletion and retention, legal processing and authorized customer-contact/old licence data, local database permissions, versioned migration and backup/restore. Connect typed repository to actual application domain and QML in a **fictional-only controlled mode** after decision, prove whole-lifecycle parity and recovery, then separately authorize live data. P8 offline packaging and P9 final owner/OS/accessibility release approval follow. No in-progress draft is merged or released.
