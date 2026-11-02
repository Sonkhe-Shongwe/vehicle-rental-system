# P6-A: Native Add Car and Motorcycle (disposable fictional demo)
**1 November 2026 | Draft PR #14 | Source commit `78ddc1e78099a9a592ebddc7b6ca5da80719885b`**

## Purpose and boundaries
P6 is the fleet and rental lifecycle parity phase. This first independent increment exposes **Add vehicle** in the native Qt Quick Fleet workspace while preserving the established C++ domain and typed FleetWriteService. The commercial product name remains **Rental Studio**. The previously preferred key + booking-calendar + car illustration is a design candidate only; no raster concept has been silently installed as a production logo, and no trademark/licensing clearance is asserted.

## Implementation
- New `FleetAddDialog.qml` offers Car/Motorcycle type, brand, model, daily rate, doors/engine capacity and explicit **Add to demo fleet** / **Cancel**. Keyboard focus returns to the initiating Fleet control after dismissal.
- New `FleetAddController` is a QObject presentation adapter. It validates basic UI ranges, calls the existing C++ `FleetWriteService::add`, and reports success only **after the authoritative commit**. The committed vehicle is refreshed into the Fleet C++ model and selected by stable ID.
- This operator action is disabled **and checked again in C++** when `--persistent-fictional-demo` is in use. That mode's SHA-pinned vehicle seed cannot be changed without violating its fixed fictional-data manifest. The ordinary preview uses a disposable `QTemporaryDir`; nothing writes to the original checked-in fixtures or real operational files.
- No real customer information, payments, new architecture or persistent fleet migration is enabled.

## Exact-source automated evidence
| Gate | Actual result |
|---|---|
| Core/legacy C++ | [Run 41318437863](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41318437863): **13/13 CTests PASS** |
| Linux Qt 6.8.3 GCC | [Run 41318437850](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41318437850): **62/62 CTests PASS**, including `rental_studio_p6_fleet_add_wide` and `_compact` |
| Windows Server 2022 Qt 6.8.3 MSVC | Same run: **62/62 CTests PASS**, including both new P6 native UI scenarios |
| Windows relocated P4 kit | Same run: PowerShell 7 and 5.1 packaged checks PASS; NOT owner hardware Narrator/OS scaling signoff |

The native P6 test uses actual keyboard-activated QML controls and verifies blank detail refusal/no file mutation, a confirmed fictional C004 Car, a confirmed fictional M003 Motorcycle, updated C++ Fleet counts/selection, domain reconstruction from disposable file bytes, and unchanged source `demo/vehicles.txt` and `demo/rentals.txt`. It also exercises the locked-mode C++ rejection. These are representative automated checks, **not** commercial real-data readiness or owner visual acceptance.

## Scope, acceptance and next
- Keep Draft [PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14) stacked on unmerged [P5 PR #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12). Neither is merged; `main` is untouched.
- This is **P6-A source implemented and native CI verified**, not a formally accepted one-of-nine complete P6 criterion. P6 **0/9**, P5 **0/8**, P4 **5/7**, programme **28/74** formally accepted, **40.6% evidence-weighted coverage** unchanged, not release completion.
- Next: P6 Fleet removal guard/confirmation and archived rental deletion parity in disposable mode with native regression, then broader Fleet/Rentals lifecycle and restart parity. Keep irreversible actions behind explicit confirmation and preserve the fixed synthetic session invariants.
- Physical Windows Qt Creator 6.10.2 MinGW, Narrator and scaling checks remain owner gates, to be batched into a consolidated review rather than repeatedly requested.
