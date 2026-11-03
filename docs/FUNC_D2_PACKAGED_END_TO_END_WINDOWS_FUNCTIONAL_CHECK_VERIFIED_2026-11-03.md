# FUNC-D2 | Native packaged Windows end-to-end functional self-check

**3 November 2026. Status: exact-source hosted Linux and Windows validated, not owner physical acceptance.**

**Compiled source:** [`ba8665c72ef0d4fbdeb2e2ac62756ca540cad41c`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/ba8665c72ef0d4fbdeb2e2ac62756ca540cad41c), on stacked draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), base P6 development branch. **CI:** [run 41671235333](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41671235333) **completed SUCCESS**. `main` untouched.

## Functional problem solved

The app's real P5/P6 generated-fictional Fleet and rental workflows already pass native CI tests, but the portable Windows preview previously exposed only a minimal bundled model/self-test through its launcher. A user on a non-development Windows machine had no simple, reproducible way to verify end-to-end booking/return/restart/refusal functionality and retain a local diagnostic report before describing UI problems.

A new **`Check-Rental-Studio.cmd`** is bundled beside the actual executable. It requires the complete extracted package and fixed `SOURCE_COMMIT.txt` + SHA-pinned `demo/vehicles.txt` / `demo/rentals.txt` files. It clears inherited Qt developer scaling/import overrides **only in the child process**, executes **existing allowlisted C++ CLI test modes** in the real Windows executable, and produces a fresh `functional-check-evidence-<random>-<random>/RESULTS.txt` with eight PASS/FAIL lines and per-test logs. Earlier reports are never overwritten. Logs may include local file paths and should be reviewed before sharing.

### The eight fixed real-app checks

1. `--self-test`: protected seed and C++ model integrity before operations.
2. `--startup-fit-smoke`: real native Qt window startup, logical screen work area and shell.
3. `--p6-integrated-flow`: three independent Qt executable processes perform actual fictional Fleet create, book, return, archive/delete and removal at **1500×860**.
4. `--p6-integrated-flow --compact`: the same real three-process journey at **1280×720**.
5. `--p6-restart-flow --compact`: independent fictional persistence/reload and state parity through three native launches in a unique ephemeral synthetic directory.
6. `--p5-stale-quote-smoke --compact`: reject stale/occupied quote and prevent false success.
7. `--p5-booking-cancel-smoke --compact`: cancellation/escape does not commit a booking.
8. `--self-test`: verify original bundled fictional source integrity **after** all operations.

These commands use C++ source-bound fictional fixture SHA checks, exact synthetic marker/stage allowlists, isolated `QTemporaryDir`/temporary sessions and actual Qt/QML screens, not a mock or a new business-rule engine. They do **not** authorize persistent customer records, fleet import, migration or general file access. Default `Launch-Rental-Studio.cmd` unchanged: real GUI session is disposable and resets at exit.

## Native verification results

| Evidence | Exact source and outcome |
|---|---|
| Ubuntu 24.04 GCC / Qt 6.8.3 | **118/118 CTests PASS**, 0 failed. Genuine P6 integrated wide/compact, P7 Lab, booking/return and QML coverage preserved |
| Hosted Windows Server 2022 MSVC / Qt 6.8.3 | **118/118 CTests PASS**, 0 failed, including P6 wide/compact, source `ba8665c72ef0d4fbdeb2e2ac62756ca540cad41c` |
| Windows relocated Qt portable package | **All eight functional checks PASS**, including 3-process journey and restart/refusal paths, with source `ba8665c72ef0d4fbdeb2e2ac62756ca540cad41c` |
| CI summary check | Workflow inspects generated `RESULTS.txt` for exact **`FINAL: PASS - all eight checks exited 0`**, fails workflow otherwise |
| Existing portable preflights | `Launch-Rental-Studio.cmd --verify` PASS, P2 check PASS, P4 Windows PowerShell 7 and **5.1** subprocess PASS |
| Diagnostic packaging | CI deletes its own generated `functional-check-evidence-*` directory before upload, so no machine-specific paths or logs are distributed |

**New exact-source Windows ZIP:** [portable Windows functional QA kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41671235333/artifacts/13247984391) (7-day default Actions artifact retention). Downloaded into this conversation as `/mnt/data/Rental_Studio_2_Functional_Check_Windows_2026-11-03.zip`; integrity verified via Python ZipFile CRC check. Contains **1,393 entries**, 38,576,488 bytes, **SHA-256 `a1b4431240ff53d3ee8fc05cbfe3d7ec099e4e562c73aed31b43a8a15dc8a807`** and source marker `ba8665c72ef0d4fbdeb2e2ac62756ca540cad41c`. All eight essential executable/launcher/checker/guide/demo/Qt files present and no CI check logs bundled.

## User-facing use and outstanding acceptance

After extracting the entire Windows ZIP into an ordinary local folder, double-click **`Launch-Rental-Studio.cmd`** to explore Fleet and Rentals, or **`Check-Rental-Studio.cmd`** to run the full protected functional check and review `RESULTS.txt`. The latter is optional, not a GUI launch alternative or a test of live commercial data. Never replace protected fictional demo files or feed real customer contact information into this demo. If the unsigned QA binary is blocked by local security policy, do not bypass protections. Microsoft VC++ x64 runtime must come from an official installer when needed.

**Still OPEN:** actual owner laptop launch and full human operator walkthrough, physical Qt Creator/MinGW, Windows 100/125/150% OS scale and Narrator, P7 D2-D8 customer-data scope/persistent fleet safety/backup/retention/migration, P8 offline signed installer, P9 release, P1 final legal visual photo set. The final fleet population is deliberately the **LAST dedicated section**. **No new owner acceptance: 45/74 criteria, weighted 70.6%.** No merge, `main` change, data cutover or release.
