# Rental Studio 2.0 | Active P0–P9 Roadmap

**Current as of 30 October 2026.** [State](PROJECT_STATE_CANONICAL.md) · [Full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) · [Exact acceptance plan](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md).

One evidence-based schedule: **P0–P9**, not additional independent R0–R8/G0–G9 percentages. The older stage identifiers in historical plans remain research-level analogues.

| Phase | Scope | Weight | Verified | Gate |
|---|---|---:|---:|---|
| P0 | Safe historical baseline | 5% | 5/5 (100%) | Documented |
| P1 | Whole-product owner design, imagery, accessibility | 12% | 7/10 (70%) | OPEN |
| P2 | Qt Quick/C++ feasibility on real Windows hardware | 10% | 3/6 (50%) | OPEN |
| P3 | Typed application/domain services | 12% | 0/7 | Not started |
| P4 | Native components, focus/navigation, state | 12% | 0/7 | Not started |
| P5 | Actual persisted Corolla rental + restart/negative cases | 16% | 0/8 | Not started |
| P6 | Full feature parity Fleet/Rentals/Returns/History | 14% | 0/9 | Not started |
| P7 | Storage hardening, IDs, money, migration decision | 9% | 0/8 | Not started |
| P8 | Offline deployment/installer, rights/privacy | 5% | 0/6 | Not started |
| P9 | Real final QA and owner release approval | 5% | 0/8 | Not started |

**Overall: 15/74 accepted checks, 18.4% weighted coverage, NOT production release readiness.**

P2 is **actively implemented and hosted-tested** (8/8 Qt CTests Windows and Linux). Owner's Qt Creator local Fleet app also launched, with screenshot-confirmed Gallery/Table/Inspector/Available/Rate/Escape. Remaining physical Windows 100/125/150% Settings scale, measured window dimensions/live resize, complete Tab/focus verification and explicit Qt Quick go/no-go are required to close the gate. In parallel P1 requires final visual owner signoff, licensed model-matched images and accessibility.

**Approved controls plan (UX-CTRL-001):** [Binding interaction contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md). P2 validates and, when needed, corrects Fleet arrows, Tab, selection and scroll on real Windows. P3 separates focus/currentIndex from C++ selected-ID state. P4 implements a **minimal** shared focus indicator, native focus scopes and component conventions. P5/P6 add safe guided form/modal/list semantics with each feature. P9 verifies physical keyboard and assistive access end to end. **Design-policy approval is not a new P4 accepted check or progress percentage.**

After gates, begin bounded P3 typed C++ services, P4 shared native Qt UI with **group-local keyboard arrows and Tab navigation**, P5 durable Corolla rental vertical slice, P6 complete parity, P7 storage decision, P8 Windows install and P9 QA/release. Preserve business rules and data safety, no full rewrite or premature SQLite.

**Review branches:** code in [P2 Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) (unmerged) and planning docs branch; stable main protected by process. Historical roadmap preserved [in archive](archive/ROADMAP_PRE_CANONICAL_AUDIT_2026-10-30.md).

When user requests another bounded task, perform that task directly, without forcing unnecessary P2 steps; never infer acceptance merely because hosted CI is green.
