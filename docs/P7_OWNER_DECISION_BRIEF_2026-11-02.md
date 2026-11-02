# Rental Studio | P7 owner decision brief (proposed, not approved)

**Prepared:** 2 November 2026. **Decision status:** OPEN, owner authorization is required for commercial cutover and real-data processing. This is a compact decision surface that *summarizes* the longer [P7 storage ADR](P7_A_STORAGE_ARCHITECTURE_ADR_DRAFT_2026-11-02.md), [eight provisional acceptance groups](P7_A_MIGRATION_AND_TEST_CONTRACT_2026-11-02.md), and [legacy hazards](P7_A_SOURCE_STORAGE_AND_MIGRATION_RISK_AUDIT_2026-11-02.md). Historical reports remain authoritative evidence; this brief does not revise them. No approved production schema, retention duration or legal conclusion is implied.

## Product scope for the decision

A **single-operator, offline-first Windows** app with QML presentation and C++-owned commands, validation, pricing and persistence. The existing normal Qt Quick executable remains a **protected fictional QSaveFile demo**. The normalized SQLite repository is compiled only into opt-in fictional P7 tests. Source and CI prove candidate engineering, not permission to store real vehicle/customer records, handle identification, import historical files, or distribute commercially.

## Decisions to approve together

| ID | Recommended default for owner review | What it governs | Unresolved choice / required condition |
|---|---|---|---|
| D1 Storage engine | One local SQLite database via QtSql/QSQLITE, typed C++ repository and one authoritative business transaction | Atomic booking, ID, return, archive and occupancy; no SQL in QML | Approve SQLite and single-operator scope; otherwise continue fictional-only |
| D2 Exact money | Signed 64-bit **integer cents** for authoritative rates and totals, strict 2-decimal input and overflow checks; booked value is not collected revenue | Quote, commit, historical reconciliation | **Owner must approve explicit daily-rate and contract-total ceilings** before real pricing. No arbitrary cap silently inserted in code |
| D3 Public identity | Stable, case-insensitive C/M/R IDs, never reused; durable counters and issued-ID/high-water import | Historical contract identity, deletion/retirement, restart | Approve a high-water policy for unknown past deleted IDs; ambiguous histories block import |
| D4 Vehicle and rental lifecycle | Retire vehicles non-destructively; keep returned and archived contracts referentially intact; no default commercial hard-delete | Fleet, historical evidence, archive | Approve retention and lawful deletion/exception procedure; synthetic P6 hard-delete does not authorize production deletion |
| D5 Customer and legacy driver's-licence fields | **No real contact/license records in any current sandbox.** Prefer minimal separately controlled contact data only after documented purpose, access, display, redaction, retention and deletion decisions. Do not import old driver's-licence values automatically | Future business booking, import and support | Owner privacy policy/rights review and explicit real-data authorization required, including backups and diagnostics |
| D6 Local root and backup | Approved app-local directory via `QStandardPaths::AppLocalDataLocation` and a consistent SQLite Online Backup API snapshot; explicit restore to isolated location with integrity and FK checks | Filesystem, failure recovery, update/uninstall | Owner to decide permissions, backup encryption, backup location, retention, restore authorization and crash/disk-full behavior |
| D7 Legacy migration | Explicit user-initiated **read-only preflight**, no partial loading, never silently fix 7/13/14-field inconsistencies. Stage separately, reconcile counts/IDs/money, verify independently before cutover | Existing text-file fleet and rentals | No automatic launch migration, imported PII or legacy-source deletion. Unresolved anomalies stop activation |
| D8 Acceptance & rollout | Preserve the frozen eight candidate P7 groupings until owner ratifies them; test exact SHA across Linux and Windows, then physical MinGW/100/125/150%/Narrator, backup and privacy reviews | Formal milestone acceptance and release | Owner must approve rubric and separate final go/no-go; CI passing alone awards no P7 points |

## Recommended implementation sequence *after* owner authorization

1. Finalize D1-D8, including specific monetary ceilings and privacy/retention/backup rules; record decisions in an owner-signed ADR version without rewriting historical proposals.
2. Introduce a **fictional-only** selectable SQLite adapter to the normal C++ controller boundary, with the existing QSaveFile fictional demo still the default; cross-check Fleet, Rentals, Overview, quote/confirm/return/archive and rollback on an identical synthetic session.
3. Complete independent Windows crash/lock, backup/restore, versioned migration, no false receipt, secure local path and cross-version checks. Keep personal data disabled.
4. Only after separate security/privacy/owner authorization, add narrowly permitted real-data storage/import and P8 offline installer, followed by P9 release QA.

## How to record approval

An unambiguous owner response can state **"Approve D1, D3, D4, D7 and the fictional-only integration path; hold D2, D5, D6 and D8 pending details"**, or approve/revise each individual row. **Silence, "continue", a green CI run or this document do not count as approval.** The owner may approve *fictional-only engineering* independently of any real-contact or commercial-data authorization.

**Current acceptance stays:** 28/74 formally accepted, weighted 40.6%; P5 0/8, P6 0/9, P7 0/8; P8/P9 not started. Main remains stable, PR stack draft/unmerged.

This is an engineering decision aid, **not legal advice**. Data protection, rights and retention must be validated before commercial release.
