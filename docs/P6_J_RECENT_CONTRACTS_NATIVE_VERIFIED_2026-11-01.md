# P6-J | Bounded recent rental contracts, exact-source native verification

**Date:** 1 November 2026. **Product:** Rental Studio 2.0. **Verified source:** [`1a468149588140346c1c98c2eea278c4818cd395`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/1a468149588140346c1c98c2eea278c4818cd395). **Branch:** `feature/p6-fleet-create-disposable-20261101`, stacked [Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14) on Draft #12/#10, stable `main` untouched.

## Purpose and exact semantics

The [P6-I audited gap](P6_I_LIFECYCLE_PARITY_AUDIT_2026-11-01.md) was the missing recent-rentals Overview section. P6-J supplies a bounded **Recent rental contracts** panel: **up to four** real C++ summaries, ordered by **rental start date descending** and **rental ID descending** for same-day ties. It is not a chronological event log: the current domain does not record return/archive event timestamps. The UI explicitly says **"Latest contract start dates. Not an activity log or payments."** Listed currency amounts are **booked contract values only**, not collected revenue or payment.

A new `RentalListModel::recentActivities` `QVariantList` property reads the full C++ snapshot `m_allItems`, independently of current status filters, and recomputes only after the existing authoritative `metricsChanged` refresh. Exact row map keys are `rentalId`, `vehicleId`, `startDate` (ISO date), `status`, `total`; **no customer names, phone numbers or contact details**. Read-only `locateById` navigates from keyboard/mouse-activated Overview row to the canonical record in Rentals, revealing hidden historical records, with no transaction.

Overview uses a real scrollable `Flickable` and four compact-height KPI cards at small windows to keep existing dashboard controls and the fictional/payment disclosure usable. Recent buttons have 36 px minimum height, accessibility names and explicit "review, no change" description. The panel has a genuine empty state. **No writer, new data file, import, production permissions or domain transaction change**.

## Real exact-source test results

| Test | Confirmed outcome |
|---|---|
| [Ubuntu core C++ run 41355569056](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41355569056) | **13/13 PASS**, expanded `vehicle_rental_p3_rental_model` |
| [Qt 6.8.3 Linux GCC native run 41355569057](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41355569057) | **70/70 PASS**, new real wide/compact `rental_studio_p6_recent_activity_*` |
| [Qt 6.8.3 Windows Server 2022 MSVC native run 41355569057](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41355569057) | **70/70 PASS**, same two real UI tests, plus previous `rental_studio_p5_overview_compact` |
| Windows package checks (same native workflow) | **PASS** on PowerShell 7 and Windows PowerShell 5.1; physical Windows scaling/Narrator/owner acceptance explicitly **not tested** |

**Core model test:** empty state, six fictional rentals bounded to four, latest ISO/same-day ID ordering, exact no-PII field allowlist, filter independence, full-snapshot active KPIs, nonmutation of protected bytes, status changes only after genuine domain return + refresh.

**Real QQuickWindow tests:** correct initial R001/R002 order, original protected and disposable ledger byte equality, History/Archived filter independence, off-screen recent row scrolled into physical Qt viewport at both 1500×860 and 1280×720, live screenshot capture, keyboard Space on R002 selecting previously hidden historical contract and navigating to Rentals with no write; prior Overview action and disclaimer regression remains green. Screenshot capture proves native output at test sizes, not physical owner OS scaling.

## Unresolved and acceptance boundary

P6-I recent **contract** gap is covered by verified implementation. A true return/archive audit event stream remains unsupported by existing source timestamps. Remaining operator/product decisions: whether to show legacy Fleet utilisation/class KPIs individually, how much rental date/contract detail to show, and whether any purpose-limited customer information should ever be visible. **Do not add PII roles without authorization.** Commercial vehicle retirement and records retention, P7 storage/migration/integer-cent IDs/transactions, P8 packaging, P9 physical Windows Narrator/scale and final visual signoff remain open.

P6's original nine-point acceptance interpretation remains **provisional** (eight groups automated-covered, one broad full-parity group open); no formal criterion granted by this implementation alone. **Formal P4 5/7, P5 0/8, P6 0/9, programme 28/74 accepted and 40.6% evidence-weighted unchanged.** Documentation-only updates after this exact tested SHA do not establish additional feature tests. Next recommended: P6-K purpose-limited rental detail presentation review and owner utilisation/type card decision.
