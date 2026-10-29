# Authentic vehicle photographs in the Qt visual branch

The images below depict representative vehicle models. They are **not** photographs of actual rental assets. The source demo data does not establish year, trim or paint colour.

| Bundled image | Model represented | Creator | Commons source | Licence |
|---|---|---|---|---|
| `toyota_corolla.jpg` | Toyota Corolla | 01x07x2022000 | [Toyota Corolla IMG 6391.JPG](https://commons.wikimedia.org/wiki/File:Toyota_Corolla_IMG_6391.JPG) | [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) |
| `ford_ranger.jpg` | Ford Ranger, *illustrative China-market 2025 XLT model photo* | Hyins | [2025 Ford Ranger T6 XLT 4WD, front three-quarter](https://commons.wikimedia.org/wiki/File:2nd_Gen_2025_Ford_Ranger_T6_RA_XLT_4WD_P789_China_Front_Three_Quarter_View.jpg) | [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) |
| `hyundai_i20.jpg` | Hyundai i20 | Trop86 | [Hyundai i20 133151.jpg](https://commons.wikimedia.org/wiki/File:Hyundai_i20_133151.jpg) | [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) |

The Corolla and Hyundai images are optimised JPEG derivatives (maximum 1300×975, quality 83), EXIF stripped, sourced from the [earlier photography review branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/design/authentic-photo-hybrid-20261029/design/v3). The Ford hero and Fleet Ranger image have been **replaced for review only** by a Hyins CC0 derivative, downloaded and metadata-checked through [isolated review CI](../.github/workflows/stage-ford-photo-candidate.yml), decoded as a JPEG, EXIF-stripped, resized to **1280×720**, quality 84, and copied byte-identically from the staged [candidate file](../design/qt-spike/photo-candidates/ford_ranger_hyins_review.jpg). The [source/derivative SHA-256 record](../design/qt-spike/photo-candidates/ford_ranger_hyins_review.json) supports provenance audit. These are locally bundled Qt resources for offline operation. The new Ford image has a showroom background, signage and a China-market plate; it may **not** match any fleet vehicle's country, year, trim or registration. It remains an **unapproved design-branch candidate**, not a release or owned rental-fleet photo.

**Missing images:** The Honda CB500F and Yamaha MT-07 do not currently have approved bundled derivatives. The Fleet inspector displays an explicit vehicle-class placeholder instead.

The project is not affiliated with or endorsed by any manufacturer. License checks and attribution are recorded, but aesthetic suitability and year/trim accuracy require additional approval. These images belong to a **review-only Qt visual prototype**, not a production release.
