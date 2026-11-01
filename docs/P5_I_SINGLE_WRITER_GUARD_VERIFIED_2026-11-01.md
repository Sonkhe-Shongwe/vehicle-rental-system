# P5-I | Concurrent Fictional Session Access Guard
**1 November 2026 | Draft PR #12 | Verified source `e7ac2f5d1b6d10a863e4290e81460636431f087c`**

## Concrete risk and scope

An opt-in `--persistent-fictional-demo` instance reopens a fixed, application-owned fictional rental ledger. `QSaveFile` guarantees atomic replacement of one write but does **not** serialize two independently running application instances. With both processes holding their own in-memory `RentalSystem` snapshots, one could overwrite the other's subsequently committed booking. General production storage and real contacts are **not enabled**.

## Focused changes

1. [`869553c`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/869553c3c638cf11764519b459a0373f52a95112): `P5SyntheticSession::open` and test cleanup acquire a Qt `QLockFile` retained for process lifetime. A competing app refuses before loading the shared ledger. The lock file resides beside, not inside, the strict synthetic fixture directory; the existing three-file allowlist and SHA-pinned demo source checks remain unchanged. Stale-by-age takeover is disabled so a legitimately long-running instance does not lose its lease. The normal disposable preview remains unaffected.
2. [`e7ac2f5`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/e7ac2f5d1b6d10a863e4290e81460636431f087c): Existing native P5 session-tamper test launches a **second real executable process** with a single-purpose probe. It only succeeds if the child specifically sees the concurrent-process refusal, while the parent continues with existing foreign-file, fictional contact, double-active-vehicle and byte-exact recovery checks. No assertions or existing test cases were removed.

## Verified CI at exact source `e7ac2f5`

| Gate | GitHub Actions | Observation |
|---|---|---|
| Core C++ and legacy domain | [41313977827](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41313977827) | **13/13 PASS**, completed |
| Native Qt Quick Linux GCC 6.8.3 | [41313977777](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41313977777) | **60/60 CTests PASS**, including `rental_studio_p5_session_tamper` |
| Native Qt Quick Windows Server 2022 MSVC 6.8.3 | Same run | **60/60 CTests PASS**, including `rental_studio_p5_session_tamper` |
| Relocated Windows fictional acceptance kit | Same run | P4 packaged checks PASS under PowerShell 7 and Windows PowerShell 5.1. Physical Narrator and owner device NOT TESTED. |

The preceding source-only workflow attempt for `869553c` was superseded/cancelled after the test commit; it is **not** cited as a passed native run. All passing claims here are from the complete later run.

## Remaining gates and continuity

P5's eight original groups retain representative automated evidence in [P5 crosswalk](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md), with additional protection against simultaneous persistent fictional sessions. Formal acceptance **remains P5 0/8** pending a consolidated owner-facing functional/visual review. P4 remains **5/7**, held for owner physical Narrator/Windows scaling/accessibility and design signoff. Programme accepted criteria remain **28/74**, 40.6% evidence-weighted coverage, **not** actual product completeness.

Keep [PR #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12) a draft stacked on unmerged [PR #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10). Never merge or change stable main without explicit authorization. Preserve synthetic only and existing safety constraints. Next: prepare a single consolidated P4/P5 owner-facing walkthrough from verified real Qt screenshots/native artifacts, fix any demonstrable UI defects, then assess P6 roadmap parity without treating unaccepted criteria as complete. No repeated PowerShell commands are requested of the owner.
