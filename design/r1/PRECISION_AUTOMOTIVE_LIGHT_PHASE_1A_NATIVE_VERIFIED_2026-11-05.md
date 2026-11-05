# Precision Automotive Light | Phase 1A native-verified engineering handoff

**Date:** 5 November 2026  
**Implementation commit:** [`33aea1a1e79c368e0614dc4c67ff9c49da19534b`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/33aea1a1e79c368e0614dc4c67ff9c49da19534b)  
**CI run:** [Actions #42068260505](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42068260505), completed SUCCESS on Linux + Windows  
**Design reference:** [`PRECISION_AUTOMOTIVE_CONCEPT_MASTER_2026-11-05.md`](PRECISION_AUTOMOTIVE_CONCEPT_MASTER_2026-11-05.md) and the original separate Light/Contrast master PNG archive preserved in the conversation  
**Status:** Engineering increment native-tested; *not full-template implementation or physical owner acceptance*.

## Implemented changes

1. `spikes/qtquick_p2/DesignTokens.qml`: added consistent, light-first design roles for selected sidebar surface, quiet UI backgrounds, heading hierarchy and geometry. Retains approved Navy `#17324D`, Emerald `#0F766E`, Cloud `#F6F8FA`, Ice `#EAF0F4`, Mint `#E8F5F0`, old rented status, warning, danger and focus tokens.
2. `spikes/qtquick_p2/PrecisionPrimaryButton.qml`: new real native reusable Button. Works with text + plus icon when expanded and a centred plus glyph with tooltip and accessible name when collapsed. Does not bypass Qt Focus/Space and does not implement domain logic.
3. `spikes/qtquick_p2/SidebarGlyph.qml`: added a licence-free local vector plus icon.
4. `spikes/qtquick_p2/WorkspaceNavButton.qml`: changed selected workspace from a large Navy block to Mint/Emerald-accented light selection. Preserves existing 48px workspace rows, accessible radio selection, Up/Down focus and explicit Enter/Space activation.
5. `spikes/qtquick_p2/Main.qml`: integrated real New Rental sidebar action above the three workspaces, retained 218/76px responsive rail widths, refined brand row, added accurate fictional session status dot, professional page heading + subtitle and quiet fictional-mode chip, and adapted margins for compact windows.
6. `beginNewRental(fromSidebar)` routes from Overview or Fleet to Rentals and invokes **existing** `bookingDialog`, `bookingActions.discardPreview()` and authoritative quote/confirm transaction. Closing via Escape restores focus to the original sidebar command if it opened the dialog, or to the Rentals in-page New rental button when that was the invoker. Existing Fleet selected-vehicle booking keeps its established route.
7. `spikes/qtquick_p2/main.cpp`, `CMakeLists.txt`, and CI screenshot lists: added `--pa-shell-001-smoke` at 1500×860 and 1280×720, testing actual native QML shortcut/booking modal/Escape/icon-only rail, asserting both protected fixture files have not changed, and capturing six screenshot states per OS.

## Verified evidence

| Gate | Result |
|---|---|
| Exact source | `33aea1a1e79c368e0614dc4c67ff9c49da19534b` |
| Linux GCC Qt 6.8.3 | **134/134 CTests PASS** |
| Windows MSVC Qt 6.8.3 | **134/134 CTests PASS** |
| New `rental_studio_pa_shell_001_wide` | PASS on both OS |
| New `rental_studio_pa_shell_001_compact` | PASS on both OS |
| Packaged native Windows functional checks | **8/8 PASS** |
| Windows PowerShell 5.1 verification | PASS |
| ZIP integrity | Windows QA, Linux screenshots and Windows screenshots available as separate artifacts |
| Protected demo data | Both original demo fixtures unchanged in new native tests |
| Manual Windows Qt Creator/MinGW/Narrator/scaling | **NOT performed** |

### Native screenshot artifacts

- Windows screenshot artifact `p2-qtquick-windows-screenshots` ID **13434339911**, archive SHA-256 `58c83ba8d8a8c217cc145636e74056f8c29c09fcea19b8178f40b230eea93486`.
- Linux screenshot artifact `p2-qtquick-linux-screenshots` ID **13433824902**, archive SHA-256 `7453c7838eaa3687aab55aa2b8032c691f24bc2f0100b5a1ee6375f62966144e`.
- Windows QA kit artifact `p2-windows-physical-acceptance-kit` ID **13436035368**, archive SHA-256 `168948e4f33958a68cd8fca8325c976ec62f63c486e7d330e0957bb0156cba04`. The packaged `SOURCE_COMMIT.txt` matches implementation source.
- Artifact retention set to 7 days. Copies were downloaded and ZIP-tested in this conversation.

Six new screenshot identifiers per OS: `pa-shell-001-overview-expanded-{1500x860,1280x720}.png`, `pa-shell-001-fleet-collapsed-{1500x860,1280x720}.png`, `pa-shell-001-real-booking-dialog-{1500x860,1280x720}.png`.

## Source image versus implemented result

Actual native screenshots were inspected. The refined Light sidebar and header now reproduce the intended hierarchy and Mint/Emerald treatment, but **the actual Overview content, Fleet card composition/Inspector, and Rentals content/booking dialog do not yet match the full precision design**. The screenshots in this new native smoke use the protected five-vehicle fictional test fixture, **not** the normal 131-vehicle portfolio launch; this is deliberate to avoid confusing test screenshots with live showroom counts.

## Next bounded increments, separate approval and CI

1. **Phase 1B, Overview composition:** Align genuine C++ data tiles, active fleet availability breakdown and truthful recent-contract list with the Light reference. Do not invent events or KPI values (the generated template's 131/104/24/3/79% is illustrative).
2. **Phase 1C, Fleet composition:** Refine photo-led Gallery, status/rate typography, toolbar alignment and Inspector. Use embedded model-family images, truthfully label unresolved silhouettes and preserve keyboard view/filter/selection semantics.
3. **Phase 1D, Rentals and booking:** Refine real Active/History table, quote dialog, confirmation, return/archival states. No customer/settings/report/calendar/maintenance modules or fake payment/favourite/draft capabilities.
4. **Phase 1E, visual coherence and physical QA:** Compare actual 1500×860 and 1280×720 screenshots, keyboard/focus, Ctrl+F and reduced motion; confirm Qt Creator 6.10.2 MinGW and 100/125/150% OS scaling where supported. Consider Contrast only after Light approval and dedicated contrast/a11y audit.

## Safety and acceptance boundary

No C++ domain code, fictional inventory, customer-data policy, production SQLite, `main`, installer, release or existing formal acceptance criteria were modified in this increment. Formal owner score remains **45/74 criteria, weighted 70.6%, P7 0/8**. Draft PR #17 remains open/unmerged. The locally generated design illustration is a proposal, not executable code or a licensed car-photo source.
