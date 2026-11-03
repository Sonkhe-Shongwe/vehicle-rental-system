# P6 | Formal owner approval of nine bounded fictional-data lifecycle criteria

**Decision date:** 3 November 2026, Africa/Johannesburg.  
**Scope of owner statement:** After being asked whether they approved **all nine proposed P6 criteria and the explicitly described intentional Qt Quick design differences, based on the verified evidence**, the owner replied **"i approve"**. This is explicit ratification of the P6-N/O proposed nine-group interpretation and formal acceptance of **P6-01 through P6-09** within the **fictional-data desktop-quality** scope. It is **not** a statement that physical Windows/MinGW/Narrator tests were performed, that production record deletion/retirement/privacy rules are authorized, or that a product release, installer, PR merge or customer-data cutover is approved.

## Verified source / exact evidence

- **Native-compiled Qt/C++ source:** [`8a7a1ed587b05775d1528868b1db593ce73384d3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8a7a1ed587b05775d1528868b1db593ce73384d3), latest tested code incorporated by stacked draft PR #17. Later docs-only heads do not constitute new compiled evidence.
- [Core 13/13 PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964414). [Native Qt 6.8.3 **Linux GCC 115/115** and hosted **Windows MSVC 115/115** PASS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095). Relevant genuine CTests include `rental_studio_p6_fleet_add_wide/compact`, `p6_fleet_remove_wide/compact`, `p6_archived_delete_wide/compact`, `p6_integrated_wide/compact`, `p6_cross_process_wide/compact`, P2 Gallery/Table focus/arrow tests, P3 return/archive tests, P5 Overview tests, and P6 recent-activity / contract-detail tests. Existing broad lifecycle tests run real **independent native Qt processes** and guarded fictional persistence.
- [Nine-group bounded proposal / decision packet](P6_CONSOLIDATED_OWNER_ACCEPTANCE_REVIEW_2026-11-03.md); [P6-N technical reconciliation](P6_N_ACCEPTANCE_CLOSURE_DECISION_RECORD_2026-11-02.md); [P6-O intended parity and privacy boundaries](P6_O_RESEARCH_REVISED_ACCEPTANCE_AND_FLEET_2026-11-02.md); [P6-I 22-row legacy parity audit](P6_I_LIFECYCLE_PARITY_AUDIT_2026-11-01.md); [P6-M integrated three-process proof](P6_M_THREE_PROCESS_INTEGRATED_NATIVE_VERIFIED_2026-11-02.md).
- The original P6 phase specified **nine acceptance units but did not independently enumerate them**. The owner is explicitly approving the **existing P6-01 through P6-09 bounded mapping** rather than implying that those nine labels were in the original text. The phase weight and total criterion count are unchanged.

## Owner-approved dispositions, all evidence-backed

| ID | Bounded fictional-data criterion | Owner decision |
|---|---|---|
| P6-01 | Validated Car and Motorcycle creation, invalid/duplicate refusal, committed refresh | **ACCEPTED** |
| P6-02 | Fleet Gallery/Table search, filter, sort and stable keyboard-aware selection | **ACCEPTED** |
| P6-03 | Safe Fleet removal, active/history reference guards and exact fictional confirmation | **ACCEPTED** |
| P6-04 | Authoritative active/overdue status and navigation | **ACCEPTED** |
| P6-05 | Return by rental or vehicle ID, explicit confirmation, missing/repeated refusal | **ACCEPTED** |
| P6-06 | Return → archive → explicitly confirmed deletion of eligible **disposable fictional** archived records only; no cascade | **ACCEPTED** |
| P6-07 | Cancel/Escape/decline/invalid and injected failed-write nonmutation, no false success | **ACCEPTED** |
| P6-08 | Independent native-process reconstruction of Fleet, Rentals, Overview in allowlisted fictional session | **ACCEPTED** |
| P6-09 | Bounded complete lifecycle path and **functional** legacy parity with recorded intentional Qt Quick differences | **ACCEPTED** |

### Exactly what P6-09 acceptance means

- Keep the approved task-first **Overview/Fleet/Rentals** navigation instead of copying every old Qt Widgets page.
- Use authoritative Fleet **Cars / Motorcycles / N of M currently rented** summary; this is a present-moment occupancy snapshot, **not** fabricated historical utilization or paid revenue.
- Keep four **recent contracts ordered by start date**, not a fictionalized return/archive audit-event timeline.
- Present selected rental dates, days, status and booked amount in a privacy-minimized read-only dialog without general name/phone/driver-licence roles. Future real-data contact views require separate privacy/purpose approval.
- Keep the guided authoritative quote + explicit Confirm/Cancel flow even when its visual composition differs from legacy Widgets.
- Permit guarded hard removal/archived deletion only under the expressly **fictional disposable** policy. No general commercial retirement/history-retention/deletion choice has been made.

## Official unchanged-denominator acceptance calculation

Previous (after 3 November P5 approval): P0 **5/5**, P1 **7/10**, P2 **4/6**, P3 **7/7**, P4 **5/7**, P5 **8/8**, P6 **0/9**, P7 **0/8**, P8 **0/6**, P9 **0/8** = **36/74, 56.6% weighted**.

New: **P6 9/9 owner accepted (14% phase contribution)**, total **45/74 formally accepted** and weighted `5 + 12*7/10 + 10*4/6 + 12 + 12*5/7 + 16 + 14 = 70.638095…%`, displayed **70.6%**. P7 through P9 remain **0 accepted**, P1/P2/P4 remain partially accepted. Weighted formal acceptance is **not** percentage of product code completed, or release readiness.

## Explicit outstanding gates

1. **NOT PHYSICALLY TESTED / OWNER DEVICE CHECK OPEN:** exact source Qt Creator **6.10.2 MinGW**, supported real Windows OS scale **100/125/150%**, physical keyboard/focus ergonomics, Narrator and whole-product accessibility/visual review. Hosted native MSVC is not MinGW, and simulated DPI is not actual physical OS scaling. These are tracked under independent P1/P2/P4/final QA.
2. **P7 real-data rules UNAPPROVED:** production non-destructive vehicle retirement, historical record retention and lawful disposal, customer contact/driver-licence data, stable commercial IDs, exact-money limits, backup/migration and default SQLite cutover. Current opt-in P7 SQLite Lab is D1 **generated-fictional only**. P6 acceptance does not authorize real records, silent archived history deletion, or a production data policy.
3. **NO PR MERGE / INSTALLER / RELEASE:** Draft stack #10/#12/#14/#17 stays unmerged. No changes to main, tags, packaging/release authorization, or P8/P9 signoff are implied.
4. Historical 2 November and the **pre-approval** P6 review packet's `0/9` and `56.6%` descriptions remain true of their earlier state, **superseded** for the present acceptance ledger by this dated owner decision.

**Next evidence-based acceptance work:** assess whether remaining **P1/P2/P4** physically testable requirements can be bundled for an actual device review; separately review **P7** fictional technical candidates versus its expressly unapproved production policy and future release/installer track. Do not manufacture another percentage increase from green CI.
