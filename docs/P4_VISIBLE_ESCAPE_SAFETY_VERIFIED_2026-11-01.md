# P4 Visible-Workspace Escape Safety | Verified 1 November 2026

## Defect

The shared Qt Quick Escape shortcut formerly used `else fleet.clearSelection()` for any non-Rentals workspace. When Overview was active, that could clear a **hidden Fleet selection**; the shortcut could also claim Escape with nothing selected. This contradicted the owner-approved [UX-CTRL-001 keyboard and focus contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md): topmost modal dismisses first; otherwise dismiss only an appropriate visible transient selection.

## Narrow implementation

Exact [source commit `cc6f0b6d2fe11b775910e0fccb866504dc4c90cb`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/cc6f0b6d2fe11b775910e0fccb866504dc4c90cb).

- `spikes/qtquick_p2/Main.qml` adds the read-only `canDismissSelection` property for **visible Fleet or Rentals only**, requiring a nonempty C++ selected ID. The Escape shortcut is enabled only if that predicate holds and no Booking/Return/Archive dialog is visible. Activation explicitly handles workspace 1 and 2 without a fallback clearing hidden Fleet state.
- `spikes/qtquick_p2/main.cpp` expands the existing genuine QQuickWindow `--p4-tab-smoke`: select fictional C001, change to Overview, assert Escape dismissal disabled and C001 preserved; return to Fleet, assert dismissal enabled and Escape clears C001; leave all prior field Tab, bounded confirmation, Booking focus, and byte-for-byte fixture assertions intact.
- Nothing changed in C++ booking/return/domain services, pricing, storage, asset permissions, production data or deployment.

## Actual test evidence

| Environment | Exact source run | Result |
|---|---|---|
| Linux Ubuntu hosted Core + legacy | [41283845689](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41283845689) | **13/13 CTests PASS** |
| Linux GCC Qt 6.8.3 native Qt Quick | [41283845685](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41283845685) | **41/41 CTests PASS**, P4 wide/compact focus-route tests PASS |
| Windows Server 2022 MSVC Qt 6.8.3 native Qt Quick | [41283845685](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41283845685) | **41/41 CTests PASS**, same P4 wide/compact cases PASS |
| Hosted Windows portable and input integrity | Same Windows run | **PASS**, tampered non-demo input correctly rejected |

Both native focus-route CTests exercise **1500×860** and **1280×720** compiled Qt windows. Linux and Windows job logs explicitly report 100% test success. No claim of direct local Qt Creator execution, manually inspected new screenshot aesthetics or physical screen-reader access is made.

## Acceptance boundary

This closes a specific source-tested keyboard defect, **not the full P4 #4 accessibility criterion**. Accessible roles/names across every work area, live Narrator, all key combinations, visibility and focus states, and physical Windows 100/125/150% scale and owner design review remain OPEN. P4 **5/7**, total **28/74**, weighted **40.6% evidence coverage** unchanged. Prior P3 **7/7** accepted. P1/P2 owner gates and P5-P9 remain open. All source fixtures are SHA-256 pinned, test mutations disposable, `main` unchanged and Draft PR #10 stacked/unmerged.

**Next:** conduct targeted native accessible-name/role and focus-state audit for Overview, Fleet and Rentals, then obtain real Windows Qt Creator 6.10.2 MinGW/Narrator and owner aesthetic evidence. No premature P5 release or storage migration.
