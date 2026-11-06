# Rental Studio 2.0 | R2 Inter-versus-Segoe Typography Trial | Native verified

**6 November 2026.** Exact executable [`eb20c0ec2e1832a79b7ae5895472a303f58a4085`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/eb20c0ec2e1832a79b7ae5895472a303f58a4085) passed [GitHub Actions #42241419346](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42241419346), on draft PR #17, branch `feature/p7-sqlite-sandbox-20261102`. Main remains untouched.

## Implemented scope and source licence

The opt-in `BUILD_R2_INTER_FONT_TRIAL=ON` configuration downloads the official Google Fonts Inter variable TTF pinned at `google/fonts@38411257417e616c5d4daa1b9e91a3dbcebe1c2e`, original Git blob SHA1 `047c92f6e2212473dc436020afed689527076d44`, 876576 bytes. `tools/fetch_r2_inter_trial.py` checks exact bytes before embedding them in a local Qt resource. SIL Open Font License 1.1 and provenance are preserved under `spikes/qtquick_p2/assets/r2_fonts/`. Only explicit `--r2-font-inter` loads that font into QFontDatabase and sets Qt's shell/global font. **No runtime network or silent default change**. A clean opt-in build requires a network connection or the previously verified local cache; normal builds default OFF.

Two new tests `rental_studio_r2_inter_font_wide` and `_compact` verify actual QFontInfo Inter resolution, widget containment, KPI-first and hero/readiness arrangement, unchanged protected fictional files, and native PNG screenshots. C++ rental domain, bookings, return, archive, destruction, pricing and persistence have not changed.

## Native exact-source test evidence

| Test | Linux GCC Qt 6.8.3 | Windows MSVC Qt 6.8.3 |
|---|---|---|
| Full CTest suite | **142/142 PASS**, zero failures | **142/142 PASS**, zero failures |
| Inter wide and compact tests #20/#21 | PASS / PASS | PASS / PASS |
| Existing shell, Fleet, Rentals, lifecycle | PASS | PASS |
| Windows packaged fictional checks | N/A | **8/8 PASS** |
| PowerShell 5.1 packaged | N/A | **PASS** |

Actual screenshots: [Windows ZIP #13516112083](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42241419346/artifacts/13516112083), [Linux ZIP #13515756972](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42241419346/artifacts/13515756972). [Windows physical-review kit #13516307130](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42241419346/artifacts/13516307130) remains hosted QA evidence only.

## Direct screenshot inspection

Inspected eight real Qt screenshots, baseline `pa-shell-001-overview-expanded-<size>.png` versus trial `pa-shell-001-inter-font-<size>.png`, at both 1500×860 and 1280×720 on Windows and Linux. Windows Segoe and Inter both appear clear, with comparable hierarchy and no observed critical cropping. The Linux baseline's considerably heavier system fallback becomes calmer with the explicitly loaded Inter font, which visually converges towards Windows. No hidden essential action or overlap was detected in the four real Inter Overview captures. The unchanged authoritative C++ data displays four available vehicles, one active rental and an overdue Ford Ranger C002/R001, and the image remains marked model reference.

This is **qualitative design evidence**, not pixel-fidelity certification against the owner's missing original high-resolution R2 image ZIP. Inter remains **an engineering-approved candidate, not a selected production default**. Baseline Segoe remains a viable alternative.

## Remaining gates

Physical owner Windows Qt Creator MinGW, OS scaling 100%, 125%, 150%, Narrator, keyboard, final photographic approval, complete Overview concept fidelity and separate Fleet/Rentals visual signoffs remain OPEN. No protected main modification, PR merge, payment/cloud activation, genuine customer data or release. Formal criterion ledger unchanged: **45/74, weighted 70.6%, P7 0/8**.

**Next bounded work:** owner font choice if requested, then remaining R2 Overview visual fidelity before Fleet/Rentals layout reconstruction. The user's next request always overrides this historical step.
