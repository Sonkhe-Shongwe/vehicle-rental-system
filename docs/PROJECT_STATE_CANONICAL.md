# Rental Studio 2.0 | Canonical product and governance state

**Reviewed 3 November 2026.** Source-level evidence and dates are in [Latest checkpoint](LATEST_CHECKPOINT.md), not duplicated as a rolling changelog here. [Roadmap](ROADMAP.md) | [Testing](TESTING.md) | [Formal acceptance](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md).

## Product contract

- **Brand:** Rental Studio. A proposed logo is not production-approved artwork or trademark clearance.
- **Purpose:** premium-quality, offline-first Windows vehicle-rental operations software, initially validated only with protected generated-fictional records. "Commercial-grade" is a **quality ambition**, not permission to market, release, migrate customer data or switch production storage.
- **Presentation:** Qt Quick/QML, light-first Midnight Navy `#17324D`, Emerald Teal `#0F766E`, Cloud White `#F6F8FA`, Ice Blue `#EAF0F4`, Soft Mint `#E8F5F0`. Three core workspaces: operational Overview, Fleet Gallery/Table/Inspector, Rentals. Preserve compact layout, focus order and accessible feedback.
- **Authority:** typed C++ domain/business logic owns quote, pricing, availability, rent, return, archive, record identity, validation and persistence outcomes. QML displays results and user intent; it is not a second business-rule authority.
- **Current normal storage:** domain-protected QSaveFile and fictional fixtures. The owner-approved **D1** SQLite candidate is limited to opt-in generated-fictional P7 Lab/test paths, not the default production store. P7 D2-D8 commercial policies remain undecided.
- **Core invariants:** prevent duplicate/double bookings, stale quotes, invalid dates and amounts, false successful receipts, unintended cancellation writes, unsafe deletion and failed-write corruption. Preserve transactional rollback and stable IDs. Do not silently change deliberate modern Qt Quick parity differences accepted with P6.

## Actually implemented vs not approved

**Implemented and native-tested (bounded scope):** C++-backed Fleet and Rentals lifecycle, Overview, photo-safe rendering/focus and explicit Gallery/Inspector reference-image versus illustration labels (UX-Q6), generated-fictional SQL Lab experiments, negative/rollback/keyboard scenarios. Exact compiled source, OS and run are in [LATEST_CHECKPOINT](LATEST_CHECKPOINT.md).

**Not demonstrated by that evidence:** owner physical Qt Creator/MinGW on the current source, real OS 100/125/150% scaling, Narrator acceptance, P1 final imagery quality/licence approval, commercial privacy/retention/migrations/backups, offline distributable installer, signed release or full customer-data readiness.

**Forbidden without separate approval:** real customer, phone or driving-licence data; general import; changing default storage to SQLite; commercial cutover; destructive real-data retirement rules; release, PR merge, `main` edits or force push. Keep fictional SHA-pinned fixture restrictions and temporary-session safeguards intact.

## Acceptance authority

The 74 criterion units and phase weights are frozen in [P0-P9 ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md). At this 3 November snapshot: P0 5/5, P1 7/10, P2 4/6, P3 7/7, P4 5/7, P5 **8/8 owner accepted**, P6 **9/9 owner accepted**, P7 0/8, P8 0/6, P9 0/8. **45/74, weighted 70.6%**. Do not treat the number as percentage code completion, interface quality score or release readiness. New acceptance requires evidence meeting that criterion and any specified owner decision.

## Source precedence

1. Current live GitHub implementation, branch heads, PR bases and genuine Action logs for implementation claims.
2. Documented owner decisions and normative acceptance/security contracts for permission and signoff.
3. [Latest checkpoint](LATEST_CHECKPOINT.md) and [testing policy](TESTING.md) for the last audited snapshot.
4. Dated prior reports and [historical Git revision](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/22fd40375ecc68c464e2bbb6a12e197a35e9a376/docs) for the historical record, **not** a competing live status.

No autonomous agent may infer a product decision or signoff from an older draft or a passing job.
