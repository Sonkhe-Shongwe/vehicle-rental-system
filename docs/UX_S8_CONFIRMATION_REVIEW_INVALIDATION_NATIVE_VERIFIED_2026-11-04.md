# UX-S8 | One-time Return and Archive confirmation invalidation

**Date:** 4 November 2026 (Africa/Johannesburg).  
**Exact compiled and native-verified source:** [`c198ca769587b9a2df5bc8e511e8570913891b41`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c198ca769587b9a2df5bc8e511e8570913891b41).  
**GitHub Actions:** [run 41736047217](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41736047217), **COMPLETED SUCCESS**.  
**Working branch:** `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked against P6 #14; no merges.

## Problem and operator risk

UX-S7 captured the selected rental ID and prevented confirming another ID while the dialog was open. However, returning to the original record after temporarily selecting a different record could re-enable the same confirmation. This **selection-away-and-back** interaction should not resurrect an old review/consent state.

## Small, bounded implementation

- `spikes/qtquick_p2/Main.qml`: Return and Archive confirmation dialogs each have a `reviewInvalidated` boolean initially false. While that dialog is visible, an actual `RentalListModel::selectionChanged` signal with a different selected ID permanently marks that modal review invalidated.
- The Confirm enabled state requires **all three** existing conditions (captured canonical ID nonempty, exact match to current visible ID, existing C++ eligibility) **and** `!reviewInvalidated`. Selecting the original ID again does not re-arm consent.
- A short, accessible, displayed explanation tells the operator **"Selection changed. Close and reopen to review this return/archive."** on a separate line. The original reviewed ID remains in the question, so the modal never silently retargets.
- Closing with Cancel or Escape remains read-only; opening the dialog anew explicitly resets `reviewInvalidated` and captures the current selected ID. The existing UX-S7 C++ exact-ID guards remain unmodified.
- `spikes/qtquick_p2/main.cpp`: both genuine native Qt shared-components smoke tests at 1500×860 and 1280×720 now exercise **A -> B -> A** selection while a Return modal is open, verify old Confirm remains disabled and the reason is shown, Cancel, reopen and verify new Confirm eligible, then Cancel safely. They also exercise the same pattern for Archive, Escape, reopen and Escape. Existing focus restoration and protected fleet/rental byte comparisons remain intact.
- An intermediate code commit `4c0d5dfa` introduced the latch and tests. The final exact-tested source `c198ca769587b9a2df5bc8e511e8570913891b41` additionally corrects the QML on-screen warning to render as a true newline. The intermediate run is **not** the final-source evidence.

No domain C++ command, quote, P7 SQLite Lab, storage format, customer-contact exposure, filesystem fixture or photo/catalogue was changed. No CTests were removed, skipped or weakened.

## Exact-source verification

[Native workflow 41736047217](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41736047217) **COMPLETED SUCCESS** against `c198ca769587b9a2df5bc8e511e8570913891b41`:
- **Ubuntu 24.04 GCC / Qt 6.8.3:** **123/123 genuine CTests PASS**, zero failed, **151.40 seconds**. `rental_studio_p4_components_wide` #69 and `_compact` #70 passed, including the new selection-round-trip and dialog-reopen checks.
- **Hosted Windows Server 2022 MSVC / Qt 6.8.3:** **123/123 genuine CTests PASS**, zero failed, **177.07 seconds**. The same actual Qt wide/compact #69–70 tests passed. Prior C++ exact-ID controller checks #9/#11 still pass.
- **Hosted Windows relocated portable executable:** **8/8 real fictional app functional checks passed**. P2/P4 packaged automation and PowerShell 7 / Windows PowerShell 5.1 checks passed.
- Generated workflow artifacts (expire 10 November 2026): [Windows physical acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41736047217/artifacts/13279307433), [Windows native Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41736047217/artifacts/13280685329), [Linux native Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41736047217/artifacts/13278828488).

## Boundaries and owner gates

**Formal acceptance remains 45/74 criteria, weighted 70.6%; P7 0/8.** Native CI success does not substitute for physical Windows owner acceptance. Owner's UX-S1 scrolling retest, Qt Creator/MinGW, mouse/keyboard focus, physical OS display scaling at 100/125/150%, Narrator, and P7 D2–D8 policy decisions for actual data/privacy/retention/backup remain open. P8 installer, P9 release, all PR merges, final Fleet Population/Photos and imagery licence review remain separate unfinished gates.

The later documentation-only HEAD is **not** another compiled or independently QA-verified source. No authorization for real customer data, commercial persistence cutover, operational backup UI, installer or public release.
