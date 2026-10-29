# Photographic Hybrid V3 | Review branch

**Not the compiled Qt application.** This is a photographic art-direction experiment combining Precision Atelier with Editorial Grand Touring, based on the actual repository demo data.

## Contents

- [preview.html](preview.html) — Dashboard, Fleet and Rentals browser concept. Browser navigation is visual review only; no rental changes are possible.
- [PHOTO_SOURCES.json](PHOTO_SOURCES.json) — verified source-page licences, authors, exact Commons filenames and mappings to C001/C002/C003/M001/M002.
- [PHOTO_CREDITS.md](PHOTO_CREDITS.md) — source links and attribution, including Honda's CC BY-SA conditions.
- [fetch_photos.py](fetch_photos.py) — deterministic, bounded image downloader/optimiser for review assets. Not necessary to run C++ application.
- `photos/` — photo derivatives downloaded only when the review build succeeds. **Do not call photo files ready until the folder contains five valid JPEGs and a MANIFEST.json.**

### Authentic photo handling

- Four source files are marked **CC0** by their individual Wikimedia Commons pages; one (Honda CB500F) is **CC BY-SA 4.0**.
- Files are genuine photographs of representative models, **not photographs of actual vehicles from this fictional fleet**. Make/year/variant matching has not been established.
- Offline Qt asset bundling, visual acceptance, photographer credit display and performance checks are separately required before integrating.

### Factual data

Actual fixtures on 29 October 2026: Toyota Corolla C001, Ford Ranger C002, Hyundai i20 C003, Honda CB500F M001, Yamaha MT-07 M002. R001 is active Ford Ranger R1,400 due 30 Oct; R002 is returned Toyota Corolla R900; no payment system.

### Review gate

1. Photo licence/source and photographic content inspected.
2. Crop and tonal consistency approved, with readable text over the hero.
3. Responsive browser preview reviewed at 1440×900 and 1280×720.
4. Only then selectively port to Qt Widgets and verify the actual app.
