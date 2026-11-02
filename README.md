# Rental Studio 2.0 | Qt/C++ Windows rental-management application

**Current project audit: 2 November 2026. This is a development project, NOT a commercial release.** [Latest checkpoint](docs/LATEST_CHECKPOINT.md) | [Full current documentation audit](docs/FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md) | [Roadmap](docs/ROADMAP.md) | [Formal acceptance](docs/P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | [Testing](docs/TESTING.md).

## Application

Offline-first native Qt Quick/QML desktop application with real C++ domain services: **Overview** (operational KPIs, due/overdue and booked value), **Fleet** (original generic car/motorcycle illustration, Gallery/Table, search/filter/sort, Inspector, vehicle actions), and **Rentals** (explicit quote, fictional booking, duplicate/stale/no-write safeguards, active/return/history/archive). The approved design direction is Midnight Navy, Emerald Teal, Cloud White, Ice Blue and Soft Mint. Historical Qt Widgets UI remains the domain/behavior reference and is not the intended final aesthetic.

The current portable Qt build runs with **generated fictional files only**. It is not a local-business multiuser platform, financial payment system or production data importer. Do not enter or upload real customer, phone or driving-licence information. Active booked contract value does not claim collected revenue.

## GitHub review and latest verified source

Source development is on [draft P7 PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), stacked over [P6 #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), [P5 #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12) and [P4 #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10). These PRs remain **unmerged**, stable main unchanged. Read [canonical state](docs/PROJECT_STATE_CANONICAL.md) for exact current instructions. Source verified at [74fb9b3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/74fb9b39086215390dabe32ce4c422d5bffb6285): [13/13 core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622337), [108/108 Linux Qt and 108/108 hosted Windows Qt](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622338), and Windows package checks PASS.

### Storage boundary

The default app uses C++ RentalSystem and protected fictional QSaveFile text ledgers. P7-G demonstrates real C++ business services with a **test-only SQLite blob transport**; P7-H implements a **separate, normalized typed fictional SQLite candidate** with int64 cents and transactional IDs. P7-H is included only in OFF-by-default test builds, **not** in the Qt Quick runtime. Commercial SQLite/backup/migration, permitted customer detail/retention, and real Windows installer require explicit owner approval. See [P7-G](docs/P7_G_CPP_DOMAIN_SQLITE_TRANSPORT_NATIVE_VERIFIED_2026-11-02.md), [P7-H](docs/P7_H_NORMALIZED_SQLITE_REPOSITORY_NATIVE_VERIFIED_2026-11-02.md), [provisional architecture ADR](docs/P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md).

## Evidence and remaining gates

The accepted planning ledger remains **28 of 74 criteria, 40.6% weighted evidence**. P5 0/8, P6 0/9, P7 0/8 require owner signoff and/or uncompleted commercial integration; P8 installer and P9 release QA not started. Hosted CI is not physical Qt Creator MinGW/Windows 100/125/150% or Narrator acceptance. No merge, release, production data or official installation is approved. [Windows physical checklist](docs/WINDOWS_ACCEPTANCE.md) and [P6-P polished UI report](docs/P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md) describe the consolidated future owner session.

## Working and documentation rules

The [date-neutral AI continuation prompt](docs/AI_CONTINUATION_PROMPT.md) is designed to recover live branch SHA, source evidence and owner decisions on each session. Historical 29/30 October reports remain for audit but are not live P7 status. Prefer a short verified checkpoint over appended legacy banners; only record new acceptance when supported by explicit criteria and owner review.
