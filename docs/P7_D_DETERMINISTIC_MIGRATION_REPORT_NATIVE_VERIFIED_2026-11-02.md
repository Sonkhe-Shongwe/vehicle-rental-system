# P7-D | Deterministic migration-anomaly report and exact cents reconciliation, native-verified

**Date:** 2 November 2026 (Africa/Johannesburg). **Last exact tested C++ source:** [`fca261607d61af708a5f976960b06e8044262f68`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fca261607d61af708a5f976960b06e8044262f68). **Branch:** `feature/p7-sqlite-sandbox-20261102`. [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) stacked over unmerged P6 Draft #14, P5 Draft #12 and P4 Draft #10. No changes to `main` or user-facing storage.

## 1. Exactly what was implemented

P7-D extends the **existing P7-C Qt Core-only source preflight** under the already **OFF-by-default** `BUILD_P7_SQLITE_SANDBOX` CMake flag. No production library, app model, QML, Qt Widgets, QtSql adapter or general-purpose import path was added. The executable still accepts **only named fake-data test cases** and reads files it itself generated in a disposable `QTemporaryDir`.

The C++ `Report::manifest()` method now returns **compact canonical JSON bytes in memory** with:

- **`schema`**: exact version tag `p7.synthetic.preflight.v1`; this is a sandbox report schema, **not** an accepted migration-file interchange contract.
- **`status`**: `NO_FINDINGS_SYNTHETIC_ONLY` or `BLOCKED`; even a no-findings synthetic report does **not** authorize a real import.
- **`counts`**: `vehicle_lines`, `rental_lines`, `parsed_vehicles`, `parsed_rentals`, `active_rentals`, `historical_rentals`. Raw framing errors do not create a misleading partially parsed reconciled dataset.
- **`reconciliation`**: `complete` Boolean, `comparable_contracts`, `matching_contracts`, `declared_booked_cents`, `computed_booked_cents`, `exact_match`. **Cents are decimal strings**, not JSON floating-point numbers. Totals and exact-match are **null** if any required rental amount/duration is unparsable or the aggregate would overflow signed 64-bit; no partial sum is labeled complete. A mismatched but fully parseable synthetic contract produces comparable amounts and `exact_match=false` while overall `status=BLOCKED`.
- **`issues`**: array of `{file_kind, line, code}`, sorted by source kind, one-based line number and issue code to make output deterministic. No raw ID, customer, phone, driver's-licence value, source row, path, sensitive hash or actual source bytes are serialized.

The scanner remains **strictly read-only on its fictional input files**, with full byte and SHA256 equality checks before and after scanning inherited from P7-C. P7-D adds no file-export operation at all. All test dates and contacts are invented.

### Synthetic example: valid fictional records

Illustrative fields from the test-asserted 3-vehicle/2-rental sample (formatting expanded for readability, not an uploaded artifact):

```json
{
  "schema": "p7.synthetic.preflight.v1",
  "status": "NO_FINDINGS_SYNTHETIC_ONLY",
  "counts": {
    "vehicle_lines": 3,
    "rental_lines": 2,
    "parsed_vehicles": 3,
    "parsed_rentals": 2,
    "active_rentals": 1,
    "historical_rentals": 1
  },
  "reconciliation": {
    "complete": true,
    "comparable_contracts": 2,
    "matching_contracts": 2,
    "declared_booked_cents": "102000",
    "computed_booked_cents": "102000",
    "exact_match": true
  },
  "issues": []
}
```

**Terminology:** These amounts total **102,000 cents of fictional booked contract value**, **not cash collected, revenue recognized or accounting profit**. The report does not include a payments or event ledger. If input is blocked by any issue, status remains `BLOCKED` even when its arithmetic can be compared.

## 2. Four added real Qt CTests and exact source CI

| Test name | What it actually asserts |
|---|---|
| `rental_studio_p7_report_manifest_clean` | Canonical JSON is byte-identical across LF/CRLF and repeated runs, schema/version/status/counts correct; 2 synthetic contracts sum to exactly `"102000"` cents with match true |
| `rental_studio_p7_report_manifest_blocked` | 14-field historical licence presence, missing actual date and fictional booked total mismatch yield three stable line-1 issue codes in sorted order; declared `"49500"` vs calculated `"50000"`, status blocked, and fixed contact/licence/IDs **absent from JSON bytes** |
| `rental_studio_p7_report_manifest_incomplete` | Unparseable monetary data yields status blocked, `complete=false`, no comparable contract and explicitly null totals/match, not misleading zeros or partial amounts |
| `rental_studio_p7_report_manifest_overflow` | Two **individually in-range** fictional 5×10^18-cent contracts exceed signed 64-bit **only when added**; emits `RECONCILIATION_SUM_OVERFLOW`, blocks eligibility and nulls totals/match; no wraparound |

| Exact CI gate | Genuine outcome |
|---|---|
| [Core C++ **41407613482**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41407613482) | **13/13 PASS**, default P7 target OFF |
| [Linux GCC Qt6.8.3 native **41407613556**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41407613556) | **89/89 PASS**; new test #86–89 PASS; previous 85 P5/P6/P7-B/C cases retained |
| [Hosted Windows MSVC Qt6.8.3 native **41407613556**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41407613556) | **89/89 PASS**; new test #86–89 PASS |
| Relocated Windows packaged P2/P4 script checks | **PASS** with PowerShell 7 and Windows PowerShell 5.1; physical display scaling and Narrator **NOT TESTED** |

### Corrections recorded, not concealed

1. First implementation [`8e98766`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8e98766bc14000d8b35636975b0d4ca99c194b0b), native [run **41406444929**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41406444929), **Linux compilation failed** due to a mixed `QJsonObject` / `QJsonArray` declaration using one `auto` deduction. [`309a653`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/309a65397d4fb417f7337522476543d2629edd67) split it into correctly typed declarations. No validator checks were removed.
2. On source [`309a653`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/309a65397d4fb417f7337522476543d2629edd67), native Linux [run **41406949606**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41406949606) compiled and had **88/89 PASS**, but the new aggregate overflow case used a value that the strict amount parser rejected *individually* due to its protective headroom rule. [`fca2616`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fca261607d61af708a5f976960b06e8044262f68) corrected only the **fictional test amounts** to values which individually parse, but collectively overflow. No production app code or parser guard was weakened.
3. Exact rerun [core **41407613482**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41407613482) and [Linux/Windows native **41407613556**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41407613556) fully passed at [`fca2616`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fca261607d61af708a5f976960b06e8044262f68). Subsequent **documentation-only** heads must not be presented as newly tested code.

## 3. Remaining safety and architectural limitations

- **Not a general migration report generator**: JSON exists **in memory within an isolated CTest executable**, with no app import/file picker, arbitrary path argument, cross-application schema contract, database insert or actual business data processed. It cannot be pointed at real customer records.
- Aggregate counts indicate syntactically structured lines, **not approved importable rows**. File-level errors can block reconciliation before row parsing. Reconciliation is strict and signed-64-bit bounded; it has no owner-approved amount cap/rounding exception or accounting classification.
- No hardened data-source isolation for adversarial real file uploads, no wide range of alternative historical encodings, no authoritative issued-ID reconstruction for already-deleted legacy numbers, no customer/driver-licence privacy retention authorization, and no safe cutover process.
- **No SQLite backup/restore or actual commercial transaction adapter** yet. P7-B proves only isolated SQLite feasibility; P7-C/D prove only generated-fixture preflight and reporting constraints.
- Existing P6-N original nine formal acceptance and owner Qt Creator 6.10.2 MinGW physical 100/125/150% scaling/Narrator decisions remain open. P8/P9 packaging and release are separate milestones.

**Next safe work candidate:** **P7-E** a standalone synthetic-only SQLite backup + independently restored verification spike, including deliberate corrupt backup, locked source/restore refusal and no accidental overwrite; leave real data, migration activation and historical record policy blocked until owner approval.

**Formal programme ledger UNCHANGED:** P7 **0/8**, P6 **0/9**, P5 **0/8**, **28/74 formally accepted**, **40.6% evidence-weighted**. These numbers do not represent code percentage or commercial readiness. Draft PRs #17/#14/#12/#10 unmerged and `main` untouched.
