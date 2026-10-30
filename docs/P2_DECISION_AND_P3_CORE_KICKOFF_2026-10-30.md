> **LATEST AUTHORIZED ENGINEERING STATE (30 October 2026, after formal owner GO):** The owner explicitly **APPROVED Qt Quick/QML presentation + authoritative C++ domain** and authorized the first narrow P3 implementation while keeping P1/P2 outstanding checks open. This satisfies the distinct P2 **technology go/no-go** decision criterion, **not** the physical Windows or full visual signoff. Evidence-weighted baseline is now **P0 5/5, P1 7/10, P2 4/6 (66.7%), P3 0/7**, **16/74 accepted checks, 20.1% weighted coverage**, **NOT release-ready**. P3-A isolated branch [`feature/p3-typed-fleet-read-20261030`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/feature/p3-typed-fleet-read-20261030), [Draft PR #7](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/7), implements a **by-value typed C++ FleetReadService** and modifies only the read-only Qt Quick Fleet model to consume summaries. At code SHA [`9fa9028`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9fa9028f81cb894f93e1cbc5fe5e6738b07df4b8), **Linux 11/11 and Windows 11/11 native Qt6.8.3 CTests PASS** [41071876101](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41071876101), plus Qt-Core-only Linux 3/3 [41071876017](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41071876017) and Windows portable fictional-data safety PASS. **P3 remains 0/7 pending formal acceptance of full criteria**, despite working tested code. Exact owner Qt6.10.2 MinGW SHA/CTest, actual supported physical scales, keyboard smoothness, P1 final design, images/a11y remain OPEN. **Stable main and Draft PR #6/#7 unmerged.** Older 3/6 and 18.4% figures below are historical snapshots **before** this formal owner GO.

# Rental Studio 2.0 | P2 Technology Decision Review and P3 Core Kickoff

**Snapshot:** 30 October 2026 (Africa/Johannesburg)  
**Document status:** HISTORICAL ENGINEERING RECOMMENDATION, **NOW OWNER-APPROVED FOR THE QT QUICK/C++ TECHNOLOGY DIRECTION**. Isolated P3-A code has STARTED and exact-source CI passed; remaining P1/P2 checks OPEN. Original recommendation wording below predates owner signoff.  
**Sources:** [Canonical status](PROJECT_STATE_CANONICAL.md) · [P0–P9 acceptance](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) · [UX-CTRL-001](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) · [Windows checklist](WINDOWS_ACCEPTANCE.md) · [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5) · [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6).

## Decision summary

**Engineering recommendation: CONDITIONAL GO for Qt Quick/QML presentation with C++ domain ownership.** The narrow P2 application has passed real native Qt compilation/tests and been physically launched by the owner. It is a defensible choice for P3 typed application boundaries, without restarting aesthetic/toolkit selection.

**Formal gate status (updated 30 Oct 2026): P2 OPEN, but owner Qt Quick technology GO is explicitly GIVEN.** Do not mark phase accepted, merge PR #6 or begin a broad implementation solely because engineering recommends GO. The owner can approve the technical direction while leaving P1 final visual/imagery/accessibility and P2 physical DPI/exact-kit QA explicitly open. If owner instead requests remaining physical checks before deciding, respect that gate and do not claim approval.

**Decision owner action:** Record explicit **GO**, **GO with time-boxed follow-up checks**, or **NO-GO**. A GO authorizes *planning and bounded P3 work*, not a product release, skipped physical tests, permanent architecture rewrite or P1 signoff. Keep stable main unchanged. Current weighted checklist remains 18.4% until P2's actual acceptance checks and required approvals are individually verified.

## Confirmed source and factual evidence

| Area | Evidence | Boundary |
|---|---|---|
| Qt Quick/C++ source | Isolated opt-in `BUILD_QTQUICK_P2_SPIKE=ON` in [P2 source branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/spike/p2-qtquick-fleet-20261030), Qt `QAbstractListModel`, `QSortFilterProxyModel`, QML Gallery/Table/Inspector | Read-only P2, not working new Rentals |
| Latest code-tested CI | [Actions run 41065470256](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41065470256): **10/10 CTests Linux Qt 6.8.3 GCC and 10/10 Windows Qt 6.8.3 MSVC**, plus portable Windows job | Hosted kit differs from owner MinGW. Later doc-only runs don't imply additional native features |
| Earlier failure | [Run 41064963032](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41064963032) 9/10 due obsolete test assumption when hidden selection now clears; corrected at `0f5668d` | Retain failure in timeline; fixed with test intact |
| Owner local Windows | Real Qt Creator **Desktop Qt 6.10.2 MinGW 64-bit Debug** ran Fleet; user-supplied screenshots and comments verified Corolla Inspector, Gallery/Table parity, Available filter, ascending Rate sort, Escape, Tab and Shift+Tab. Later user expressly confirmed hidden selection, sorting, arrow boundary and search work in local build | Does not establish exact local Git SHA, Qt Creator application version, local CTest log or subjective new arrow smoothness |
| Physical display | Actual Windows Settings screenshot: **150% Recommended**, **1920×1080 Recommended**, Landscape; readable Qt Fleet screenshots in same conversation | Not a controlled simultaneous app-at-scale record, cannot replace 100/125/150 comparison where supported |
| Owner control decision | [UX-CTRL-001](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) approved: native Qt focus, group-based arrows, Tab between regions, only small per-feature implementation | Sidebar Right → Search is documented **future P4 work**, not P2 implementation |

## P2: the shortest remaining acceptance path

**Do not retest already confirmed Corolla, search, sorting, Escape and filtering without a regression.** Instead retain three outstanding composite gates in the [74-check ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md), recorded with their actual evidence rather than inventing individual checkmarks:

1. **Exact owner kit/local build:** record `git rev-parse HEAD`, Qt Creator version, Kit Qt6.10.2 MinGW, and CTest output for the checked-out P2 source. Local output is currently not available to the assistant.
2. **Physical usability and device scale:** inspect currently recommended 150%/1920×1080 compact window at a measured feasible size; verify Tab/Shift+Tab focus order, arrow selection/Inspector and no independent scrolling, filter/sort focus retention and boundary behavior. Compare 100%/125% *only where genuinely supported and appropriate*. Hosted synthetic pixel ratio is not physical approval. A 1500×860 **logical** window cannot fit a ~1280×720 logical desktop at 150%, so don't mislabel expected overflow.
3. **Owner decision:** formally approve or reject the **Qt Quick** technical stack, explicitly noting any deferred physical checks/risks. Independently maintain P1 art/licensing/a11y/final owner whole-product approval as OPEN.

This is a short sign-off path, **not an invitation to spend another full stage polishing arrow controls**. Log any actual blocker and proceed only through explicit accepted scope.

## P3 goal: make the existing C++ rules reusable without rewriting them

**Existing source baseline inspected:** `rentalsystem.h` exposes a C++ `RentalSystem` that owns `QList<Vehicle*>`/`QList<Rental*>`, provides fleet and rental methods returning `bool`, and handles text files internally. `vehicle.h` and `rental.h` expose current `double` daily rate/total and direct domain fields. `CMakeLists.txt` builds the legacy Widgets executable with separate domain/GUI tests and opt-in isolated P2 application. These are **real present source constructs**, not proposed architecture.

**Target seam:** reusable, typed C++ application/view-model boundary between QML and `RentalSystem`, maintaining C++ as single source for availability, pricing and booking invariants.

```text
Qt Quick / QML (presentation, focus, rendering)
           |
Small typed QObject application adapters / commands / results
           |
Existing C++ RentalSystem + Vehicle/Rental rules
           |
Existing safe storage adapter (unchanged initially)
```

No UI-owned pricing, ad-hoc QML business rules, raw mutable `Vehicle*` exposed to QML, giant new controller, immediate SQLite migration, or new booking semantics.

### First bounded P3 implementation slice (after owner technology decision)

**P3-A: Read-only typed Fleet boundary + characterization tests.**

- Introduce a small, by-value `VehicleSummary` shape (`id`, type, brand/model/display name, availability, daily rate represented with current precision **only at adapter boundary**, no silent currency migration), with a tested service translating owned `RentalSystem` objects to immutable consumer-facing snapshots. Reuse today's `QAbstractListModel`/proxy behaviour where feasible, not parallel databases of vehicles.
- Keep domain ownership explicit and lifetimes safe: returned snapshots must remain valid across QML view switches; never expose raw `Vehicle*` for mutation in a delegate. No new persistence writes.
- Write characterization tests: Car/Motorcycle mapping, five fictional vehicles, stable ID on filter/sort, empty/not-found, no mutation, and integration with existing domain tests. Use `QTemporaryDir` fixture data only.
- At this stage avoid premature interface hierarchies and unnecessary `I*` abstractions. Extract only the first genuine seam consumed by the view. Prefer a single focused C++ module and independent CTest.
- If a later typed `OperationResult<T>` is needed, add it when there is a real **write command** to express success, validation and persistence failure rather than inventing a generic framework now.

**Later P3 slices:** support a typed quote preview/read command that preserves same-day 1–365-day semantics; define stable command/error results and controlled transaction boundaries only when P5's real Corolla rent/commit/restart exercise needs them. Add an injectable Clock only for rules that demonstrably depend on current date/time. Preserve legacy tests and original storage until a separately accepted migration plan.

**P3 done is not code-volume-based:** choose a minimal set of *actual* source-gated acceptance cases and show independent local/hosted CTest evidence. The existing P3 ledger has **seven checks, none yet verified (0/7)**. A kickoff document alone does not complete any of them.

## Branch and collaboration strategy

- Keep **`main` stable** at audited `9bfca8786af1c64b0284a5a1bb3e2186573147a4`. Do not merge old Draft PR #3/#4 or Draft PR #6 automatically.
- P2 source authority: `spike/p2-qtquick-fleet-20261030`, currently includes the existing tested Qt Quick implementation. Planning/decision-doc authority: `docs/product-rebuild-reset-20261029`.
- After owner GO, isolate first P3 change on a new **named P3 branch created from latest P2 head**, with a **Draft PR targeting the P2 source branch** for review. Do not build P3 on outdated `main` or mix P3 with unfinished P1 imagery.
- Test in GitHub Actions on exact new source SHA and via GitHub Desktop/Qt Creator when local native UI matters. Never imply the connected assistant can drive the owner's screen or run local CTest.

## Immediate owner-facing decision

**Recommended answer:** `GO: Qt Quick for Rental Studio 2.0; retain listed P1/P2 follow-up evidence and use narrow typed C++ P3 slices.`

The user should only make this decision after reviewing the evidence and risks. Before this explicit statement, the document remains a recommendation, **not owner approval**.

**Programme score at creation:** P0 5/5, P1 7/10, P2 3/6, P3–P9 0, **15/74**, weighted **18.4%**. No additional accepted checklist item, runtime code change, hardware acceptance or release claim arises from this document.
