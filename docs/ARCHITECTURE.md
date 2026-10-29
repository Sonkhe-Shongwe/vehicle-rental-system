# Current Architecture and Evolution

## Current source organisation

```text
             Qt Widgets desktop GUI
                MainWindow
                    |
                    v
              RentalSystem
          rental rules + file IO
         /         |         \
        v          v          v
     Vehicle     Rental      Flat-file storage
       ^                        vehicles.txt
       |                        rentals.txt
    +--+----+
    |       |
   Car   Motorcycle
```

`Vehicle` is abstract and supplies the shared identity, pricing and availability contract. `Car` and `Motorcycle` provide subtype-specific values and serialisation. `Rental` records a customer transaction, its duration, price and lifecycle state. `RentalSystem` handles fleet and rental commands plus legacy persistence. `MainWindow` constructs and controls the Qt GUI.

## Consistency policy in the revision

A saved rental history is the authoritative source for occupancy. Creating a rental and returning it write only one rentals file atomically with `QSaveFile`; on startup, rented/available status is reconstructed from active rental transactions. Fleet changes are written atomically to the vehicle file. Invalid and failed new writes return failure to the caller.

This prevents the specific two-file update problem during rent/return, but is not a transaction database. Malformed legacy rows, duplicate identifiers after deletion, failure messages for parsing and handling multiple concurrent app processes remain unresolved.

## Intended architecture after deadline

```text
Qt UI widgets
    |
Application service (validated commands, explicit result/error objects)
    |
Rental domain model + invariants
    |
Repository interface
    |
SQLite implementation with constraints, migrations and transactions
```

SQLite is preferred over implementing a second unrelated backend overnight. A future optional REST service could wrap this domain/API boundary and demonstrate full-stack skills without rewriting the desktop UI.

## Design tradeoffs to discuss in an interview

- Why source-coupled file paths harm packaging and tests.
- Why external errors and IO failures must be reported, not swallowed.
- Why booking occupancy should have one authority.
- How a database transaction and uniqueness constraint prevent double bookings at concurrent access.
- Why a Qt GUI should not itself determine the business truth.
- Why money should use integer cents or a fixed decimal type rather than floating-point doubles.
