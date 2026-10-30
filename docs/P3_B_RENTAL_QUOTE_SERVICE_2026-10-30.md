# P3-B: Typed, read-only Rental Quote Preview

**30 October 2026 | Implementation awaiting independent native Qt verification.**
Stacked on `feature/p3-typed-fleet-read-20261030`, not on stable `main`.

A small `RentalQuoteService` returns a typed success/result error and a by-value quote using the **existing C++ RentalSystem**. It uses the existing vehicle ID lookup and occupancy checks; input is vehicle ID + days, **not** customer information. Preserves immediate bookings only and **1–365 days**, with `R450 × 3 = R1350` demonstration, expected return day, explicit invalid/unavailable/overflow results, and a tiny injected date function for deterministic testing. Legacy rates are still **double** and labelled `legacyDailyRate`/`legacyTotal`. Qt/QML gains **no** independent price formula.

**Safety:** `preview()` never writes to `vehicles.txt`/`rentals.txt` or reserves a vehicle. Any later booking confirmation must independently revalidate using legacy `RentalSystem::createRental`. Unit test uses `QTemporaryDir`, checks file bytes unchanged after previews, missing/rented/invalid cases, overflow, and confirms only actual domain `createRental` writes a successful record. No new real data handling, SQLite, UI, payments, future reservations or large framework.

**Acceptance status:** Owner already approved Qt Quick + C++; P1/P2 physical/visual gates remain open. Before exact-source CI this slice is NOT verified. P2 **4/6**, P3 **0/7** pending milestone acceptance, **16/74 and weighted 20.1%**. Full Linux + Windows Qt Quick and domain regression required; the feature is deliberately isolated in a Draft PR against P3-A.
