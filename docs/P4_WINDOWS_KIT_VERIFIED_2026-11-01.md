# P4 Windows Accessibility Kit | Verified Hosted Artifact, 1 November 2026

## Rationale and scope

P4 source-level Qt accessibility interface tests already passed on Linux and hosted Windows, but there was no P4-specific way to reproduce those checks from the **actual relocated Windows executable**. The existing P2 portable kit only exercised basic model/UI smoke. The remaining P4 gates require a real owner-device Narrator and Qt Creator review, which must never be self-certified from hosted CI.

## Implementation

- First source commit: [`7d51015e73991626a75ca34f95f4595d174c7f9d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/7d51015e73991626a75ca34f95f4595d174c7f9d).
- Corrected exact source: [`5dfa1107cdb22b284f096f1c5e53e98a9f82b272`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/5dfa1107cdb22b284f096f1c5e53e98a9f82b272) uses explicit `$commandArgs` PowerShell splatting for reliable external executable arguments. Intermediate source is **not** claimed verified.
- `spikes/qtquick_p2/Verify-P4-Windows.ps1` accepts the relocated `RentalStudioP2Review.exe`, requires full `SOURCE_COMMIT.txt` SHA and bundled fictional `vehicles.txt` / `rentals.txt`, discards inherited Qt test display overrides, and runs four dedicated commands with individual exit checks and logs:
  1. `--p4-a11y-smoke --compact`
  2. `--p4-tab-smoke --compact`
  3. `--p4-motion-smoke --compact`
  4. `--p4-motion-smoke --p4-reduce-motion --compact`
- SHA-256 protection compares both bundled fictional file contents before/after commands. A failure throws, and physical Narrator, OS scaling and signoff remain `NOT TESTED` in `acceptance-evidence/P4_WINDOWS_ACCESSIBILITY_RESULTS.txt`.
- `spikes/qtquick_p2/P4_WINDOWS_ACCESSIBILITY_ACCEPTANCE.md` supplies a structured operator-only Narrator/keyboard/display matrix and exact Qt Creator/commit provenance requirements.
- `.github/workflows/p2-qtquick-review.yml` includes both P4 files in the original Windows artifact and executes `Verify-P4-Windows.ps1 -VerifyOnly` **after** the existing P2 packaged verification, without removing any previous CTests, package tamper checks or screenshot uploads.

## Executed exact-source evidence

| Runtime | Run | Result |
|---|---|---|
| Ubuntu 24.04 Qt Core/legacy | [41285300118](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41285300118) | **13/13 CTest PASS** |
| Ubuntu 24.04 GCC Qt6.8.3 native Qt Quick | [41285300126](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41285300126) | **43/43 CTest PASS** |
| Windows Server 2022 MSVC Qt6.8.3 native Qt Quick | [41285300126](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41285300126) | **43/43 CTest PASS** |
| Windows portable `windeployqt`, tamper, original P2 checks | Same Windows job | **PASS**, substituted demo fixture correctly rejected |
| **Relocated Windows P4 test executable** | Same Windows job, inspected actual logs | **4/4 packaged checks PASS**, each logged by name; physical review intentionally remains NOT TESTED |
| GitHub Actions artifact | Same Windows job | `p2-windows-physical-acceptance-kit` uploaded (7-day retention) with new P4 helper and instructions |

CI job logs explicitly report each of the four P4 checks and `P4 packaged automation PASS. Physical Narrator, scaling and owner acceptance remain NOT TESTED.` The Windows artifact is an ephemeral disposable QA package, **not** a release installer or a production rental application. Screenshot artifacts were also uploaded; no new owner's visual approval was obtained.

## Exact limitations and next gate

This verified software runs under hosted Windows **Qt6.8.3 MSVC**. The owner's local **Qt Creator 6.10.2 MinGW** and actual Microsoft Narrator announcements were **not executed**. The script never changes Windows display scale; 100%, 125%, 150% actual monitor behavior remains NOT TESTED until an owner operates and records them. The original fictional records remain protected. Do not expose customer data.

P4 criterion **#4 complete accessibility** and **#7 physical Windows/owner visual approval** stay OPEN. **P4 5/7; programme 28/74, phase-weighted 40.6% accepted evidence unchanged**. P1/P2 owner gates and P5-P9 remain separate. Stacked Draft PR #10 remains DRAFT/unmerged and `main` untouched.

**Next action:** owner obtains current Windows kit from [successful run 41285300126](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41285300126), runs `Verify-P4-Windows.ps1 -VerifyOnly`, and performs **physical Narrator and display-scale testing** per checklist with sanitized evidence. Reproduce and fix any actual local defects before considering acceptance. Do not force unsupported settings or use operational files.
