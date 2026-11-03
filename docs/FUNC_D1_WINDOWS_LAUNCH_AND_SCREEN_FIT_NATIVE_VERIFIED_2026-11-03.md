# FUNC-D1 | Functionality-first Windows launch and screen-fit native evidence

**Date:** 3 November 2026. **Compiled source:** [`25661db7c8d53b1d274534baf55d37e9c25c04ee`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/25661db7c8d53b1d274534baf55d37e9c25c04ee), branch `feature/p7-sqlite-sandbox-20261102`, draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) base P6 feature branch. **Actual native CI:** [run 41666259382](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41666259382) **SUCCESS**.

## Functional objective and implemented changes

The existing app already had P5 8/8 and P6 9/9 owner-accepted bounded **fictional** quote, booking, return, Fleet creation/removal and cross-process operation tests, yet the user could not easily obtain a complete, self-verifying Windows GUI to run as an ordinary operator. Its fixed 1500×860 logical startup viewport could exceed a 1920×1080 screen using 150% Windows scaling (approximately 1280×720 logical before taskbar reservations). This is a *functional desktop accessibility* problem, not a missing photo.

The exact-source change implements:

1. **True Qt screen-fit on normal startup:** after loading `Main.qml`, C++ reads the actual `QScreen::availableGeometry()` (logical desktop work area, taskbar excluded where supported); clamps requested size to **1024-1500 × 660-860** with 24px horizontal and 12px vertical work-area margins where possible; centres within available screen geometry. Existing QML 1024×660 minimum is preserved. Unusually small desktops **below** that minimum cannot be promised a fully visible window. QML fictional business logic/fixtures are untouched.
2. **Real native startup assertion:** adds `--startup-fit-smoke` and CTest `rental_studio_functional_startup_fit`. Uses a **real QQuickWindow**, not a screenshot mock: verifies visible nonempty GUI, exact current Qt work-area-derived dimensions, min/max and containment for a fitting screen. No artificial OS scaling changes, and the test is distinct from owner physical Windows acceptance.
3. **Direct one-click preview:** `spikes/qtquick_p2/Launch-Rental-Studio.cmd` included in portable Windows kit, with **only** default GUI launch or a non-GUI `--verify` path. Default launches isolated, disposable fictional dataset, with no network/admin or customer-data imports. Script checks for executable, pinned demo fixtures and source SHA marker; removes inherited Qt test-related environment overrides from its temporary child environment; uses no default `--persistent-fictional-demo` to keep P6 Fleet Add enabled.
4. **Independent packaged verification:** hosted Windows workflow now copies launcher and `START_HERE_FUNCTIONAL_DEMO.md` to relocated `windeployqt` artifact, calls `Launch-Rental-Studio.cmd --verify` against packaged, source-hash-protected fake fixtures **before upload**, and continues P2/P4 native portable PowerShell 7/5.1 verification.
5. **Hands-on operator checklist** for Overview → Fleet Gallery/Table → Add a new fictional car/motorcycle → book → return → invalid/cancel refusal → close/reopen default session. The last step intentionally resets temporary records. The existing separate `--persistent-fictional-demo` is not a commercial store and deliberately disables Fleet Add; no rule is changed.

## Exact-source native outcome

| Runner | Source and genuine results |
|---|---|
| Ubuntu 24.04 GCC / Qt 6.8.3 | **118/118 CTests PASS**, 0 failed; new `rental_studio_functional_startup_fit` PASS in 0.41s |
| Hosted Windows Server 2022 MSVC / Qt 6.8.3 | **118/118 CTests PASS**, 0 failed; same startup-fit CTest PASS in 0.49s |
| Hosted Windows portable real compiled EXE | **`Launch-Rental-Studio.cmd --verify` PASS**, bundled protected fictional native C++ self-test |
| Portable P2/P4 hosted Windows | P2 test PASS, P4 PowerShell 7 and actual **Windows PowerShell 5.1 subprocess PASS**; source SHA marker matches `25661db7c8d53b1d274534baf55d37e9c25c04ee` |
| Latest QA artifact | [portable Windows QA kit](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41666259382/artifacts/13247085314), GitHub Actions retention **7 days**; includes Qt runtime, `RentalStudioP2Review.exe`, CMD launcher, walkthrough, original five fictional fixture files and source marker |

Downloaded the generated Windows ZIP to current conversation file path `/mnt/data/Rental_Studio_2_Functional_Windows_Preview_2026-11-03.zip`, and programmatically checked complete ZIP integrity and all essential files. **Exact ZIP size:** 38,574,410 bytes; **SHA-256:** `bfd5598a26272d0d4b1fbd0299a4b47e58383766660ca70ce874e4fb03c131dc`; **1,392 ZIP entries**. The ZIP contains exactly source marker `25661db7c8d53b1d274534baf55d37e9c25c04ee`. A locally downloadable artifact is not an installer or a physical Windows run.

The CTest suite is now 118 (previously 117) per platform because **one new startup regression test** was added. Previous P6 integrated three-process create-book-return lifecycle and all photo/UI/accessibility tests retained. No new photographic assets or vehicle catalogue data was added.

## What has *not* been accepted

- The user's actual Windows machine has **not yet** run the newly downloaded ZIP. No Qt Creator/MinGW **exact-source** compile, physical supported Windows 100/125/150% Settings-scale, keyboard/mouse/Narrator test or owner manual signoff. Real launch may require official Microsoft VC++ x64 redistributable, and unsigned QA binaries may be blocked by local security policy. Never instruct the user to disable security controls.
- Default GUI demo is disposable: it works for realistic CRUD and booking experiments but **does not persist changes over restarts**; persistent real-business storage and backups require owner-gated P7 D2-D8 policy and full tests.
- No P8 certified installer or sign/uninstall support, no P9 commercial release permission, no real customer data, no real fleet population size, no final photography. `main` unchanged, draft PR remains unmerged.

## Next actionable step

Have the owner **extract the whole ZIP**, double-click `Launch-Rental-Studio.cmd` and report an observed real failure (if any) with application-only screenshots. Validate the end-to-end fictional walkthrough on the physical Windows device, then fix real functional bugs before P7 production persistence and Windows packaging gates. **Final Fleet Population & Visual Catalogue is deliberately the dedicated last section**, per [owner plan](FUNCTIONALITY_FIRST_AND_FINAL_FLEET_POPULATION_2026-11-03.md). Formal acceptance unchanged: **45/74, weighted 70.6%**.
