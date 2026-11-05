# Rental Studio 2.0 | Free model-photo acquisition and actual integration

**Current checkpoint, 5 November 2026:** The actual compiled QA application now contains **131 fictional vehicles (121 cars, 10 motorcycles) across 70 distinct make/model families**. This supersedes the original research-only 100-vehicle status. The five original fixture records remain unchanged. **48 newly acquired and visually screened source candidates are embedded and mapped in the real Qt Fleet**, while **two unsuitable photos** are withheld. These are still owner-review references, not approved final photography.

## Verified integration ledger

| Measure | Latest engineering evidence |
|---|---:|
| Downloaded and source/sha/licence-checked candidates | **50** |
| Newly compiled model-photo references with explicit make/model keys | **48** |
| Existing wrong-model photo assignments corrected with new references | **23 / 25** |
| Other two wrong-model assignments removed for accurate silhouettes | **2 / 25** |
| Proposed additional models now present as fictional cars | **31 / 31** |
| Additional proposed models with correct-family photos in this build | **25 / 31** |
| New proposed models with honest silhouettes pending sources | **6** |
| Distinct make/model families in Qt Fleet | **70** |
| Actual fictional inventory records in Qt Fleet | **131** |
| New photo candidates explicitly accepted by the owner on physical Windows | **0** |

**Source:** [model-photo map](model_photo_map.tsv) and [full credits with original author, licence and SHA256](ACTIVE_ASSET_CREDITS.md). [Native Actions #42055392137](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42055392137) passed 132/132 native tests on each platform and 8/8 packaged Windows functional checks, source [`6c1b852`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c1b852cdc5b9b34c820a6a1244131bfb2dc4226). Source and visual correctness require separate gates: licensing/CI success is not owner photography signoff.

**Two images withheld after visual contact-sheet review:** Jeep Wrangler (cropped partial car) and Toyota Starlet (car too distant). Neither should be mapped to a different car. Their cards correctly show silhouettes.

## Browse all five contact sheets

| Batch | Acquired model candidates | Sources verified | Actual staged images |
|---|---|---|---|
| 01 | Creta, Polo, Jolion, Navara, D-Max, CX-5, CBR500R, Ninja 400, G-Class, Golf GTI | 10/10 | [Contact sheet](batch01/PREVIEW.md) |
| 02 | Jimny, Tiggo 4, Wrangler, Caddy, Almera, Starlet, C-Class, EcoSport, M4, RS6 Avant | 10/10 | [Contact sheet](batch02/PREVIEW.md) |
| 03 | Kiger, Mazda3, Grand i10, Magnite, Urban Cruiser, T-Cross, V-Strom 650, G 310 R, Tenere 700, Porsche 911 | 10/10 | [Contact sheet](batch03/PREVIEW.md) |
| 04 | Mustang GT, GR Supra, GT-R, M3, R8, GR Yaris, Civic Type R, Defender, Model 3, XC60 | 10/10 | [Contact sheet](batch04/PREVIEW.md) |
| 05 | Range Rover Sport, Land Cruiser Prado, RX, X5, GLC, Q5, MINI Cooper, Kwid, Triton, Tucson | 10/10 | [Contact sheet](batch05/PREVIEW.md) |

**Workflow evidence:** [Batch01](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42007433964) · [Batch02](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42010192161) · [Batch03](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42011389574) · [Batch04](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42012804875) · [Batch05](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42016092532). All five acquisition jobs completed SUCCESS. Each batch stores [source_manifest.json] and [IMAGE_CREDITS.md] in its own folder, including author, original file page, licence, adaptation note and SHA256.

## Final six proposed models to source

- Mercedes-AMG A 45
- Volkswagen Golf R
- BYD Atto 3
- Opel Corsa
- Nissan Qashqai
- Toyota Quantum

## Six remaining model-photo acquisitions

Mercedes-AMG A 45, Volkswagen Golf R, BYD Atto 3, Opel Corsa, Nissan Qashqai and Toyota Quantum. Two other replacements are needed for Jeep Wrangler and Toyota Starlet due to unsuitable composition. **Do not use a wrong-model substitute** or falsely label a sourced candidate as owner-approved.

## Acceptance and ownership boundary

The expanded catalogue, 48 new photo mappings and photo-fit layout are native-tested engineering progress, not final owner approval. Original `demo/vehicles.txt` and `demo/rentals.txt` remain protected; no public commercial data, payments, installer or `main` merge. Formal owner acceptance stays **45/74, weighted 70.6%, P7 SQLite 0/8** until explicitly updated after physical QA.

