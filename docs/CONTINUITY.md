# Project Continuity - 29 October 2026

## Objective

Make `Sonkhe-Shongwe/vehicle-rental-system` a credible, honest software engineering portfolio artifact for a Retipuj Zoft Full-Stack Software Engineer Graduate application due **30 October 2026**.

## Source truth

Uploaded initial source archive: `VehicleRentalSystem_A3.zip` (July 2026 Qt assessment). At audit start, the public GitHub repo existed but had no commits. The source ZIP contained a working-project design, not externally verified runtime execution. Its `rentals.txt` and some screenshots contained customer information and are deliberately not distributed in the hardened handoff.

## Current patch work

- Added constructor option for isolated test data directories.
- Converted fleet/rental writes to atomic `QSaveFile` results with in-memory rollback for failed operations.
- Made rental ledger authoritative so creating/returning rental needs one file write; fleet occupancy is reconstructed on reload.
- Removed automatic rewriting of source data during startup.
- Added numeric and text validation for newly created domain records; rejected duplicate active rentals from imported history.
- Added CTest regression source, sanitized `demo/`, `.gitignore`, README and documentation.
- No Qt toolchain here; no runtime pass has been claimed. Test with Qt on Windows before treating as stable.

## Important preservation constraints

The default legacy data folder remains next to the C++ source (using `__FILE__`) for compatibility. The new constructor can isolate testing. Do not overwrite real `vehicles.txt` / `rentals.txt` with demo files. Back up originals. Existing data may include records in the old 14-field rental format, which the reader still supports. Do not silently migrate or delete unrecognized lines.

## Immediate next actions

1. Extract the prepared hardened ZIP and import its contents into the existing GitHub repository; do not upload the original source's customer data or unredacted screenshots.
2. Run Qt Creator/CMake build and CTest. If they fail, record exact compiler output and correct before claiming the patch works.
3. Complete the disposable-data GUI smoke test and save a short dated result.
4. Make a concise application submission featuring the repo link and confirmed C++/Qt functionality.
5. Defer SQLite/REST/full-stack extensions until the tested release candidate is stable.

## Review risks after this checkpoint

The project is still a Qt desktop app with flat-file storage and no service API. SQLite transactions, secure customer data lifecycle, source-independent AppData paths, deterministic IDs and a clean deployment story are not yet implemented. `mainwindow.cpp` remains large. Revenue is calculated as sum of rental values, not receipts. All code must be compiled and tested on the target kit.
