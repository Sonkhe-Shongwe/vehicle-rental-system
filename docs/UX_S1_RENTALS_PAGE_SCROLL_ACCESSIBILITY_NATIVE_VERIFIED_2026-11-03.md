# UX-S1 | Physical Windows Rentals clipping report and scroll accessibility repair

**Reported by owner on 3 November 2026.** Observed actual Windows screenshot in conversation: a real fictional booking **R003** had been saved, Rentals navigation was visible, the fixed top controls consumed the available page height, and the record panel was cut off at the bottom. A nested rental ListView scrollbar did **not** allow scrolling the **surrounding** page. This is a real owner observation, not a synthetic screenshot. The user's original personal screenshot was not committed to the public repository.

## Confirmed technical cause

In `spikes/qtquick_p2/Main.qml`, Overview already used an outer `Flickable` with content height and a vertical scrollbar. Rentals was a top-level **non-scrollable `ColumnLayout`** with many preceding actions/lookup/filter rows and a `Rectangle { Layout.fillHeight: true }` holding an inner ListView. At smaller available Windows logical heights, the card and its own scroll/contract footer fell below the parent viewport. A working ListView scrollbar cannot rescue a parent page that cannot scroll.

## Exact implementation

- QML [`f277322`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f277322635716444f33b81ac518f1b402333dfbe): introduce `rentalsPageScroll` whole-page Flickable, visible vertical ScrollBar, height from `rentalPageContent.implicitHeight`, width kept clear of scrollbar; add global scoped `PgDown`/`PgUp` keyboard navigation, disabled during modal dialogs.
- Bound `rentalRecordsPanel` to an explicit **360-460 logical-pixel** preferred height based on visible rental count, preventing its inner ListView from collapsing. For four-or-fewer rental records, `interactive: false` on ListView yields wheel events to the outer page; larger lists keep their efficient virtualized internal scrolling.
- Booking, return, archive, permanent fictional delete and contract-details popups use `Overlay.overlay` as visual parent/anchor, so scrolling page content does not displace a modal offscreen. C++ authoritative pricing, booking, return, archive and delete services remain unchanged.
- Add native CLI `--rentals-page-scroll-smoke` and two CTests (wide and compact) in [`c95c8c3`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c95c8c3becc192467ce87ac4223c236ebf5b4871): real QQuickWindow, actual Rentals data, viewport extent, keyboard PageDown and PageUp, bottom View contract details screen reachability, real PNG capture, no source-fixture changes.
- Initial test-only threshold incorrectly required **90px of scrolling on both layouts**; at 1500×860 the repaired content was nearly fully visible, with only **15px overflow**. As expected the new wide test failed at `c95c8c3` on each OS while compact passed; all previous preexisting functional tests remained green. Corrected wide-responsive expectation in [`d12fad5`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/d12fad5a57714ab8cae45b150563cd33ae8f4210) without changing production QML behaviour. This is test correction, not concealment of an app failure.

## Exact compiled CI, screenshot and portable package evidence

**Source:** [`d12fad5a57714ab8cae45b150563cd33ae8f4210`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/d12fad5a57714ab8cae45b150563cd33ae8f4210), on still-draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), base P6 development branch. **CI:** [native run 41680556750](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41680556750) **completed SUCCESS**.

| Environment | Verified |
|---|---|
| Ubuntu 24.04 GCC + Qt 6.8.3 | **120/120 genuine native Qt CTests PASS**; `rental_studio_ux_s1_scroll_wide` **PASS**, `..._compact` **PASS** |
| Hosted Windows Server 2022 MSVC + Qt 6.8.3 | **120/120 genuine native Qt CTests PASS**; the same two wide/compact native GUI/keyboard/visibility tests **PASS** |
| Native wide/compact screenshots | [Hosted Windows actual Qt window screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41680556750/artifacts/13252319847) and [Linux screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41680556750/artifacts/13253180525), with `ux-s1-rentals-bottom-1280x720.png` and `...1500x860.png`. Both hosted Windows screenshots were downloaded and visually inspected; the rental rows and footer are in view and page scrollbar shown |
| Deployed Windows QA bundle | **8/8** packaged real C++/QML fictional functional lifecycle checks PASS, P2 portable checks PASS, P4 PowerShell 7/5.1 PASS. [new Windows QA package](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41680556750/artifacts/13253545978) |
| Downloaded artifact integrity | `/mnt/data/Rental_Studio_2_Rentals_Scrolling_Fix_Windows_2026-11-03.zip` verified with ZipFile CRC (no errors), **1,393 entries**, **38,582,040 bytes**, **SHA-256 `e5eb4e1d41fd1b07f16a34dd0ba02e9c9bc53c9c2a50aa028513846bc5baa707`**; `SOURCE_COMMIT.txt` exactly `d12fad5a57714ab8cae45b150563cd33ae8f4210`. Includes bundled executable, Qt libraries, both CMD scripts, walkthrough and SHA-pinned fictional fixtures; excludes generated check logs |

## Physical owner acceptance remains open

The original actual Windows screenshot is proof of a **real bug in the previous build**, and the native CI + visual evidence above verify **the fixed source on hosted environments**. The owner has **not yet** run the new `d12fad5` ZIP on their personal Windows computer, verified wheel/scrollbar/PgUp/PgDown or attested to Narrator, tab/focus and actual OS scaling accessibility. Do not mark P1/P2/P4 physical criteria PASS from hosted CI alone. On-device retest: extract the full updated ZIP, double-click `Launch-Rental-Studio.cmd`, open Rentals and make 3 fictional contracts if desired, then wheel/drag the right page scrollbar or use PageDown/PageUp to see records and the contract action. If still clipped, report actual scale, window size and application-only screenshot; preserve exact SOURCE_COMMIT marker. No actual personal data.

This work did **not** add catalogue entries or photos, change C++ business/persistence rules, approve real customer records or commercial SQLite cutover, or certify a signed installer/release. Fleet population and imagery remain a separately deferred LAST project section, per owner directive. **Formal acceptance unchanged: 45/74, weighted 70.6%.** `main` untouched, draft PR remains unmerged.
