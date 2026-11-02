# Rental Studio 2.0 | Current verification and test policy

**Reconciled 2 November 2026.** [Current source](LATEST_CHECKPOINT.md) | [full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md) | [formal acceptance](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md).

## Verification levels are not interchangeable

**Designed** ≠ **source implemented** ≠ **compiled** ≠ **native CTest PASS** ≠ **actual hosted Windows Qt screenshot inspected** ≠ **owner physical Windows/MinGW/Narrator checked** ≠ **formal signoff** ≠ **commercial release**. Always tie a result to its exact source SHA, CI job, Qt/OS kit, test scenario, fixture and safety boundary. Treat a documentation-only green run as scope inspection, not freshly verified compiled source.

## Current exact source baseline

| Evidence | Result | Boundary |
|---|---|---|
| [P7-L `3108849`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3108849ab571c63355ca87703e307a6b22f9bc85) | [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41477526035) PASS | Exact source C++ regressions |
| Same source | [native Qt 6.8.3 Linux/hosted Windows 112/112 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41477526173) PASS, Linux GCC | Full native suite including Fleet snapshot concurrency and QML |
| Same source | [native Qt 6.8.3 Linux/hosted Windows 112/112 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41477526173) PASS, hosted Windows MSVC | Full real Windows QPA, not physical owner MinGW |
| Same Windows native run | Packaged PowerShell 7 and Windows PowerShell 5.1 verification **PASS** | Disposable hosted kit, not an installed commercial product |
| [P6-P final Qt UI](P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md) | Earlier P6 source bfb591c: **74/74 native per OS**, compiled 1500×860 and 1280×720 screenshots inspected | One consolidated owner OS/device acceptance remains open |
| [P7-G](P7_G_CPP_DOMAIN_SQLITE_TRANSPORT_NATIVE_VERIFIED_2026-11-02.md) | Three test cases #101–103 verify real C++ quote/book/return/archive through a generated-fictional SQLite blob adapter | Does not run in Qt Quick runtime |
| [P7-H](P7_H_NORMALIZED_SQLITE_REPOSITORY_NATIVE_VERIFIED_2026-11-02.md) | Five tests #104–108 verify normalized typed rows, rollback, money/IDs, future schema, writer contention | OFF-by-default test target, no commercial contact records or application cutover |
| [P7-I Qt Quick/normalized SQL preview](P7_I_QTQUICK_NORMALIZED_REPOSITORY_PREVIEW_NATIVE_VERIFIED_2026-11-02.md) | Two new genuine Qt Quick UI CTests #109–110: fictional full lifecycle + rollback/no false receipt/reopen | Separate OFF-by-default test executable; not the normal Overview/Fleet/Rentals application |
| [P7-J shared read-model verification](P7_J_SHARED_RENTALS_READ_MODEL_QT_SQL_NATIVE_VERIFIED_2026-11-02.md) | Native #109–111 verify shared Rentals read/selection and Fleet projection | Only opt-in fictional SQL preview |
| [P7-K native verified report](P7_K_SNAPSHOT_FAILURE_VISIBLE_NATIVE_VERIFIED_2026-11-02.md) | Prior native #111 tests failure-visible Rentals metrics and Qt Quick retry | No production SQL storage or P7 approval |
| [P7-L consistent Fleet SQLite snapshot](P7_L_FLEET_SNAPSHOT_NATIVE_VERIFIED_2026-11-02.md) | New native #109/112 tests Fleet snapshot consistency while a second independent connection attempts to commit a return; retry then succeeds | Only opt-in fictional SQLite, no production cutover |

The P7 test suite is opt-in via **BUILD_P7_SQLITE_SANDBOX=ON**. Its repository implementation is under src/application/p7_sandbox for future adaptation, but it is **only compiled and linked in the test target** today. The normal Qt Quick executable does not link QtSql or use the candidate normalized repository.

## Efficient GitHub Actions policy

Both .github/workflows/ci.yml and .github/workflows/p2-qtquick-review.yml use a lightweight head-to-head PR revision classifier in tests/ci_change_scope.py. On synchronize, **only all-document delta** (docs/ or Markdown-only edits) skips expensive compilation. Code, QML, CMake, workflow YAML or mixed delta runs the full required suites. Open/reopened PR, manual workflow dispatch, main pushes and unknown/ambiguous SHAs fail closed to full suites. The native workflow does not cancel an active source-validation run for a later docs-only change.

**Verified CI behavior:** [code-change core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41421348619), [code-change Linux/Windows 100/100](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41421348736), [docs-only core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41421474097) and [docs-only native](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41421474110) passed lightweight inspection while skipping expensive source jobs. The most recent [P7-H docs-only scope runs](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41461103640) also skipped native builds by design. Prefer focused local tests while editing; keep full regression for meaningful code changes and release candidates.

## Safety and physical acceptance gate

Use fictional temporary or pinned fixtures only, with tamper refusal and immutable original bytes. No real name/phone/licence data, arbitrary file import, commercial migration, destructive true rental history cleanup or production SQLite path may be introduced without owner approval. Synthetic processes and rollback tests do not prove power-failure/disk-full protection or licensed imagery.

**Physical Windows outstanding:** owner's Qt Creator 6.10.2 MinGW local exact SHA/CTest, real display 100/125/150% where supported, logical window fit at actual taskbar resolution, keyboard Tab/Shift+Tab/arrow/Enter/Space/Escape, Narrator names and live announcements, visual clipping/focus recovery, portable-kit use and final operator acceptance. User's historical Windows Settings screenshot verified **150% Recommended / 1920×1080**, but not a matching full in-app rendering/assistive check; historical Fleet screenshots showed two static filters and occupancy. [Owner Windows checklist](WINDOWS_ACCEPTANCE.md) keeps observations separate from required manual tests.

**Acceptance boundary:** P1 7/10, P2 4/6, P4 5/7, P5 0/8, P6 0/9, P7 0/8; total 28/74 and **40.6%** weighted accepted; P8/P9 not started. No automatic test increments formal counts.

## Historical test reporting

Individual dated P2/P3/P4/P5/P6/P7 milestone files contain exact earlier tests, failures and fixes. [30 October full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) and [archived test policy](archive/TESTING_PRE_CANONICAL_AUDIT_2026-10-30.md) preserve original context. Use them as dated evidence, not a competing latest test count.
