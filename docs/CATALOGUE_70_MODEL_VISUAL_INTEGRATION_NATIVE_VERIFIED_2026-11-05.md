# Rental Studio 2.0 | 70-model catalogue and UX-VIS-003 native verification

**Recorded:** 5 November 2026  
**Owner review classification:** Implemented and native CI verified; **NOT physically owner-approved**  
**Repository:** `Sonkhe-Shongwe/vehicle-rental-system`  
**Executable source:** [`6c1b852cdc5b9b34c820a6a1244131bfb2dc4226`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c1b852cdc5b9b34c820a6a1244131bfb2dc4226)  
**Native verification:** [Actions run #42055392137](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42055392137), completed success on both Linux and Windows.

## 1. Actual catalogue, not a research-only claim

- **131 fictional inventory records**: **121 cars and 10 motorcycles**.
- **70 distinct make/model families**, including the original 39 and 31 newly appended fictional cars, `C091` through `C121`.
- The first 100 records in `portfolio/vehicles.txt` retain their original values, and protected independent `demo/vehicles.txt` and `demo/rentals.txt` remain unchanged.
- `portfolioShowcase` normal no-argument mode uses the embedded 131-record fictional fleet; neither real operational customer data nor production SQLite is enabled.
- The new cars' daily rates are illustrative portfolio values, not market quotes.

## 2. Curated photographic sources and rights

The separate [five-batch acquisition index](../catalogue_acquisition/INDEX.md) covers **50 downloaded candidate JPEG files**, with unique SHA-256 hashes, original Wikimedia Commons pages, named creators, licences and derivative notices. The [50-image provenance workflow](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42051056835) completed successfully.

**48 selected new candidate photographs are actually embedded in Qt resources** through `catalogue_acquisition/model_photo_map.tsv`, keyed by exact make and model rather than vehicle category. The result corrects 23 of the original 25 wrong-model photo associations with model-family matches. The other two bad associations have been removed and deliberately use a neutral illustration.

The eight silhouettes needing new photos are:
1. **Jeep Wrangler**, staged candidate shows only part of the vehicle, unsuitable for a clear whole-car card.
2. **Toyota Starlet**, staged candidate leaves the vehicle too small in its frame.
3. **Mercedes-AMG A 45**, candidate not sourced.
4. **Volkswagen Golf R**, candidate not sourced.
5. **BYD Atto 3**, candidate not sourced.
6. **Opel Corsa**, candidate not sourced.
7. **Nissan Qashqai**, candidate not sourced.
8. **Toyota Quantum**, candidate not sourced.

All other previously bundled model-specific illustrative files remain available where relevant. The original 12 CC0 assets are not counted as new photo acquisitions. New source attribution, licence links, derivative notices and hashes appear in [active-photo credits](../catalogue_acquisition/ACTIVE_ASSET_CREDITS.md), and both the new and original credits are copied into `PHOTO_CREDITS/` within the Windows QA ZIP. **Free and source-verified does not automatically mean approved by the owner as final imagery.** No photograph is represented as the actual rental unit, exact trim or model year.

No paid photo API, runtime internet retrieval, external credentials or commercial licence subscription is introduced.

## 3. Visual quality correction UX-VIS-003

In the native Qt Quick `spikes/qtquick_p2/Main.qml` Fleet:
- Gallery cell height is 282 px, cards 264 px, media panels 160 px.
- Inspector width is 282 px, media height is 170 px at compact or 194 px at roomy window size.
- Gallery and Inspector use `Image.PreserveAspectFit` instead of `PreserveAspectCrop`, avoiding tight clipping of the vehicle body.
- The existing photo/illustration label distinguishes decoded reference images from silhouettes. Vehicle identity and availability come from C++ records; model photos do not affect bookings or fleet state.
- Native wide (1500×860) and compact (1280×720) Gallery screenshots include three independently model-matched examples: C017 Haval Jolion, C091 Volkswagen Golf GTI and C121 Hyundai Tucson.
- Existing icon-led collapsible sidebar, Fleet All/Name/Search keyboard flow, safe dialogs and filtering remain.

The native snapshots were inspected after the photo-fit change, with complete vehicle framing at compact size. Other windows, DPI and real monitor review remain unaccepted.

## 4. Exact native testing evidence

Run [#42055392137](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42055392137) at executable source `6c1b852cdc5b9b34c820a6a1244131bfb2dc4226`:
- **Linux GCC, Qt 6.8.3:** 132/132 CTests, zero failures.
- **Windows MSVC, Qt 6.8.3:** 132/132 CTests, zero failures.
- Actual `rental_studio_portfolio_catalog_wide` and `_compact` passed on each platform, verifying the 131 records, counts, C++ photo availability and intentional fallback exclusions, search reset and actual QML screenshot generation.
- Portable fictional Windows app: eight out of eight native functionality checks passed, including protected fixture preservation, independent process lifecycle and confirmation safety.
- Packaged Windows PowerShell 5.1 verification passed.

Windows screenshot artifact **#13429108279** (SHA-256 `56c26dfc8664f67f6e59fba9b34524cd81b235e9d893dbbfc3a45351f552417b`) and Windows physical QA kit **#13428488764** (SHA-256 `b868568f8389b3490378b05be91b6d0eb6a64575e2077352e65b7e810502a0f2`) expire 12 November 2026. Linux screenshot artifact **#13428747971** (SHA-256 `06169f11b45bf85faa2aebdb7a52aa03eef10e0fd7e75f2181ae3144a79b66c8`) also expires 12 November 2026. Follow-up documentation updates do not change the cited compiled source; any new QA archive should be verified against its own `SOURCE_COMMIT.txt`.

## 5. Physical Windows owner checklist, PASS/FAIL/NOT TESTED

1. Launch the current packaged `Launch-Rental-Studio.cmd` without administrative privileges, confirm 131 fictional records.
2. Expand and collapse the icon sidebar. Confirm legible icons/tooltips, focus, selected workspace, ability to enter a workspace by keyboard.
3. Fleet: All → Name → Search, then Left from empty search to Name → All, retaining caret Left/Right for entered text.
4. Browse Gallery and Table, keyboard selected vehicle, Inspector, Escape, and preservation of stable model IDs.
5. Inspect reference photos for C017 Haval Jolion, C091 Volkswagen Golf GTI, C121 Hyundai Tucson, and images for other vehicle families. Check body visibility, proportions, accurate matching and credit notices.
6. Inspect the eight intentionally illustration-backed models. Do not mistake them for photographed actual fleet units.
7. Check Overview and Rentals visuals and guided fictional quote, Cancel/Return/Delete safeguards, and absence of false payment receipt claims.
8. Repeat at physical Windows display scaling 100%, 125%, 150% where supported, and Qt Creator 6.10.2 MinGW; record clipping or layout/focus problems.
9. Review Microsoft Narrator announcements, ComboBox native behaviour, modal Escape and restored focus.
10. Mark **physical PASS / FAIL / NOT TESTED**, do not silently change the formal acceptance count.

## 6. Governance and next work

- **Owner accepted 45/74**, **fixed-weight 70.6%**, P7 SQLite production acceptance **0/8**. These are governance values, not percent of aesthetic work completed.
- [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) remains stacked on P6, unmerged. Stable `main` unchanged.
- The eight missing or unsuitable photos need individual model-match and licence review before final image approval.
- Further full-product aesthetic polishing, actual DPI/Narrator acceptance, real production persistence policy, signed installer and release remain outside this verified feature milestone.

