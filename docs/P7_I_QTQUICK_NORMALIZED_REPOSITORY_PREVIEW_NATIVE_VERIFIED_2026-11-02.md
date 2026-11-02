# P7-I | Fictional Qt Quick-to-normalized SQLite workflow, native-verified

**Date:** 2 November 2026. **Exact code revision:** [`b2edee6`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/b2edee62f94a1283c6750451348ed4acbf11c47a). **Scope:** strictly generated fictional **opt-in preview executable only**, built by the existing **`BUILD_P7_SQLITE_SANDBOX=ON`** test subtree. **No change to the normal Qt Quick application, its original protected fictional text-file storage, or real customer handling.**

## Increment: from database-only repository to an actual Qt Quick-facing C++ seam

P7-G proves that actual C++ `RentalSystem`, `RentalQuoteService`, and `RentalConfirmService` can operate via a throwaway SQL blob transport. P7-H separately provides a typed normalized SQLite repository of Vehicles/Rentals/C/M/R counters with exact int64 cents, transaction-scoped IDs, distinct active and retired state and failure handling. **P7-I now exercises real compiled Qt Quick controls against P7-H through a QObject controller**. This closes the *fictional-only UI ↔ typed repository* demonstration gap. It **does not** integrate the new repository with the existing Overview/Fleet/Rentals `Main.qml` and its production-directed business services.

**New files:**
- `src/application/p7_sandbox/repository_preview_controller.h`: `PreviewController`, QObject Q_PROPERTY/Q_INVOKABLE adapter over P7-H `Repository`. Owns and deletes a unique temporary SQLite directory, refuses absent/invalid marker, seeds one generated fictional C001 Toyota Corolla at R 450.00/day, displays exact 135000-cent 3-day quote, and exposes bounded quote → confirm → return → archive → retire commands. No contact, licence, payment or arbitrary filesystem field. Confirmation displays R001 only after SQLite commit. A fake commit failure leaves no row, ID or UI receipt.
- `tests/p7_sandbox/p7_fictional_preview.qml`: isolated **Qt Quick Controls** application window, current navy/teal palette, fictional-only banner, asset status/quote/receipt, and explicit sequential action buttons. Not imported by the normal QML module or shipped Windows kit.
- `tests/p7_sandbox/p7_qml_preview_tests.cpp`: actual QGuiApplication/QQmlApplicationEngine/real-window mouse-click test driver; verifies live QML quote/receipt/status bindings, one committed rental, independent new SQL connection reopen, return/archive/retire, and rollback/retry without false receipts.
- `tests/p7_sandbox/CMakeLists.txt`: Qt Quick + Qt SQL linked into **`rental_studio_p7_qml_preview` opt-in test executable only**, with 2 new CTests #109–110. No QtSql link added to `rental_studio_qtquick_spike` or the older Widgets app.

## Exact compiled-source results

| CTest | Linux Qt 6.8.3 GCC | Windows Qt 6.8.3 MSVC | Evidence |
|---|---|---|---|
| `rental_studio_p7_qml_journey` (#109) | PASS | PASS | Real Qt Button → C++ quote R1350 for 3 days → COMMIT R001 → read-only UI update → fresh DB reopen → return/archive/retire → fresh DB reopen, archived reference preserved |
| `rental_studio_p7_qml_rollback` (#110) | PASS | PASS | Same real QML buttons; deterministic rejected write before COMMIT yields no UI receipt/ID and no SQL record; retry commits R001 then completes lifecycle |
| Entire native suite | **110/110 PASS** | **110/110 PASS** | [Exact-source native GitHub Actions](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41466363800) |
| Existing core regression | **13/13 PASS** | Not a separate native Windows core workflow | [Core GitHub Actions](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41466363812) |

Windows packaged P4 PowerShell 7 and 5.1 checks **PASS** in the native workflow. The existing protected fictional Qt Quick P5/P6 UI tests and P7-B–H storage tests remained green. Windows native-QPA runtime ≠ physical owner Qt Creator 6.10.2 MinGW, monitor scaling or Narrator certification.

## Safety and nonclaims

- **Runtime:** The normal Rental Studio exe remains on the original fictional `RentalSystem` and QSaveFile text ledgers. P7-I is a distinct off-by-default *test preview* executable; it is not a user-selectable production database setting and has no backdoor file import or general customer data entry.
- **Data:** Unique QTemporaryDir, exact `.fictional-only` marker, synthetic literals only, DB removed when preview exits. No customer name, phone, driver's licence or other genuine PII fields. The fixed date is a deterministic test clock, not a commercial booking calendar.
- **Commerce:** No customer-contact workflow, pricing caps/legacy import adjudication, secure backup/restore, permissioned roles, privacy retention, genuine installer or production migration. The stored schema remains an owner-unratified candidate.
- **Acceptance:** Host-run 110/110 is engineering evidence, **not** formal P7 approval. P5 **0/8**, P6 **0/9**, P7 **0/8**, programme **28/74** formally accepted and **40.6%** weighted. All relevant stacked PRs remain **DRAFT/unmerged**, `main` untouched. P8/P9 not started.

## Next useful product step

Consolidate and ratify P7 commercial ADR: acceptable SQLite deployment, exact money caps, durable lifetime ID and legacy ID migration, non-destructive retirement/history retention, purpose-limited contact/licence handling, local permissions and protected backup/recovery. **Only then** connect the typed repo to the actual normal Overview/Fleet/Rentals services in a guarded fictional mode, perform equivalence/upgrade and physical Windows acceptance, and separately authorize any real-data use. Do not mistake a separate QML preview executable for completed commercial runtime integration.
