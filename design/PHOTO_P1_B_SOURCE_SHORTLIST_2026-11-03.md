# PHOTO-P1-B | Five-model source shortlist, before visual crop and owner selection

**3 November 2026. Status: RESEARCH COMPLETE FOR SOURCE PAGES, ACTUAL SOURCE-IMAGE AND CROP REVIEW STILL OPEN.** This is a non-destructive continuation of the [3/10 to 10/10 photography mission](FLEET_PHOTOGRAPHY_10_OF_10_MISSION_2026-11-03.md). This document is not evidence of new artwork in Qt. The three original illustrative car JPEGs and two motorcycle silhouettes remain unchanged. Exact source for the last code safety fix: [f0332a8](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f0332a81a75849fd5013ce89cc302dee110772f9), native [117/117 Linux and Windows](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41618236689).

## 1. Selection rule

The goal is a coherent **five-image set**, not five unrelated attractive photos. Each candidate must identify the real make and model, allow documented reuse, have an unobstructed complete vehicle, and survive the actual Qt Gallery crop at **1280×720 and 1500×860**. The operator must see the image as an **illustrative model reference**, not a photo of a verified stock unit. File pages were checked for author, declared licence, vehicle depiction and source dimensions, but source JPEG binary downloads and native crop comparisons **have not been completed** in this research pass. The subjective visual rating remains the existing **3/10 baseline**, not revised.

## 2. Candidate register

| Demo model | Source-page candidate | Creator and source-page licence | Source size | Stage / concern |
|---|---|---|---|---|
| C001 Toyota Corolla | [2019–2022 Corolla E210 sedan](https://commons.wikimedia.org/wiki/File:2019-2022_Toyota_Corolla.jpg) | TTTNIS; CC0 | 5696×2393 | Primary candidate. Very wide 2.38:1 aspect: check front/roof/wheel crop before use |
| C001 alternative | [2022 Corolla L, front right](https://commons.wikimedia.org/wiki/File:2022_Toyota_Corolla_L_in_Classic_Silver_Metallic,_Front_Right,_03-20-2022.jpg) | Elise240SX; CC BY-SA 4.0 | 4236×2340 | Alternate angle; attribution/share-alike obligation |
| C002 Ford Ranger | [2024 Wildtrak X Blue Lightning, front](https://commons.wikimedia.org/wiki/File:2024_Ford_Ranger_Wildtrak_X_EcoBlue_4x4_-_1996cc_2.0_(205PS)_Diesel_-_Blue_Lightning_-_02-2025,_Front.jpg) | Harvey Bold; CC0 | 4693×2865 | Primary replacement research. New pickup; verify clutter, trim and crop |
| C002 current comparison | [Hyins 2025 China-market Ranger](https://commons.wikimedia.org/wiki/File:2nd_Gen_2025_Ford_Ranger_T6_RA_XLT_4WD_P789_China_Front_Three_Quarter_View.jpg) | Hyins; CC0 | 4032×2268 | Existing bundled derivative; showroom signage and China plate undermine consistency |
| C003 Hyundai i20 | [2022 standard i20](https://commons.wikimedia.org/wiki/File:2022_Hyundai_i20.jpg) | Calreyn88; CC BY-SA 4.0 | 3477×2552 | Primary candidate. Check whether full hatchback is unobstructed |
| C003 alternative | [Hyundai i20 123725](https://commons.wikimedia.org/wiki/File:Hyundai_i20_123725.jpg) | Trop86; CC0 | 1672×1252 | Marked **i20 Coupe** in Commons categorisation; not a safe generic five-door representation |
| M001 Honda CB500F | [2021 Honda CB500F](https://commons.wikimedia.org/wiki/File:2021_Honda_CB500F.jpg) | Chanokchon; CC BY-SA 4.0 | 1288×1055 | Correct modern model, but dealer setting and 1.22:1 proportion may crop badly |
| M002 Yamaha MT-07 | [2021 black MT-07](https://commons.wikimedia.org/wiki/File:2021_Black_Yamaha_MT-07.jpg) | PackMecEng; CC BY-SA 4.0 | 3031×1903 | Primary candidate; expose dark bodywork and retain both wheels/handlebars |
| M002 alternative | [2014 Yamaha MT-07](https://commons.wikimedia.org/wiki/File:YAMAHA_MT-07.JPG) | Tokumeigakarinoaoshima; CC0 | 2464×1784 | Easier licence, but older model and photographic treatment |

**Explicit exclusions:** Hyundai **i20 N** is a performance variant not established by our fictional record, and the **Honda CB500 Four** is a different historical model from the Honda CB500F. Do not use either merely because the filenames contain familiar words. The fictional data does not establish any trim, year, colour, registration number or actual stock vehicle.

## 3. Preliminary choices, not approvals

- **Corolla:** start with the TTTNIS E210 sedan for CC0 simplicity, but only adopt if the panoramic source shows the whole car well after intelligent framing. Keep the Elise240SX alternative.
- **Ranger:** compare Harvey Bold exterior against the Hyins showroom image. Prefer the quieter *composition*, not the newest trim or most dramatic image.
- **i20:** prefer the modern regular i20 to the Coupe or N variant. Accept CC BY-SA with a full credit/derivative record if the composition is sufficiently better than the old CC0 image.
- **Honda:** Chanokchon's correct-model CB500F is a better semantic match than generic bicycle-like art; inspect the dealer background and whether image isolation is possible without misleading editing.
- **Yamaha:** compare the modern black 2021 photo against the older CC0 2014 source; black paint may disappear at small gallery sizes. License simplicity does not trump readable vehicle identity.

These are source-data and art-direction **hypotheses**. No individual visual score, crop pass, or actual installed asset may be claimed from these source pages alone.

## 4. Licensing and quality controls

The source pages declare **CC0 1.0** or **CC BY-SA 4.0**. CC0 generally allows reuse without copyright permission, but it does not remove third-party publicity, privacy or trademark concerns: [CC0 deed](https://creativecommons.org/publicdomain/zero/1.0/). CC BY-SA permits adaptations and commercial use if the author, source and licence are credited and modifications/compatible ShareAlike requirements are handled: [CC BY-SA deed](https://creativecommons.org/licenses/by-sa/4.0/). Our portable Qt package must carry applicable image credits and modification notices if CC BY-SA assets are selected. Review-only hyperlinks are not a licence-compliance audit of final derivatives.

The next actual-asset gate must record: exact source bytes and SHA-256, verified current metadata, local EXIF-stripped derivative SHA-256, full-image and 2.8:1 crop comparison, absence of dominant faces/plates/advertising, matching manufacturer/model, and a full five-vehicle Gallery/Inspector screenshot from *real Qt* on Windows at both target sizes. No unreviewed candidate is to replace `assets/` merely to demonstrate progress.

## 5. Actual outcome and next move

**Done:** nine source-page candidates across all five correct models, creator/licence/dimension register, risky body-variant exclusions, and preliminary primary-vs-alternative choices. Machine-readable source register: [PHOTO_P1_B_CANDIDATES_2026-11-03.json](photo_review/PHOTO_P1_B_CANDIDATES_2026-11-03.json).

**Not done:** downloading new candidate binaries, checking full-image composition against the existing gallery, image transformation/hashing, finding the final coherent set, installing approved assets, UI framing changes, and native screenshot acceptance for new photos. A source-page hyperlink is not an actual selected art asset.

**Frozen gates:** P1 whole-product/art owner signoff and physical P2/P4 Windows checks still open; P5/P6 previously accepted; formal **45/74, weighted 70.6%**, unchanged. Draft PR #17, unchanged `main`, no real-data cutover or release.
