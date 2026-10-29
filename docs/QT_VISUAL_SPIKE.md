# Qt Widgets visual proof of concept (unapproved)

29 October 2026. A conservative exploration of the user's approved hybrid aesthetic in the actual Qt UI. The stable main branch remains unchanged.

- Graphite sidebar, warm mineral canvas, restrained lime selection / primary actions.
- Photo-based dashboard hero with Ford Ranger Commons CC0 photo. The photo is illustrative, not an actual rental fleet unit.
- Availability hero reads the real loaded fleet count; no hardcoded KPIs.
- Existing nine navigation actions, rental workflows, table, ID lookup and data persistence have not been changed.
- Dashboard secondary metrics include **Booked Rental Value** instead of ambiguous Revenue; no payment tracking is implied.
- No API/SQLite is added.

**Acceptance gates:** CI CMake/CTest; actual Qt screenshot verification; Windows Qt Creator check; verify 1280x720 layout; smoke-test Add/Search/Rent/Return/Archive/Restart with disposable data; owner visual review. Do not merge before those checks.
