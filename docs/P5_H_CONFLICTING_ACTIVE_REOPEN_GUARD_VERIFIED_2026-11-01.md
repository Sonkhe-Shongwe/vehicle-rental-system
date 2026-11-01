# P5-H | Conflicting Active Contract Guard and Readiness Audit
**1 November 2026 | Source `bc5fa2fd740799f75e731ed7d807f5ecc5465626` | Draft PR #12**

## Concrete defect found

The opt-in `--persistent-fictional-demo` session used `P5SyntheticSession::syntheticLedger()` to reject unexpected files, unknown vehicle IDs, malformed rental fields, duplicate rental IDs, real/non-fictional contact names, foreign phones and altered source fixtures. It **did not** check that a vehicle appears in at most **one active rental record**. Meanwhile `RentalSystem::loadRentalsFromFile()` guards against a second active contract for a given vehicle by skipping that conflicting record. A manually modified but otherwise fictional-looking persisted file could therefore be accepted by the session validator, while the UI reconstructed fewer contracts than the underlying ledger actually contained. This is a correctness issue in the fictional-only demo boundary, not an approved production data scenario.

## Implemented fix

- `spikes/qtquick_p2/p5_synthetic_session.cpp` records active vehicle IDs in a `QSet<QString>` during the *existing* strict validation pass. A second active row for the same vehicle now makes the **entire session fail closed** before construction of `RentalSystem`. Returned or archived historical records for the same vehicle remain legal.
- `spikes/qtquick_p2/main.cpp` extends the existing **separate native executable process** P5 session-tamper CTest. It appends a correctly formatted fictitious `R998` active rental for `C002` (fictional Ranger already active in immutable `R001`), expects P5 session open to reject it, restores the prior ledger with an atomic `QSaveFile`, reopens the genuine session successfully and byte-compares the restored ledger. Existing unknown-file and non-fictional-customer injections remain active.
- No C++ rental business rules, app-facing booking UI, original SHA-verified fixtures, general storage setting or live customer data changed. No tests were removed.

## Actual exact-source verification

| Environment | Evidence | Result |
|---|---|---|
| Core/legacy C++ | [Run 41312855685](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41312855685) | **13/13 PASS** |
| Native Linux GCC Qt Quick 6.8.3 | [Run 41312855684](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41312855684) | **60/60 CTests PASS**, including `rental_studio_p5_session_tamper` |
| Native Windows MSVC Qt Quick 6.8.3 | Same native run | **60/60 CTests PASS**, including the new contradictory-active-vehicle injection |
| Hosted Windows relocated EXE, protected fixtures | Same native run | Deliberately wrong source fixture rejected. Four packaged P4 checks pass separately in PowerShell 7 and Windows PowerShell 5.1. |
| Native screenshots and kit | Same run | Linux/Windows screenshot artifacts and fictional-only Windows acceptance kit uploaded; **not physical owner review** |

All claims above were checked against actual GitHub Actions job logs and completed run conclusions, not merely source or assertions.

## Consolidated P5 acceptance preparation

The original eight P5 expectations are mapped to native automated cases in [P5 Acceptance Evidence Crosswalk](P5_ACCEPTANCE_EVIDENCE_CROSSWALK_2026-11-01.md). **All eight have representative automated coverage**. Separate formal owner acceptance is not implied and remains **P5 0/8**. The existing P4 Windows physical Narrator, 100/125/150% display scaling, Qt Creator/MinGW and visual signoff also remain open. User asked to avoid repeated PowerShell/manual QA, so any later review should be **one consolidated actual product walkthrough**, using the real executable/screenshots and including visual clarity, selected item, booking quote, confirmed receipt, cancellation, reload and disabled duplicate booking. No new manual task is assigned in this increment.

P4 remains **5/7**. Programme formal accepted criteria remain **28/74**, evidence-weighted **40.6%**. These are acceptance counts, **not actual engineering completeness**. Neither PR #12 nor its P4 ancestor Draft PR #10 is merged; the stable `main` is untouched. Do not start general customer storage/migration, release or P6 without respecting existing owner gates.

**Next development decision:** Avoid inventing new P5 features when its eight groups already have automated evidence. Prepare a single owner-facing P5/P4 visual review from GitHub artifacts and only address concrete visual or integration defects that it exposes. The remaining acceptance gap is primarily review/approval, not an absence of C++ bookings.
