# Hosted Windows Qt Acceptance | Verified Checkpoint

**Date:** 29 October 2026 (SAST)  
**Scope:** Windows-hosted Qt 6/MSVC automated build, isolated CTest and non-destructive UI smoke.  
**Branch:** `feature/qt-hybrid-visual-spike-20261029` | **Verified code SHA:** `7d9027bde4fe3c6f87c57b6d29195fc8fd6d1383`  
**Workflow:** [Windows Qt6 build, domain and UI smoke, run 40921642782](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40921642782)  
**Result: PASS** (all workflow steps succeeded). **Manual Windows Qt Creator acceptance is still PENDING.**

## Verified environment and test results

| Gate | Evidence | Result |
| --- | --- | --- |
| Windows runner | GitHub-hosted `windows-2022`, Visual Studio 2022 x64 / MSVC | PASS |
| Framework | Qt 6.8.3, `win64_msvc2022_64` installation by `jurplel/install-qt-action@v4` | PASS |
| CMake | Configure with VS 17 2022 x64 generator and Qt prefix | PASS |
| C++ application and tests | Release build, C++17/Qt Widgets, compiled all sources and Qt resource bundle | PASS |
| Domain regression | `ctest --test-dir build-windows -C Release --output-on-failure`, 1/1 test `vehicle_rental_domain` | PASS |
| Actual Windows Qt UI smoke | Five `QT_QPA_PLATFORM=offscreen` runs of the **compiled GUI executable** | PASS |
| Screen identity and PNG integrity | Each PNG has 1500×860 dimensions, valid chunk CRCs, valid inflate/scanline dimensions and diverse image data | PASS |
| Source data safety | SHA-256 of `vehicles.txt` and `rentals.txt` unchanged after all five UI smoke runs using fictional fixtures | PASS |
| Windows real desktop interaction, Qt Creator, 100/125/150% DPI, full persisted rental workflow | Not executed here | **PENDING** |

Smoke modes: `--portfolio-screenshot`, `--portfolio-fleet-screenshot`, `--portfolio-rent-screenshot`, `--portfolio-history-screenshot`, and `--portfolio-return-screenshot`. Existing runtime checks cover fleet search/filter, rental quote for an unavailable vehicle, 3-day R1350 Corolla estimate, required-field state, rental-history status filtering and active return listing. None submits a rental or modifies source data.

## Root-cause work performed during this Windows milestone

1. [Initial run 40919894617](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40919894617) successfully compiled but failed a fixture byte-integrity test on Windows. The **test setup**, not the application, used `QIODevice::Text` to create a fixture, which converts LF line endings to CRLF on Windows. Fixed by writing exact bytes without the Text flag, and asserting byte identity **before and after** application startup. Production storage code unchanged.
2. [Run 40920464940](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40920464940) then passed Windows CTest but failed the UI process exit check because invoking a GUI-subsystem executable via PowerShell's `&` does not reliably wait or produce a usable `LASTEXITCODE`. Fixed by `Start-Process -Wait -PassThru` with explicit `ExitCode`.
3. [Run 40920895215](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40920895215) executed Dashboard and Fleet smoke checks, then incorrectly rejected a valid Rental PNG based only on an arbitrary 25 KB compressed-size threshold. Replaced this fragile test with `tests/verify_qt_png.py`: PNG signature, CRC, exact dimensions, compressed stream/scanline validation and basic content diversity, not just file size.
4. [Final run 40921642782](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40921642782) passed all build, domain, five UI smoke and fixture-integrity checks.

**Do not treat the three failed intermediate runs as passing.** The final success applies only to the exact verified commit SHA above.

## What remains before merge or release

- Real Windows Qt Creator application test in a **disposable clone**, using `docs/WINDOWS_ACCEPTANCE.md` as the manual procedure.
- Full click-through rental lifecycle and persistence after restart (add/rent/double-book rejection/return/repeat-return/archive/delete).
- Windows high-DPI at 100%, 125% and 150%; keyboard/focus, modal dialogs, content clipping and mixed image quality.
- Owner aesthetic sign-off, suitable licensed photography, documentation of any defects and successful retest.
- Stable `main` is unchanged by the visual work. Draft PR #4 is still unmerged.

No installer, commercial transaction/payment processing, SQLite or REST API was added. The release gate is **not complete**, despite a successful Windows-hosted automation run.
