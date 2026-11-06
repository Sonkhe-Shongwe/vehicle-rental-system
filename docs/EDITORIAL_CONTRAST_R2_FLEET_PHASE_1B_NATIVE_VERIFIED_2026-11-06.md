# Rental Studio 2.0 | Fleet R2 Phase 1B | Native verified

**6 November 2026.** Native compiled source [`558006e803ef68ced1efb004ba927e93412ea20d`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/558006e803ef68ced1efb004ba927e93412ea20d), [GitHub Actions #42264261740 SUCCESS](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42264261740) on `feature/p7-sqlite-sandbox-20261102` (draft PR #17, no merge).

## Completed changes

Fleet 1280×720 Gallery now uses 232px rows, 219px cards and 116px model-reference photo region to show the initial two rows without automatically cutting off the first. At 1500×860, the three-column 272px photo-led layout stays unchanged. Manual scroll, arrow-key focus, stable C++ vehicle selection, Gallery/Table mode and filters remain intact. Source-specific creator/licence attribution is displayed below the selected photo in the factual white inspector instead of an obstructive overlay. At wide desktop sizes, selected vehicle ID and category are C++-backed details, without invented specifications.

C001 Toyota Corolla is available/bookable at R450/day; Ford Ranger C002 is rented/nonbookable at R700/day in the protected fictional fixture. No C++ business logic, payments, persistence, source licence rights or customer data were changed.

## Full native evidence

| Verification | Linux GCC Qt 6.8.3 | Windows MSVC Qt 6.8.3 |
|---|---|---|
| Full native suite | **142/142 PASS** | **142/142 PASS** |
| Fleet Gallery/Inspector wide and compact | PASS/PASS | PASS/PASS |
| Focus-edge keyboard, photo/credit wide and compact | PASS | PASS |
| Packaged fictional checks | N/A | **8/8 PASS** |
| Windows PowerShell 5.1 | N/A | **PASS** |

Actual Qt screenshot archives [Windows #13527310853](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42264261740/artifacts/13527310853) and [Linux #13527251009](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42264261740/artifacts/13527251009) contain 1500×860 and 1280×720 Fleet Gallery and Table. Both platforms' compact Gallery screenshots were opened and inspected: first row begins fully at top; second row is fully shown, selected C001 is truthful, credits are under the photo. Wide Windows capture shows C001 and Car in inspector, correct rate/status and separate actions. This is not a pixel-perfect comparison to the missing owner reference ZIP.

## Failed attempt and repair transparency

`b146ca2` failed [CI #42260956629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42260956629), Linux 140/142: the legacy photo tests still demanded attribution over the photo, contrary to this bounded UI change. `3cef64b` replaced that obsolete requirement with stricter verification of actual CC0 source, white-body credit placement, inspector containment, photo actions and factual wide ID/type, passing [CI #42262252221](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42262252221) 142/142 each platform. Further screenshot inspection found a compact first-row crop and prompted final source `558006e`, which passed the full suite and adds explicit top-scroll regression coverage.

## Outstanding

Rentals R2 layout reconstruction remains the next major engineering screen. Original full-resolution design ZIP, on-device owner Windows Qt Creator MinGW, OS DPI 100/125/150%, Narrator, photo suitability and all Overview/Fleet/Rentals owner visual signoffs remain OPEN. Formal acceptance stays **45/74, 70.6% weighted, P7 0/8** with P5/P6 previous owner approvals, PR #17 draft and protected main unchanged. Inter font trial opt-in only.
