# UX-S14 | Irreversible archived-delete review invalidation

**Date:** 4 November 2026 (Africa/Johannesburg)  
**Exact compiled and native-tested source:** [`f97d83d5631cd35e9c1c9a2bf2e1e9a923ffa249`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f97d83d5631cd35e9c1c9a2bf2e1e9a923ffa249)  
**GitHub Actions:** [run 41788843497](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41788843497), **COMPLETED SUCCESS**  
**Working branch:** `feature/p7-sqlite-sandbox-20261102`, draft PR #17 stacked on P6 PR #14; no merge.

## Verified functional risk

P6's disposable-fictional **Delete archived** modal froze the reviewed target ID on opening. Its existing Confirm enabled binding relied on whether *some* currently selected rental was eligible for archived deletion and the frozen target ID was nonempty, not on the continuity of the exact selection being reviewed. Changing selection could therefore leave an enabled-looking confirmation, and navigating A → B → A could revive the old review without operator reconsent. The C++ `P6ArchivedDeleteController::permanentlyDelete` already rejects mismatched IDs and requires the exact `DELETE R002` phrase in a disposable-only session; this improvement closes the **operator-visible stale consent** gap and does not claim a discovered data-loss incident.

Additionally, the old modal could remain open after an authoritative `RentalListModel::refresh()` with the selected ID unchanged. The review should expire after such a refreshed snapshot, even if the previous ID remains eligible.

## Bounded QML correction

- `spikes/qtquick_p2/P6ArchivedDeleteDialog.qml` takes an explicit `rentals` model reference. Its open review has a one-way `reviewInvalidated` latch and `reviewInvalidationReason`, preserving the *first* cause until the dialog is closed/reopened.
- Native `selectionChanged` invalidates the open modal if its selected rental ID departs from the captured `targetId`. Returning to the original ID does not re-enable Confirm. `modelReset` always invalidates a visible review even if ID is unchanged. A failed provider read also invalidates on `snapshotAvailabilityChanged`.
- Confirm additionally requires a verified currently eligible C++ archived-delete controller, a nonempty captured ID **equal** to the selected rental ID, and `reviewInvalidated == false`. A visible, accessible warning states **"Selection changed."**, **"Rental data refreshed."**, or **"Rental data unavailable."** and requires closing and reopening for a new review.
- On dialog close, the typed `DELETE` phrase, captured ID and invalidation state are cleared. A fresh opening can be used for the then-current selected archived contract.
- `spikes/qtquick_p2/Main.qml` passes the existing `rentalsModel` into the reusable deletion dialog. The C++ deletion transaction, exact-ID/phrase guard, P6 disposable-only policy, storage, data schema and other modals remain unchanged.

## Real native Qt regression coverage

The existing `--p6-archived-delete-smoke` scenario in `spikes/qtquick_p2/main.cpp`, exercised at both **1500×860** and **1280×720**, now:
1. Opens the genuine Qt archived-delete dialog for fictional archived R002 and confirms the initial button is enabled and no warning is shown.
2. Types the correct phrase but independently clears the selected ID, verifying the prior review is disabled, the warning is visible and the frozen target still says R002.
3. Selects R002 again to reproduce A → B → A. The C++ controller again regards R002 as eligible, but the *same modal* Confirm remains disabled and source fleet/ledger bytes are identical.
4. Cancels, opens a completely new modal, verifies the phrase is cleared, warning is gone and Confirm is available for fresh consent.
5. Calls genuine C++ `rentalModel.refresh()` with R002 still selected. The open modal now disables Confirm and shows a separate **data refreshed** warning without changing the ledger. Escape and reopen provides another genuinely fresh review.
6. Continues the pre-existing incorrect phrase, Cancel/Escape, rollback, fixed-mode denial, actual valid deletion, keyboard focus, Fleet-history release, restart and protected-source byte comparisons.

No test was deleted or disabled. There are still **123 registered native CTests** per platform.

## Exact-source verification

[GitHub Actions 41788843497](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41788843497) **COMPLETED SUCCESS** for the exact application/test source `f97d83d5631cd35e9c1c9a2bf2e1e9a923ffa249`:
- **Ubuntu 24.04 GCC / Qt 6.8.3:** **123/123 genuine native CTests PASS**, zero failures, total **159.41 seconds**. Real `rental_studio_p6_archived_delete_wide` #37 and `_compact` #38 PASS with new UX-S14 review invalidation checks.
- **Hosted Windows Server 2022 MSVC / Qt 6.8.3:** **123/123 native CTests PASS**, zero failures, total **174.85 seconds**. Same two actual Qt wide/compact dialogs pass.
- **Relocated hosted Windows portable executable:** **8/8 real fictional functional checks PASS**. P2/P4 packaged automation and both PowerShell 7 and Windows PowerShell 5.1 checks PASS.
- [Portable Windows physical acceptance kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41788843497/artifacts/13302557658), [hosted Windows Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41788843497/artifacts/13301824737), [Linux Qt screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41788843497/artifacts/13302672014). All artifacts expire **11 November 2026**.

Hosted CI and screenshots are **not physical Windows owner acceptance**, Qt Creator/MinGW validation, display scaling 100/125/150%, actual Narrator verification or release certification.

## Project gates unchanged

**Formal owner acceptance remains 45/74 criteria, weighted 70.6%; P7 0/8.** P5/P6 functionality is valid only within the agreed fictional/demo scope. Physical UX-S1 Rentals scrolling and keyboard/focus retest, Qt Creator/MinGW, Narrator, real device scaling, P7 D2-D8 real-data/privacy/security/retention/backup decisions, P8 installer, P9 release, all draft PR merges and final Fleet Population/Photos remain OPEN. No customer/contact data, commercial pricing, production database or public release was introduced.

A later documentation-only HEAD **is not separately compiled or verified** as the application.
