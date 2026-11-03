> **P6-O FLEET SNAPSHOT EXACT-SOURCE CROSS-PLATFORM VERIFIED | 2 NOV 2026:** [P6 code `41683c8`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/41683c8796e6a8acd98031a8533696f51659628f) [core **13/13**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41436600124), [native Linux/Windows **74/74 each**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41436600115) PASS; identical [stacked P7 code `64c4d60`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/64c4d60a3223d4a0d16124d799a5bd0a01c35d41) [core **13/13**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41436659750), [native Linux/Windows **100/100 each**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41436659850) PASS, including existing Qt real UI wide/compact, SQLite tests, packaged Windows PS7/PS5.1. [Research-informed bounded P5/P6 decision](P6_O_RESEARCH_REVISED_ACCEPTANCE_AND_FLEET_2026-11-02.md) keeps instantaneous Fleet occupancy distinct from historical utilisation; no generic contact roles or commercial history deletion. [Docs-only CI `4de7557`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/4de7557902844ddb576a4d123c9f76a81c2ab667) [core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41437011387) and [native](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41437011528) scope jobs PASSED and expensive compile jobs SKIPPED by design. Formal **P5 0/8, P6 0/9, P7 0/8, 28/74, 40.6% unchanged**; owner physical Qt6.10.2 MinGW, 100/125/150% Narrator and acceptance remain OPEN. No merge or live-data authorization.

# P6-O | Research-informed acceptance and Fleet snapshot decision

**Prepared:** 2 November 2026. **State:** WORKING DESIGN DIRECTION AGREED FOR FICTIONAL P6; FORMAL ACCEPTANCE AND COMMERCIAL DATA POLICY NOT APPROVED. **Existing owner context:** proceed with the revised recommendations, not an unrestricted P7 production cutover. The original unnumbered nine-point P6 roadmap is not silently rewritten.

## 1. Evidence considered, not invented acceptance

- [P5 original eight acceptance expectations, issue #13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/13) and [source-to-test crosswalk](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md): eight representative native outcomes automated, but physical/operator formal acceptance pending. Booking success, duplicate denial, failed write, cancel/no-false receipt, independent reopen verified in fiction-only scope.
- [P6 nine provisional capability groups](P6_N_ACCEPTANCE_CLOSURE_DECISION_RECORD_2026-11-02.md), [22-row legacy vs Qt Quick parity audit](P6_I_LIFECYCLE_PARITY_AUDIT_2026-11-01.md) and [three native-process connected lifecycle](P6_M_THREE_PROCESS_INTEGRATED_NATIVE_VERIFIED_2026-11-02.md): P6-01…08 representative automated, P6-09 integrated sequence tested but broad parity not signed.
- [P6-L metrics source comparison](P6_L_OVERVIEW_FLEET_METRICS_DECISION_2026-11-02.md): old Widgets displayed utilisation and vehicle counts; modern Overview has four action-oriented cards, a separate Fleet workspace, and its own full C++ snapshot. A historical rental-day utilisation metric cannot honestly be reconstructed from a momentary rented/total count.
- Privacy/legal research direction: POPIA purpose limitation, minimisation, access security and retention warrant a purpose-limited future commercial contact view, **not** unrestricted customer visibility in the current P6 history table. These are product design safeguards, not a legal opinion or production processing approval.
- Accessibility/acceptance research: green hosted CI proves scoped program behaviour, not actual Windows screen-reader, focus or display-scale performance on the owner's physical Qt 6.10.2 MinGW kit.

## 2. Revised bounded P6 acceptance contract, pending per-criterion owner signoff

The nine **provisional grouping IDs remain unchanged**; the P6-09 definition becomes bounded and objectively reviewable, rather than “copy every old Widgets page pixel for pixel.”

| Candidate | Required synthetic operator outcome | Acceptance evidence / remaining review |
|---|---|---|
| P6-01 | Add validated Car and Motorcycle, reject invalid and duplicate, refresh after successful write | Native P6-A/E; owner creation dialog/focus review |
| P6-02 | Gallery/Table search, filter, sort, selected ID and keyboard navigation stable | Native P2; physical scroll/scale/Narrator review |
| P6-03 | No removing a rented or historically referenced vehicle; fictional disposable exact confirmation | Native P6-B/D; irreversible UX review; commercial **RETIRE** deferred |
| P6-04 | Correct available/active/overdue navigation from authoritative full domain read | Native P5-J; current-date/empty-state operator review |
| P6-05 | Return via rental/vehicle ID with separate confirmation; duplicate/missing return refused | Native P6-H/M; operator confirmation language |
| P6-06 | Return then archive with state checks; fictional-only archived delete exact phrase, no silent cascade | Native P6-C/M; operator destructive-action review; commercial policy separate |
| P6-07 | Cancel/Escape/declined/failed-write does not mutate protected files or issue false receipt | Native P5-G/P6-B/C/M; keyboard and message review |
| P6-08 | Independent executable restart restores Fleet/Rentals/Overview in strictly allowlisted fictional mode | Native P6-E/M; no extrapolation to commercial storage |
| **P6-09** | **One bounded complete operator path**: create Fleet asset → choose/quote → confirm → refuse duplicate → reopen → return → archive → enforce deletion guard → final independent restart; compare essential legacy functions with 22-row audit, **explicitly record intentional differences** (three workspaces, no generic contact roles, bounded recent contracts, snapshot Fleet metrics). | Native P6-M covers interconnected path; final owner UI/physical review, approved deviations and P6 rubric ratification OPEN |

An automated test PASS is evidence, **not** owner milestone acceptance. Physical Windows Qt Creator MinGW, real 100/125/150% display scaling, keyboard focus and Narrator are an integrated review, **not** a demand to manually repeat every automated regression. P5's original eight remain separately accepted or rejected individually when owner examines them.

## 3. Fleet summary implementation direction

**Selected working direction:** compact text in Fleet, keep four Overview primary cards. Use complete authoritative C++ `FleetReadService` value snapshot, not QML filtering or a hand-entered sample. Display **Cars, Motorcycles, and N of M currently rented**. This is an **instantaneous rented-fleet snapshot**, not historical utilisation, rental-day percentage, paid revenue or profitability. Empty fleet must say “No fleet vehicles” instead of an unqualified zero percentage.

Implementation in the unmerged P6 branch: `spikes/qtquick_p2/main.cpp` adds read-only `carCount`, `motorcycleCount`, `rentedCount` with `fleetChanged` notifications; `spikes/qtquick_p2/Main.qml` renders `fleetSnapshotSummary` under Fleet controls. Existing source-model and real QML wide/compact smoke assert counts are unaffected by filtering and update only after actual domain commit refresh. The patch is also synchronized to stacked P7 draft, not merged to main.

**Exact P6 source commit:** [`41683c8`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/41683c8796e6a8acd98031a8533696f51659628f); **stacked P7 equivalent:** [`64c4d60`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/64c4d60a3223d4a0d16124d799a5bd0a01c35d41). **Exact-source verified:** P6 [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41436600124) and [Linux Qt 74/74, hosted Windows Qt 74/74](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41436600115), P7 [core 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41436659750) and [Linux/Windows native Qt 100/100 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41436659850), including P5/P6 real QML and P7 opt-in sandbox. These are hosted Qt 6.8.3 runs, not the owner's physical Qt Creator 6.10.2 MinGW acceptance.

Future actual utilisation would need rentable asset-days, historical rental days and a defined period, plus decisions about retired/maintenance/non-rentable fleet. Do not back-calculate from present occupancy or hard-code sample values.

## 4. Privacy and deletion boundaries (do not activate P7)

- For P6 **fictional-only** UI: retain existing privacy-safe contract list and read-only dates/days/rate/status/total detail; no generic QML name/phone/driver-licence read roles. This is a presentation choice, not a universal ban on contacts.
- Candidate P7 commercial workflow: an **authorized purpose-limited detail view** may be necessary for contacting a rental customer. Before any real-data use, define access model, processing purpose/legal basis, contact minimisation, presentation and logs, retention/deletion, storage permissions and backup security, and old 14-field licence disposition. No customer real data in existing CTests.
- Commercial archive should preserve legitimate rental history until policy permits controlled deletion/de-identification. P6's explicitly confirmed deletion is restricted to its disposable fictional test environment, **not** approved production history deletion.
- Do not enable live QSQLITE in Qt Quick, import real text records, invent permissions/login or store plaintext credentials by implementing this P6 decision.

## 5. Closure ledger and next action

**Formal counts do not change:** P4 5/7, P5 0/8, P6 0/9, P7 0/8; programme **28/74 accepted, 40.6% weighted**, not engineering-completeness or release readiness. Draft PRs #12/#14/#17 stay open, unmerged. Next: verify exact-source Linux/Windows runs for Fleet summary, then perform one consolidated owner P5/P6 operator/physical acceptance review; record each approval with concrete evidence and only then adjust weighted scoring. P7 storage architecture, privacy and irreversible business rules remain separately gated.
