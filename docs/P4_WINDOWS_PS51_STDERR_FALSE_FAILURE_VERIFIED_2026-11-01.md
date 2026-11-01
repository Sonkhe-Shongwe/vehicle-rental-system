# P4 Windows PowerShell 5.1 false test failure | owner evidence and verified correction
**Date:** 1 November 2026. **Status:** verified fix in new review kit, physical Narrator still not tested.

## Owner-observed evidence

On the owner's physical Windows host, the old `Verify-P4-Windows.ps1 -VerifyOnly` failed to launch due to unsigned PowerShell execution policy. The owner then launched a **child** `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\\Verify-P4-Windows.ps1" -VerifyOnly`, avoiding a permanent policy change. The old helper declared each of four packaged checks FAIL with exit `-1`, **not** the real executable exit code.

The supplied on-device P4 accessibility log showed:
```text
RentalStudioP2Review.exe : P4 native accessibility controls PASS 1280x720 real roles/names/checked states and immutable fixtures
Verify-P4-Windows.ps1:55 ... & $exe @commandArgs *> $log
FullyQualifiedErrorId : NativeCommandError
```

The owner's independent direct invocation of `RentalStudioP2Review.exe --p4-a11y-smoke --compact` printed the same P4 PASS message without the script exception. The screenshot showed `$LASTEXITCODE` entered at the prompt, **not executed**, so we do not invent a physical numeric zero or claim the other three local checks passed.

**Root cause:** Windows PowerShell 5.1 can promote **redirected native stderr** to a `NativeCommandError` under the script's `$ErrorActionPreference='Stop'`. Qt's `qInfo()` emits successful status diagnostics to stderr. The old helper caught the PowerShell exception and substituted `-1` without consulting actual native exit status. This was a **false-negative wrapper**, not a demonstrated QML accessibility failure.

## Narrow code/test change

[Source commit `6659abd7840c3534911ac329d8826af612ecd686`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6659abd7840c3534911ac329d8826af612ecd686) changes only:

- `spikes/qtquick_p2/Verify-P4-Windows.ps1`: replaces direct `& $exe ... *> $log` with `Start-Process -FilePath $exe -ArgumentList ... -Wait -PassThru`, redirecting stdout/stderr into distinct files without PowerShell's native stderr error promotion; uses **actual `$process.ExitCode`** to grade each of the four commands, and retains a readable `P4-<check>.log`. A process launch failure still results in `-1` with recorded exception detail. All original SHA-256 checks, real fictional/temporary inputs, unmodified Windows display settings, strict nonzero failure and explicit owner `NOT TESTED` report fields remain.
- `.github/workflows/p2-qtquick-review.yml`: retains existing hosted PowerShell 7 packaged checks, then launches **Windows PowerShell 5.1** using `powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File ... -VerifyOnly` on the same relocated Qt package. This bypass is process-only in a disposable CI runner, never modifies Windows system or user execution policy.

No application C++/QML/domain source, production records or active rental operations were changed.

## Exact-source independent verification

| Scope | Exact source and run | Observed |
|---|---|---|
| Core / legacy CTests | [41287512734](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41287512734) | **13/13 PASS** |
| Linux GCC Qt6.8.3 native | [41287512746](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41287512746) | **43/43 PASS**, including P4 accessibility wide/compact |
| Windows Server 2022 MSVC Qt6.8.3 native | [41287512746](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41287512746) | **43/43 PASS** |
| Relocated Windows Qt portable via PowerShell 7 | Same Windows job | **4/4 P4 packaged checks PASS** |
| Same portable via **Windows PowerShell 5.1** | Same Windows job, `powershell.exe` child | **4/4 P4 packaged checks PASS**; explicit `P4 Windows PowerShell 5.1 subprocess verification PASS` |
| Synthetic data protection / kit upload | Same Windows job | **PASS**, altered non-demo fixture rejected and refreshed `p2-windows-physical-acceptance-kit` uploaded |

Actual hosted Windows job log inspected. This verifies compatibility of the corrected helper with 5.1 and 7 but cannot substitute for owner machine execution.

## Required physical follow-up

On the owner's existing Windows machine, download the **refreshed** `p2-windows-physical-acceptance-kit` artifact from [successful run 41287512746](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41287512746). Extract to a disposable folder (not operational rental files) and inspect the updated `Verify-P4-Windows.ps1`. PowerShell administrator rights are **not required**. If normal script execution is prohibited by an applicable policy, only with permission use a **process-scoped** `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\\Verify-P4-Windows.ps1" -VerifyOnly`, or follow local policy; never globally weaken security. Confirm the new four process `ExitCode=0` and unchanged fixture hashes from the local evidence report. A failure is a real troubleshooting gate, not an automatic pass.

For P4 final physical acceptance, owner must still test Narrator speech and state changes for Overview/Fleet/Rentals and each rental record, physical Windows supported 100/125/150% scaling, native Qt Creator 6.10.2 MinGW and owner visual approval. Keep sanitized screenshots/logs only.

**Formal progress unchanged:** P4 **5/7**, programme **28/74**, **40.6% weighted accepted-evidence coverage**. Draft PR #10 still draft/unmerged, stable `main` untouched, P5 not started.
