# UX-S5 | Date-rollover refresh for ordinary Rentals due states

**Date:** 3 November 2026  
**Exact native-verified source:** [`fcfe78a93762f1dbdb9a9994a561b6e20c9e81aa`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fcfe78a93762f1dbdb9a9994a561b6e20c9e81aa)  
**Workflow:** [GitHub Actions 41721766185](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41721766185), **completed SUCCESS**  
**Scope:** Fictional-only native Qt Quick / C++ read-only reporting behavior. Draft PR #17 on P6 #14; no merge.

## Operator reliability gap

The existing C++ `RentalReadService` derives `NotDue`, `DueToday` and `Overdue` using the local domain clock when a record snapshot is read. Ordinary Rentals and Overview already displayed those correct values **at refresh time**, but an untouched desktop session could remain open overnight without a domain command or explicit model refresh. Such a screen could retain yesterday's overdue and due-today counts, row labels or urgency filters.

## Bounded implementation

- `spikes/qtquick_p2/Main.qml` tracks only the current local calendar date key. A visible-window `Timer` checks at 60-second intervals, and `ApplicationWindow.onActiveChanged` checks on returning to the app after sleep or inactivity. A **changed** key calls the existing `rentalsModel.refresh()` once; an unchanged key does nothing. QML never assigns due states, modifies a date, or writes business records. No new executable privileges or external/network activity.
- `tests/p3_rental_model_tests.cpp` adds an independent injected `QDate` advancing from day zero to +1 and +2. The actual C++ service moves one active record from `NotDue` to `DueToday` to `Overdue`, another record into `DueToday`, clears selection of a record hidden by the active filter, preserves full-snapshot booked-value/active counts and leaves fleet and rental fixture bytes identical.
- `spikes/qtquick_p2/main.cpp` strengthens **both existing actual QML** wide and compact filter smoke tests. They invoke the QML calendar guard and observe `RentalListModel::metricsChanged` exactly zero times for the same key, once for a different key, no second time for a repeated key, then once when restored to the original key. The actual native controller model preserves the visible selected ID and filter. Both tests locate the live QML timer object.
- No C++ due-state maths, quote, booking, return, archive, SQLite Lab, original protected fixture, customer contact, or P7 policy was changed.

## Native verification for this source

[GitHub Actions 41721766185](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41721766185) **completed SUCCESS**:
- Ubuntu 24.04 GCC / Qt 6.8.3: **123/123 CTests PASS**, zero failures, CTest elapsed **156.28 seconds**. Native `vehicle_rental_p3_rental_model` #7, `rental_studio_p3_filter_qml_wide` #47, and `_compact` #48 individually PASS.
- Hosted Windows Server 2022 MSVC / Qt 6.8.3: **123/123 CTests PASS**, zero failures, CTest elapsed **177.81 seconds**. The same three target tests individually PASS.
- Hosted Windows relocated portable app: **8/8 real fictional functional checks PASS**; P2/P4 package verification, PowerShell 7 and Windows PowerShell 5.1 PASS. Native artifact archives include the operator acceptance kit and Qt screenshots. This increment did not add a new photographed real-midnight session.
- There were no native test count changes, removed tests or weakened expected outcomes.

## Limits and acceptance

Calendar-change detection is bounded by one minute while the app is visible and an activation check after focus returns; it is not guaranteed to trigger at midnight to the millisecond. The tests simulate a changed day key and inject a controllable C++ calendar. They do **not** constitute a multi-day physical owner Windows soak test or proof for system-clock tampering, missed OS wake notifications or production storage.

Formal owner acceptance remains **45/74 criteria, weighted 70.6%; P7 0/8**, unchanged by native tests. Physical owner UX-S1 scrolling retest, Qt Creator / MinGW, actual Windows 100/125/150% display scaling, Narrator, P7 D2-D8 real-data/storage/backup policies, P8 installer, P9 release, final Fleet Population/Photos and every PR merge remain OPEN. There is no authorization for real customer/contact data, default SQLite cutover, operational backup UI or public release. A subsequent documentation-only commit must not be cited as a newly compiled source.
