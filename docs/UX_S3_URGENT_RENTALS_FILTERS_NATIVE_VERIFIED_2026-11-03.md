# UX-S3 | Operator urgency filters, C++ due-state authority

**Date:** 3 November 2026. **Exact compiled source:** [`6c409acd`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c409acd8f194cb0019d367581a08be408973f86). [Native Qt workflow 41703041464](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41703041464) **COMPLETED SUCCESS**. Branch `feature/p7-sqlite-sandbox-20261102`, stacked draft PR #17 on P6; stable main not updated.

## Problem and scope

Rental Studio already calculated `overdueCount`, `dueTodayCount` and the oldest overdue active contract in C++, but the ordinary Rentals list could not be narrowed to those urgent records. This increment adds **read-only active-contract return-timing filters**, without changing any domain booking, return, archive, storage or customer-data behaviour. The owner-approved premium light-first Midnight Navy / Emerald Teal / Cloud White interface remains the style basis; functionality comes first and final Fleet Population/Photography stays last.

## Exact changes

- `src/application/rental_list_model.cpp`: allow the additional exact, case-sensitive `Overdue` and `DueToday` filter tokens. Both include **only Active** records and compare to the already computed typed C++ `RentalDueState`. They do not evaluate timestamps in QML or include returned/archived contracts. Existing All/Active/Returned/Archived/History filters, cross-filter ID lookup, stable selection clearing, return lookup, full-snapshot KPIs and non-mutating filter operations stay intact.
- `spikes/qtquick_p2/Main.qml`: an independent compact **Return timing** row with keyboard-accessible Overdue and Due today radio-like buttons, C++-backed checked state, labelled active-only/read-only scope, and meaningful empty-state messages with Show all rentals reset. The previous lifecycle-status buttons retain their own row to avoid compressing them.
- `tests/p3_rental_model_tests.cpp`: strengthens the existing native C++ regression using independently injected local dates: one overdue active R002, one due-today active R003 and a not-due R001. Checks exact inclusion and exclusion, hidden selection clearing, a rejected unrecognized filter spelling, cross-filter lookup to All, return lookup and byte-for-byte unchanged protected fictional files; complete Overview booked-value metrics remain unscoped by filter.
- `spikes/qtquick_p2/main.cpp`: strengthens both existing native wide and compact Qt UI filtering CTests. Tests genuinely focus and Space-activate Overdue and Due today controls on the app screen, check selected ID retention/disarming and empty states, confirm C++ aggregate metrics unchanged, restore All and continue the existing lifecycle/lookup/regression flow. Explicitly checks the new due row and both buttons are inside 1500x860 and 1280x720 viewports and do not overlap the existing status or lookup rows. **No tests disabled, new test count, or source fixture changes.**

## Exact source verification

[GitHub Actions 41703041464](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41703041464):
- Ubuntu 24.04 GCC with Qt 6.8.3: **123/123 native CTests PASS**, zero failed; relevant `vehicle_rental_p3_rental_model` #7, `rental_studio_ux_s1_scroll_wide/compact` #43-44 and `rental_studio_p3_filter_qml_wide/compact` #47-48 PASS. Total CTest 149.82 seconds.
- Hosted Windows Server 2022 MSVC with Qt 6.8.3: **123/123 native CTests PASS**, zero failed, including the same five smoke/regression checks; total CTest 182.81 seconds.
- Hosted Windows relocated portable kit: **8/8 fictional executable functional checks PASS**; PowerShell 7 and Windows PowerShell 5.1 automatic checks PASS.
- [Windows real Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41703041464/artifacts/13264247784), [Linux real Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41703041464/artifacts/13264107395), [Windows acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41703041464/artifacts/13263917999). Independently downloaded and inspected actual **1280x720 Windows History Rentals** and **scrolled-bottom Rentals** screenshots. The new timing toolbar is readable and unobstructed, existing status/lookup controls are visible, and lower records/details remain reachable by scrolling. Linux compact History screenshot inspected too.

## Limits and next gates

This is a **fictional-data functional UX** improvement, not a policy approval or real-data rollout. Formal **45/74 accepted criteria, weighted 70.6%** unchanged, P7 **0/8**. The owner's physical Windows UX-S1 scroll retest, current-source Qt Creator/MinGW, real OS scaling 100/125/150%, Narrator, P7 D2-D8 commercial data/storage/backup decisions, P8 installer, P9 release and all draft merges remain OPEN. No real contact/licence files, operational backups, automatic migration, new fleet imagery or public release were authorized. Documentation-only follow-up is not a separate compiled test result.
