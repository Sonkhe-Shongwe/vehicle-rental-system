# UX-Q1 | Main Rentals empty-state guidance and keyboard reset

**2 November 2026.** **Exact verified compiled source:** [`cd9492f`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/cd9492fc18c82d80e2a81940dbaf9ab26ca6a75b), active stacked draft branch `feature/p7-sqlite-sandbox-20261102`. This change affects the **main Rentals workspace**, not the isolated P7 SQLite Lab. It remains a generated-fictional-only product-quality change.

## Operator improvement

- Previously, switching to an empty rental lifecycle filter (for example Archived before any archive exists) showed a blank list with no helpful explanation.
- A centered, readable, accessible zero-results message now explains whether no rental exists under All or whether the selected **Active / Returned / Archived / History** filter has no matching record.
- When a filter is responsible for an empty result, a keyboard-accessible **Show all rentals** action switches the C++-owned RentalListModel status filter to All, without booking, returning, archiving, deleting, touching disk or exposing hidden selected contracts. Under All with a genuinely empty rental ledger, only guidance appears.
- The existing `rentalList` keeps its identity, row bindings, keyboard navigation and available viewport. The surrounding `Item` anchors the list to fill the remaining card, while its empty-state overlay is visible only when `rentalsModel.count === 0`.
- The main application C++ lifecycle and data layer were not changed.

## Automated tests, tied to exact source

| Environment | GitHub Actions | Result |
|---|---|---|
| Linux core C++ | [41515463954](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41515463954) | **13/13 PASS** |
| Linux GCC, Qt 6.8.3 actual Qt Quick | [41515463962](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41515463962) | **115/115 PASS** |
| Hosted Windows MSVC, Qt 6.8.3 actual Qt Quick | Same native run | **115/115 PASS** |
| Hosted Windows portable-kit/PowerShell checks | Same native run | **PASS**, including Windows PowerShell 5.1 |

The existing native `rentals-filter-smoke` test for **1500×860** and **1280×720** now checks that an initially populated list hides empty state; switching to a zero-result Archived filter shows specific guidance and the enabled reset; pressing the real reset button by keyboard returns to All, restores two visible records without reviving a hidden selection; and a later empty Returned filter shows the correct updated context. Existing history, C++ archive, keyboard interaction, proof-of-transaction, source-fixture protection and all other regressions remain. **No test counts were inflated, and no assertions removed.**

## Safety and owner review

This is evidence of hosted/native automated behavior, **not** a physically inspected Qt Creator **6.10.2 MinGW** build or an owner-verified Windows **100/125/150%** scaling, Narrator, real keyboard or professional visual signoff. The `main` branch and stacked draft PR hierarchy were not changed. Real customer data, commercial SQLite switch, migration, installer and release remain unapproved.

The owner's **commercial-grade** target refers to **software quality**, not a request to sell or release the product. Formal programme acceptance remains **28/74 criteria, weighted 40.6%**, which does **not** measure the app's quality or completeness.
