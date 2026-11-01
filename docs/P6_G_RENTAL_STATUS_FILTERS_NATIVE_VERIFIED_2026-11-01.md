# P6-G | Separate Returned and Archived native rental views

**Date:** 1 November 2026. **Product:** Rental Studio. **Exact passing implementation source:** [`502b622`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/502b6229947649fd2c50d7f75f1e338837663591), which includes the initial filter implementation [`fb7d561`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fb7d561da3a6d0b46b644dda5b6ba8170ac2e8bf). **Branch:** `feature/p6-fleet-create-disposable-20261101`, [Draft PR #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14) stacked on P5 Draft #12 (P4 Draft #10 ancestor); `main` unchanged.

## Operator problem and actual change

Legacy Qt Widgets Rental Records provides separate Active, Returned and Archived status views. The current Qt Quick Rentals screen previously exposed only All, Active and combined History, forcing operators to scan historical rows to distinguish Returned from Archived.

The new **five distinct keyboard-accessible native filters** are `All`, `Active`, `Returned`, `Archived` and `History`. The C++ `RentalListModel` remains the single read-model authority for lifecycle classification:

- **Returned** shows only `RentalRecordStatus::Returned`, excluding archived records. **Archived** shows only `RentalRecordStatus::Archived`, excluding returned records.
- **History** continues to include both statuses, preserving the older QML workflow; Active/All are unchanged. Filter values are explicitly allowlisted, case-sensitive and unknown values are no-ops.
- Changing filter clears a now-hidden selected rental rather than keeping an invisible destructive-action target. An existing visible selection remains canonical across row reordering.
- Existing read-only `locateById` can still reveal a hidden rental by switching presentation to All. Full-snapshot Overview KPIs never follow the visible rental subset.
- No new domain write, customer/phone QML role, persistent-demo Fleet permission or production storage path was added.
- Filter buttons use an explicit **36 px minimum control height** after an actual native check found Qt's 26 px default unnecessarily small for the chosen usability boundary.

## Exact automated verification

| Environment | Source and result | Evidence |
|---|---|---|
| Ubuntu 24.04 core C++ Qt test suite | **13/13 PASS** | [Run 41350990892](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41350990892), including `vehicle_rental_p3_rental_filter` |
| Qt 6.8.3 Linux GCC native QQuickWindow | **68/68 PASS** | [Run 41350990927](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41350990927), including actual wide 1500×860 and compact 1280×720 filter tests |
| Qt 6.8.3 Windows Server 2022 MSVC native QQuickWindow | **68/68 PASS** | [Same run](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41350990927), including both wide/compact UI checks |
| Hosted Windows portable app verification | **PASS** | [Native run](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41350990927), PowerShell 7 and Windows PowerShell 5.1 P4 checks |

The native test verifies Returned-only R002; Archived empty-state before archive; History and keyboard selection; actual C++ archive commit to R002; Archived-only R002 with preserved selected ID; Returned clearing archived selection; reset to Active/All; existing ID-lookup and guarded SHA-pinned demo files. Native test captures `p3-qt-rentals-returned-<size>.png` and `p3-qt-rentals-archived-<size>.png` at both sizes for review. C++ regression checks Returned vs Archived typed statuses, hidden-selection clearing, History union, valid/invalid filters, ID lookup and unchanged ledger/vehicle bytes.

### Preserved initial failure and correction

The initial `fb7d561` implementation passed [13/13 core tests](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41350552933), but first native [run 41350552967](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41350552967) reported **two failing Linux native filter tests** (66/68 overall) because both new filter buttons were only 26 px tall and the new usability assertion required at least 28 px. The superseded Windows job was cancelled after the follow-up commit, not counted as a pass. We corrected the **actual QML control height** to a 36 px minimum in `502b622`, retained the test's original minimum height and full coverage, and reran all core and native checks to green. Do not attribute the final CI to the initially failing source.

## Acceptance, restrictions, next work

The P6 full legacy-versus-Qt-Quick operator parity group is still open overall. In particular, the legacy return flow accepts an active **rental ID or vehicle ID**; the Qt Quick flow currently centers on selecting a visible rental. The need for purpose-limited customer display, commercial non-destructive vehicle retirement and lawful historical retention also remains distinct from fictional-only engineering.

P6 provisional rubric: **8 groups with representative automated coverage, 0 partial, 1 unproven full lifecycle parity group**, pending owner ratification of nine original source criteria. **Formal P4 5/7, P5 0/8, P6 0/9, overall 28/74 and weighted 40.6% unchanged.** These are evidence/acceptance measures, not software-completion or commercial-release percentages.

No physical Windows Qt Creator/MinGW, Microsoft Narrator, 100/125/150% OS scaling or owner aesthetic review has been performed by these hosted jobs. No general customer data, installer, payment collection or production storage is approved. Next bounded task: evaluate a safe read-only vehicle-ID to active-rental lookup or dedicated return route, preserve typed C++ return/confirmation policies, and close residual Qt Quick/legacy lifecycle parity before owner review.
