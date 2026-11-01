# P4 Rentals Collection Keyboard Tab Stop | Verification, 1 November 2026

## Scope and observed defect

Within the owner-approved native keyboard contract, Rentals should expose one navigable ListView Tab stop, with arrow keys selecting C++-authoritative rental IDs inside the collection. Existing `spikes/qtquick_p2/Main.qml` made both the Rentals ListView and **each** delegate Button `activeFocusOnTab: true`. This risks forcing a keyboard user through individual rental rows as unrelated Tab destinations.

## Minimal source correction

- **Exact source commit:** [`bd0e584d676e961415758bd4cb574bbd67616ea4`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/bd0e584d676e961415758bd4cb574bbd67616ea4).
- `spikes/qtquick_p2/Main.qml`: keep `rentalList.activeFocusOnTab: true`; change `rentalRow.activeFocusOnTab` to `false`. Existing `onClicked` remains, as do ListView arrow selection, model IDs and visual focus/selection logic.
- `spikes/qtquick_p2/main.cpp`: expand existing `--p4-tab-smoke` at both real QQuickWindow sizes. Assert collection is a Tab stop, visible row delegate is not, and pressing Tab from the list does not focus an individual row. Existing Fleet field order, Return modal, Booking focus and SHA-pinned fictional-data invariance assertions remain.
- No changes to pricing, C++ domain writes, Qt Widgets legacy app, asset provenance, external data paths, storage format or CI requirements.

## Executed independent verification

| Environment | Run | Result |
|---|---|---|
| Ubuntu Core and legacy regression, GitHub hosted | [41266191565](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41266191565) | **13/13 CTests PASS** |
| Ubuntu Linux GCC, Qt 6.8.3, native QQuickWindow | [41266191604](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41266191604) | **41/41 CTests PASS**; `rental_studio_p4_focus_route_wide` and `_compact` PASS |
| Windows Server 2022 MSVC, Qt 6.8.3, native QQuickWindow | [41266191604](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41266191604) | **41/41 CTests PASS**; both focus-route cases PASS |
| Hosted Windows portable and source-fixture guard | Same Windows job | **PASS**; tampered synthetic input correctly rejected |

The Linux and Windows native tests used the actual compiled QML executable (not an HTML prototype), at **1500x860** and **1280x720** for focus-route checks. Hosted headless/virtual display does not establish real owner-side Qt Creator 6.10.2 MinGW mouse, keyboard, Windows scaling or Narrator results. No claim of manual image inspection is made for this increment.

## Acceptance and safety

**No new P4 rubric criterion closes:** #4 still requires whole-product focus, accurate screen-reader roles/names, physical Windows Narrator and keyboard workflow review; #7 needs the owner's Qt Creator desktop review, native Windows Settings animation/100-125-150% scaling and visual approval. P4 **5/7**, programme **28/74**, weighted **40.6%** accepted evidence remain unchanged. Earlier P3 **7/7** stays accepted.

Protected demo `vehicles.txt` and `rentals.txt` are SHA-pinned, and tests use disposable isolated copies. Production data has not been activated. Draft PR #10 and its stacked ancestors remain unmerged; `main` is unchanged. No claim of release or portfolio certification.

**Next priority:** audit accessibility of real Overview/Fleet/Rentals roles, names, keyboard focus, modal Escape and logical reading order with targeted native regressions. Then obtain the owner's physical Windows Qt Creator and Narrator signoff. Do not advance to P5 until the active P4 acceptance decision is resolved.
