# P3-H | Native Qt Rentals All / Active / History Filter | Verified

**Date:** 30 October 2026. **Private repository:** Sonkhe-Shongwe/vehicle-rental-system.
**Branch:** `feature/p3-rental-confirm-20261030`, still unmerged Draft PR #9 stacked on Draft #8, #7 and #6.
**Exact full-test source:** [`02fc4cc755c77c18fe40d67b1d7173cc3489dc22`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/02fc4cc755c77c18fe40d67b1d7173cc3489dc22), production additions at [`6c1703d5a749d9bd87f8ebad1cf2fe5929b0deca`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c1703d5a749d9bd87f8ebad1cf2fe5929b0deca).

## Implemented, precise scope

- Native Qt Core `RentalListModel` adds `statusFilter` property with allowable **All**, **Active** and **History** only, and an explicit change signal. C++ determines lifecycle inclusion using existing `RentalRecordStatus`: History combines Returned and Archived, never Active. No JS pricing/availability/status truth.
- `m_allItems` contains the last authoritative C++ read-service snapshot; `m_items` is the filtered visible copy. Changing filters does not refetch or write the source ledger. Explicit `refresh()` re-reads the C++ service and applies the currently selected filter.
- Selection stores the real canonical rental ID rather than a row index. A filter change or refresh retains ID if visible; otherwise clears it, without silently restoring an earlier hidden selection. `selectVisibleRow()` accepts only valid filtered visible rows. `modelReset`, `countChanged`, `selectionChanged` and `statusFilterChanged` are emitted when appropriate.
- `spikes/qtquick_p2/Main.qml` uses three accessible buttons for All/Active/History and a ListView keyboard Up/Down handler that calls the C++ visible-row selection API. The UI remains a read-only fictional-fixture proof, no user-facing booking, return, archive or data-entry controls.
- Adds `tests/p3_rental_filter_tests.cpp` as a Qt Core-only CTest and two real Qt Quick CTests, `rental_studio_p3_filter_qml_wide` and `_compact`, to the opt-in native QML build. Existing Qt Widgets and P2/P3 suites unchanged.

## Exact-source executed evidence

| Environment | Test case | Result |
| --- | --- | --- |
| Ubuntu Qt Core and legacy app | `ctest --test-dir build --output-on-failure` | [Run 41104175400](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41104175400): **8/8 PASS** |
| Ubuntu GCC Qt6.8.3 + native Qt Quick | `ctest --test-dir build-p2 --output-on-failure` | [Run 41104175382](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41104175382): **20/20 PASS** |
| Windows MSVC Qt6.8.3 + native QML | `ctest --test-dir build-p2 -C Release --output-on-failure` | [Same run 41104175382](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41104175382): **20/20 PASS** |
| Windows packaged demo source protection | Real hosted Windows portable automatic checks | **PASS**; physical/manual Windows scaling expressly not tested |
| Linux/Windows screenshot artifact uploads | Existing uploader includes Fleet and P3 Rentals screenshot globs, including History QML capture | Three workflow artifacts uploaded (Linux/Windows screenshot archives and Windows physical acceptance kit), not owner manual signoff |

## Failure diagnosed and corrected

First P3-H candidate [`6c1703d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c1703d5a749d9bd87f8ebad1cf2fe5929b0deca) compiled and passed its real Qt Quick Rentals **wide and compact Active/History** smoke cases, but the new Core filter test incorrectly required `vehicles.txt` to change when returning, archiving or deleting only rental records. Its Core 7 existing tests passed; filter regression failed at this false expectation. On real domain behavior `rentals.txt` is persisted and the fleet file need not change.

Test-only fix [`02fc4cc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/02fc4cc755c77c18fe40d67b1d7173cc3489dc22) corrects the assertion: fleet bytes stay unchanged, rentals ledger changes, and all subsequent model-only filter/read calls preserve both files byte for byte. No C++ production code changed between the failing and passing revisions. Full 8/8 and 20/20 each OS passed at corrected source.

## Specific tests passed

- Independent fictional three-rental lifecycle fixture: one Active, one Returned, one Archived. All=3, History=2, Active=1 and real restarted history=2; archived has precedence and remains in History.
- C++ signal checks for changing filter, count, selection and model resets. Unknown/repeated values do not mutate state. Invisible selection cannot be chosen; selected ID stays with its record after filtered row shifts. Hidden selection clears, never resurfaces implicitly.
- After authoritative C++ return, Active remains a snapshot until explicit refresh; returned record leaves Active and appears in History. After archiving a historical selected contract, selection remains. Deleting that contract removes selection without stale row; all model operations are storage-read-only.
- Actual QQuickWindow and visible QML buttons exercised using keyboard Space, ListView arrow navigation, real C++ model statuses, historical archived transition only after refresh, both 1500x860 and 1280x720 QML captures, no changes to protected SHA-pinned demo fixtures.

## Honest acceptance boundary

**P3 remains 3/7 accepted, 19/74 across programme and 25.2% weighted evidence coverage**. This is **not release readiness**. P3 criterion 4 remains PARTIAL: the read-model filtering and live read-only QML binding are verified, but no end-user active rental return/booking/archive command path, confirmation-to-view integration in production UX, or independently injectable repository. Criterion 5 remains open for full QML pricing and availability ownership proof in user flow. P1 imagery/a11y and P2 physical Windows Qt Creator MinGW/100%,125%,150% OS scaling/real input remain OPEN.

**Next bounded step:** add a carefully constrained C++ application command/controller seam for user-operated rental actions only after reviewing P4/P5 scope and return-domain rollback requirements. Do not introduce payments, UI pricing truth, a database migration or release approval without their dedicated gates.
