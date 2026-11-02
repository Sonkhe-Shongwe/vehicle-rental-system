# Rental Studio 2.0 | Active P0–P9 roadmap

**Live planning checkpoint 2 November 2026.** [Canonical current state](PROJECT_STATE_CANONICAL.md), [latest source/evidence](LATEST_CHECKPOINT.md), [full documentation audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md), [formal 74-criterion matrix](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md).

The **planned weights and criterion denominators remain frozen**. Source implementation, test coverage and formally accepted checkmarks are three different things.

| Phase | Weight | Accepted | Actual work status | Next required gate |
|---|---:|---:|---|---|
| P0 Historical safe baseline | 5% | 5/5 | Accepted | Preserve evidence |
| P1 Whole-product design | 12% | 7/10 | Selected navy/teal direction; polished Qt UI | Model-appropriate licensed imagery, accessibility and final owner design review |
| P2 Native Qt/C++ feasibility | 10% | 4/6 | Hosted native tests; earlier local Qt Creator P2 observations | Physical Windows current app, exact SHA/MinGW/keyboard and supported OS scaling |
| P3 Typed C++ domain | 12% | 7/7 | Accepted | Preserve invariants |
| P4 Shared native UI/focus | 12% | 5/7 | Components/motion tested | Owner physical keyboard/Narrator/accessibility |
| P5 Booking vertical slice | 16% | 0/8 | All 8 original expectations have representative automated evidence | Consolidated operator signoff of original eight |
| P6 Full Fleet/Rentals lifecycle | 14% | 0/9 | Polished interface, 8 scoped groups covered, 9th integrated path tested | Ratify bounded nine-point rubric and operator/physical parity review |
| P7 Reliable commercial storage | 9% | 0/8 | Synthetic P7-A–L: typed SQLite, separate real QML command path, shared Rentals model handles failed reads/retry and Fleet consumes consistent vehicle/rental SQL transactions; normal app not switched | Owner business/privacy ADR, actual main app controller integration, secure backup/migration and physical acceptance |
| P8 Offline Windows installer | 5% | 0/6 | Not started; CI portable kit is NOT installer | Build/run/uninstall/update/rights/privacy tests on clean offline Windows |
| P9 Final product QA/release | 5% | 0/8 | Not started | Final real device 100/125/150%/Narrator/performance, security/data policy, exact-SHA CI, owner release authorization |

**28/74 accepted, weighted 40.6%; NOT released.** The percentage reflects approvals and evidence-weighting, not how much product code exists.

## Immediate delivery order

1. **Decision gate:** consolidate [P7 storage ADR draft](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md) and [candidate eight criteria](P7_A_MIGRATION_AND_TEST_CONTRACT_2026-11-02.md). Approve data protection, exact money and lifecycle semantics before commercial runtime integration.
2. **Actual product integration:** [P7-J shared read-model verification](P7_J_SHARED_RENTALS_READ_MODEL_QT_SQL_NATIVE_VERIFIED_2026-11-02.md), [P7-K native verified report](P7_K_SNAPSHOT_FAILURE_VISIBLE_NATIVE_VERIFIED_2026-11-02.md) and [P7-L consistent Fleet SQLite snapshot](P7_L_FLEET_SNAPSHOT_NATIVE_VERIFIED_2026-11-02.md) prove reusable Rentals KPIs/filter/selection, visible failed-read retry and consistent Fleet occupancy in opt-in fictional SQL, not main `Main.qml`. After approving business/privacy/retention policies, integrate actual Overview/Fleet/Rentals command services with typed SQL in a controlled fictional-only app mode, preserving default behavior.
3. **Operator acceptance batch:** one substantial physical Windows/P1/P2/P4/P5/P6 review once the application candidate is sufficiently polished; preserve PASS/FAIL/NOT TESTED for each item.
4. **Distribution then release:** P8 genuine installer and clean-offline deployment tests, P9 final physical, privacy/licensing, robustness and owner approval.
5. Resolve draft PR stack (#10, #12, #14, #17) only by explicit authorized review; no force push or direct main merge during development.

See [P6-P reviewed UI](P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md), [P7-G C++ bridge](P7_G_CPP_DOMAIN_SQLITE_TRANSPORT_NATIVE_VERIFIED_2026-11-02.md), [P7-H normalized candidate](P7_H_NORMALIZED_SQLITE_REPOSITORY_NATIVE_VERIFIED_2026-11-02.md), [exact compiled runs: native](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622338) and [core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622337). The 30 October roadmap snapshots and milestone history remain in Git history and dated reports, rather than competing in this live file.
