
# P2 Windows physical acceptance kit | manual checklist

This is a **review-only** acceptance procedure for `RentalStudioP2Review.exe` from the exact source commit recorded in `SOURCE_COMMIT.txt`. The application uses only bundled SHA-256 pinned fictional fixtures, copied into auto-removed temporary storage. Do not copy a real `vehicles.txt` or `rentals.txt` into this folder.

## On the owner's physical Windows machine

1. Extract the complete `p2-windows-physical-acceptance-kit` artifact to a disposable folder **outside** operational rental data.
2. Run `Verify-P2-Windows.ps1` in Windows PowerShell. It runs the packaged Qt C++ model and QML compact smoke first and writes a local evidence report. If policy blocks scripts, inspect the script and follow your organisation's policy rather than permanently weakening execution policy. Never run as administrator unless your own policies require it.
3. Open Windows **Settings → System → Display → Scale** and select 100%, then 125%, then 150%, if supported. Some changes require signing out. **Do not force unsupported values.** Record the actual scale visibly shown in Settings and the monitor resolution.
4. At each scale open the bundled compiled application, switch Gallery ↔ Table using mouse and keyboard, search `Honda`, select `M001`, press Escape and verify the Inspector clears, filter `Rented` to find the Ranger. Inspect 1500×860 and 1280×720 and live resize within the available screen. Check labels, focus visibility, clipped buttons, overlays and horizontal scroll. Save **cropped application-only** screenshots to the evidence directory.
5. Record any clipping, inaccessible controls, incorrect rate, missing Qt DLL/QML modules, crash, DPI blur or keyboard problems. Verify `demo/*.txt` hashes remain unchanged.
6. If testing in Qt Creator as well, record its exact version, Qt kit, compiler and run output; the portable kit alone does not establish Qt Creator's installed kit.

## Gate decision

- Only mark physical Windows acceptance **PASS** with explicit observed results and screenshots for supported scales. Tests that cannot be performed are **NOT TESTED**, not passed.
- Before moving to P3, record a separate owner Qt Quick go/no-go decision. A clean portable smoke or synthetic DPI test is not that approval.
- P1 design signoff, licensed model-matched imagery and broader accessibility remain separate unresolved items.

**Do not edit main, merge Draft PR #6 or treat this kit as an installer or release.**
