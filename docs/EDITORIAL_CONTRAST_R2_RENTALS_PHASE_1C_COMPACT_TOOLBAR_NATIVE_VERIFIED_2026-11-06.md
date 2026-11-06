# Rental Studio 2.0 | Editorial Contrast R2 Rentals Phase 1C | Compact toolbar native verified

**Date:** 6 November 2026

**Verified executable:** [`3b74c50eaf3187af3e10c36713791efbb5096b48`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3b74c50eaf3187af3e10c36713791efbb5096b48)

**GitHub Actions:** [#42282222982, completed SUCCESS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42282222982)

## Real cross-platform verification

| Check | Result |
| --- | --- |
| Linux GCC, Qt 6.8.3 native CTest | **142/142 PASS** |
| Windows MSVC, Qt 6.8.3 native CTest | **142/142 PASS** |
| Windows packaged fictional journey | **8/8 PASS** |
| Windows PowerShell 5.1 P4 native verification | **PASS** |
| Existing compact UX-S1 #56, Rentals P3-H filters and P4 a11y | **PASS**, unchanged assertions |

### Actual native screenshot artifacts

- [Windows Qt screenshots #13536456859](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42282222982/artifacts/13536456859)
- [Linux Qt screenshots #13535638431](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42282222982/artifacts/13535638431)
- [Windows fictional physical owner acceptance kit #13536062635](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42282222982/artifacts/13536062635)

Inspected actual screenshot names from both artifact ZIPs: `p3-qt-rentals-1500x860.png`, `p3-qt-rentals-1280x720.png`, `pa-rentals-004-register-1500x860.png`, `pa-rentals-004-register-1280x720.png`, and `ux-s1-rentals-bottom-1280x720.png`. These are genuine compiled Qt screens, not mockups.

## Visual changes and review

The R2 charcoal sidebar, mint active navigation, light application canvas, four factual KPI cards, real grouped booked value and the contract register are retained. This phase consolidates the formerly separate text-heavy fictional-data disclosure and duplicate in-page New Rental row into a **single 44px-high contextual toolbar** above the KPIs. The toolbar retains `rentalNewBookingButton`, `rentalBookingMessage` and existing C++ booking/receipt behavior, along with visible fictional-only/non-production disclosure.

At 1500×860, both R001 active overdue / C002 and R002 returned / C001 are visible, and the white register is next to the selected green contract inspector. At 1280×720 both records, KPI cards and contextual inspector stay readable. Lower register selection/footer details can require normal page scroll; this is intentional and tested. The wide and compact Windows/Linux screenshot layouts are structurally consistent despite font differences.

**Residual visual issue identified from screenshots:** The selected Ford Ranger photo was still globally dimmed and is less prominent than the owner's desired premium photographic hero. A distinct QML-only candidate [`b2dacc2`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/b2dacc2a0cc6640703330ce3b70e393c848c5df7) uses the actual C++ selected-vehicle photo at opacity 0.92 with a dark evergreen horizontal text-protection gradient rather than dimming the whole image. That commit was started after the verified `3b74c50` source and is **not** part of this verified report. Verify [CI #42286318986](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42286318986) and compare its actual screenshots at both OS/window sizes before promoting.

No owner-approved visual reference PNG pack is currently source-controlled. The separately supplied old light-sidebar Overview screenshot is a quality benchmark, not an override of the later owner-approved dark-sidebar Editorial Contrast R2 palette. No exact pixel comparison or owner acceptance is claimed.

## Guardrails

Business logic remains C++ authoritative: availability, dates, booked money, selected rental IDs, booking, returns, archiving, deletion, persistence and validation. Screens use fictional records only; no operational production database, payments, customer fields or new workspace was fabricated. Draft PR #17 remains unmerged; main unchanged. Physical owner Windows MinGW 6.10.2, DPI and Narrator, image licensing/final selection, and each R2 workspace's owner visual signoff are still open. Formal acceptance **45/74, fixed weighted 70.6%, P7 0/8** unchanged.
