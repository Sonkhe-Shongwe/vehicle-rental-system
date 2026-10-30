# P2 Portable Windows Physical Review Kit | Hosted Verification

**30 October 2026. Source SHA:** `3620d83518cc01bce047b6f0a17deab0b96079b6`. **Status:** COMPILED / PACKAGED / HOSTED-TESTED, NOT PHYSICALLY OWNER-ACCEPTED.  
**Draft PR:** [#6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) on `spike/p2-qtquick-fleet-20261030`, targeting the product-reset documentation branch, not stable main.

## Verified, exact evidence

[GitHub Actions run 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629): Qt 6.8.3 **Ubuntu 24.04/GCC 8/8 CTests PASS**; **Windows Server 2022/MSVC2022 8/8 CTests PASS**. All prior native QML, C++ model, Qt keyboard, live resize and synthetic DPI tests remain enabled and passed.

**NEW portable Windows CI integration, also PASS:**

- Built `RentalStudioP2Review.exe` and deployed its Qt plugins, QML modules and DLL dependencies with Qt's `windeployqt --release --no-compiler-runtime --qmldir`. This is **QA distribution only**, not a published installer. End-user MSVC runtime, if absent, must come from an official Microsoft Visual C++ x64 Redistributable, not raw developer machine DLLs.
- Bundled **only** source-controlled fictional `demo/vehicles.txt` and `demo/rentals.txt`. At CMake configure, their expected SHA-256 values are embedded into the C++ executable. It prioritises bundled `appDir/demo` on Windows, else source-tree demo for CI/Qt Creator. No customer directory argument or booking mutation endpoint is exposed.
- Explicit **negative test PASS:** intentionally modified a temporary packaged `demo/vehicles.txt`, observed that the compiled application returned failure rather than accepting unknown data, and restored the original fixture before kit upload.
- **Relocated packaged executable smoke PASS:** invoked the included `Verify-P2-Windows.ps1 -VerifyOnly` against the standalone deployment directory, successfully ran packaged C++ `--self-test` and genuine QML `--ui-smoke --compact`, then checked both source fixture hashes had not changed.
- Downloaded GitHub artifact `p2-windows-physical-acceptance-kit` (artifact ID **12972169619**, retention **7 days**), ZIP **34,670,311 bytes**, **1,323 entries**, 83.5 MiB uncompressed. ZIP integrity check PASS; includes `RentalStudioP2Review.exe`, `Verify-P2-Windows.ps1`, `WINDOWS_PHYSICAL_ACCEPTANCE.md`, `SOURCE_COMMIT.txt` matching the above SHA, `Qt6Core.dll`, Qt Quick QML modules, and fictional fixtures. The local ZIP is an **engineering review artifact**, not a release.
- Source demo SHA-256 at review: `vehicles.txt` = `3213eee960c30713daaa8a2e11847cf06d8634a21b935a615c10f1623efeb0a4`; `rentals.txt` = `98ead7f9721b4b457e68dc7c96fa988bf2108aa07697da71967fe6c12bd3ad0c`. No private data was used or written.

## Owner on-device acceptance (still NOT VERIFIED)

1. Download the same-named archive from the Actions run or the supplied conversation review file. Extract to a disposable user directory outside actual rental data.
2. Run `Verify-P2-Windows.ps1` in Windows PowerShell; perform the automatic model/Qt compact tests and save the local evidence log. It does **not** alter Windows DPI/scaling or download software.
3. On the **physical Windows desktop**, manually validate 100%, 125%, 150% display scaling if supported, with both 1500×860 and 1280×720 layouts, live resizing, Tab/Shift+Tab, Space/Enter/Escape, Gallery/Table/Inspector, rented Ranger, Honda search and fake sample rates; save application-only screenshots. Some scales or sizes may not be available on a small display and must be recorded as NOT TESTED rather than passed.
4. Independently capture the installed Qt Creator/Qt compiler kit and its output, then obtain an explicit owner Qt Quick go/no-go. The portable kit is convenient **but does not itself verify an installed Qt Creator kit**, native screen-reader support, full design or release.
5. Record any warnings, missing MSVC redistributable, accessibility failures, focus/keyboard issues, display clipping or DPI blur. [On-device checklist](../spikes/qtquick_p2/WINDOWS_PHYSICAL_ACCEPTANCE.md).

## Gate and scope

**P0 5/5 (100%), P1 7/10 (70%), P2 3/6 (50%), P3–P9 0%; weighted coverage 18.4% unchanged.** The new portable kit reduces practical testing friction and adds data-safety evidence. It does not fill any of the three outstanding P2 acceptance criteria that explicitly require the owner's physical Windows/Qt Creator kit and recorded go/no-go.

Preserve stable main, rejected historic Draft PR #4 and unmerged P2 Draft PR #6. No SQLite, REST, AI, deployment release, real rental creation or customer data.
