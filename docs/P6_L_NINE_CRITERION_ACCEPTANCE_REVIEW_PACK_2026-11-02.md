# P6-L | Nine-criterion P6 acceptance review pack and safe sequential operator runbook

**Prepared:** 2 November 2026. **Status:** **CANDIDATE CROSSWALK FOR OWNER/RUBRIC RATIFICATION ONLY**. This is not a newly approved nine-check rubric, a physical test report, a new CI run or formal signoff. **Review reference:** current [P5/P6 reconciliation](P5_P6_ACCEPTANCE_RECONCILIATION_2026-11-01.md), original [P0–P9 progress source](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md), [P6-I 22-row parity audit](P6_I_LIFECYCLE_PARITY_AUDIT_2026-11-01.md), [P6-J](P6_J_RECENT_CONTRACTS_NATIVE_VERIFIED_2026-11-01.md), [P6-K](P6_K_CONTRACT_DETAIL_NATIVE_VERIFIED_2026-11-02.md). Current [P6 Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14) is unmerged on P5 Draft #12/P4 Draft #10.

The **actual original P6 text** is: “Add Car/Motorcycle, search/filter/sort selection, deletion safeguards, active/overdue, return/repeat refusal, archive and delete in allowed states, cancellation non-mutation, restart and full domain parity tests on new UI.” The source promises nine P6 acceptance units but does **not** number the nine individually. The following is a **faithful provisional grouping**, not a newly invented scoring standard.

## 1. Candidate nine P6 checks (all formal status: unapproved)

| Candidate ID | Capability from original wording | Current scoped automated source evidence | What the operator must additionally inspect on actual Windows | Present verdict |
|---|---|---|---|---|
| **P6-01** | Add Car/Motorcycle | [P6-A](P6_A_FLEET_CREATE_NATIVE_VERIFIED_2026-11-01.md), `rental_studio_p6_fleet_add_wide/compact` | Add both types in **disposable fictional mode**, inspect specifications, reject blank/duplicate/invalid input, verify accurate Fleet result | **Automated covered**, owner review pending |
| **P6-02** | Search, filter, sort, stable selection | P2 gallery/table focus/selection smoke; `rental_studio_p2_arrows_focus`, `_focus_edges` | Search IDs and model, switch Gallery↔Table after sorting/filtering; confirm same selected ID, correct keyboard arrows, no overlap | **Automated covered**, owner review pending |
| **P6-03** | Fleet deletion safeguards | [P6-B](P6_B_NATIVE_FLEET_REMOVAL_VERIFIED_2026-11-01.md), [P6-D](P6_D_HISTORICAL_VEHICLE_REFERENCES_VERIFIED_2026-11-01.md) | In disposable fiction: Cancel/Escape/wrong `REMOVE <ID>` nonwrite; refuse occupied AND any historically referenced car; valid unreferenced vehicle removal requires exact confirmation | **Automated covered** under conservative fictional-only policy, commercial vehicle retirement is **P7** |
| **P6-04** | Active/overdue status and navigation | [P5-J overdue Overview](P5_J_ACTIONABLE_OVERDUE_OVERVIEW_VERIFIED_2026-11-01.md), `rental_studio_p5_overview_wide/compact` | With system date understood, inspect C++-sourced due/overdue and navigate oldest overdue item; do not claim fixed past sample dates are “today” | **Automated covered**, operator physical view pending |
| **P6-05** | Return plus repeated-action refusal | [P6-H](P6_H_RETURN_LOOKUP_NATIVE_VERIFIED_2026-11-01.md), `rental_studio_p3_return_qml_wide/compact` | Find active by rental ID AND vehicle ID, separate explicit return confirm, see available Fleet/revised History, reject duplicate or returned/archived target | **Automated covered**, sequential operator review pending |
| **P6-06** | Archive returned and delete archived only in allowed states | P3 archive CTests, [P6-C](P6_C_ARCHIVED_DELETE_NATIVE_VERIFIED_2026-11-01.md) | Active cannot archive; Returned can archive with confirmation; only Archived disposable record eligible for exact `DELETE <ID>`, Cancel/Escape/wrong phrase never commits | **Automated covered**, owner must approve destructive UX |
| **P6-07** | Cancellation does not mutate state | [P5-G](P5_G_BOOKING_CANCELLATION_VERIFIED_2026-11-01.md), P6-B/C cancellation tests | Cancel and Escape from booking/return/archive/delete; no phantom receipt, no stale contact entry or changed storage | **Automated covered**, end-to-end review pending |
| **P6-08** | Restart and reconstruct state | [P6-E](P6_E_THREE_PROCESS_NATIVE_RESTART_VERIFIED_2026-11-01.md), `rental_studio_p6_cross_process_wide/compact` | On safe test workspace, reopen independent native Qt instances and compare Fleet/Overview/Rentals to final allowed disposable operations; distinguish ephemeral default from opt-in fictional-only persistent mode | **Automated covered** scoped to synthetic process tests, production P7 durability still separate |
| **P6-09** | Full domain lifecycle parity tests on the new UI | [P6-I source audit](P6_I_LIFECYCLE_PARITY_AUDIT_2026-11-01.md), [P6-J recent contracts](P6_J_RECENT_CONTRACTS_NATIVE_VERIFIED_2026-11-01.md), [P6-K contract detail](P6_K_CONTRACT_DETAIL_NATIVE_VERIFIED_2026-11-02.md), scoped native P3/P5/P6 tests | Perform the full sequential run below with real keyboard, status/selection, failure paths and visual review; record conscious design divergences separately | **OPEN as a full-scope proven/ratified criterion** |

**Technical source baseline:** [`fae183b`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fae183bb334d227bcc313cc89c8de670c7de66f2) passed [13/13 core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41363457853) and [72/72 native Linux + 72/72 native Windows](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41363457990) on Qt 6.8.3. These are genuine scoped automated results, **not** fresh full P6-09 acceptance or the owner's Qt 6.10.2 MinGW device proof.

## 2. Ready-to-run *future owner* sequential scenario

**Precondition:** a disposable, resettable synthetic-only directory/packaged test kit approved for the specific owner machine. **Do not import private files or use real customer names or phones.** The ordinary default launch is ephemeral; a fixed `--persistent-fictional-demo` session is only for strictly preapproved fixed fake fixtures, and purposely blocks some fleet writes. A fully writable P6 three-process synthetic test uses its own allowlisted disposable root; **do not interpret that as a general data-dir launch option**.

The owner can run these in one consolidated supervised review when convenient; this document **does not require or assert a manual run now**.

1. **App/shell:** launch real Windows Qt app at 1500×860 and 1280×720 logical sizes, then inspect OS display 100/125/150% on physical hardware separately. Review left Overview/Fleet/Rentals nav, keyboard focus vs selection, long-text and modal accessibility, and that no arbitrary file opens.
2. **Initial state:** capture Fleet total/type/availability from actual C++ fixture; Overview must reconcile available/active/overdue/booked amount with source and current date. The four-contract recent panel is **latest rental start dates**, not event history.
3. **Fleet:** switch Gallery↔Table, search/filter/sort and inspect a known vehicle; add both Car and Motorcycle with synthetic fields in disposable scope, reject duplicate, Cancel/Escape and invalid rate/type.
4. **Book:** select available Fleet vehicle and open Rentals guided quote; review current rate × 1–365-day total; Cancel/Escape scrub fictional contact fields without writing; then confirm a valid **synthetic** contract. Observe visible saved rental ID, Fleet unavailable, Active list, Overview changes, original fixture hash intact.
5. **Refusals:** reject double booking, stale quote/price, occupied vehicle and injected failure path; no second booking, no fake receipt, correct selection/focus; do not change actual production rates in operator tests.
6. **Return:** use both active rental ID and matching vehicle ID as lookup keys; review only active contract, separate confirmation; reject wrong/missing/returned ID; after successful return verify Active/History/Available totals and read-only detail actual-return date.
7. **History:** review Returned/Archived filters and purpose-limited [contract detail](P6_K_CONTRACT_DETAIL_NATIVE_VERIFIED_2026-11-02.md), check that no customer contact appears in generic QML roles, confirm archive only returned state; destructive archived deletion only in disposable synthetic scope with exact phrase. Vehicle reference guard must retain any still-referenced vehicle.
8. **Restart:** use the already-designed independent synthetic three-process harness for write operations; reconstruct final fleet/booking/history from separate process. On real fixed fictional-only mode, respect intentional restrictions and don't claim those operations are enabled.
9. **Negative cases:** no-selection, last-row deletion and stale selection, long data, no results, Cancel/Escape on each modal, storage write refusal, swapped fixture hash denial and selection after filter changes; screenshots, keyboard record, failures, evidence URL and exact binary/source SHA.
10. **Decision:** compare observed lifecycle with [22-row legacy/UI matrix](P6_I_LIFECYCLE_PARITY_AUDIT_2026-11-01.md). Explicitly classify differences as intended design vs missing capability. **Full P6-09 remains unaccepted until this evidence and rubric decision are reviewed.**

## 3. Evidence recording template (to fill only after genuine review)

| Field | What to record |
|---|---|
| Date/device | Physical Windows version, Qt Creator + selected Qt kit compiler and QML run binary |
| Exact source | SHA of candidate app and protected test fixture; disposable path description, not private absolute paths |
| Window & OS scale | 1500×860/1280×720 and actual 100/125/150% Windows display settings tested; identify synthetic vs hardware proof |
| Narrator/keyboard | Tab, Shift+Tab, arrows, Space, Enter, Escape, focus restoration, accessible role/name/checked state |
| Evidence | Real filenames/logs/CI links, failing reproduction and separately attached review screenshots |
| Per criterion | P6-01…09: **Proposed PASS / FAIL / REVIEW_NEEDED** with exact rationale, distinct from formal accepted status |
| Owner approval | Date, decision and reason for acceptance or request for changes; no inferred approval from automation |

## 4. Outstanding owner and release decisions

1. **P6 rubric:** Approve or correct the *candidate interpretation* of the source text's nine units, **before awarding any formal accepted criterion**. Do not arbitrarily change total 74 checks or weights.
2. **Overview/Fleet metric location:** [P6-L proposal](P6_L_OVERVIEW_FLEET_METRICS_DECISION_2026-11-02.md) recommends keeping the four Overview operational cards and optionally placing a tiny occupancy/type line in **Fleet**, not a fifth primary Overview card. **Owner decision open**; no code change in P6-L.
3. **Customer privacy:** generic QML no-contact projection remains strict; private detail needs separate purpose, role/access, retention and production policy. No live data authorization.
4. **Commercial vehicle retirement:** preserve historical references without hard deletion; agree legal/accounting retention and non-destructive inactivation before P7, not required to turn fictional P6 deletion into commercial deletion.
5. **P4/P5/P6 owner device:** physical Windows OS scale/Narrator and design approval remain distinct from hosted Linux/Windows tests. Existing P5 eight automated-covered but formal **0/8** needs its own signoff.
6. **P7–P9:** integer-cent accounting, IDs, migration and durable storage (P7); licensing/Windows installer (P8); physical/manual reliability and explicit release signoff (P9) are **not** satisfied by P6 CI.

**Current authoritative acceptance:** P0–P4 accumulated **28/74 accepted** with **40.6% evidence-weighted score**, P4 **5/7**, P5 **0/8**, P6 **0/9**; provisional P6 **8 automated-covered / 0 partial / 1 broad parity open**. All PRs in the P4→P5→P6 stack remain **DRAFT/unmerged**. Stable `main` untouched. This document grants **zero** new formal acceptance and enables a deliberate review rather than a misleading percentage increase.
