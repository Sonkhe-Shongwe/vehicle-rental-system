# Rental Studio 2.0 | Current offline fictional portfolio catalogue

**Updated 5 November 2026.** The **normal no-argument Qt Quick launch** contains **131 fictional vehicles, comprising 121 cars and 10 motorcycles, across 70 distinct make/model families**. The previous 100-vehicle catalogue was expanded by appending 31 new fictional cars, IDs C091 through C121, with clearly illustrative daily rates. All original C001-C090 and M001-M010 records remain intact, including the five protected demo identities. The separate original `demo/vehicles.txt` and `demo/rentals.txt` fixtures remain byte-for-byte unchanged.

The portfolio loads locally embedded `portfolio/vehicles.txt` into a disposable fictional session and resets changes when closed. Booking, return, archival and other operations still use the authoritative C++ services. `--persistent-fictional-demo` and `--p7-fictional-sql-lab` are separate opt-in fictional modes, not real operational persistence. No commercial customer data may be loaded.

## Vehicle imagery

**48 newly compiled model-family image candidates** are mapped explicitly by **make + model**, not vehicle category or a shared unrelated brand. These cover **23 of the 25 previous wrong-photo model names** and **25 of the 31 new proposed models**. The other two incorrect associations were removed; Jeep Wrangler and Toyota Starlet have honest silhouettes until better images are chosen. Six new proposed models also retain silhouettes until correctly sourced: Mercedes-AMG A 45, Volkswagen Golf R, BYD Atto 3, Opel Corsa, Nissan Qashqai, Toyota Quantum.

The original **12 Wikimedia Commons CC0 photos** and **three legacy demonstration JPEGs** remain as appropriate baseline references; actual usage is model-specific. New candidates come from the 50-image staged acquisition with individual licence/manifests, two of which were withheld after contact-sheet composition review. Each selected new image is embedded in the Qt executable, with no remote runtime image requests, key or subscription. Source materials: [catalogue index](../catalogue_acquisition/INDEX.md), [active new-photo credits](../catalogue_acquisition/ACTIVE_ASSET_CREDITS.md), [original CC0 credits](../assets/portfolio/IMAGE_CREDITS.md).

Every rendered image remains a **reference of a model family**, not a photograph of an actual rental unit. Model year, trim and colour are not guaranteed. CC BY-SA photos retain attribution and licence notices, which are included under `PHOTO_CREDITS/` in the portable Windows QA kit. Custom per-vehicle local photo overrides remain under existing C++ guards; no right to import real customer files is implied.

## Native verification and remaining acceptance

[Exact executable source `6c1b852`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/6c1b852cdc5b9b34c820a6a1244131bfb2dc4226) passed [Actions #42055392137](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42055392137): **132/132 native CTests on Linux and Windows each**, plus packaged Windows fictional **8/8** and PowerShell 5.1 verification. The native `--portfolio-catalog-smoke` checks C++ counts, names, photo-backed IDs, six unsourced IDs, two deliberately withheld images, search restoration, protected five-fixture integrity and wide/compact actual Qt screenshots.

Pending: physical owner approval of visual image identity/cropping and the premium UI at 100%, 125%, 150% Windows scaling; Narrator; Qt Creator 6.10.2 MinGW; replacement sources for the eight missing pictures; signed installer and production data policy. Formal owner score remains **45/74; weighted 70.6%; P7 0/8**. Stable `main` is untouched; PR #17 remains DRAFT. No commercial-use claim.
