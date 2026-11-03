# PHOTO-P1-C | Real Qt motorcycle fallback and source-review outcome | 3 November 2026

**Status: exact-source NATIVE VERIFIED, but the five-model photography mission is NOT visually accepted.**

## What changed

- Code commit [`8f1d8cc0afa00af2feb8930ab5f02d2d1cde76ea`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8f1d8cc0afa00af2feb8930ab5f02d2d1cde76ea), parent `69ce1360118ff650eac81ab2c8e3c71ed6bfc596`, on `feature/p7-sqlite-sandbox-20261102`; draft PR #17, based on draft P6 #14.
- `spikes/qtquick_p2/VehicleSilhouette.qml`: original, model-agnostic QML Canvas drawing now includes motorcycle tyres and hubs, engine casing, tank, saddle, fork, headlight, short tail and exhaust. It replaces a bicycle-like outline while preserving existing navy/teal tokens, component dimensions and unchanged car fallback.
- `spikes/qtquick_p2/main.cpp`: existing real Qt `--fleet-photo-smoke` cases select Honda M001, verify visible motorcycle fallback with no incorrect photo, check native viewport containment and capture `ux-q3-motorcycle-fallback-1500x860.png` and `ux-q3-motorcycle-fallback-1280x720.png`. Prior photo, booking and data-integrity cases remain enabled.

## Exact-source hosted verification

[Actions run 41632213416](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41632213416) was triggered by source push for `8f1d8cc0afa00af2feb8930ab5f02d2d1cde76ea`, and completed with **success**.

| Host/toolchain | Completed evidence |
|---|---|
| Ubuntu 24.04, GCC, Qt 6.8.3 | 117/117 CTests PASS, zero failed, 136.48 s CTest time |
| Hosted Windows Server 2022, MSVC, Qt 6.8.3 | 117/117 CTests PASS, zero failed, 159.99 s CTest time |
| Windows portable kit | PowerShell 7 packaged checks PASS; PowerShell 5.1 subprocess PASS |
| Native photo smoke | Wide and compact `rental_studio_fleet_photo_wide` / `_compact` passed on both OSes, with actual QQuickWindow screenshots |

The actual Linux and hosted Windows screenshots were downloaded and inspected. Both show the updated road-motorcycle glyph for the selected Honda and Yamaha gallery cards and the selected vehicle Inspector; layout remains contained and Book stays visible. This is **hosted native Qt rendering**, not a physical Qt Creator MinGW/Windows scaling/Narrator signoff. Screenshots: [Linux artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41632213416/artifacts/13229071189), [Windows artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41632213416/artifacts/13229206431).

## PHOTO-P1-B image-source review attempt: BLOCKED, not verified

The independent review-only workflow source [`69ce136`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/69ce1360118ff650eac81ab2c8e3c71ed6bfc596) introduced a disposable, attributed nine-candidate original-file download, dimension validation, hashing and center-crop/contain comparison. It never adds images to `assets/` or the Qt resource collection.

[Actions run 41631655379](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379) **FAILED** because Wikimedia returned **HTTP 429 Too Many Requests** for all nine originals. Exactly **0/9 candidate binaries** were retrieved, no source hashes were produced and no valid actual-media crop comparison was generated. Its small failed-run artifact preserves the machine-readable errors and credits. Do not misrepresent the synthetic local generator test or empty output as source-image acceptance. Respect the source-host rate limit rather than repeatedly issuing the same automated requests.

Potential follow-up: obtain the candidate photographs through a permitted source/owner upload route, inspect their correct model/body variants and Commons licensing, produce true five-model real-Qt screenshots, and seek owner artistic acceptance. Research shortlist still records nine unapproved source pages. No source photo was installed or approved in this session.

## Acceptance and remaining gates

The visual fallback is an interim **neutral illustration**, not a Honda CB500F or Yamaha MT-07 model photograph. The two models intentionally share generic art until accurate images can be selected. The owner photography 3/10 to 10/10 mission and P1 visual/licensing acceptance are still open, along with physical P2/P4 Windows MinGW, scaling, keyboard/Narrator, P7 D2-D8 commercial storage policy, P8 installer and P9 final release.

**Formal status unchanged: 45/74 criteria accepted, weighted 70.6%.** This percentage measures formally accepted criteria, not total code completeness or launch readiness. Stable `main` unchanged. No merge, release, real customer data, external image asset or new storage cutover authorised.
