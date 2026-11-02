# Rental Studio 2.0 | Current verification and test policy

**Reconciled 2 November 2026.** [Current source](LATEST_CHECKPOINT.md) | [full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md) | [formal acceptance](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md).

## Verification levels are not interchangeable

**Designed** ≠ **source implemented** ≠ **compiled** ≠ **native CTest PASS** ≠ **actual hosted Windows Qt screenshot inspected** ≠ **owner physical Windows/MinGW/Narrator checked** ≠ **formal signoff** ≠ **commercial release**. Always tie a result to its exact source SHA, CI job, Qt/OS kit, test scenario, fixture and safety boundary. Treat a documentation-only green run as scope inspection, not freshly verified compiled source.

## Current exact source baseline

| Evidence | Result | Boundary |
|---|---|---|
| [P7-O `4c63b6a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/4c63b6a34240c2c762f14976b928f5fb7b54078b) | [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41491428956) PASS | Exact source Linux C++ core regression |
| Same source | [native Qt Linux/hosted Windows 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41491428682) PASS, Linux GCC Qt 6.8.3 | 115/115 native CTests, including 2 new actual-app SQLite Lab scenarios |
| Same source | [native Qt Linux/hosted Windows 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41491428682) PASS, hosted Windows MSVC Qt 6.8.3 | 115/115 native QPA tests, not owner physical MinGW |
| Same Windows native run | Packaged PowerShell 7 and Windows PowerShell 5.1 verification **PASS** | Disposable hosted kit, not an installed commercial product |
| [P6-P final Qt UI](P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md) | Earlier P6 source bfb591c: **74/74 native per OS**, compiled 1500×860 and 1280×720 screenshots inspected | One consolidated owner OS/device acceptance remains open |
| [P7-G](P7_G_CPP_DOMAIN_SQLITE_TRANSPORT_NATIVE_VERIFIED_2026-11-02.md) | Three test cases #101–103 verify real C++ quote/book/return/archive through a generated-fictional SQLite blob adapter | Does not run in Qt Quick runtime |
| [P7-H](P7_H_NORMALIZED_SQLITE_REPOSITORY_NATIVE_VERIFIED_2026-11-02.md) | Five tests #104–108 verify normalized typed rows, rollback, money/IDs, future schema, writer contention | OFF-by-default test target, no commercial contact records or application cutover |
| [P7-I Qt Quick/normalized SQL preview](P7_I_QTQUICK_NORMALIZED_REPOSITORY_PREVIEW_NATIVE_VERIFIED_2026-11-02.md) | Two new genuine Qt Quick UI CTests #109–110: fictional full lifecycle + rollback/no false receipt/reopen | Separate OFF-by-default test executable; not the normal Overview/Fleet/Rentals application |
| [P7-J shared read-model verification](P7_J_SHARED_RENTALS_READ_MODEL_QT_SQL_NATIVE_VERIFIED_2026-11-02.md) | Native #109–111 verify shared Rentals read/selection and Fleet projection | Only opt-in fictional SQL preview |
| [P7-K native verified report](P7_K_SNAPSHOT_FAILURE_VISIBLE_NATIVE_VERIFIED_2026-11-02.md) | Prior native #111 tests failure-visible Rentals metrics and Qt Quick retry | No production SQL storage or P7 approval |
| [P7-L consistent Fleet SQLite snapshot](P7_L_FLEET_SNAPSHOT_NATIVE_VERIFIED_2026-11-02.md) | Native #109/112 tests Fleet snapshot consistency with competing return; retry succeeds | Only opt-in fictional SQLite |
| [P6-Q cross-workspace Fleet search shortcut](P6_Q_FLEET_QUICK_FIND_NATIVE_VERIFIED_2026-11-02.md) | Existing native focus-route tests verify modal-safe Ctrl+F | Normal fictional app, not owner physical Windows signoff |
| [P7-M impossible return-date read guard](P7_M_RETURN_DATE_READ_GUARD_NATIVE_VERIFIED_2026-11-02.md) | Native `rental_studio_p7_normalized_invalid_return_date` refuses impossible historical return dates | Opt-in fictional SQL only |
| [P7-N real QML Fleet SQL projection](P7_N_REAL_QML_FLEET_SQL_PROJECTION_NATIVE_VERIFIED_2026-11-02.md) | Strengthens existing real QML journey/rollback/read-model native tests; Fleet now displays transactional C++ SQL-derived availability and hides/retries failed reads | Only isolated generated-fictional test executable; no normal app SQL cutover |

| [P7-O actual-app SQLite Lab](P7_O_ACTUAL_APP_SQLITE_LAB_NATIVE_VERIFIED_2026-11-02.md) | New `rental_studio_p7_actual_app_lab_wide` and `_compact` native CTests on actual Qt Quick executable prove fictional SQL, rejected COMMIT, post-COMMIT UI, independent reopen and byte-identical legacy files | Limited D1 owner-approved, isolated fourth workspace only |
The P7 integration is compiled only with **BUILD_P7_SQLITE_SANDBOX=ON** (OFF by default). Under that explicit build, the actual Qt Quick executable can link QtSql, but its temporary SQLite Lab is activated only with `--p7-fictional-sql-lab` or a dedicated CI-only test switch. Ordinary launches use the exact prior QSaveFile-backed Overview/Fleet/Rentals workspaces. No customer data, import or commercial database path is enabled.

## Efficient GitHub Actions policy

Both .github/workflows/ci.yml and .github/workflows/p2-qtquick-review.yml use a lightweight head-to-head PR revision classifier in tests/ci_change_scope.py. On synchronize, **only all-document delta** (docs/ or Markdown-only edits) skips expensive compilation. Code, QML, CMake, workflow YAML or mixed delta runs the full required suites. Open/reopened PR, manual workflow dispatch, main pushes and unknown/ambiguous SHAs fail closed to full suites. The native workflow does not cancel an active source-validation run for a later docs-only change.

**Verified CI behavior:** [code-change core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41421348619), [code-change Linux/Windows 100/100](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41421348736), [docs-only core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41421474097) and [docs-only native](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41421474110) passed lightweight inspection while skipping expensive source jobs. The most recent [P7-H docs-only scope runs](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41461103640) also skipped native builds by design. Prefer focused local tests while editing; keep full regression for meaningful code changes and release candidates.

## Safety and physical acceptance gate

Use fictional temporary or pinned fixtures only, with tamper refusal and immutable original bytes. No real name/phone/licence data, arbitrary file import, commercial migration, destructive true rental history cleanup or production SQLite path may be introduced without owner approval. Synthetic processes and rollback tests do not prove power-failure/disk-full protection or licensed imagery.

**Physical Windows outstanding:** owner's Qt Creator 6.10.2 MinGW local exact SHA/CTest, real display 100/125/150% where supported, logical window fit at actual taskbar resolution, keyboard Tab/Shift+Tab/arrow/Enter/Space/Escape, Narrator names and live announcements, visual clipping/focus recovery, portable-kit use and final operator acceptance. User's historical Windows Settings screenshot verified **150% Recommended / 1920×1080**, but not a matching full in-app rendering/assistive check; historical Fleet screenshots showed two static filters and occupancy. [Owner Windows checklist](WINDOWS_ACCEPTANCE.md) keeps observations separate from required manual tests.

**Acceptance boundary:** P1 7/10, P2 4/6, P4 5/7, P5 0/8, P6 0/9, P7 0/8; total 28/74 and **40.6%** weighted accepted; P8/P9 not started. No automatic test increments formal counts.

## Historical test reporting

Individual dated P2/P3/P4/P5/P6/P7 milestone files contain exact earlier tests, failures and fixes. [30 October full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) and [archived test policy](archive/TESTING_PRE_CANONICAL_AUDIT_2026-10-30.md) preserve original context. Use them as dated evidence, not a competing latest test count.
