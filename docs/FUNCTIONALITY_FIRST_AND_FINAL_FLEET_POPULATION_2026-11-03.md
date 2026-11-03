# Rental Studio 2.0 | Functionality first, final fleet population last

**Owner instruction: 3 November 2026.** This is the current sequencing directive. It supersedes earlier project suggestions that final photo sourcing should be the immediate next development task. It does **not** rewrite the frozen P0-P9 acceptance matrix or erase historical engineering/photo evidence.

## Immediate objective: a functioning desktop product

Concentrate development on the **app's actual end-to-end operations**, not the number or visual polish of test vehicles.

| Functional stream | Present evidence | What remains to be proven or decided |
|---|---|---|
| Application launches and navigates | Latest [Qt source `03831a7`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/03831a790db4429487a20ddfa56f3d6546c38c8a) passed [117/117 native CTests on each Linux/hosted Windows Qt 6.8.3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884) | Owner's own Windows physical operation and accessible keyboard/screen scaling/Narrator review are still unverified |
| Fleet operations | P6 9/9 **owner accepted** for bounded generated-fictional create/remove and lifecycle behaviours | Validate complete actual operator workflow on-device; address only reproduced defects |
| Quotes, bookings, returns, rentals | P5 8/8 **owner accepted** for bounded fictional operational workflow; P3 typed domain 7/7 accepted | Test and fix visible user journey regressions; preserve authoritative C++ validation and receipt semantics |
| Data durability and recovery | Fictional QSaveFile default and generated-fictional opt-in SQLite Lab D1 already native-tested | D2-D8 commercial IDs, money, backup, retention, privacy, migration/real data cutover and failure policy require explicit owner approval |
| Offline Windows deployment | A disposable Windows **physical acceptance kit** is emitted by hosted CI and portable checks pass | Installer/update/uninstall licensing, packaging and physical machine signoff are **not yet certified** |
| Release | PR #17 draft stacked on P6, not `main` | P8/P9 approvals, security/privacy, hardware QA and explicit owner release decision remain open |

**Near-term execution order:** runnable Windows demonstration -> complete fictional operational user journey -> persistence/error/rollback regressions -> P7 policy decisions and fictional-only technical tests -> offline Windows distribution and physical QA -> final fleet population -> explicit P9 release approval. This is a planning order; no new stage is formally accepted merely by being listed.

### Demonstration acceptance walkthrough

On a Windows desktop with fictitious seed records, verify startup and workspace navigation, create a vehicle, see it in Gallery and Table, search/filter/select it, quote and book available stock, see the rental, return it, handle archived/deleted records according to the approved fictional rules, restart and confirm expected persistence, then deliberately test rejected input and denied writes without false successful receipts. Record exact source SHA, OS/kit, screenshots and failures. Hosted Windows CI is supporting evidence **not** proof of this physical end-user run.

### Engineering rules until this is done

- No repetitive stock-photo sourcing, licence-chasing, crop review or custom illustration development unless the owner explicitly reopens the final fleet visual task.
- No need to add demo vehicles merely to make the UI look populated. Current **five generated-fictional vehicles** are enough for initial functional journeys; additional synthetic data may be created only as temporary tests of scaling or failure modes.
- Do not silently change P5/P6 accepted flows or invent an unapproved permanent fleet cap.
- Keep desktop app working offline, preserve exact-money/identity and transaction boundaries, and keep fictional demo data separate from real customer data.
- No new live/imported personal records, no unapproved default SQLite cutover, no destructive real-data deletion policies, no PR merges or release before authorization.

## Final section: Fleet Population & Visual Catalogue

This is a **dedicated final owner-facing stage**, postponed until the functionality is stable and usable.

1. Owner chooses the **initial number and categories of fleet vehicles**. No fixed number has been agreed, and this is not a system capacity limit.
2. Establish permitted source of those entries: generated fictional demonstration data or separately authorized lawful business fleet data. For real entries, resolve the P7 privacy, retention, backup and migration decisions first.
3. Populate vehicles through approved Fleet creation/import paths, retaining stable identifiers and valid rates/availability; do not bulk-add through unsafe direct database writes.
4. Confirm sorting, search, Gallery/Table/Inspector, availability, rental lookup, persistence, correct identity after re-open and performance at the chosen population. Run higher-scale synthetic stress tests separately; a test size is not a promised production maximum.
5. Source and verify only needed model-appropriate photos, lawful usage rights, crop/plate/privacy treatment and owner visual approval. Use truthful illustrations/placeholders where a lawful photo is absent.
6. Complete the P1 imagery acceptance gate and owner final presentation review **before** release signoff.

Existing PHOTO-P1-D through H screenshots, safe offline candidate review tools and [Pexels i20 research](../design/photo_review/PHOTO_P1_H_PEXELS_I20_SOURCE_RESEARCH_2026-11-03.md) remain available as background for this final stage. Original image acquisition and approval were **not completed**, and cannot be represented as done.

## Progress and governance

Formal owner-accepted status at this directive: **45/74 criteria, weighted 70.6%**, reflecting the frozen rubric, **not** an estimate of remaining engineering time or release readiness. P1 7/10 remains partly open; P2/P4 physical Windows remain open; P7 0/8, P8 0/6 and P9 0/8 remain open. P5/P6 accepted test behaviours stay accepted. `main` remains unchanged, draft PRs stay unmerged, and photo finalization is delayed, not discarded.
