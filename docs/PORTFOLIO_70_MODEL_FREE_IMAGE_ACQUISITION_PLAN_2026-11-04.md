# Rental Studio 2.0 | 70-model free offline vehicle image catalogue

**Research checkpoint:** 4 November 2026. **Scope:** portfolio only, R0 acquisition, no commercial subscriptions. **Status:** owner requested a 60+ model target; this is a 70-model research shortlist, not 70 vetted photo assets. No new images have been downloaded or integrated by this documentation change.

## Baseline and model counts

- **70 model candidates** = 39 distinct existing models + 31 proposed models. Current existing fleet remains **100 fictional units**: 90 cars and 10 motorcycles, with no inventory ID change.
- Existing repo holds **12 individual Wikimedia Commons CC0 JPEG files plus 3 earlier demo photos**. Of these 15, 14 distinct resources are actively used because the newly downloaded Ranger photo is not used by the priority image mapping.
- **25 existing distinct models** have unrelated-photo assignments, affecting **66 of 100 existing inventory records**. These need replacement, not Qt image-loader fixes.
- **Primary outcome:** >=60 distinct models with a recognisable, visually accepted, offline-bundled image; **stretch:** 70. Do not inflate model count with mislabeled photos.
- A source photo URL is an **image discovery candidate only**. It is not a downloaded file, visually approved match, cleared licence record, or current app asset.

## Official source-provider acquisition rules

| Provider | Free acquisition strategy | Conditions / practical boundary | Source |
|---|---|---|---|
| Wikimedia Commons | Curated individual files; approved Wikimedia API/media URLs may support batch download | Confirm per-file CC0 / CC BY / CC BY-SA, creator, link, attribution and any adaptations | https://www.mediawiki.org/wiki/Wikimedia_APIs/Content_reuse |
| Pexels | Free button on individually verified photo pages, or authorised Pexels API | Free images in apps; do **not** systematically scrape or bulk-copy its collection without permission | https://www.pexels.com/legal-pages/license/ ; https://help.pexels.com/hc/en-us/articles/900005880463-What-are-the-Terms-and-Conditions |
| Pixabay | Individual Free Download on the photo page | Free Content Licence but no standalone redistribution as stock-image collection; individual page claims checked | https://pixabay.com/service/license-summary/ |
| Unsplash (free only) | Individual permitted download from free image page | The API requires hotlinking, unsuitable for the target offline bundle. Do not scrape the website; exclude Unsplash+ paid files. | https://unsplash.com/license ; https://help.unsplash.com/en/articles/2511245-unsplash-api-guidelines ; https://unsplash.com/terms |

**Important:** free is not equivalent to unrestricted automated collection. The *application* is offline; manual or permitted API acquisition happens during development. No runtime API keys, network dependency or payment.

## Ten-step standard operating procedure

1. **Catalogue freeze:** audit existing 39 names, choose 31 additions, confirm unique `make + model` keys. No current 100-row fleet mutation.
2. **Find candidates:** search specific full make/model on Pexels, Pixabay, free Unsplash and Wikimedia Commons. Try aliases (G-Class / G-Wagon, GR Supra / Supra). Record up to three actual individual photo pages per model.
3. **Licence gate:** verify the original page and provider licence. Log author, URL, licence version/link, free eligibility and attribution/share-alike conditions. Reject paid/Plus, watermarked or unclear-rights results.
4. **Visual gate:** photograph must show same make and recognisable model family; different year/trim/colour acceptable. No unrelated model impersonation. Prefer clear exterior angle and >=1000px source width.
5. **Acquire:** download through website's provided free route or approved official API, without scraping, bypassing access controls or abusive request rates. Save original in a staging folder outside runtime.
6. **Optimize and de-duplicate:** encode to 1024x680 or 1280x850 JPEG/WebP without unwanted stretching, preserve crop / padding. Hash and check repeated imagery; multiple fleet units may share only a same-model photo.
7. **Provenance:** maintain original title, photographer, canonical page, licence URL, modified/resized notice, date, SHA256, final local filename, optional credit display. Respect CC BY-SA obligations on adaptations.
8. **Model-photo approval:** approve only if licence, real local file, quality and vehicle identity pass. Use explicitly generic silhouettes if missing; never replace with a picture of another make/model.
9. **Integration (later, separate change):** embed cleared local photos via Qt resources and data-only model map; keep existing five-fixture tests and custom photo overrides; no runtime fetching or production SQLite changes.
10. **Regression/owner QA:** wide and compact Qt gallery checks, 100/125/150% where possible, smooth keyboard navigation, source-file integrity, no wrong model/brand substitutions and actual owner photo/layout review.

## Complete proposed 70-model catalogue

| # | Make | Model | Segment | Lineage | Existing units | Current photo condition | Free candidate page |
|---:|---|---|---|---|---:|---|---|
| 1 | Toyota | Corolla | Sedan | Existing | 1 | Legacy photo: rights review | Not yet sourced for replacement |
| 2 | Ford | Ranger | Bakkie | Existing | 1 | Legacy photo: rights review | Not yet sourced for replacement |
| 3 | Hyundai | i20 | Hatchback | Existing | 1 | Legacy photo: rights review | Not yet sourced for replacement |
| 4 | Honda | CB500F | Motorcycle | Existing | 1 | CC0 near-model image | Not yet sourced for replacement |
| 5 | Yamaha | MT-07 | Motorcycle | Existing | 1 | CC0 same-model image | Not yet sourced for replacement |
| 6 | Suzuki | Swift | Hatchback | Existing | 4 | CC0 near-model image | Not yet sourced for replacement |
| 7 | Kia | Picanto | Hatchback | Existing | 4 | CC0 same-model image | Not yet sourced for replacement |
| 8 | Toyota | Hilux | Bakkie | Existing | 4 | CC0 same-model image | Not yet sourced for replacement |
| 9 | Toyota | Fortuner | SUV | Existing | 3 | CC0 same-model image | Not yet sourced for replacement |
| 10 | Toyota | Corolla Cross | SUV | Existing | 3 | CC0 same-model image | Not yet sourced for replacement |
| 11 | Honda | Civic | Sedan | Existing | 3 | CC0 same-model image | Not yet sourced for replacement |
| 12 | BMW | 320i | Sedan | Existing | 3 | CC0 near-model image | Not yet sourced for replacement |
| 13 | Hyundai | Staria | Van | Existing | 3 | CC0 same-model image | Not yet sourced for replacement |
| 14 | Volkswagen | Polo | Hatchback | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 15 | Nissan | Navara | Bakkie | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 16 | Isuzu | D-Max | Bakkie | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 17 | Mazda | CX-5 | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 18 | Renault | Kiger | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 19 | Haval | Jolion | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 20 | Chery | Tiggo 4 | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 21 | Jeep | Wrangler | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 22 | Volkswagen | Caddy | Van | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 23 | Nissan | Almera | Sedan | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 24 | Toyota | Starlet | Hatchback | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 25 | Mercedes-Benz | C-Class | Sedan | Existing | 3 | Wrong-model image | https://www.pexels.com/photo/black-mercedes-benz-c-class-w205-on-a-parking-lot-14775845/ |
| 26 | Suzuki | Jimny | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 27 | Hyundai | Creta | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 28 | Mazda | Mazda3 | Hatchback | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 29 | Hyundai | Grand i10 | Hatchback | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 30 | Nissan | Magnite | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 31 | Toyota | Urban Cruiser | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 32 | Ford | EcoSport | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 33 | Volkswagen | T-Cross | SUV | Existing | 3 | Wrong-model image | Not yet sourced for replacement |
| 34 | KTM | Duke 390 | Motorcycle | Existing | 2 | CC0 same-model image | Not yet sourced for replacement |
| 35 | Kawasaki | Ninja 400 | Motorcycle | Existing | 2 | Wrong-model image | Not yet sourced for replacement |
| 36 | Suzuki | V-Strom 650 | Motorcycle | Existing | 1 | Wrong-model image | Not yet sourced for replacement |
| 37 | BMW | G 310 R | Motorcycle | Existing | 1 | Wrong-model image | Not yet sourced for replacement |
| 38 | Honda | CBR500R | Motorcycle | Existing | 1 | Wrong-model image | Not yet sourced for replacement |
| 39 | Yamaha | Tenere 700 | Motorcycle | Existing | 1 | Wrong-model image | Not yet sourced for replacement |
| 40 | Volkswagen | Golf GTI | Performance | Proposed | 0 | No photo yet | https://www.pexels.com/photo/front-of-a-volkswagen-golf-gti-14577491/ |
| 41 | Mercedes-Benz | G-Class | Luxury SUV | Proposed | 0 | No photo yet | https://www.pexels.com/photo/side-view-of-a-mercedes-benz-g-class-20212565/ |
| 42 | BMW | M4 | Performance | Proposed | 0 | No photo yet | https://www.pexels.com/photo/sleek-bmw-m4-luxury-sports-car-in-ankara-garage-29764974/ |
| 43 | Audi | RS6 Avant | Performance | Proposed | 0 | No photo yet | https://www.pexels.com/photo/black-car-on-an-asphalt-road-5733743/ |
| 44 | Porsche | 911 | Performance | Proposed | 0 | No photo yet | https://www.pexels.com/photo/a-blue-porsche-911-gt3-is-driving-on-the-track-27505234/ |
| 45 | Ford | Mustang GT | Performance | Proposed | 0 | No photo yet | https://www.pexels.com/photo/a-black-ford-mustang-gt-8012516/ |
| 46 | Toyota | GR Supra | Performance | Proposed | 0 | No photo yet | https://www.pexels.com/photo/toyota-supra-at-the-parking-lot-10978972/ |
| 47 | Nissan | GT-R | Performance | Proposed | 0 | No photo yet | https://www.pexels.com/photo/luxury-nissan-gt-r-parked-in-tokyo-street-31418443/ |
| 48 | Mercedes-AMG | A 45 | Performance | Proposed | 0 | No photo yet | Search pending |
| 49 | BMW | M3 | Performance | Proposed | 0 | No photo yet | Search pending |
| 50 | Audi | R8 | Performance | Proposed | 0 | No photo yet | Search pending |
| 51 | Toyota | GR Yaris | Performance | Proposed | 0 | No photo yet | Search pending |
| 52 | Volkswagen | Golf R | Performance | Proposed | 0 | No photo yet | Search pending |
| 53 | Honda | Civic Type R | Performance | Proposed | 0 | No photo yet | Search pending |
| 54 | Land Rover | Range Rover Sport | Luxury SUV | Proposed | 0 | No photo yet | https://www.pexels.com/photo/black-range-rover-sport-car-in-a-winter-forest-16510650/ |
| 55 | Land Rover | Defender | SUV | Proposed | 0 | No photo yet | https://pixabay.com/photos/land-rover-defender-car-off-road-1627117/ |
| 56 | Toyota | Land Cruiser Prado | SUV | Proposed | 0 | No photo yet | Search pending |
| 57 | Lexus | RX | Luxury SUV | Proposed | 0 | No photo yet | Search pending |
| 58 | BMW | X5 | Luxury SUV | Proposed | 0 | No photo yet | Search pending |
| 59 | Mercedes-Benz | GLC | Luxury SUV | Proposed | 0 | No photo yet | Search pending |
| 60 | Audi | Q5 | SUV | Proposed | 0 | No photo yet | Search pending |
| 61 | Volvo | XC60 | SUV | Proposed | 0 | No photo yet | Search pending |
| 62 | Tesla | Model 3 | EV | Proposed | 0 | No photo yet | Search pending |
| 63 | BYD | Atto 3 | EV | Proposed | 0 | No photo yet | Search pending |
| 64 | MINI | Cooper | Hatchback | Proposed | 0 | No photo yet | Search pending |
| 65 | Renault | Kwid | Hatchback | Proposed | 0 | No photo yet | Search pending |
| 66 | Opel | Corsa | Hatchback | Proposed | 0 | No photo yet | Search pending |
| 67 | Nissan | Qashqai | SUV | Proposed | 0 | No photo yet | Search pending |
| 68 | Mitsubishi | Triton | Bakkie | Proposed | 0 | No photo yet | Search pending |
| 69 | Toyota | Quantum | Van | Proposed | 0 | No photo yet | Search pending |
| 70 | Hyundai | Tucson | SUV | Proposed | 0 | No photo yet | Search pending |

## First verified individual photo-page candidates

The following **11 provider pages** were individually located and marked Free in the provider's page. They remain **undownloaded** and **not visually approved** for this research revision.

| Make / model | Provider | Photographer | Individual page |
|---|---|---|---|
| Volkswagen Golf GTI | Pexels | Nicholas Derio Palacios | https://www.pexels.com/photo/front-of-a-volkswagen-golf-gti-14577491/ |
| Mercedes-Benz G-Class | Pexels | Mike Bird | https://www.pexels.com/photo/side-view-of-a-mercedes-benz-g-class-20212565/ |
| BMW M4 | Pexels | Ali Senan Köroğlu | https://www.pexels.com/photo/sleek-bmw-m4-luxury-sports-car-in-ankara-garage-29764974/ |
| Audi RS6 Avant | Pexels | Grégory Costa | https://www.pexels.com/photo/black-car-on-an-asphalt-road-5733743/ |
| Porsche 911 | Pexels | Patrick | https://www.pexels.com/photo/a-blue-porsche-911-gt3-is-driving-on-the-track-27505234/ |
| Ford Mustang GT | Pexels | Sachith Ravishka Kodikara | https://www.pexels.com/photo/a-black-ford-mustang-gt-8012516/ |
| Toyota GR Supra | Pexels | Roger Arbisi | https://www.pexels.com/photo/toyota-supra-at-the-parking-lot-10978972/ |
| Nissan GT-R | Pexels | Daniel Gubó | https://www.pexels.com/photo/luxury-nissan-gt-r-parked-in-tokyo-street-31418443/ |
| Land Rover Defender | Pixabay | See photo page | https://pixabay.com/photos/land-rover-defender-car-off-road-1627117/ |
| Land Rover Range Rover Sport | Pexels | Luke Miller | https://www.pexels.com/photo/black-range-rover-sport-car-in-a-winter-forest-16510650/ |
| Mercedes-Benz C-Class | Pexels | Johny Goh | https://www.pexels.com/photo/black-mercedes-benz-c-class-w205-on-a-parking-lot-14775845/ |

## Delivery gates and evidence

| Gate | Requirement | At this checkpoint |
|---|---|---|
| G0 | 70 candidate make/model keys | Prepared; owner review pending |
| G1 | 1-3 individual free-photo candidates per model | 11 located pages; remaining discovery open |
| G2 | rights, source metadata and actual local image file recorded | No new images downloaded in this turn |
| G3 | 60 distinct visual-approved offline model photos | OPEN |
| G4 | approved photo map and bundled Qt images | NOT STARTED |
| G5 | cross-platform native tests, owner visual/photo QA | NOT STARTED |

**Portfolio acceptance ledger remains unchanged:** 45/74 owner accepted, fixed-weight 70.6%; P7 SQLite 0/8. This research does not authorise a real-data cutover, branch merge, release or any app code change.

**Companion external workbook:** `Rental_Studio_70_Model_Master_Catalogue_Tracker_2026-11-04.xlsx` (model-by-model research statuses, rights sheet, acquisition log, dashboard). This file is supplied in the conversation and is not falsely claimed to be committed to the repository.
