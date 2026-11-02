# Rental Studio 2.0 | Final-product specification, controlled draft v0.1

**2 November 2026 implementation addendum:** The source-level P6-P application has a visually polished fictional Overview/Fleet/Rentals UI with original generic silhouettes, Fleet current-occupancy summary, guarded booking/return/archive and new guided quote styling; [evidence](P6_P_POLISHED_UI_CANDIDATE_NATIVE_VERIFIED_2026-11-02.md). [P7-H](P7_H_NORMALIZED_SQLITE_REPOSITORY_NATIVE_VERIFIED_2026-11-02.md) now has an **OFF-by-default normalized, test-only C++ SQLite candidate**, with no customer fields or actual Qt Quick storage integration. This **draft remains unapproved** for real customer data, commercial retention, installer or release. Preserve original business proposal below as originally dated; [current source truth](LATEST_CHECKPOINT.md).

**Date:** 1 November 2026. **Status:** **DRAFT, NOT WHOLE-PRODUCT OWNER SIGNOFF.** **Source:** current P6 Draft PR [#14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14), development head audited at `5d92daf`, and exact [P6-H source `8467701`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/84677015f335b1624652d0367dfde52802e5e436). **Governing inputs:** [current product state](PROJECT_STATE_CANONICAL.md), [selected visual direction](../design/r1/OWNER_THEME_DIRECTION_2026-10-30.md), [design specification and dated caveats](../design/DESIGN_SPEC.md), [owner keyboard contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md), [phase acceptance rules](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md), and [P6-I source-to-interface audit](P6_I_LIFECYCLE_PARITY_AUDIT_2026-11-01.md).

This consolidates what the *target finished product* should do, clearly separating **approved direction**, **source-implemented demonstration behaviour**, and **unapproved commercial proposals**. It is not a new owner decision or a release authorization. If a historical document conflicts with the 30 October owner-selected navy/teal design direction, the dated later selection controls. The old Qt Widgets interface is a reference for rules and operator capabilities, **not the final design**.

## A. Product identity, intended audience, and scope

**Working user-facing name:** **Rental Studio**; **project/rebuild name:** Rental Studio 2.0. Name, identity mark and external rights clearance are not yet fully approved. The target is a refined, **offline-first, single-operator Windows desktop vehicle-rental workspace** for a small automotive fleet. Local C++ domain and typed application services are the authority; Qt Quick/QML is presentation. It should be credible as a portfolio-quality application and, after separate P7–P9 decisions and hardening, usable for actual single-operator work.

### Approved/in-scope core behaviour

1. Fleet inventory of **Car** and **Motorcycle** records, validated creation, available/rented status, unique identifiers, detailed inspection, search/filter/sort, guarded removal only under permitted lifecycle policies.
2. Guided **same-day** rental booking, **1–365-day** duration, authoritative price/day × duration **quote**, required validated customer contact in the C++ command domain, explicit confirmation, durable transaction, fleet occupancy updates, duplicate-booking refusal, and transparent error/cancel outcomes.
3. Return of an **active** rental using either rental ID or associated vehicle ID for lookup, with a separate confirmation and current-day domain restrictions; no double-return.
4. Distinct **Active**, **Returned**, **Archived** and combined **History** views. Archive only returned rentals; deletion only from the permitted archived state, with explicit guard. **Permanent deletion currently restricted to disposable fictional demos**; not an approved production retention operation.
5. A truthful operational Overview with live available/total fleet, active and overdue rentals, due-today/upcoming attention, active booked contract value **not payments/revenue**, useful navigation, and a bounded recent-rentals/activity section.
6. State reconstructs correctly after restart without fake success receipts. Failed writes must preserve authoritative records. All state-changing commands flow through typed C++ services and domain validation.

### Explicit non-goals unless separately approved

No payment gateway, deposits or collected-revenue reporting; no cloud synchronization, public API, AI features, multi-user login/roles, online bookings, future-reservation inventory, remote telemetry, automated SMS/emails, or manufacturing claims about illustrative photographs. Do not add speculative customer analytics or trends. These features require a new product decision and tested requirements.

## B. Visual and information architecture contract

**Owner-selected direction, not whole-product final approval:** light-first, automotive, polished and readable. Palette: Midnight Navy `#17324D`, Emerald Teal `#0F766E`, Cloud White `#F6F8FA`, Ice Blue sidebar `#EAF0F4`, Soft Mint quote panel `#E8F5F0`, muted secondary text `#5F6F82`. White cards, quiet borders, intentional typography, one coherent spacing/radius system, clear enabled/disabled/error/selected/focus states. Reject the historical graphite/lime UI and superseded sage/copper speculations. Imagery: legally usable, model-accurate photo or deliberately designed silhouette; no fake branded endorsements or misleading fleet-specific photograph claims. Current logo remains a concept until approved/licensed.

**Three persistent top-level workspaces only:**

| Workspace | Composition and information hierarchy | Principal operator task | Mandatory conditions |
|---|---|---|---|
| **Overview** | Page heading, four prioritized real KPIs, due/overdue attention, concise recent rental activity, navigation to affected contracts and Fleet | Identify today's work and act on an actual record | Never label booked amount as cash/revenue; empty/no overdue states truthful; bounded recent rental **contracts implemented and verified P6-J**; real return/archive events are not recorded |
| **Fleet** | Gallery default, Table alternate, shared search/status/sort, vehicle selection and responsive Inspector, contextual Add/Book/Remove | Find correct available vehicle and manage inventory | Gallery/Table selected ID and query preserved; blocked actions explain why; no silent destructive mutation; photo fallback consistent |
| **Rentals** | Clear New Rental flow, read-only current status filters, selected contract/detail, return lookup, return/archive/delete confirmation and feedback | Book, return and review rental lifecycle | Authoritative C++ amounts/statuses and permissions; no optimistic success; separate Confirm; historical records cannot be returned |

**Viewport targets:** native Windows logical **1500×860** and compact **1280×720**; physical OS 100/125/150% scaling and the owner's recorded 1920×1080 at 150% must be reviewed on-device. Vertical scrolling is acceptable; controls cannot overlap or become unreachable. A screenshot size or synthetic DPI test is not physical scale acceptance.

### UX interactions to preserve

Tab and Shift+Tab move between meaningful groups. Fleet Gallery uses four arrow keys for **selection** within the current grid; Fleet Table uses Up/Down; Rentals list uses Up/Down; Search/caret and ComboBox arrow keys retain native use. Visible **keyboard focus** is distinct from persistent domain **selection**. Escape prioritizes open modals, then selection only in the visible workspace; Cancel/Escape never persists a draft. Dialog focus remains trapped appropriately and returns safely; status is readable without color alone. Reduced-motion configuration suppresses cosmetic motion; Narrator and real scale remain physically unverified.

## C. Functional states and acceptance scenarios

| User story | Intended operator-visible result | Current evidence or next gate |
|---|---|---|
| Start from no vehicles/no rentals | Zero-state Overview and helpful Fleet/Rentals prompts; no fabricated summary | Domain empty-snapshot behavior covered in tests; **whole-screen UX review required** |
| Find a vehicle | Gallery/Table search and availability filter agree, stable selected ID, accurate type/specs/rate | P2 native smoke and P6-A; **demonstration-only** |
| Add a car or motorcycle | Input validity, unique ID, confirmation, saved record appears in Fleet | P6-A native / C++ service; disposable-only |
| Remove a fleet vehicle | Typed destructive confirmation; refuse active **or surviving historical rental reference**; failed write does not remove | P6-B/D native; commercial **retire rather than delete** still undecided |
| Book a vehicle | Quote uses current domain price and 1–365 days; confirm remains disabled until current quote; durable commit updates Overview/Fleet/Rentals | P3/P5 native, stale quote + cancelled draft tests; only fictional-persistent or disposable modes |
| Return by rental/vehicle ID | Lookup finds exactly one active contract, then explicit return confirmation; active row disappears and History reflects returned | P6-H Linux/Windows Qt PASS; no auto-return |
| Archive and remove records | Archive only returned; permanent delete only archived **fictional disposable** record after exact phrase | P6-C/D tests; **real-record deletion policy not approved** |
| Restart | Reconstruct consistent Fleet/Rentals/Overview with no orphan references or false receipt | P5 fixed fictional session and P6-E isolated three-process test; production recovery P7 |
| Inspect current work | See overdue/due today, oldest overdue route, booked contract value and **bounded recent activity** | P5-J overdue supported; **P6-J recent rental contracts implemented and verified**, not a chronological event stream |
| Review selected rental contract | Operator can inspect start/expected/actual dates, duration, rate, booked amount and status in a separate view | **P6-K native verified** for no-PII contract detail. Current QML still excludes all customer/contact roles; consent, authorization, minimization and retention require separate owner approval |

**Minimum negative-case matrix:** missing/blank IDs, wrong case/whitespace, duplicate occupied vehicle, wrong rental state, long text, no results, invalid contact, stale price/availability, double-submit, Cancel/Escape at every modal state, unsupported date, injected write rejection, damaged storage, nonexistent/malformed records, source fixture tampering, separate process restart, unexpected high-DPI layout and keyboard focus recovery. Only label cases tested where an exact test proves them.

## D. Technical and persistence rules

**Current tested topology:** standalone Qt Quick/QML + C++17 typed read models/command controllers; existing RentalSystem domain and single-writer persistence abstraction. Automated native Qt 6.8.3 Linux/Windows and C++ tests pass at [P6-H source `8467701`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/84677015f335b1624652d0367dfde52802e5e436): [13/13 core](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41352847944), [68/68 Linux and Windows native each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41352847881). Native CI is evidence of *scoped fictional flows*, not real customer-data compliance or hardware acceptance.

**Current runtime restrictions that must not be bypassed by this spec:** default disposable fictional fixtures; optional narrowly defined fixed **fictional-only** persistent session; intentional blocked destructive fleet operations in fixed session; original SHA-pinned demo fixtures protected; no real names, contact records or general production imports. Any proposal for commercially usable storage is **P7 scope**, requires explicit owner authorization.

**P7 decision requirements before real data:** retain referenced historical vehicles through a **non-destructive retirement/inactivation model** or another explicit approved consistent policy; nonreusable IDs after deletion; **integer cents/precision** instead of uncontrolled double; storage location in user app data (e.g., QStandardPaths), durable transaction boundaries, corruption/error diagnostics, backup/restore, schema versioning and safe migration from legacy text only with verified reconciliation; privacy/authorization and retention of customer name/phone; single-process ownership and contention recovery. SQLite is a **candidate**, not already selected. Require testable crash/restart and failed-commit evidence.

**P8:** Qt/QML runtime dependencies, model-image and third-party licences, installer/update/uninstaller rules, offline clean Windows machine tests, preservation of legitimate existing data. **P9:** exact-source local and independent tests, native Windows Qt Creator/MinGW builds, OS 100/125/150% scaling, keyboard and Narrator, performance/reliability, owner whole-product visual approval, and explicit merge/tag/release decision.

## E. Decisions that are **not** authorized by this draft

| ID | Pending decision | Default until decided | Owner acceptance evidence |
|---|---|---|---|
| D-01 | Whole-product visual hierarchy and imagery | Use chosen palette/direction; preserve legal placeholders | Review all three actual Qt screens at two desktop sizes |
| D-02 | Overview recent-activity presentation and date columns | Proposed read-only C++ summary subset, no customer PII | Approve exact rows/columns/ordering and empty states |
| D-03 | Customer/contact visibility, privacy, retention and access | **Do not expose contacts via QML**, no real data | Approve minimum necessary fields and data rules |
| D-04 | Commercial vehicle retirement and rental history retention | Block removal while referenced; no real record deletion | Document retirement and retention policy and negative tests |
| D-05 | Commercial storage and migration strategy | Stay fictional-only; no SQLite migration by assumption | Approve storage model and recovery tests |
| D-06 | Final brand/logo and automotive photo assets | Concept only; use rights-safe placeholder | Approve actual assets and licensing |
| D-07 | Native OS/a11y acceptance and release gates | Hosted CI only, no physical signoff | Owner's Qt Creator, scaling, Narrator and complete workflow results |

## F. Completion gates and next authorized engineering slice

1. **P6-I audit:** [P6-I parity matrix](P6_I_LIFECYCLE_PARITY_AUDIT_2026-11-01.md) records source-proven parity, genuine differences and approved design divergences. This specification is an audit-derived **draft**, not a signed product baseline.
2. **P6-K now implemented:** native purpose-limited rental contract detail panel/modal has [exact-source verification](P6_K_CONTRACT_DETAIL_NATIVE_VERIFIED_2026-11-02.md). P6-J recent-contract Overview was previously verified. Remaining owner decisions: whether utilization/type KPIs belong in Overview and whether any strictly authorized customer detail is appropriate; **do not disclose contact data** until explicit privacy/retention approval.
3. **Owner acceptance:** explicitly ratify the original P5 eight and P6 nine criteria and approve/design pending differences. The P6 **9th full-parity group is still open** until independently demonstrated, not resolved by writing this document.
4. **Commercial release:** complete P7, P8, P9 gate proofs, production data policy, installed app on clean Windows, and explicit owner signoff.

**Frozen formal acceptance at this audit:** P4 **5/7**, P5 **0/8**, P6 **0/9**, **28/74** programme accepted and **40.6% evidence-weighted coverage**. This is **not percent of code complete** and **not release readiness**. The new audit/spec provides **zero new acceptance credit** until approved acceptance evidence justifies a change. Do not merge Draft PR #14/#12/#10 or alter `main` based on this document.


### P6-L addendum (2 November 2026): non-primary Fleet composition proposal

Based on the actual legacy source and new C++ Fleet model, **retain the four current Overview operational KPI cards**. [P6-L comparison and owner options](P6_L_OVERVIEW_FLEET_METRICS_DECISION_2026-11-02.md) propose a discreet secondary car/motorcycle and current occupancy line in **Fleet**, only if owner selects that option. The alternatives are one low-priority Overview line or omitting extra counts. **Owner selection remains pending; no new UI has been implemented.** The sample counts 3 cars, 2 motorcycles, 1 rented out of 5 come from SHA-pinned fictional fixtures and must never become hardcoded metrics. [Original nine P6 candidate checks and physical acceptance runbook](P6_L_NINE_CRITERION_ACCEPTANCE_REVIEW_PACK_2026-11-02.md) remain provisional; formal P6 0/9, 28/74 and 40.6% weighted unchanged.


### P6-M addendum (2 November 2026): end-to-end operator sequence, synthetic-only

[Exact-source three-process real Qt integrated test](P6_M_THREE_PROCESS_INTEGRATED_NATIVE_VERIFIED_2026-11-02.md) connects native create Car → Fleet-to-booking → authoritative quote/confirm → process restart → vehicle-ID active return → history/actual return date → archive → correct archived deletion → removal of unreferenced test vehicle → third native process Overview/Fleet/Rentals consistency, both display sizes on Linux and Windows. It proves important fictional-domain integration but **not** full commercial lifecycle parity, owner manual desktop acceptance, live customer data authorization or P7–P9 readiness. The original nine P6 criterion grouping remains provisional, formally P6 0/9 and 28/74 overall accepted. [P6-L Fleet utilisation/type metric-placement proposal](P6_L_OVERVIEW_FLEET_METRICS_DECISION_2026-11-02.md) is **still an unapproved design recommendation**, and no new metric widget was added.


### P6-N decision record, 2 November 2026

The [P6-N evidence-based acceptance closure record](P6_N_ACCEPTANCE_CLOSURE_DECISION_RECORD_2026-11-02.md) is the current owner review entry point. It maps the nine **provisional** original P6 capability groups, preserves exact C++/native Qt Linux and hosted Windows evidence, and specifies which decisions require actual owner action. The new P6-M integrated test proves a complete fictional-only connected lifecycle on both OSes but does not approve commercial customer data or all physical UX. Existing palette and three workspaces remain as selected visual **direction**, not whole-product acceptance. Optional Fleet utilization/type breakdown, no-contact detail policy, and real Windows DPI/Narrator checks remain open. No P6 signoff was inferred from documentation.


### P7-A addendum (2 Nov 2026): storage and migration architecture proposal, no activation

[Exact-source persistence audit](P7_A_SOURCE_STORAGE_AND_MIGRATION_RISK_AUDIT_2026-11-02.md) records key P7 threats: double prices, possible C/M/R ID reuse, atomic text-file writes without joint ledger transaction, permissive legacy loading and guessed actual-return dates. [P7-A candidate SQLite ADR](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md) proposes isolated app-local QtSQL SQLite, cents, retained ID history, retirement, backup/reconciliation, masked legacy records and no real-data import until privacy policy. [Proposed P7-A eight-test contract](P7_A_MIGRATION_AND_TEST_CONTRACT_2026-11-02.md) is **not the approved eight-point rubric**. Current QML runtime continues to use protected fictional-only legacy path; owner storage engine/retention/contact permissions and production Windows installer are still pending. Future P7-B should build an isolated test-only adapter with no actual production switch.


### P7-B addendum (2 November 2026): QtSql capability verified in sandbox only

[Exact-source test report](P7_B_SQLITE_SANDBOX_NATIVE_VERIFIED_2026-11-02.md) confirms the Qt6 QSQLITE driver is available in the hosted 6.8.3 Linux and Windows MSVC kits. Its test-only schema supports unique casefold IDs, single active rental per vehicle, integer cents, high-water ID allocation, transaction rollback and three independent DB connections. The existing user-facing app still uses protected fictional text ledgers; database integration/production import, backups, sensitive customer fields and commercial lifecycle policy remain **unapproved**. This does not change the Draft P7-A ADR, original eight-criterion rubric or any formal acceptance score.


### P7-C addendum (2 Nov 2026): raw-text migration preflight is NOT a customer-file import

[Exact-source Qt Core-only P7-C scanner](P7_C_READ_ONLY_LEGACY_PREFLIGHT_NATIVE_VERIFIED_2026-11-02.md) recognizes seven-field vehicle rows and thirteen-/fourteen-field rental rows, deliberately flags historical driver's-licence presence, unknown actual return dates and orphan historical vehicle references for review. It checks date/duration and amount precision, duplicate active occupancy and unsafe encoding using only generated, SHA-checked fictional test files. No general import file picker, real customer contact processing, SQLite migration or production recovery mechanism is implemented, and the test source is not an approved comprehensive migrator. Production storage/privacy decisions remain blocked until owner approval.


### P7-D addendum, 2 November 2026: test-only deterministic migration report

[Native-tested P7-D](P7_D_DETERMINISTIC_MIGRATION_REPORT_NATIVE_VERIFIED_2026-11-02.md) adds an **in-memory, versioned synthetic-only JSON anomaly manifest** to the standalone P7-C read-only preflight. Fixed issues are ordered by source/line/code, record counts are explicit, and booked contract comparison uses checked int64 cents serialized as decimal strings; missing/overflowed amounts are null, not fabricated zeros. The module is not connected to runtime SQL, application file pickers or a real-data importer. P7-B/C/D remain independent proof-of-concept tests, and commercial migration, backup/restore and privacy approval remain future gates. No formal acceptance changes.
