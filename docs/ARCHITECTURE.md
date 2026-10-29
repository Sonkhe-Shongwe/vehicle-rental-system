# Architecture — Current Source and Rebuild Options

**Status:** Architecture options for owner-authorised full product rebuild. This is a **plan**, not deployed code.  
**Master audit:** [29 October rebuild](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md).

## Current implementation (verified by reading source)

    Qt Widgets MainWindow (large coupled GUI implementation)
                  |
              RentalSystem (rules + file I/O)
               /       \
        Vehicle/Car/Motorcycle     Rental
                  |
          vehicles.txt, rentals.txt

CMake builds C++17 application and two tests. The current app uses a legacy source-relative directory by default; tests inject a disposable directory. Rental events write one ledger with QSaveFile and occupancy is reconstructed at load. UI and persistence are not independent modules. There is no SQLite/database server, browser UI, REST endpoint, login, payment collection or production installer.

## Rebuild target — presentation technology not yet confirmed

    Light, interactive presentation layer
         (candidate Qt Quick/QML, otherwise Qt-native alternative)
                      |
       typed C++ QObject / QAbstractListModel adapters
                      |
       application use cases + validated result objects
                      |
       rental domain / pricing / availability policy
                      |
            repository abstraction
                 /             \
       compatibility text    candidate SQLite
          reader             transactional store
                 \             /
         versioned, backed-up migration when approved

**Hard architectural principles:** UI does not decide booking availability, commit payment, or directly construct storage records. State changes result from validated domain/application operations. Expose errors and busy state for correct feedback. Models use stable IDs, not table row indexes. A visual interaction is not a mutation until an explicit command succeeds.

## Refactoring decision gates

1. **UI feasibility first.** Reuse current domain through an adapter; produce a compiled real QML UI for three simple interactions. This isolates UI technology risk from persistence risk.
2. **Compatibility parity.** Map existing C++ operations Add, Remove, Search, Rent, Return, Archive, Delete, Restart, Invalid/No into tests; no loss of safeguards. The owner allows rewriting the implementation, not silently changing expected outcomes.
3. **Local storage hardening.** Evaluate durable IDs, integer-cent prices, QStandardPaths AppData location, validation/diagnostics and backups before irreversible migration.
4. **SQLite only after it has a clear release use case.** Atomic transactions, safe schema and migration tests must be mandatory if used. Do not claim production/transaction-safety until verified on real failure cases.
5. **Cross-platform/deployment.** Preserve Windows Qt Creator local-first testing and relevant Linux build. Qt Quick module dependencies must be validated on the actual installed Qt kit.

## Source risks to track (not all necessarily immediate blockers)

- Existing MainWindow couples many UI pages and tabular presentation to global widget pointers.
- Text files store serialized customer data adjacent to source, fragile for installation.
- Separate persisted files and no multi-process transaction boundary.
- Floating-point currency and potential identifier reuse after deletion.
- Need explicit malformed-record diagnostics and non-destructive migration.
- No authenticated multi-user sessions, concurrent booking service or API; none should be implied.

## Provenance and engineering references

Source: mainwindow.cpp/.h, rentalsystem.cpp/.h, rental.cpp, CMakeLists.txt, tests/ and demo/ at reference SHA d1704ec.
Qt: https://doc.qt.io/qt-6/qtquick-index.html and https://doc.qt.io/qt-6/qquickwidget.html .
Historic audit: [Initial source findings](archive/AUDIT_INITIAL_2026-10-29.md).
