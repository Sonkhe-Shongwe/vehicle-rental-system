# UX-Q3 | Fleet photographs and compact Inspector: exact-source native and visual QA

**3 November 2026. Final tested C++/Qt source:** [`f8d7357`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f8d7357042c93d7aefd4b2170adb81c3b0989dd4) in open **draft** [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), stacked on draft P6 #14. This is fictional-only UI/source verification, **not** physical Windows owner acceptance, final photograph approval or commercial release.

## Exact-source verification

[GitHub Actions run 41605584293](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41605584293) completed successfully on the exact source commit:
- **Ubuntu 24.04 / GCC / Qt 6.8.3:** compiled real Qt Quick application; full CTest **117/117 PASS**, including `rental_studio_fleet_photo_wide` and `rental_studio_fleet_photo_compact`.
- **Hosted Windows Server 2022 / MSVC / Qt 6.8.3:** real native-QPA Qt Quick; full CTest **117/117 PASS**, including both photo cases. Windows portable/packaged verification, including PowerShell 7 and Windows PowerShell 5.1 P4 checks, **PASS**.
- [Linux native screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41605584293/artifacts/13217375893) and [Windows native screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41605584293/artifacts/13217091625) include actual selected and newly imported fictional Fleet photos at **1280x720** and **1500x860**. The CI artifacts expire; preserve the evidence/run IDs even after ZIP expiry.
- The source changes leave original fleet/rental domain logic and protected demo fixtures unchanged. No tests were waived. This does **not** constitute real physical Windows Qt Creator MinGW, operating-system 100/125/150% scale, Narrator or end-user acceptance.

## UX-Q3 changes and observed visual correction

1. Initial embedded rights-audited Corolla/Ranger/i20 illustrative candidates, neutral Honda/Yamaha fallback, optional user-selected local fictional photos, re-encoded controlled PNG sidecars and image tamper guards were already staged. [Security and native regression `ce285bd`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/ce285bd0c69ece631e41731f87ed2f45a54d3316) passed **117/117 per OS** in [run 41601317152](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41601317152).
2. [Gallery composition `29827ef`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/29827ef8a128747b042899967d047953e01f61c0) raised photo panel height **76 to 112**, card height **176 to 214**, Grid cell height **192 to 230**, and asserts live image height. Verified at [run 41603489737](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41603489737), **117/117 per OS**. Native wide and compact screenshots show less severe car cropping and still-operable Fleet search, selection and actions.
3. [Real selected/import screenshot coverage `89c1415`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/89c1415f307393af3f870b2f6abe4b0b09be3427) passed **117/117 per OS** at [run 41603945608](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41603945608). The captures revealed an Inspector disclaimer crowded against the vehicle heading and an oversized compact Change photo control.
4. [Inspector correction `f8d7357`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f8d7357042c93d7aefd4b2170adb81c3b0989dd4) preserves minimum image room, clips the Inspector photo panel, moves a short **Illustrative** marker into the top-left of the photo, shortens the compact Change action, and adds scene-bound checks for the disclaimer plus Book button. Latest Linux and Windows selected/imported images were inspected. The marker no longer touches the vehicle title, selected details remain readable and Book remains visibly usable at both sizes.

## Boundaries and open gates

- C001-C003 photographs are **illustrative candidates**, not owner-approved photos of specific rental stock; motorcycle images M001/M002 remain fallback illustrations pending model/crop/licence selection.
- Default Add Vehicle and photo storage use a **temporary fictional demo**, not restart-persistent commercial storage. The opted-in fictional SQLite Lab and normal QSaveFile workspaces keep their boundaries; D2-D8 real-customer policy, retention, migration and cutover remain unapproved.
- P1 whole-product visual/photography and accessibility approval, P2/P4 owner physical Windows/MinGW/OS scaling/Narrator, and P8/P9 packaging/release gates are **open**.
- P5 **8/8** and P6 **9/9** owner accepted from earlier evidence. The formal ledger remains **45/74 accepted, weighted 70.6%**; neither this screenshot pass nor any repository code commit automatically earns new owner acceptance.

**Next product priority:** review/approve the three illustrative car photos and choose/approve suitably licensed actual-model motorcycle candidates, then run the consolidated P1/P2/P4 owner Windows visual and accessibility checks. Separately improve the optional photo-change failure/success feedback if new UX work is requested. Never merge `main` or authorize real customer data as part of this gate.
