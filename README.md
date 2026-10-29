# Vehicle Rental Management System

C++17 and Qt Widgets desktop application for car and motorcycle rentals, based on an original university project and being upgraded for graduate software engineering applications.

**Engineering status (29 October 2026):** A source audit and revised local code package have been prepared. Qt compilation, CTest execution, and Windows GUI checks are pending. **This repository is being populated; do not assume the complete code is online until source files appear here.**

## Existing features
- Fleet management: add, search, remove, and auto-generate vehicle IDs.
- Car and Motorcycle derived classes with a polymorphic Vehicle base class.
- Rental creation, availability checks, return processing, and archived records.
- Date and price calculations, dashboard KPIs and rental history.
- CMake/C++17 build with Qt5/Qt6 Widgets compatibility.
- Human-readable local persistence (planned SQLite migration).

## Portfolio upgrade plan
1. Commit the sanitized application sources, CMake test target, sample data and safe screenshots from the prepared development ZIP.
2. Compile using Qt Creator on Windows and execute the CTest domain regression suite.
3. Check the rent/return/archive/restart workflow with disposable data and record the result.
4. Preserve the familiar desktop UI; continue with data integrity and architectural changes only after verification.

## Build
Requires Qt 6 (or supported Qt 5), CMake 3.16+, and a C++17 compiler.

```bash
cmake -S . -B build -DBUILD_TESTING=ON
cmake --build build --config Release
ctest --test-dir build -C Release --output-on-failure
```

For Qt Creator, open CMakeLists.txt, select a desktop kit, configure and build.

## Engineering notes
The original source stores runtime personal information in text records. Do not publish the original rentals.txt, vehicles.txt, or screenshots with customer information. Only synthetic demo records belong in the public repository. The revised source uses QSaveFile and an authoritative rental ledger, but Qt execution has not yet been verified.

See [Audit](docs/AUDIT.md), [Roadmap](docs/ROADMAP.md), and [Continuity](docs/CONTINUITY.md).

**Scope:** Qt desktop software, not a deployed REST API or web full-stack application. Future API/database work is documented as a roadmap, not a completed feature.
