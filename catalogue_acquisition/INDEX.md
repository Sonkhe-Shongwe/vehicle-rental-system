# Rental Studio 2.0 | Free vehicle-photo acquisition index

**Research checkpoint:** 5 November 2026. **Portfolio only, R0 offline.** Goal: minimum 60, stretch 70 distinct **visually approved** models. Research list: 70 make/model candidates (39 current + 31 proposed). Application still holds 39 distinct model names and 100 fictional inventory records.

## Source acquisition progress

| Measure | Current |
|---|---:|
| Successfully downloaded, individually free-licensed and hashed candidate photos | **40** |
| Unique model associations / unique downloaded hashes | **40 / 40** |
| Of 25 existing wrong-photo models, with acquired replacement candidates | **25 / 25** |
| Newly proposed models with acquired image candidates | **15 / 31** |
| Newly proposed model names still without acquired candidates | **16** |
| New photos visually approved by the owner | **0** |
| New photos integrated into the Qt Fleet UI | **0** |

The original compiled demo images (12 Commons CC0 plus three legacy images) are tracked separately; do **not** conflate 40 new staged images with 40 newly displayed images. Those 25 existing wrong-photo assignments are **still present in the live application**.

## Acquired source batches and photo previews

| Batch | Models covered | Download/licence status | Actual contact sheet |
|---|---|---|---|
| 01 | Creta, Polo, Jolion, Navara, D-Max, CX-5, CBR500R, Ninja 400, G-Class, Golf GTI | 10/10 | [View batch 01](batch01/PREVIEW.md) |
| 02 | Jimny, Tiggo 4, Wrangler, Caddy, Almera, Starlet, C-Class, EcoSport, BMW M4, Audi RS6 Avant | 10/10 | [View batch 02](batch02/PREVIEW.md) |
| 03 | Kiger, Mazda3, Grand i10, Magnite, Urban Cruiser, T-Cross, V-Strom 650, G 310 R, Tenere 700, Porsche 911 | 10/10 | [View batch 03](batch03/PREVIEW.md) |
| 04 | Mustang GT, GR Supra, Nissan GT-R, BMW M3, Audi R8, GR Yaris, Civic Type R, Defender, Model 3, Volvo XC60 | 10/10 | [View batch 04](batch04/PREVIEW.md) |

**Actual source/rights records:** [01](batch01/source_manifest.json) · [02](batch02/source_manifest.json) · [03](batch03/source_manifest.json) · [04](batch04/source_manifest.json). Each includes original Wikimedia file link, author, Creative Commons licence, resizing note and local SHA256. All four Commons-acquisition GitHub Actions runs completed successfully: [01 #42007433964](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42007433964), [02 #42010192161](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42010192161), [03 #42011389574](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42011389574), [04 #42012804875](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42012804875).

## Required quality gate, before app integration

The acquired photos are genuine separate local JPEG files, and their rights metadata passed. They are **candidates only**, not owner-accepted images. Each must be reviewed for actual make/model identity, photograph crop, perspective and visual consistency. Preserve licences and credit information for any CC BY/CC BY-SA adapted files, and ensure one model never displays an unrelated vehicle.

Next: source the **16 proposed models still missing** and review staged contact sheets. Then make a **separate, tested Qt integration** patch only after the selected images are visually accepted. No production SQLite cutover, customer details, recurring fees, main-branch merges or release. Formal owner acceptance unchanged 45/74, weighted 70.6%, P7 0/8.
