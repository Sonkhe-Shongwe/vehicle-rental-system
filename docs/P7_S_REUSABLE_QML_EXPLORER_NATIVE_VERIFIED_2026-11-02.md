# P7-S | Reusable Qt Quick snapshot cards and multi-row fictional record explorers

**Date:** 2 November 2026. **Exact compiled and verified source:** [`062ee985`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/062ee985b879208de9b561a9298940df754f7c6c). **Scope:** opt-in generated-fictional SQLite Lab, quality and maintainability only. No real customer data, commercial storage cutover, or public release approval.

## Implementation and operator benefit

- Extracted the two duplicated Fleet and Rentals status/retry panels into a shared **`P7LabSnapshotCard.qml`** presentation component. It uses the existing **`DesignTokens.qml`** navy/teal/white palette. The caller still supplies its authoritative C++ read-availability state, summary and retry callback.
- Preserved stable QML object names for real-application checks, visible failed-read feedback and native retry buttons. The shared card has no SQL, rental/vehicle state calculations, or business write functionality.
- Increased both read-only Fleet/Rental `ListView` preferred heights from 55 to 96 device-independent QML units, and the record-explorer card from 292 to 338. The scrollable Lab now accommodates multiple visible records rather than a single cramped row.
- Kept the operator's booking/return/archive action row above the read-only Overview and record explorer to preserve the previously verified compact desktop journey.
- Extended the existing actual-application native wide/compact scenarios to require both shared cards and record-list heights of at least 90. Their prior quote/commit/rollback, inspection, fail-visible retry and protected QSaveFile fixture checks remain. **No tests were removed or weakened.**

## Exact-source automated evidence

| Gate | Evidence | Result |
|---|---|---|
| Core C++ domain, Linux | [run 41512827219](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41512827219) | **13/13 PASS**, actual job log inspected |
| Native Qt 6.8.3 Linux GCC | [run 41512827186](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41512827186) | **115/115 PASS**, actual CTest log inspected |
| Native Qt 6.8.3 hosted Windows MSVC | Same native run | **115/115 PASS**, actual CTest log inspected |
| Actual Qt Quick Lab 1500×860 and 1280×720 | `rental_studio_p7_actual_app_lab_wide`, `_compact` | **PASS on both operating systems** |
| Hosted Windows packaged scripts | Same native run | **PowerShell 7 / Windows PowerShell 5.1 checks PASS**; not a commercial installer |

**Limitations:** No owner physical Qt Creator 6.10.2 MinGW run, Windows 100/125/150% OS scale review, Narrator review or visual owner signoff has been conducted for this source. Hosted native CI is not a release certification.

## Owner quality objective and unchanged permissions

"Commercial-grade" is a **professional quality benchmark**: coherent desktop UX, reliable business functionality, accessibility, maintainability and robust validation. It does not imply near-term commercial launch or permission to process live customer data. Development may continue improving fictional-data quality without waiting for commercial migration, privacy or deployment decisions.

D1 SQLite permission remains limited to the separately opted-in generated-fictional Lab. Default Overview/Fleet/Rentals remain protected QSaveFile demo data. D2–D8 retain their release/data-policy approval requirements if those capabilities are ever pursued. The frozen P0–P9 formal ledger remains **28/74 accepted, weighted 40.6%** with P7 **0/8**; this is **not a product-quality percentage**. P8/P9 release/distribution work is not the present development priority. PRs remain draft/unmerged, main unchanged.
