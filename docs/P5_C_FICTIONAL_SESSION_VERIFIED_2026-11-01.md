# P5-C: Controlled Fictional Persistence Across Actual Processes
**Verified 1 November 2026 | Draft PR #12 | no release or customer data**

## Why this exists

Previous P5-B showed correct saved-ledger reconstruction by constructing a second C++ domain instance **inside one running application process**, but the regular Qt Quick preview intentionally erased its `QTemporaryDir` upon exit. This P5-C increment is an explicit development-only **fictional-session opt-in** so one confirmed booking survives shutting down and restarting the executable, without changing default ephemeral behavior or prematurely authorizing general storage (reserved for P7).

## Actual implementation

- `spikes/qtquick_p2/p5_synthetic_session.h/.cpp` provides a **single fixed application-owned path** under `QStandardPaths::AppLocalDataLocation` in a versioned `rental-studio-p5-fictional-only-v1` subdirectory. No CLI or QML path selector exists. Standard launches continue with isolated `QTemporaryDir`; the **only** operator opt-in is `--persistent-fictional-demo`.
- On first opt-in, only exact **SHA-pinned fictional** `demo/vehicles.txt` and `demo/rentals.txt` are seeded, with an explicit version/seed SHA marker written last. On reopen, the session refuses unknown files, symbolic links at the session/leaf, altered Fleet fixture bytes, missing/wrong marker, malformed rental format, duplicate IDs, unexpected customer names/phone numbers and nonfictional records. Ledger comparison normalizes Linux LF versus Windows CRLF **in-memory only**; it does not rewrite verified source data.
- The existing `RentalSystem` remains the **only** business data writer; Qt is only presentation. Existing QSaveFile booking/return/archival flow remains unchanged. `RentalBookingController` additionally enforces that persistence mode can write **only** `Fictional Demo Session` with phone `0000000000`, regardless of QML callers. The QML form disables real contact entry and confirms with those fixed fictional values. Receipts and errors remain visible via previously verified P5-B feedback.
- This is **not** a general persistent customer-data application, not a production data migration, not payment processing and not an approved data-import capability. Modifying session content manually or encountering an unrecognised directory **fails closed**, without attempting recovery or deletion of unknown files. No session-reset UI, remote backup or source data rewrite was added.

## Executed cross-process verification

Four separate CTest process invocations use a **Qt test-only standard data location and distinct test app name**, isolated from the user's actual application data:

1. `rental_studio_p5_session_seed`: first executable process loads the pinned demo, previews 3 days for Corolla C001, performs the real R450/day × 3 booking through authoritative C++ commit, checks saved R003, Active = 2, Fleet available = 3 and persisted ledger differs from the seed.
2. `rental_studio_p5_session_reopen`: a **new executable process** loads the same local fixed synthetic directory, reconstructs R003/active booked value R2750/Fleet occupancy, rejects attempting to book the same C001 and rejects non-fictional contact, and verifies unchanged saved bytes.
3. `rental_studio_p5_session_tamper`: a **third executable process** introduces an unexpected file and separately a fictional-fixture-format record carrying a non-fictional customer name in the isolated test location, confirms each is rejected, restores original bytes and validates that the restored session can reopen.
4. `rental_studio_p5_session_clean`: a **fourth executable process**, permitted in Qt test mode only, removes its own fixed identified test files; unknown markers/files would instead make cleanup refuse.

The default real user-review executable **does not** execute these CI-only commands unless explicitly invoked.

## Verification history

| Environment | Run | Evidence |
|---|---|---|
| Initial negative-test expansion, Linux | [41292644690](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41292644690) | **49/49 PASS** |
| Initial expansion, Windows | Same run | **46/49 PASS**; new seed FAIL, dependent reopen/tamper NOT RUN, due to unnormalised Windows CRLF checkout |
| Corrected exact source, Core/legacy | [41293145323](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41293145323) | **13/13 PASS** |
| Corrected exact source, Linux GCC Qt6.8.3 | [41293145322](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41293145322) | **49/49 PASS**, all four P5 process tests |
| Corrected exact source, Windows Server 2022 MSVC Qt6.8.3 | Same run | **49/49 PASS**, all four P5 process tests |
| Hosted Windows portable review, tamper / P4 scripts | Same Windows job | **PASS** intentional wrong-fixture rejection and PowerShell 5.1 / 7 packaged accessibility checks |
| Visual outputs | Same native workflow | Existing real QQuickWindow screenshots uploaded for each covered wide/compact UI flow; no owner aesthetic signoff inferred |

The Windows failure was retained in CI history and the specific CRLF comparison-only correction is [`12cec44cfc32a0eb3bf8af017728d33f338df4d2`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/12cec44cfc32a0eb3bf8af017728d33f338df4d2). This passes against **actual separate process invocations**, not merely a second C++ instance in the same process. Job logs were inspected and show `100% tests passed, 0 tests failed out of 49` on both native operating systems.

## Remaining acceptance, owner burden and next product work

P5 formal **0/8** until the complete end-to-end milestone including live Qt UI save/relaunch user journey, injected durable-write rejection and comprehensive negative pathways is reviewed; the new guarded fictitious demo is not the production storage solution. P4 remains **5/7**, overall **28/74** and **40.6% accepted-evidence coverage** unchanged. Physical Qt Creator 6.10.2 MinGW, full Narrator/scale and owner visual approval are separately pending.

User specifically asked not to be assigned repetitive manual tests, so no manual PowerShell instructions are required. Next development should focus on polished guided booking/rejection and a native UI cross-process controlled demo smoke, then the P5 failure/rollback gate. Do not start P7 database migration, allow arbitrary paths, merge drafts or release without explicit approval.
