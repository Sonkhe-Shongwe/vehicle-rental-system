> **Rebuild security baseline — 29 October 2026:** The owner has authorised an architectural rebuild, **not** the publication or in-place conversion of private customer records. Any new storage path, database or migration must include backups, rollback, input validation, explicit errors and independent tests. The current code is a reference implementation; the planned light-first UI and SQLite are not yet implemented. [Full rebuild audit](docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md).

# Security and Privacy Notes

This is an educational desktop rental management application, not a certified enterprise rental service. It stores customer names and phone numbers in local human-readable files without encryption or account-level access control.

## Precautions

- Do not commit live `vehicles.txt`, `rentals.txt`, database files, backups, environment files or customer-related screenshots.
- Only fictional names and placeholder phone numbers are present in `demo/`.
- The legacy app uses source-adjacent storage, which needs a carefully tested migration to application-specific user data directories before packaging.
- Sanitise records before sharing screenshots, diagnostic logs or issues.
- Validate inputs at the domain level as well as at the GUI boundary.
- `QSaveFile` protects individual file replacement but is not a fully transactional relational database. A SQLite-backed storage layer is a planned improvement.
- No network API, authentication or remote service is exposed by the current source.

Please report issues without attaching real customer information or credentials.
