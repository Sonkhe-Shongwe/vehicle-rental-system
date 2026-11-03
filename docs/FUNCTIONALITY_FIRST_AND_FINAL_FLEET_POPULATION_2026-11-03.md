# Rental Studio 2.0 | Functionality first, final fleet population last

**Functionality-first response to an observed GUI blocker (UX-S1):** The owner's actual Windows Rentals screen showed bottom records inaccessible. [UX-S1 tested source `d12fad5`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/d12fad5a57714ab8cae45b150563cd33ae8f4210) / [native run 41680556750](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41680556750) **120/120 native Qt CTests EACH Linux/Windows** and Windows 8/8 deployed package regression PASS. Full Rentals page now scrollable with visible scrollbar/keyboard and stable modal placement. User physical retest remains OPEN; [new Windows QA package](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41680556750/artifacts/13253545978); [UX-S1 evidence](UX_S1_RENTALS_PAGE_SCROLL_ACCESSIBILITY_NATIVE_VERIFIED_2026-11-03.md). Next: follow observed laptop defects, then P7 owner-gated data persistence/backup decisions and deployment; final Fleet Population/Photos LAST.

**Earlier functionality-first verification (FUNC-D2):** [FUNC-D2 source `ba8665c`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/ba8665c72ef0d4fbdeb2e2ac62756ca540cad41c) / [native CI 41671235333](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41671235333), **118/118 native CTests EACH** Linux/Windows plus real relocated Windows package **8/8 user-runnable fictional functionality checks PASS**. A new optional `Check-Rental-Studio.cmd` supplies one-click self-check and local RESULT/log evidence; normal GUI launcher still uses disposable data and resets on close. [portable Windows functional QA kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41671235333/artifacts/13247984391), [FUNC-D2 evidence](FUNC_D2_PACKAGED_END_TO_END_WINDOWS_FUNCTIONAL_CHECK_VERIFIED_2026-11-03.md). Next meaningful milestone is owner-on-device Windows walkthrough and then P7 policy-gated persistence improvements, not repeating catalogue photo sourcing. The final Fleet Population section remains LAST, formal **45/74 weighted 70.6%** unchanged.

**First completed functionality-first technical milestone (FUNC-D1):** [FUNC-D1 compiled source `25661db`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/25661db7c8d53b1d274534baf55d37e9c25c04ee) / [native run 41666259382](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41666259382) native Qt **118/118 CTests each Linux/hosted Windows**. Actual QScreen logical work-area startup fit and a self-verified double-click Windows fictional demo launcher are now built and downloadable as a portable QA ZIP; `START_HERE_FUNCTIONAL_DEMO.md` describes the user journey and temporary-data reset. [portable Windows QA kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41666259382/artifacts/13247085314); [FUNC-D1 report](FUNC_D1_WINDOWS_LAUNCH_AND_SCREEN_FIT_NATIVE_VERIFIED_2026-11-03.md). The next important evidence is a **real user physical Windows session**, not another screenshot polish or catalogue expansion. Final Fleet Population remains LAST. P7 data-policy and P8 installer/release gates unchanged.

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
