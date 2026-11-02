# P6-C | Native guarded archived-rental deletion

**1 November 2026 | Draft PR #14 | exact verified source `7d59cc18362c9730cbc3859e4dcfbdfe36a0b041`**

## Functional implementation
The Rentals screen now offers **Delete archived**, enabled only when a currently visible **Archived** rental is selected and only in the disposable fictional preview. It opens a keyboard-accessible QML dialog showing the selected stable rental ID, a permanent-deletion warning and a required case-sensitive phrase `DELETE <canonical rental ID>`. Cancel and Escape leave the rental ledger unmodified.

The new `P6ArchivedDeleteController` adapts the existing typed `ArchivedDeleteService::permanentlyDelete`; it independently refuses non-disposable fixed synthetic mode, missing/hidden/stale selected IDs and non-archived status. The existing `RentalSystem::deleteArchivedRental` alone owns the actual write and rolls back its in-memory removal when the atomic ledger write fails. Only a successful committed deletion causes the Qt rental model and Overview totals to refresh. The former selection disappears, and keyboard focus returns to the Rentals list instead of a now-disabled Delete button. Topmost P6 Fleet and Rentals dialogs now own Escape before the workspace clears selection.

No production records, real contacts, customer deletion tool, SQLite migration or changed storage schema have been enabled. This is explicitly **fictional-only** functionality. Archived rental removal is irreversible in the temporary preview, so the exact ID phrase and prior archive stage are required.

## Exact compiled and test evidence

| Gate | Actual run and result |
|---|---|
| Core C++ and existing domain suite | [Run 41334368520](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41334368520): **13/13 CTests PASS** |
| Linux GCC Qt 6.8.3 | [Run 41334368413](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41334368413): **66/66 native CTests PASS**, including `rental_studio_p6_archived_delete_wide` and `_compact` |
| Hosted Windows Server 2022 MSVC Qt 6.8.3 | Same run: **66/66 native CTests PASS**, both new P6-C tests passed |
| Windows packaged P4 safeguards | Same native run: packaged PowerShell 7 and Windows PowerShell 5.1 regression checks PASS. Owner physical Narrator and 100/125/150% OS scaling still NOT TESTED |

Both new tests run a **real native QQuickWindow** at 1500×860 and 1280×720, use keyboard activation of existing Archive and new Delete actions, and exercise: no action before selection; active R001 and returned R002 deletion refusal; real R002 archival prerequisite; preservation of selected R002 when switching to History; incorrect, blank or wrong-ID confirmations; Cancel/Escape byte-for-byte ledger integrity; stale-ID and fixed persistent-session refusal; a rejected injected atomic writer with in-memory rollback; successful **DELETE R002** with C++ state and Overview history/count reconciliation; focus recovery; a separate domain reopen proving R002 absent and active R001 still present; no vehicle ledger mutation or checked-in fictional fixture changes. Native screenshots were generated as additional smoke evidence; hosted CI is not owner physical signoff.

Superseded intermediate CI runs are not claimed as passing exact source.

## Remaining gates

P6 still needs complete original P6 criteria and final owner acceptance. The historical returned-rental reference policy of Fleet vehicle removal remains unresolved for commercial data, alongside P7 durable storage/migration/privacy, P8 licensing/packaging/installer and P9 physical Windows and release gates.

**Formal scores unchanged:** P6 **0/9**, P5 **0/8**, P4 **5/7**, programme **28/74**, evidence-weighted **40.6%**. This figure is **not** product completion or release readiness. Draft PR #14 remains stacked on unmerged P5 Draft #12, and stable `main` is untouched.
