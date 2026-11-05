# Rental Studio 2.0 | Qt/C++ Windows rental-management application

**DAILY REVIEW: NO MORE REPEATED 30–50 MB ZIPS.** [Open the 4-step GitHub Desktop → Qt Creator guide](docs/DAILY_UI_REVIEW_NO_ZIPS.md). Pull the existing feature branch, then build/run the modern `rental_studio_qtquick_spike` target locally. [Phase 1B actual Light Overview source `05cf7fa`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/05cf7fa0bebae8c9fd203f31ffdd66fceee153b6), [verified 136/136 each OS + Windows 8/8](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42080938894); owner physical testing still open.

---


**CURRENT 5 November 2026, 70-MODEL OFFLINE FLEET CATALOGUE:** The normal fictional Qt Quick demo now contains **131 vehicles (121 cars, 10 motorcycles) across 70 distinct models**. The active image map embeds **48 new model-matched Commons candidates**, retains the original model-specific pictures and honestly shows **eight silhouettes** where imagery needs replacement or acquisition. Two poor compositions are withheld. [Executable source `6c1b852`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c1b852cdc5b9b34c820a6a1244131bfb2dc4226) was [verified at 132/132 each native Windows/Linux plus packaged Windows 8/8](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42055392137). Card and inspector photos now preserve the whole model rather than crop it. [Full new verification report](docs/CATALOGUE_70_MODEL_VISUAL_INTEGRATION_NATIVE_VERIFIED_2026-11-05.md) and [active licence credits](catalogue_acquisition/ACTIVE_ASSET_CREDITS.md). This is a fictional owner-review build, not the final accepted aesthetic or a commercial release. Formal owner signoff **45/74, weighted 70.6%, P7 0/8** unchanged; draft PR #17 unmerged and `main` untouched.

---


**HISTORICAL 4 NOVEMBER R0 100-vehicle free portfolio showcase (4 Nov 2026):** Normal no-argument Qt Creator launches include 100 fictional vehicle entries and 12 locally bundled Wikimedia Commons CC0 representative photos, with no subscription or runtime image API. [Verified 130/130 Linux + 130/130 Windows, plus Windows 8/8 QA](docs/PORTFOLIO_100_VEHICLES_FREE_CC0_OFFLINE_NATIVE_VERIFIED_2026-11-04.md) at source [`75b9b8d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/75b9b8d751860dd773e462cc38e29121412f3845), [Actions #41868916532](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41868916532). 90 cars/10 motorcycles, owner can still add temporary demo vehicles; original five-vehicle test fixtures preserved. [Image credits](assets/portfolio/IMAGE_CREDITS.md). Portfolio-only: user photo matching is illustrative, not necessarily an exact year/trim. Physical Qt Creator photo/layout approval open; acceptance ledger stays 45/74, 70.6%, P7 0/8. No commercial rollout, no main changes.

---


**New local development workflow (4 November 2026):** [One-time Qt Creator setup, CMake preset and complete Windows script audit](docs/LOCAL_QT_CREATOR_WORKFLOW_AND_SCRIPT_AUDIT_2026-11-04.md). For everyday changes, use the existing P7 feature branch in GitHub Desktop, pull, then **Build/Run `rental_studio_qtquick_spike`** in the configured Qt 6.10.2 MinGW Qt Creator kit. Do not download a new QA ZIP for every commit. The four existing packaged QA verification scripts are still required by GitHub Actions; no redundant tracked batch file was identified. Actual local MinGW validation and UX-CTRL-002 physical owner acceptance remain OPEN. The older historical compiled-source references below are not the latest checkpoint; follow [LATEST_CHECKPOINT](docs/LATEST_CHECKPOINT.md).

---


**Current project audit: 2 November 2026. This is a development project, NOT a commercial release.** [Latest checkpoint](docs/LATEST_CHECKPOINT.md) | [Full current documentation audit](docs/FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md) | [Roadmap](docs/ROADMAP.md) | [Formal acceptance](docs/P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | [Testing](docs/TESTING.md).

## Application

Offline-first native Qt Quick/QML desktop application with real C++ domain services: **Overview** (operational KPIs, due/overdue and booked value), **Fleet** (original generic car/motorcycle illustration, Gallery/Table, search/filter/sort, Inspector, vehicle actions), and **Rentals** (explicit quote, fictional booking, duplicate/stale/no-write safeguards, active/return/history/archive). The approved design direction is Midnight Navy, Emerald Teal, Cloud White, Ice Blue and Soft Mint. Historical Qt Widgets UI remains the domain/behavior reference and is not the intended final aesthetic.

The current portable Qt build runs with **generated fictional files only**. It is not a local-business multiuser platform, financial payment system or production data importer. Do not enter or upload real customer, phone or driving-licence information. Active booked contract value does not claim collected revenue.

## GitHub review and latest verified source

Source development remains on [draft P7 PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), stacked over P6 #14, P5 #12 and P4 #10, all unmerged with main unchanged. Latest compiled source [P7-J 6224a0f](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6224a0fcdf7c879f64d677472e073d3037bcd7a8) passed [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41471605002) and [Qt 6.8.3 Linux/Windows native 111/111 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41471604730); Windows package checks also passed.

### Storage boundary

The default app still uses protected fictional `RentalSystem` + QSaveFile text storage. P7-G verifies a SQL blob transport for real services, P7-H normalized typed SQLite, P7-I a separate QML/SQLite command preview, and [P7-J shared read model](docs/P7_J_SHARED_RENTALS_READ_MODEL_QT_SQL_NATIVE_VERIFIED_2026-11-02.md) the **existing RentalListModel** on validated SQLite snapshots with post-commit refresh. All P7 SQL remains in opt-in synthetic test code; **no commercial contact/import paths** or normal application SQL cutover.

## Evidence and remaining gates

The accepted planning ledger is now **45 of 74 criteria, 70.6% weighted evidence**, including [P5 8/8 owner signoff](docs/P5_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md) and [P6 9/9 owner signoff](docs/P6_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md) on 3 November. P7 0/8 still requires separate acceptance and/or integration; P5 original eight functional outcomes have owner approval while physical Windows/assistive QA remains open; P8 installer and P9 release QA not started. Hosted CI is not physical Qt Creator MinGW/Windows 100/125/150% or Narrator acceptance. No merge, release, production data or official installation is approved. [Windows physical checklist](docs/WINDOWS_ACCEPTANCE.md) and [P6-P polished UI report](docs/P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md) describe the consolidated future owner session.

## Working and documentation rules

The [date-neutral AI continuation prompt](docs/AI_CONTINUATION_PROMPT.md) is designed to recover live branch SHA, source evidence and owner decisions on each session. Historical 29/30 October reports remain for audit but are not live P7 status. Prefer a short verified checkpoint over appended legacy banners; only record new acceptance when supported by explicit criteria and owner review.
