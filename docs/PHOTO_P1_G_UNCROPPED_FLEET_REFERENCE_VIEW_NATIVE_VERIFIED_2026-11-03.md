# PHOTO-P1-G | Uncropped Fleet photo inspection, genuinely native-verified

**Date:** 3 November 2026, South Africa. **Exact compiled source:** [`66253ee3d2e4eb326d37af85059ffdbafa7074ae`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/66253ee3d2e4eb326d37af85059ffdbafa7074ae) on `feature/p7-sqlite-sandbox-20261102`, stacked draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) on the P6 development branch. **GitHub Actions:** [run 41656937822](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41656937822) completed **SUCCESS**.

## Motivation

The current fictional Toyota Corolla, Ford Ranger and Hyundai i20 reference photographs are already bundled as unapproved illustrative CC0 derivatives. Their tightly cropped 112px Gallery strips and compact Inspector can hide edges of vehicles or nearby background clutter, especially the i20 frame with two adjacent vehicles. Previously, an operator had no native, read-only way to inspect the full, uncropped source image in context before considering photo replacement.

## Implemented

- The existing Inspector now offers a keyboard-focusable **View full** control **only if the selected vehicle's photo is decoded and visible**. Generic Honda and Yamaha motorcycle illustrations do not acquire a fictitious photo viewer.
- Opens a centred modal dialog with the current C++ selected model name and ID, a full-size **`Image.PreserveAspectFit`** rendering of the authoritative `image://fleetphotos/` source, and an explicit notice: **"Illustrative model reference only. This is not a verified photo of an actual fleet vehicle."** It does not crop the source.
- Supports **Escape** and an explicit **Close** button. Closing returns keyboard focus to the Inspector's View full button, when visible. The preview locks the selected ID/name, and selection changes close the modal rather than leave a stale vehicle displayed.
- No new photo binaries, downloads, image edits, licence determinations, customer information, business-rule duplication, storage writes, C++ ABI changes, installer or release operations. Existing Gallery/Inspector crop stages and fictional business domain remain unchanged.

## Native source and regression evidence

| Job | Exact source | Results |
|---|---|---|
| Ubuntu 24.04 GCC / Qt 6.8.3 | `66253ee` / [CI 41656937822](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41656937822) | **117/117 CTests PASS**, 0 failures, actual `rental_studio_fleet_photo_wide` and `_compact` PASS |
| Hosted Windows Server 2022 MSVC / Qt 6.8.3 | same SHA and run | **117/117 CTests PASS**, 0 failures, both actual Qt wide/compact Fleet photo tests PASS |
| Hosted Windows packaged preflight | same workflow | Windows PowerShell 7 and 5.1 checks PASS; manual physical Windows scaling/Narrator **NOT TESTED** |
| Native screenshot artifacts | [Linux artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41656937822/artifacts/13240627555), [Windows artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41656937822/artifacts/13241155798) | Existing real Gallery/Inspector views captured; **a dedicated open-dialog full-preview screenshot was not saved**. Do not claim this new modal was independently pixel-reviewed. |

Actual test assertions exercise the **View full** Inspector button, require a loaded correctly selected Corolla image in the modal, exact full-image disclosure, visible Close button, modal dismissal, returned focus to the View full control, and no access to View full for both motorcycle illustration fallbacks. Original photo identity, invalid-URL/oversized source refusal, change-photo cancellation, reset, fake-photo write denial, five-model screenshot, domain booking/return, transaction/rollback and other regression tests remain present in the 117 CTests. Exact source SHA was independently confirmed in Linux and Windows checkout logs.

## Still blocked and next acceptance requirements

This is an inspection tool, **not final five-model photography**. No candidate from the [PHOTO-P1-B shortlist](../design/PHOTO_P1_B_SOURCE_SHORTLIST_2026-11-03.md) was obtained or visually approved; Commons prior original/thumbnail downloads failed with HTTP 429/400 and remain suspended. The source-led [PHOTO-P1-E offline candidate preflight](PHOTO_P1_E_OFFLINE_CANDIDATE_PREFLIGHT_VERIFIED_2026-11-03.md) remains ready for lawfully obtained correctly labelled i20, Ranger, Corolla, CB500F and MT-07 original photo files. A source-page licence declaration must still be independently matched to exact source bytes, author/licence attribution, actual model, and owner aesthetic/crop review.

The owner-approved P5 8/8 and P6 9/9 fictional operation gates remain intact; **formal 45/74 criteria accepted and weighted 70.6%**, unchanged. Physical owner Windows Qt Creator/MinGW, 100/125/150% OS scaling, Microsoft Narrator, P7 D2-D8 real-data policy, P8 installer and P9 release/merge remain **OPEN**. No modification to `main`.
