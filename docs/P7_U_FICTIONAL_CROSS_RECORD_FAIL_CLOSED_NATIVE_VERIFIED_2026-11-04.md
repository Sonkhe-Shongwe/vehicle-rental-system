# P7-U | Fictional SQLite cross-record fail-closed integrity: native verified

**Verification date:** 4 November 2026 (Africa/Johannesburg).  
**Actual compiled and tested source:** [`680df6bb6e4f68a2664de62803ac8f3d428422f7`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/680df6bb6e4f68a2664de62803ac8f3d428422f7).  
**Exact-source GitHub Actions:** [run #41853608167](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41853608167), **completed SUCCESS**, matching the commit SHA exactly.  
**Branch:** `feature/p7-sqlite-sandbox-20261102`, still stacked [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) on P6.  
**Authorization:** P7 D1 owner-approved opt-in **generated-fictional SQLite integration only**. No D2–D8 production-data approval.

## 1. Why the new guard was needed

In the existing P7 normalized repository, individual SQLite vehicle/rental rows were validated and combined within a consistent read transaction. However SQLite schema v1 allows an external writer to mark a vehicle RETIRED while its rental is ACTIVE, and a separate connection with foreign keys disabled may introduce an orphaned historical rental. SQLite `PRAGMA integrity_check` can still report `ok` for the first state, even though this violates the application's business rules. Without a cross-record validation, Fleet availability, Rentals and Overview could mistakenly present inconsistent records as verified.

## 2. Source implementation

- `src/application/p7_sandbox/sqlite_repository.h`: `Repository::fleetRows()` now checks its **single transactional snapshot** before COMMIT. All rental vehicle IDs must exist. An ACTIVE rental requires an ACTIVE (not RETIRED) vehicle and no duplicate active occupancy. Violations return no snapshot, never a partial or apparently verified one. The path does **not** mutate or silently repair any record.
- `src/application/p7_sandbox/sqlite_read_projection.h`: `ReadProjection::rentals()` now uses the same cross-validated `fleetRows()` as the Fleet projection. This prevents publishing a rental view from a row-only read when the corresponding vehicle relationship is inconsistent. The authoritative SQL repository and Qt/C++ read DTOs remain separate from QML.
- `tests/p7_sandbox/p7_normalized_repository_tests.cpp` and `tests/p7_sandbox/CMakeLists.txt`: a new native CTest `rental_studio_p7_normalized_cross_record_integrity` creates a temporary generated-fictional DB with C001 and R001, verifies valid snapshot views, deliberately injects ACTIVE-on-RETIRED corruption through a separate disposable SQLite connection, checks that Fleet **and** Rentals reject it even though SQLite integrity still passes, repairs and verifies recovery, then injects an orphaned rental by deliberately disabling foreign keys on the test-only connection, verifies both reads refuse it, repairs, and verifies recovery and unchanged exact `.fictional-only` marker. No real data or general import path is available.

## 3. Exact-source native results

| Gate | Environment | Result |
|---|---|---|
| Full CTest matrix | Ubuntu 24.04 GCC / Qt 6.8.3 | **128/128 PASS**, 0 failed; 167.69 seconds |
| Full CTest matrix | Hosted Windows Server 2022 MSVC / Qt 6.8.3 | **128/128 PASS**, 0 failed; 192.65 seconds |
| New CTest #125 | Linux and Windows | **PASS** on both, including semantic corruption and recovery |
| Prior UX-CTRL-002/003 regressions | Linux and Windows, wide/compact | Preserved in complete passing matrix |
| Relocated Windows fictional application checks | Hosted Windows | **8/8 PASS** |
| Windows PowerShell 5.1 packaged checks | Hosted Windows | **PASS** |

**Run evidence:** [Linux job #126656229899](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41853608167/job/126656229899) and [Windows job #126656229783](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41853608167/job/126656229783) both record `100% tests passed, 0 tests failed out of 128`. Windows job explicitly records `ALL 8 REAL APP FUNCTIONAL CHECKS PASSED` and `P4 Windows PowerShell 5.1 subprocess verification PASS`. GitHub Actions finished successfully on the exact source commit, with no corrected intermediate failed run for this increment.

Three workflow artifacts were confirmed existing, **not downloaded or visually inspected** during P7-U verification:
- Windows QA kit `p2-windows-physical-acceptance-kit`, artifact **13336972098**.
- Windows screenshots `p2-qtquick-windows-screenshots`, artifact **13337276490**.
- Linux screenshots `p2-qtquick-linux-screenshots`, artifact **13335934473**.

## 4. Scope and what remains unapproved

The normal Overview/Fleet/Rentals remain a protected fictional QSaveFile demo. Opt-in P7 SQLite is **generated fictional-only**, with no real customer contacts, driver's licences, payments, operational storage, legacy migration, production backup/retention path, installer, or automatic cutover.

The owner said UX-CTRL-003 "**I think it feels okay**" after the previous physical navigation review. Record this as **positive qualitative feedback**, not a full acceptance of Narrator, 100/125/150% OS scaling, contract visual quality or fresh recorded MinGW CTests.

**Formal owner acceptance remains 45/74 criteria, fixed-weight 70.6%; P5 8/8, P6 9/9, P7 0/8.** D2 pricing ceilings, D3 historic identifier policy, D4 retention/deletion, D5 real contact privacy, D6 durable backup/encryption/location, D7 import/cutover and D8 release acceptance remain **open**. Do not silently turn continued fictional engineering into approval for any of these decisions.

**Next milestone:** continue only bounded generated-fictional architecture validation or present the pending D2–D8 decision brief for explicit owner choices. Do not merge PR #17 or touch stable `main` without direct authorization. For daily local work, continue **GitHub Desktop Pull -> Qt Creator Build/Run**, without another portable QA ZIP download.
