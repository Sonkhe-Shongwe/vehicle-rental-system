# Project Continuity - 29 October 2026

## Objective

Make `Sonkhe-Shongwe/vehicle-rental-system` a credible, honest software engineering portfolio artifact for a Retipuj Zoft Full-Stack Software Engineer Graduate application due **30 October 2026**.

## Source truth

Uploaded initial source archive: `VehicleRentalSystem_A3.zip` (July 2026 Qt assessment). At audit start, the public GitHub repo existed but had no commits. The complete sanitized source and screenshots were subsequently published to `main` (latest source-and-screenshot commit `253918f7b765e82df17bc5b25eec584fc11e9672`). The source ZIP contained a working-project design, not externally verified runtime execution. Its `rentals.txt` and some screenshots contained customer information and are deliberately not distributed in the hardened handoff.

## Current patch work

- Added constructor option for isolated test data directories.
- Converted fleet/rental writes to atomic `QSaveFile` results with in-memory rollback for failed operations.
- Made rental ledger authoritative so creating/returning rental needs one file write; fleet occupancy is reconstructed on reload.
- Removed automatic rewriting of source data during startup.
- Added numeric and text validation for newly created domain records; rejected duplicate active rentals from imported history.
- Added CTest regression source, sanitized `demo/`, `.gitignore`, README and documentation.
- The local container lacks Qt; GitHub Actions `40872123623` subsequently **passed** Qt 6 configuration, build, fixture hygiene and CTest on Ubuntu 24.04. Interactive Windows GUI verification is still required.

## Important preservation constraints

The default legacy data folder remains next to the C++ source (using `__FILE__`) for compatibility. The new constructor can isolate testing. Do not overwrite real `vehicles.txt` / `rentals.txt` with demo files. Back up originals. Existing data may include records in the old 14-field rental format, which the reader still supports. Do not silently migrate or delete unrecognized lines.

## Research and design checkpoint — 29 October 2026

The [full comparative portfolio / UX research report](PORTFOLIO_RESEARCH_2026-10-29.md) has been added to the repository. It reviews the current Qt source and screenshots, three comparable open-source rental systems, commercial rental workflows, Qt engineering guidance, visual hierarchy, UX, persistence, security, testing, and the Retipuj Zoft graduate role. The PDF and DOCX presentation copies were delivered separately in ChatGPT; the complete Markdown report is the tracked GitHub source.

**Confirmed completed:** current public C++17/Qt source and sanitized screenshots; source audit; regression tests; Linux Qt6 CI compile and CTest passes (latest known documentation checkpoint); the report and roadmap. No code was modified as a result of this research.

**Recommended, NOT approved or implemented:** light-first operator-focused visual refresh; grouping nine sidebar destinations into fewer user-oriented workspaces; prioritising four operational metrics; improving rental/return workflows, responsive layout and feedback; then safely introducing modular widgets, SQLite and optional REST API. Visual tokens and UI structure are proposals, not an agreed design or a working screen.

**Pending verification:** interactive Windows Qt Creator compile and user-journey acceptance, screenshots of the updated running executable, accessibility/resizing checks, data migration and recovery, and all future features proposed by the research. Never infer these from CI alone.

**Next development decision:** agree on a bounded visual/UX specification and acceptance scenarios; improve the current application incrementally, preserve domain behaviour, and test each user journey. Prioritise a truthful portfolio demonstration for the **30 October 2026 application deadline**, not a speculative framework rewrite. The full design roadmap remains in the research report; do not label later milestones complete.

## Immediate next actions

1. **COMPLETE:** Prepared C++/Qt source, tests, docs, fictional demo data and sanitized screenshots are committed directly in the public GitHub repository. Do not publish real customer data.
2. **Linux CI PASS:** Hosted Qt 6 compile + CTest passed on commit `253918f`; **NEXT:** Run Qt Creator on Windows and document exact compiler/test output.
3. Complete the disposable-data GUI smoke test and save a short dated result.
4. Make a concise application submission featuring the repo link and confirmed C++/Qt functionality.
5. Defer SQLite/REST/full-stack extensions until the tested release candidate is stable.

## Review risks after this checkpoint

The project is still a Qt desktop app with flat-file storage and no service API. SQLite transactions, secure customer data lifecycle, source-independent AppData paths, deterministic IDs and a clean deployment story are not yet implemented. `mainwindow.cpp` remains large. Revenue is calculated as sum of rental values, not receipts. All code must be compiled and tested on the target kit.
