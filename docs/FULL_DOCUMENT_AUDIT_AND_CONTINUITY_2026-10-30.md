> **LATEST AUTHORIZED ENGINEERING STATE (30 October 2026, after formal owner GO):** The owner explicitly **APPROVED Qt Quick/QML presentation + authoritative C++ domain** and authorized the first narrow P3 implementation while keeping P1/P2 outstanding checks open. This satisfies the distinct P2 **technology go/no-go** decision criterion, **not** the physical Windows or full visual signoff. Evidence-weighted baseline is now **P0 5/5, P1 7/10, P2 4/6 (66.7%), P3 0/7**, **16/74 accepted checks, 20.1% weighted coverage**, **NOT release-ready**. P3-A isolated branch [`feature/p3-typed-fleet-read-20261030`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/feature/p3-typed-fleet-read-20261030), [Draft PR #7](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/7), implements a **by-value typed C++ FleetReadService** and modifies only the read-only Qt Quick Fleet model to consume summaries. At code SHA [`9fa9028`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9fa9028f81cb894f93e1cbc5fe5e6738b07df4b8), **Linux 11/11 and Windows 11/11 native Qt6.8.3 CTests PASS** [41071876101](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41071876101), plus Qt-Core-only Linux 3/3 [41071876017](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41071876017) and Windows portable fictional-data safety PASS. **P3 remains 0/7 pending formal acceptance of full criteria**, despite working tested code. Exact owner Qt6.10.2 MinGW SHA/CTest, actual supported physical scales, keyboard smoothness, P1 final design, images/a11y remain OPEN. **Stable main and Draft PR #6/#7 unmerged.** Older 3/6 and 18.4% figures below are historical snapshots **before** this formal owner GO.

> **LATEST P2 FLEET KEYBOARD CHECKPOINT (30 October 2026):** Owner confirms **Tab and Shift+Tab worked** locally but reports **Gallery arrows merely scrolled instead of selecting vehicles** in the previous Qt Creator build. [Source fix `f486c8a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f486c8a32b156ddeec1816b2ab2a4811c2c45431) now makes Gallery arrows select spatially adjacent C++ vehicle IDs (Up/Down/Left/Right), Table Up/Down select rows, and keyboard focus visibly distinct from selection. Text field/combo arrows retain native behaviour, Tab/Backtab traverse groups. [Qt6.8.3 Actions run 41059423971](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41059423971) **PASS 9/9 native CTests Linux AND 9/9 Windows**, including new real keyboard arrows, no stand-alone Gallery scroll, search caret noninterference, filter parity, Tab/Shift+Tab, and previously verified portable fake-fixture safeguards. **New source has NOT yet been pulled/rebuilt/accepted on owner's Qt6.10.2 MinGW PC:** focus order/smoothness, hardware scale and full-product accessibility pending. **P2 remains 3/6 (50%), weighted coverage 18.4%**, not release readiness. Historical 8/8 results or 'no arrows implemented' text below represent an earlier code stage.

# Rental Studio 2.0 | Full Documentation, Engineering Evidence and Continuity Audit

**Audit edition:** 30 October 2026 · **Scope:** entire live product-rebuild documentation and source-branch P2 evidence as of the audited commits. **Outcome:** synchronized authoritative state + general-purpose continuation prompt + corrected living guides, without C++/QML changes or branch merges.  
**Read first:** [CANONICAL CURRENT STATE](PROJECT_STATE_CANONICAL.md) for operative facts; [AI CONTINUATION PROMPT](AI_CONTINUATION_PROMPT.md) for the handoff procedure. This audit is the detailed evidence trail, not a competing mutable status list.

**New real physical Windows display-settings evidence (30 October 2026):** User screenshot of **Settings → System → Display** confirms **150% (Recommended)** scale, **1920 × 1080 (Recommended)** physical resolution and Landscape orientation. The Settings screenshot contains personal account identifiers, so only its technical values are logged on [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5#issuecomment-6523145162), never the full image. This verifies the OS **setting**, not a simultaneous Qt app rendering at that scale, physical 100/125% behavior, full keyboard support or a measured 1500×860 logical viewport. At 150% the nominal logical desktop is ~1280×720 before taskbar, so a 1500×860 logical window cannot fit fully; don't call that clipping a UI defect. **P2 still 3/6, weighted 18.4%.**

## Latest P2 keyboard navigation acceptance addendum (30 October 2026)

Owner reported local Tab and Shift+Tab working but Gallery arrows scrolling rather than selecting vehicle records. Targeted fix [`f486c8a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f486c8a32b156ddeec1816b2ab2a4811c2c45431) implements GridView spatial arrow selection (layout-dependent columns), ListView vertical row selection, visibly different focus borders, C++ proxy-backed selected vehicle ID, noninterference with search/combo arrows, and automatic scrolling only to reveal the newly selected vehicle. [Actual Qt6.8.3 run 41059423971](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41059423971) PASSED 9/9 native CTests Linux and 9/9 Windows, including `rental_studio_p2_arrows_focus` real key events, Tab/Shift+Tab and filtered-proxy cases. The same workflow passed Windows portable packaged smoke and demo tamper rejection. **This exact source was not yet tested on the owner's local Qt6.10.2 MinGW**, and the requested subjective smoothness/focus-accuracy review remains open. Other full keyboard accessibility and P4 reusable focus system remain pending. P2 3/6, total 18.4% are unchanged. Existing older 8/8, no-arrow and future-work descriptions in dated audit sections are history.

## Owner decision recorded: UX-CTRL-001 approved on 30 October 2026

The owner explicitly accepted the proposed **native Qt first, small interaction contract now, progressive per-feature implementation later** strategy. This supersedes the former comment labelled PROPOSED in [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5#issuecomment-6523732241) for **design policy only**. [Binding contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) records the complete focus/selection/command separation, key map, boundary rules, modal priority, accessibility, small implementation plan, test matrix and non-goals. Approved policy does not mean P2 on-device new-arrow smoothness passed, P4 is coded, or keyboard accessibility complete. No progress gate was credited, and there were no Qt/C++ implementation changes in this documentation decision.

**NEW P2 FLEET STATE/FOCUS REGRESSION (30 Oct 2026):** [Verified fix at `0f5668d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/0f5668d8ef359d84aa0901c0b5ccdb3ff8cb27df) now clears the selected Inspector if a filter hides the vehicle, keeps Gallery/Table keyboard `currentIndex` aligned to the stable C++ ID after query/filter/sort, and avoids stray boundary scrolling. Added real QML `rental_studio_p2_focus_edges` CTest. Initial [run 41064963032](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41064963032) FAILED 9/10 each due stale earlier model expectation; expectation fixed without disabling tests. [Run 41065470256](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41065470256) at exact source `0f5668d`: **Linux Qt6.8.3 10/10 PASS, Windows Qt6.8.3 10/10 PASS**, Windows portable packaging PASS. [Detailed test evidence](P2_FLEET_FOCUS_EDGES_VERIFIED_2026-10-30.md). **Owner's latest Qt6.10.2 MinGW physical focus smoothness and 150% app-at-scale review PENDING**, P2 3/6 (50%), weighted 18.4% unchanged. UX-CTRL-001 remains owner-approved design only, not full hardware gate.

## Executive findings

**The project is no longer merely planning a Qt Quick experiment.** Hosted Ubuntu/GCC and Windows/MSVC Qt6.8.3 have genuinely compiled the read-only C++/QML P2 spike and passed 8/8 CTests. A tested portable Windows QML/Qt review kit exists. Crucially, the owner has also *actually built and opened the read-only Fleet application in Qt Creator on a Windows computer*, then supplied screenshots confirming selected Corolla, synchronized Gallery/Table/Inspector, correct Available and Rate sort, and explicit Escape-to-clear. **This advances confidence in native feasibility but not automatically the composite P2 3/6 gate.** A physical Windows **150% Settings baseline** is now documented; app behaviour at that recorded scale, comparisons with other supported settings, complete keyboard/accessibility and explicit toolkit decision remain open.

**The primary documentation defect** was inconsistent chronology: long chains of dated Markdown notes above unchanged old paragraphs implied mutually exclusive states such as `QML NOT STARTED`, `no visual palette selected` and `no owner Windows Qt launch`. Those lines were historically correct when written but misleading as current policy. Older research palettes and the 29 October 2026 reset audit should no longer override the owner-selected Navy/Teal theme. The audit resolves precedence rather than deleting credible evidence.

## 1. Evidence and materials actually inspected

The GitHub repository, both live branch heads, commit/tree inventories, open PR #3/#4/#6, Issue #5 and its most recent comments, current Actions runs, existing `docs/`, `design/` and P2 `spikes/qtquick_p2/` file inventories, dated masterplan and audit, P0–P9 table, old/replacement README, design contracts and P2 harness/checklist were examined. Specific live audited references:

- `main` `9bfca8786af1c64b0284a5a1bb3e2186573147a4`, untouched.
- Planning `docs/product-rebuild-reset-20261029` at `fbfdf78cbcc599bbe2924dbb2949b18dbb718c80` before this doc update.
- P2 `spike/p2-qtquick-fleet-20261030` at `e5474d6f39b415ecbfa9f232ab9a757df872b60f` before this doc update.
- [Owner Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5), including current local Windows evidence comments; [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6), based on the *planning branch*, not `main`.
- [CI run 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629) successful at actual P2 source `3620d835`; [follow-up 41048156914](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41048156914) successful on docs-only source-branch head `e5474d6`.
- Actual user-supplied Windows Qt Creator, Gallery, Table, Available/Rate sort and Escape screenshots from the current conversation. Screenshots themselves have no encoded git SHA or Windows scale setting and are not stored in the GitHub repo as attached binary artifacts.

**Limit of inspection:** The local Qt Creator machine was not accessed remotely, a local CTest log was not supplied, a Windows Settings screenshot subsequently captured the owner's **150% / 1920×1080** baseline (but not a simultaneous Qt app test), and the full corrected HTML review package lives as earlier conversation files rather than in GitHub source. GitHub record completeness does not imply that all those artifacts are versioned forever.

## 2. Document-by-document discrepancy register and disposition

| Source | Detected risk or dated claim | Correct handling after audit |
|---|---|---|
| `README.md` | “No replacement QML UI built,” obsolete sage/ivory visual candidate | Updated living front page summarises actual P2, owner-selected theme, branch/test links; old version retained in Git |
| `docs/AUDIT.md` | 29 Oct “not implemented,” old only Widgets risk register | Repoint to this full audit and canonical state, retain valid legacy technical risks |
| `docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md` | Old research says no palette/Qt proof | Preserve dated historical audit; annotate latest-state precedence rather than rewrite original findings |
| `docs/ENGINEERING_MASTERPLAN_RESEARCH_2026-10-30.md` | G0–G9 is a *proposal* and old G1 palette testing pre-dates selected PDF | Keep planning research, add clear current-state pointer and P0–P9 mapping |
| `docs/AI_HANDOFF_CURRENT.md` | 15kB of stacked chronological banners and obsolete core paragraph | Replace with concise current handoff and archive the previous full text |
| `docs/AI_CONTINUATION_PROMPT.md` | Prompt explicitly says no selected palette and R2 not started | Replace with portable **general-purpose** prompt covering ANY next task and requiring live-state verification; archive old text |
| `docs/P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md` | Multiple status banners, residual literal backslash-n escapes and stale “next P2 start” | Preserve exact weights/counts/formula; normalize table/status; link proof and current P2 owner checklist |
| `docs/ROADMAP.md` | Old R1 NEXT / R2 NOT STARTED under latest banner | Replace living summary with P0–P9 current gates; note older R nomenclature is historical mapping |
| `docs/ARCHITECTURE.md` | “Qt Quick not yet confirmed” without known compiled P2 fact | Clarify P2 *proof implementation* vs still-pending final architectural/toolkit signoff |
| `docs/TESTING.md` | “Rebuilt QML UI doesn't exist,” old CI restrictions | Summarise exact modern hosted 8/8 and local screenshots, prior failure and test scope; retain test policy |
| `docs/WINDOWS_ACCEPTANCE.md` | “NOT STARTED” even though owner has launched and tested parts | Replace with precise **PARTIALLY VERIFIED** checklist, keeping OS scaling and go/no-go open |
| `docs/CONTINUITY.md` | Append-only history can obscure current sequence | Keep dated historical record; add top canonical current-state pointer |
| `design/DESIGN_SPEC.md` / `design/README.md` | Older theme candidates in body | Latest owner PDF Navy/Teal overrides other colour proposals, label old body historical where it conflicts |
| `design/r1/*` | Older evidence says QML unbuilt, historically true then | Do not retroactively alter tested browser report; cross-link dated scope and current status |
| `spikes/qtquick_p2/README.md` | Source-prepared blockers and early no-build status appear near latest notes | Mark historical, foreground working local/CI Qt Quick and physical on-device checklist |
| `spikes/qtquick_p2/WINDOWS_PHYSICAL_ACCEPTANCE.md` | Manual steps exist, not fully executed | Link as operative P2 finish checklist; avoid inventing outcomes |
| `docs/archive/*` and old PR #3/#4 | Rejecting aesthetics might lead to accidental deletion of useful behavioral/test evidence | Keep historical with explicit NOT CURRENT labels; no merge |

The audit uses **current status by reference, historical documents by date**. Archived files are never silently claimed to be current; Git revisions provide a complete restore route.

## 3. Owner decisions and approved scope

Visual direction is selected, not final art signed off. The nine-page owner PDF anchors Midnight Navy `#17324D`, Emerald Teal `#0F766E`, Cloud White `#F6F8FA`, Ice Blue `#EAF0F4`, Soft Mint `#E8F5F0`. Three workspaces: Overview (operations), Fleet (vehicles and linked Gallery/Table/Inspector), Rentals (Vehicle/Customer/Review, quote not payment, active/history/return). The Rivian/Arc/Tide Guide study is inspiration, not a competing palette. Historical dark graphite/lime, plain blue and speculative sage/copper are *not* new choices.

Owner has specifically requested keyboard navigation that feels spatial and intuitive. **Accepted design principle:** group-local arrows where semantically coherent, Tab between groups, Enter/Space activation, Escape dismissal, never globally hijack text-field arrows. This belongs to P4 reusable component behavior; not a claim arrow navigation exists today. Owner has already explicitly verified Escape works.

No future reservation support, `Pending` bookings, persistent `Save draft`, payments, multi-user login, web client, AI, cloud or new external API is authorized by design illustrations.

## 4. Functional, architecture and data preservation audit

Current legacy C++17/Qt Widgets behavior must survive the new visual architecture: Car/Motorcycle, derived availability, add/remove/search, same-day 1–365-day rentals, price/day calculation, validation, double-booking refusal, cancellation without write, return/repeat-return, archive/delete constraints and restart reconstruction.

Legacy risks were not magically repaired by P2: `double` money rather than integer cents, deletion-related ID reuse, source-relative storage, two individually atomic but not jointly transactional QSaveFile saves, incomplete malformed-row reporting and legacy MainWindow coupling. Preserve fake fixtures and no real customer content. Separate P3 C++ boundaries, P5 end-to-end durable Corolla slice and P7 persistence/SQLite choice before claiming operational replacement.

P2 app, by contrast, reads source-compatible domain objects through a typed C++ QAbstractListModel and QSortFilterProxyModel, in `QTemporaryDir`. The CI distribution only loads hash-pinned fictional fixture copies; no mutation controls or production filesystem writes are exposed. Native Qt Quick is **technically proven viable for a limited Fleet demonstration**, not selected formally as the final toolkit.

## 5. Verification provenance and regression history

**Browser review:** selected-theme interactive HTML, 19 original and 63 targeted browser checks; source/deliverable historical, not compiled app proof.

**Native P2:** 8/8 Qt6.8.3 tests on Ubuntu/GCC and Windows Server/MSVC on [41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629) at `3620d835`. Includes two historical Widgets domain/GUI tests, Fleet C++ model, QML 1500×860/1280×720, keyboard selection/Escape and live resize, synthetic 125%/150% scaling; Windows `windeployqt` portable executable launched in relocation and rejected altered demo fixture. [41048156914](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41048156914) also reports green at later docs head; a docs-only green run does not introduce new feature tests.

**Honest failure history:** initial native Windows offscreen glyph rendering produced tofu; initial hosted 1028px display truncated intended 1280/1500 captures; layout Inspector clipping corrected; expanded test initially failed 7/8 [41045247197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045247197) until visual-tree row lookup fixed at `eeb0848`. Final native checks pass with screenshot pixel dimensions enforced. Do not wipe failed runs from records.

**Actual owner Windows PC:** observed Qt Creator MinGW kit and local compiled P2 Fleet, C001 selected Inspector, state sync Gallery→Table, proper Available four, four-rate order and Escape resets selection. Some screenshots show a partially scrolled Gallery row; track as an open observation, not a confirmed software bug. Exact local branch SHA, `ctest` execution, **the application rendered alongside recorded 150% scale / supported 100% and 125% comparisons**, and detailed key-navigation results are **not recorded**, and must not be inferred from PNG dimensions.

## 6. P0–P9 audit and readiness integrity

**Original pre-GO baseline:** Weights sum 100%, 74 criteria across ten phases. At that earlier point verified: P0 5/5, P1 7/10, P2 3/6, others zero; **15/74 and weighted 18.4%**. The owner subsequently signed the Qt Quick decision criterion, so the current baseline is 16/74 and 20.1%. P0 contributes 5.0; P1 8.4; P2 5.0. This is *accepted checklist evidence coverage*, not app-shipped ratio. P1 art/accessibility/owner signoff remain open; P2 owner physical Windows and toolkit go/no-go remain open. P3–P9 are not started. Every future percentage change must identify exact criterion, platform, version, run, screenshot, date and required owner decision. **Do not mark a compound P2 physical scaling check passed from synthetic Qt scaling or basic local screenshot.**

P0–P9 is the operative progress schedule. Historical R0–R8/G0–G9 describe research gate analogues, not a second progress ledger. Do not calculate a competing percentage from them. The downloadable XLSX from prior conversation can be updated once its *actual file* is accessible; the GitHub Markdown criteria are the authoritative current total meanwhile.

## 7. Risk register, ranked and actionable

| Severity | Risk | Owner / mitigation | Open result |
|---|---|---|---|
| Critical | Wrong toolkit or inconsistent physical DPI on owner's actual Windows PC | P2: screenshot supported scales at both desktop sizes; record Qt Creator/compiler and explicit go/no-go | OPEN |
| Critical | Existing rental behavior silently lost in new QML rewrite | P3/P5/P6: characterization + end-to-end C++ persistence / restart / negative tests | OPEN, no rewrite authorized |
| High | Data corruption / ID reuse / double-money / no joint transaction | P7: versioned storage decision, safe backup and reversible migration, integer cents | OPEN |
| High | Historical visual documents override selected design | Canonical current state and prompt, archive outdated competing claims | Corrected by this documentation audit |
| High | Accidental merge of old PRs or main | Separate doc and spike branches, draft PRs, exact refs, no force-push | Guardrail |
| High | Pending photos and full user design signoff | P1 model-matched licence/provenance, owner approval of whole product | OPEN |
| High | Inaccessible arrow navigation or focus hijack | P4 group-local focus scopes, preserve input caret, visible focus and Qt keyboard tests | OPEN |
| Medium | UI clipping after focus/scroll or compact-size changes | P2 screenshot issue repro; P4 native scrolling and responsive Inspector tests | Investigation |
| Medium | CI success misread as owner manual OS scale test | Label hosted synthetic vs real physical; no gate inflation | Guardrail |
| Medium | GitHub artifact retention and stale local cache | Version source, exact SHA, portable kit provenance; local clean CMake build dir | Controlled |
| Medium | Heavy GitHub Actions usage | Branch-scoped CI, local-first as sensible, don't suppress tests or make unsupported quota claims | Monitor |

## 8. Exact next-action decision tree

**If user wants to continue P2:** first finish actual on-device Windows `Settings → Display → Scale` 100/125/150% *where supported*, manual Tab/Shift+Tab/Space/Enter/Escape, live resize (1500×860/1280×720 as screen permits), record Qt Creator version, exact local SHA and CTest; investigate Gallery scroll retention; then ask for an explicit Qt Quick go/no-go once evidence exists. Local user has already verified Corolla, filter, rate sort, Escape. **Do not repeat those checks without an identified regression.**

**If user asks for visuals:** use owner-approved token system and full screen scope; do not restart from generic aesthetic search; distinguish mockups and actual compiled Qt. Make targeted visual corrections only when a specific screenshot/risk justifies them.

**If user asks for code:** implement narrow changes on the P2 branch, reproduce tests and exact-run evidence, never merge main or begin P3/full SQLite before gates. Code source is **not** in docs-only planning branch.

**If user asks for documentation:** update canonical state first, record the decision/evidence in audit and dated continuity, update prompt only when needed, keep source and planning branch mirror in sync.

**If user explicitly requests new features/architecture:** determine whether request alters scope/risks; propose a bounded gate and validate against current domain contract; don't silently introduce payment, reservations, cloud, API or migration.

## 9. Documentation governance, versioning and quality tests

1. **Precedence:** explicit current owner decisions + actual live source/test evidence → [canonical state](PROJECT_STATE_CANONICAL.md) → this audit → [P0–P9 criteria](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) → latest handoff/prompt → dated research and archives. If conflict, fix the document, do not improvise.
2. **One source for current facts:** `docs/PROJECT_STATE_CANONICAL.md`; this full audit contains the *why*, not a second changing live table; `docs/AI_CONTINUATION_PROMPT.md` is the reusable *how*. Both branches carry matching copies of the trio at audit time. The planning branch is the preferred doc authority; the P2 branch is the source authority.
3. **Prompts are generic:** future assistant must fetch live state and decide appropriate task, never assume user is starting P2 from zero, asking to rerun design exploration, or authorizing P3.
4. **Maintain audit trace:** preserve former handoff and prompt under `docs/archive/`; chronological `docs/CONTINUITY.md` is historical; major updates go to Issue #5 and PR #6 if technical.
5. **QA contract:** check exact README links, file presence, P0–P9 totals and phase weights, all branch naming, SHA/evidence provenance, no fabricated native/full acceptance, no literal `\\n` escapes in Markdown. GitHub readback after update. Source C++ unchanged, so this documentation-only audit does not imply a new compilation result.
6. **Transition acceptance test:** a new session given only the general-purpose prompt and GitHub must correctly identify live P2 branch, chosen palette, typed model, verified 8/8 hosted and owner local tests, open physical scaling + owner gates, and **18.4%** without asking the owner to restate details. If any is missed, the handoff is not seamless.

**Audit status:** documentation reconciled at the time of writing, but engineering **P2 remains open**; product not released and no new acceptance check is credited by documentation work.
