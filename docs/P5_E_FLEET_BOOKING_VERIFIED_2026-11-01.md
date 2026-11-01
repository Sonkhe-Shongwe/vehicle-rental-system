# P5-E: Direct Fleet-to-Booking Action
Verified: 1 November 2026 | Draft PR #12 | fictional-only development preview

## Delivered product change

The native Fleet gallery/table previously allowed selection and inspection of real C++ Fleet summaries, but its inspector still displayed the obsolete message that booking actions were intentionally absent. Operators had to navigate to Rentals and type the selected vehicle ID again. This was inconsistent with the existing P3/P5 authoritative booking workflow.

The selected Fleet inspector now shows a **Book selected vehicle** button with descriptive keyboard accessibility metadata. Its enabled state is bound to `fleet.selectedId` and C++-derived `fleet.selectedAvailable`. Clicking it while an available vehicle is selected opens the existing real Rentals booking modal with exactly that ID prefilled. It resets stale ephemeral quote/receipt UI; it does not book or calculate anything in QML. The operator must still preview the C++ quote and explicitly confirm through `RentalBookingController`. Selecting an already-rented vehicle leaves the action disabled, and after a successful booking the same vehicle's action becomes disabled when returning to Fleet. The inspector text now explains these states.

Only `spikes/qtquick_p2/Main.qml`, `main.cpp`, `CMakeLists.txt` and the existing CI screenshot-upload patterns changed. Original SHA-pinned fictional files, real rental storage boundaries, pricing and domain persistence remain unchanged.

## Actual validation

Two new native CTests at wide 1500×860 and compact 1280×720 drive the real QQuickWindow using keyboard Space on the Fleet action. They assert:
- No selection and already-rented C002 both disable booking.
- Available Corolla C001 enables the button, opens a *visible* Qt modal in Rentals, and populates C001 without prematurely enabling Confirm.
- Preview uses the existing authoritative C++ R450/day, three-day quote, total R1350. Only an explicit Confirm saves fictional R003, updates Rentals and Fleet, and shows the saved receipt.
- Original source fixtures are untouched; the disposable ledger changes. Returning to Fleet leaves C001 selected but now rented, so the booking action is disabled.
- Both native screenshots `p5-qt-fleet-booking-receipt-1500x860.png` and `-1280x720.png` are included with corresponding Linux/Windows CI screenshot artifacts.

The first code [`3b84183`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3b841830fa9140333415b9e406a86bea4541ec85) had two **failed new Linux tests** in [run 41298252503](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41298252503), with the failure `P5 Fleet did not prefill the real safe rental dialog`. The test mistakenly searched for the `Dialog` QObject through a recursive `QQuickItem` visual-tree helper. A Dialog derives from Popup, not a QQuickItem. The focused correction [`43c06ddf222e58c08d13bb52746500d97c6c755a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/43c06ddf222e58c08d13bb52746500d97c6c755a) checks for actual visible modal fields and confirmation controls instead, retaining detailed real ID, quote and disk assertions; no test disabled.

### Exact corrected-source evidence

| Platform | Run | Result |
|---|---|---|
| Core C++ | [41298601013](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41298601013) | **13/13 CTests PASS** |
| Linux Qt 6.8.3 GCC | [41298600964](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41298600964) | **56/56 CTests PASS** |
| Windows Server 2022 Qt 6.8.3 MSVC | [41298600964](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41298600964) | **56/56 CTests PASS** |
| Windows packaged review and synthetic-fixture safety | Same run | P4 scripted checks PASS under PowerShell 7 and 5.1, intentional wrong-fixture rejection PASS |
| Visual evidence | Same native run | Native Fleet-booking receipt captures uploaded in Linux and Windows screenshot artifacts |

Compiled native job logs were inspected directly. Both platforms reported `100% tests passed, 0 tests failed out of 56`.

## Open scope

P5 full eight-point acceptance, including owner final product review and other negative paths, remains open despite this functional increment. P4 remains formally 5/7; P5 remains 0/8, total programme accepted evidence remains 28/74 and 40.6% evidence-weighted coverage. These figures are **not product release readiness**. Keep P5 Draft PR #12 stacked on unmerged P4 Draft PR #10, stable `main` untouched, no live customer data or production storage changes, and no repeated manual PowerShell requests to owner.

Next product-focused priority: ensure a stale C++ quote can be retried clearly in the native modal, while preserving failure/no-receipt behavior and existing validation rules.
