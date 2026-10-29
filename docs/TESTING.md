# Test Plan and Evidence Register

## Current execution status - 29 October 2026

- Source review: **complete** for central domain, persistence and UI event paths.
- Privacy screening of historical raw data: **complete**; removed from handoff.
- CMake configure in this environment: **BLOCKED: Qt development packages unavailable**.
- C++ compilation: **NOT RUN**.
- CTest `vehicle_rental_domain`: **NOT RUN**.
- Windows interactive UI run: **NOT RUN**.
- Crash/power-loss recovery: **NOT RUN**.

Do not relabel prepared tests as passed until their exact commands have been executed.

## Automated checks

```powershell
cmake -S . -B build -DBUILD_TESTING=ON
cmake --build build --config Release
ctest --test-dir build -C Release --output-on-failure
```

The `vehicle_rental_tests` binary covers isolated add/duplicate/reject, record separator injection, rental lifecycle, no double booking, bad totals, future return refusal, restart occupancy reconstruction, archiving, deletion, failed-save in-memory rollback and read-only startup.

## Manual Windows smoke test (disposable demo data only)

- [ ] Qt Creator configures and compiles the app with known kit/version.
- [ ] Dashboard opens without warnings; resizing and navigation work.
- [ ] Add a car and motorcycle, search both IDs and reopen them after restart.
- [ ] Reject duplicate IDs, invalid prices and invalid fields.
- [ ] Rent an available vehicle; amount and expected date are correct.
- [ ] Attempt a second rental of the same vehicle; must reject.
- [ ] Close and reopen app; active rental remains and vehicle stays unavailable.
- [ ] Return by rental ID, then repeat return; first succeeds, repeat rejects.
- [ ] Archive returned rental; cannot archive an active rental.
- [ ] Delete only archived records after confirmation.
- [ ] Remove an available vehicle; block removal while active rental exists.
- [ ] Confirm application files do not change merely by opening the app.
- [ ] Test a failed save in an isolated unwritable folder; no false success.
- [ ] Confirm all public screenshots and demo data have fictional identities.

## Test record template

Date, OS, Qt version, compiler, CMake version, commit SHA, test command, exit code, failed case IDs, reproduction steps, expected vs actual result, screenshot or sanitized log and fix/issue link.
