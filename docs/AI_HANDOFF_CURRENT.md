> **Latest evidence update, 29 October 2026:** [Windows 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521) has now **PASSED** for source `aaf2ceee22dbe4fd782c142c1a0999e54d59d816`. Hosted Windows Server 2022, MSVC 2022, Qt 6.8.3, Release build, **CTest 2/2** (domain + real Qt GUI lifecycle), all 12 offscreen compiled-Qt screens (1500x860, 1280x720, synthetic 125% and 150% DPI), and before/after fictional fixture hash integrity passed. The earlier "Windows pending" paragraph below is a preserved status-at-authorship note, now superseded. **Physical-monitor scaling, Windows Qt Creator hands-on UX, keyboard/focus, final aesthetic review and owner approval remain PENDING.** Stable `main` stays untouched; PR #4 draft/unmerged.

# AI Handoff | Vehicle Rental System

**Dated checkpoint: 29 October 2026.** This is the authoritative short current-state record for the review branch, **not a live branch pointer**. Always recheck GitHub PR #4 head SHA, workflow conclusions and Issue #2 before editing.

## Project and governance

- Repository: `Sonkhe-Shongwe/vehicle-rental-system`; active branch: `feature/qt-hybrid-visual-spike-20261029`; [Draft PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4); [Issue #2](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/2).
- Stable `main` remains untouched. PR #4 must stay **draft/unmerged** until Windows acceptance and explicit owner approval.
- **One active milestone:** finish the real Qt Widgets visual-redesign acceptance, not SQLite, REST, React, cloud, AI, broad application architecture or installer work.
- Visual direction: Precision Atelier × Editorial Grand Touring, graphite navigation, warm mineral surfaces, restrained lime, premium editorial automotive photography with verified licences and honest model/trim credits.

## Implemented, not equivalent to release sign-off

- Actual Qt Widgets Dashboard, Fleet Inventory, New Rental, Rental History and Return Processing have been redesigned. Grouped navigation preserves nine historical destinations. A branded vehicle inspector, Fleet search and availability filtering, quote and customer gating, rental-ledger filtering and return form operate through original `RentalSystem`.
- Domain safeguards remain: same-day checkout, 1–365 rental days, no double booking, confirmed returns, active rental cannot archive/delete, returned rental must archive before deletion, rental ledger authoritative on reload, atomic `QSaveFile` persistence and no rewrite at startup. Original flat-file format and older rental rows are preserved. A large `mainwindow.cpp` and source-adjacent default storage are known technical debt, not current-phase rewrite targets.
- Photographs for three fictional demo car models are rights-recorded representative images; image aesthetics remain unapproved and both motorcycle assets are missing. Booked rental value is **not collected revenue**.
- **New source increment:** [`fdecb35`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/fdecb35cc2e6612afa43a8df728dcdd7ecd66ff6) and compile correction [`aaf2cee`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/aaf2ceee22dbe4fd782c142c1a0999e54d59d816). Default `MainWindow()` keeps legacy data path; test-only `MainWindow(QString dataDirectory)` safely isolates real GUI integration tests. New `tests/gui_lifecycle_tests.cpp` checks full persisted transaction journey using `QTemporaryDir` and expected QMessageBox titles.

## Exact verified test evidence

- **Linux 29 Oct 2026, source `aaf2ceee22dbe4fd782c142c1a0999e54d59d816`:** GitHub-hosted Ubuntu 24.04, GCC, Qt 6 base development package, CMake/Ninja Release. [CI 40931662760](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931662760) **PASS**: source hygiene, compile, CTest **2/2** (`vehicle_rental_domain`, `vehicle_rental_gui_lifecycle`). GUI test uses Qt offscreen and temporary fictional records, checks add/rent/duplicate guard/restart/return/archive/delete.
- **Prior Windows hosted verified:** [MSVC2022/Qt6.8.3 run 40923616007](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40923616007) on source `630b8a53fdce2ab5413e7f0988505f3c04d3f307`: CTest 1/1, 12 offscreen compiled-Qt captures at 1500×860, 1280×720 and synthetic scale settings with file-hash checks. Other documented domain lifecycle regression pass at 40923443793 and 40923451003.
- **Open Windows check on new code:** [run 40931645521](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40931645521) still running as this checkpoint was written. Check its final result and update this record rather than assuming success.
- **Failure history:** initial `fdecb35` Linux 40931501438 and design 40931493273 failed compile due `QAbstractButton*`/ `QPushButton*` mismatch in new test. Corrected in `aaf2cee`; do not retroactively mark failed runs green.

## Unaccepted gates and defects

- PENDING: actual Windows Qt Creator and physical monitor 100%, 125%, 150% scaling, keyboard focus, modal text/navigation, UI-driven end-to-end walkthrough in a **separate disposable Windows clone**, resize at 1280×720 and wide desktop.
- PENDING: independently reviewed 5-page final aesthetic, non-overlapping panels after interaction, strong licensed photographic composition and motorcycle model photos, truthful credits, user visual approval. The current Ford hero image is visually weak and shows a licence plate; no unlicensed replacements.
- PENDING: crash/power-loss testing, broader security/installer hardening, source-directory storage migration and monolithic MainWindow split. These are future engineering gates, not reasons to divert the current visual milestone.
- Never treat offscreen screenshots or HTML browser prototypes as manual physical Windows confirmation.

## Immediate next priority

1. Check latest PR #4 HEAD and hosted CI for the new lifecycle test; investigate failures without bypassing assertions.
2. On Windows Qt Creator, follow [`WINDOWS_ACCEPTANCE.md`](WINDOWS_ACCEPTANCE.md) on a new disposable clone; save exact kit/OS/SHA/CTest outputs and screenshots, test 100/125/150% real scaling, keyboard and all modal interactions.
3. Review actual Qt screenshot quality and replacement photo rights; fix material visual and functional defects, rerun CI and acceptance, obtain owner visual approval.
4. Update this file, CONTINUITY, TESTING, RENTALS_REVIEW, VISUAL_REVIEW, Draft PR #4 and Issue #2 after each verified increment, distinguishing implemented, tested, visually reviewed, approved and released. Leave `main` alone and do not merge.

**Safety:** No personal customer records in source, tests, logs or published screenshots. In normal operation the legacy `__FILE__` source-adjacent data directory still applies, so never run mutation tests against a working checkout with real data. The new Qt GUI regression uses disposable temporary data only.
