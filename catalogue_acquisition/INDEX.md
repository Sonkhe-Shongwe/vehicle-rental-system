# Rental Studio 2.0 | Free vehicle-photo acquisition index

**Research checkpoint:** 5 November 2026. **R0, offline portfolio project.** Goal: at least 60, stretch 70 distinct models with photos that pass visual owner review. Research shortlist contains 70 model keys: 39 current + 31 proposed. Current application still displays the original 100 fictional inventory records using 39 models and old photo mappings.

## Current acquisition ledger

| Measure | Verified source status |
|---|---:|
| Newly downloaded free-licensed, locally stored photo candidates | **50** |
| Distinct model labels and distinct file SHA256 hashes | **50 / 50** |
| Existing wrongly pictured models with acquired replacement candidates | **25 / 25** |
| New proposed models with acquired photo candidates | **25 / 31** |
| Remaining proposed models requiring acquisition | **6** |
| Newly acquired photos approved in the actual UI by owner | **0** |
| Newly acquired photos integrated into compiled Qt Fleet images | **0** |

**Important:** The previously embedded 12 Commons CC0 photographs and 3 older demonstration pictures are **separate** from these 50 new staging files; the latter have not replaced any actual UI image. "Acquired and metadata-verified" is not the same as "visually accepted and installed".

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

## Approval and integration boundary

The 50 images still require actual visual review for correct make/model, image quality, cropping and presentation. Incompatible or misleading images must be replaced, not relabelled. Model year, trim and colour need not be exact.

Only after a separate owner review should a new change update the Qt image map, compiled assets, and 100-unit fictional gallery. Regression tests must preserve the original protected five-vehicle fixture. No paid API, online runtime photo fetching, real customer data, commercial launch, or `main` changes. Formal owner acceptance stays 45/74, fixed-weight 70.6%, P7 SQLite 0/8.
