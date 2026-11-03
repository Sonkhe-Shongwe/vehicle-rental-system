# UX-S2 | Operator-readable rental due-state labels, native verified

**3 November 2026. Scope:** a demonstrated native Rentals screenshot displayed the internal C++ due-state token `NotApplicable` to operators. The requested response was to preserve the typed C++ rental status and its due-date calculation, and translate *presentation only* in the existing Rental Studio QML.

## Change
- [Code source `42dfd33`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/42dfd33ff5828f6f7cdf468d713601d241c11272) adds a single QML `dueStateLabel` presentation function. It converts `NotApplicable` to **No return due**, `NotDue` to **On schedule**, `DueToday` to **Due today**, retains **Overdue**, and shows **Due date unavailable** for an unknown/unrecognized state. The values used by C++ availability/return/overdue decisions are unchanged.
- Real Rentals list rows, accessible row descriptions, and read-only contract details consume this presentation mapping. No extra data fields, booking rules, database writes or production records were added.
- The existing native two-size `rental_studio_ux_s1_scroll_wide` and `_compact` tests were strengthened to inspect both active R001 (Overdue) and returned R002 (No return due) QML delegates, not just static source text.

## Test correction and failure history (retained)
- Initial [source `42dfd33`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/42dfd33ff5828f6f7cdf468d713601d241c11272), [run 41689122465](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41689122465) **FAILED 2/120 on each Linux and Windows**. Test incorrectly located QML ListView delegates via the window's QObject parent chain before the scroll.
- [Source `3427474`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/34274746c2063f01a00a2be7c7f3389244c8ea82), [run 41690525380](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41690525380) **FAILED 2/120 on each hosted OS** even after scrolling: diagnostics confirmed both delegates were `<not instantiated>` from the **wrong search mechanism**, not from the rendered UI. This correction did not alter production QML.
- Final [source `3772978`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/3772978852018951e6b280014785030666973c37) switched the strengthened native test to the **visual QQuickItem childItems tree**, as already used in other accepted real-QML smoke tests. Both strict row-text expectations remain enabled; no tests disabled or weakened.

## Exact final verification
[Native GitHub Actions 41691687627](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41691687627), **completed SUCCESS** for executable source `3772978852018951e6b280014785030666973c37`:
- **Ubuntu 24.04 / GCC / Qt 6.8.3:** **120/120 CTests PASS**, zero failed; UX-S1 scroll wide and compact PASS; total CTest 150.26 sec.
- **Hosted Windows Server 2022 / MSVC / Qt 6.8.3:** **120/120 CTests PASS**, zero failed; same two QML scroll tests PASS; total CTest 175.54 sec.
- **Windows relocated portable package:** existing **8/8 real fictional functional checks PASS**; packaged P2 verification and P4 PowerShell 7 and Windows PowerShell 5.1 PASS.
- **Actual Qt screenshot evidence:** [hosted Windows screenshot artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41691687627/artifacts/13259220228) and [Linux screenshot artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41691687627/artifacts/13257264051). The hosted Windows compact archived R002 view and compact bottom-scrolled Rentals list were downloaded and independently viewed; both show **No return due**, and the active R001 row retains **Overdue**.

## Non-inferred acceptance and restrictions
No new owner criterion accepted; formal **45/74, weighted 70.6%** remains unchanged and is **not** release readiness. Owner Windows UX-S1 physical retest, current-source Qt Creator/MinGW, OS 100/125/150% scaling, Narrator, P7 D2-D8 commercial-data policy, P8 installer, P9 signoff, final fleet visuals and all merges remain OPEN. Documentation-only follow-up commits are not newly compiled code.
