# P5: Eight-criterion Automated Evidence Crosswalk

**P5 formal owner signoff, 3 November 2026:** [all eight original criteria owner accepted](P5_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md), P5 **8/8**, total **36/74**, weighted **56.6%**. Last verified compiled source `8a7a1ed`, [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964414), [Linux/Windows native 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095). The 40.6% remarks in earlier 2 Nov reports are historic. This signoff does not certify physical Windows Qt Creator/MinGW, 100/125/150% scaling, Narrator, commercial data, release or PR merges.

**Historical scope:** Below, the original 1–2 Nov `0/8` descriptions document the pre-signoff state; the 3 Nov owner decision supersedes only those acceptance claims, not the underlying test-to-criterion mapping.

**Current 2 November 2026 audit:** The original eight expectations remain mapped to representative native tests; the P6-P polished UI and P7-H opt-in test source passed [108/108 per hosted platform](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41459622338). This verifies regression coverage, **not P5 owner acceptance**. Formal P5 remains **0/8**. Original source-to-test table below is a dated trace, not a new set of criteria.
**Updated 1 November 2026.** This is a source-to-test crosswalk, NOT owner formal acceptance.

## Meaning of this matrix

The original [P5 tracking issue #13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/13) lists eight operator/business behavior acceptance expectations. The following mapped native tests pass on hosted Linux GCC and Windows MSVC Qt 6.8.3 at [run 41302083630](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41302083630), with the core suite [41302083582](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41302083582). In this table **Automated PASS** means the criterion has representative compiled automated evidence, not that every user/device failure mode or the full P5 milestone has passed physical owner acceptance.

| P5 original acceptance expectation | Automated evidence on real native Qt | Current evidence status |
|---|---|---|
| 1. Corolla available and selected in native UI | `rental_studio_p5_fleet_booking_wide/compact` selects C001 through authoritative C++ Fleet inspector, enables the booking CTA | Automated PASS; formal owner review pending |
| 2. Guided validated input and authoritative R450/day x 3 quote | `rental_studio_p3_booking_qml_wide/compact`, `rental_studio_p5_fleet_booking_*`, `rental_studio_p5_stale_quote_*` quote/review/invalid field checks | Automated PASS; owner UX review pending |
| 3. Explicit confirmation saves rental through domain-owned atomic persistence | `rental_studio_p5_ui_session_seed`, `rental_studio_p3_booking_qml_*`, `rental_studio_p5_fleet_booking_*` real C++ confirm/receipt/ledger | Automated PASS; not general production storage |
| 4. Overview, Fleet, Rentals reconcile after commit | `rental_studio_p5_overview_wide/compact`, `rental_studio_p5_fleet_booking_*` aggregate, occupancy and active count | Automated PASS; visual acceptance pending |
| 5. Restart/reopen reconstructs saved rental and availability | `rental_studio_p5_ui_session_seed` and `_reopen` use two **separate actual native Qt executable processes** in opt-in fictional-only fixed session | Automated PASS; only explicit fictional opt-in, no real data |
| 6. Duplicate and unavailable booking attempts refuse without second contract | `rental_studio_p5_ui_session_reopen`, `rental_studio_p5_session_reopen`, `rental_studio_p5_stale_quote_*` | Automated PASS; broader stress/concurrency not approved |
| 7. Cancel, declined and invalid booking never write or issue receipt | `rental_studio_p5_booking_cancel_wide/compact` (Cancel, Escape, declined), `rental_studio_p3_booking_qml_*`, `rental_studio_p5_stale_quote_*` | Automated PASS; owner final UX signoff pending |
| 8. Injected durable-write failure refuses and preserves original state | `rental_studio_p5_ui_write_failure_wide/compact` uses rejecting `RentalStorage` writer and asserts original bytes/occupancy/no receipt | Automated PASS; broader power-failure durability out of scope |

## Constraints that remain in force

- **Do not convert this crosswalk into eight formally accepted checkboxes.** P5 stays **0/8 formally accepted** while acceptance methodology, owner physical interface review and complete milestone closure remain open.
- The protected source files are **SHA-256 pinned fictional demos**; ordinary preview works only on disposable temporary copies; opt-in `--persistent-fictional-demo` runs a restricted, fixed-location synthetic-only session with strict contact allowlisting. No general customer storage, arbitrary data import, production payments or P7 migration.
- Draft PR #12 is based on **unmerged** Draft PR #10. Stable `main` remains protected and unchanged.
- Hosted Windows MSVC CI **does not replace** owner physical Qt Creator 6.10.2 MinGW, Narrator/live screen reader, 100/125/150% scaling and design signoff. The owner asked to consolidate physical review rather than run repetitive PowerShell test rounds.

## Next practical handoff

With the eight behavior groups now represented in automation, prioritise a **consolidated P5 product review/reliability assessment**: audit precise acceptance rubric and critical negative paths, identify only genuine remaining holes, and prepare a single owner-facing visual signoff when valuable. Do not prematurely close P5 or begin P6/P7 writes without following the separate approval gates. Continue feature improvements only where they address demonstrable user-facing defects.
