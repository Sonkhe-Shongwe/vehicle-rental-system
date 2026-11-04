# Rental Studio 2.0 | Free 100-vehicle offline portfolio showcase: native verified

**Date:** 4 November 2026 (Africa/Johannesburg).  
**Exact compiled and verified application source:** [`75b9b8d751860dd773e462cc38e29121412f3845`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/75b9b8d751860dd773e462cc38e29121412f3845).  
**Exact-source hosted native CI:** [GitHub Actions #41868916532](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41868916532), **completed SUCCESS**, same `head_sha` as the source above.  
**Image acquisition workflow:** [GitHub Actions #41867883113](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41867883113), **completed SUCCESS**, 12/12 source files individually checked CC0 and bundled by bot as a feature-branch commit.  
**Scope:** Portfolio-only, free, offline, 100 fictional rental inventory records, representative imagery. NOT a commercial launch, production P7 database switch, paid API or operational customer store.

## 1. Real portfolio improvement

- `portfolio/vehicles.txt` has **exactly 100 unique fictional inventory records**, comprising **90 cars (C001–C090) and 10 motorcycles (M001–M010)**. First three cars and first two motorcycles preserve the original five demonstration IDs, specification values, and both established example contracts. The Ford Ranger C002 remains the single initially rented vehicle; **99 initially available**. Vehicle names and rates are samples, not actual vehicle listings or market quotes.
- The **normal no-argument Qt Creator/Windows launch** now populates the existing Fleet/Overview/Rentals interface from an immutable embedded 100-row Qt resource. Runtime copies the verified seed into a newly created disposable `QTemporaryDir` and uses the **existing C++ Fleet/Rental business controllers** for filtering, search, sort, keyboard focus, inspect, quote, book, return, add/remove and reporting. The UI explicitly displays `FICTIONAL · 100-VEHICLE SHOWCASE` and notes that changes reset on exit.
- The original `demo/vehicles.txt` and `demo/rentals.txt` remain **unchanged**; historical CLI/native tests and opt-in `--persistent-fictional-demo` continue using the original five-vehicle source. The P7 generated-fictional SQLite Lab remains separate and opt-in, not a production storage cutover.
- `portfolio/photo_map.tsv` gives representative preloaded imagery by make/model. The owner explicitly said exact years, trim and photographic authenticity do not have to hinder this portfolio project. Multiple fictional model names intentionally share an illustrative, type-appropriate reference photograph. No photo is represented as a verified picture of a customer's rental unit.
- The local library has **12 actual CC0 Wikimedia Commons JPGs**, optimized to **1024x680**, committed under `assets/portfolio/`. Each has photographer, original Commons page, licence and SHA256 in [IMAGE_CREDITS.md](../assets/portfolio/IMAGE_CREDITS.md) and [source_manifest.json](../assets/portfolio/source_manifest.json). The free offline model has **R0 API/asset subscription cost**, with no live API or runtime Internet requirement. The three existing original demonstration JPGs and the generic silhouette fallback remain.
- A carefully scoped `FleetPhotoStore::setPortfolioShowcase()` flag permits CC0 bike/car images only for the large showcase. Earlier small-fixture native tests still correctly require neutral motorcycle silhouettes. Existing user-added vehicle photo import remains available.
- Build-time embedded assets are resource-prefixed `:/portfolio-demo/` and `:/portfolio-photos/`; compile-time SHA256 must match `portfolio/vehicles.txt`. No arbitrary runtime catalogue path, no auto-import and no source-adjacent writes.

## 2. Exact-source native results

| Gate | Platform | Result |
|---|---|---|
| Full real Qt6.8.3 native CTest suite | Linux Ubuntu 24.04 GCC | **130/130 passed**, zero failures, 162.83 seconds |
| Full real Qt6.8.3 native CTest suite | Hosted Windows Server 2022 MSVC | **130/130 passed**, zero failures, 190.90 seconds |
| New 100-vehicle native Gallery `rental_studio_portfolio_catalog_wide` #16 | Linux and Windows, 1500x860 | **PASS** |
| New 100-vehicle native Gallery `rental_studio_portfolio_catalog_compact` #17 | Linux and Windows, 1280x720 | **PASS** |
| Test assertions in actual Qt QML | Both platforms | 100 visible records, 90/10 split, 99 initially available, C++ query/filter/selection/reset, preserved original fixture bytes, CC0 photos for Suzuki C004, Kia C005 and Honda M001 |
| Windows portable real executable functional checks | Hosted Windows | **8/8 PASS** |
| Packaged Windows PowerShell 5.1 verification | Hosted Windows | **PASS** |
| Free Commons download and CC0 metadata validation | GitHub Actions runner | **12/12 verified and committed** |
| Current owner's local Qt Creator 6.10.2 MinGW photo-inclusive review | Physical Windows PC | **NOT TESTED / OWNER REVIEW OPEN** |

**Verified run links:** [Linux job #126715014619](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41868916532/job/126715014619) and [Windows job #126715014576](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41868916532/job/126715014576). Both logs show 130/130 tests passed, zero failed. Windows logs explicitly show `ALL 8 REAL APP FUNCTIONAL CHECKS PASSED` and `P4 Windows PowerShell 5.1 subprocess verification PASS`.

### Important failure transparency

The early image acquisition workflows [#41867344770](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41867344770) and [#41867709192](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41867709192) failed closed because the downloader initially permitted `upload.wikimedia.org` but Commons returned thumbnails from `thumb.wikimedia.org`. **Neither committed unverified images**. Source commit `f0efe163` permitted exactly those two Wikimedia hosts under HTTPS and the Commons media path. The next [#41867883113](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41867883113) succeeded, 12/12 CC0 images obtained. Older source CI [#41866770434](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41866770434) also passed 130/130 both platforms **before imagery download**; only the latest [#41868916532](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41868916532) is cited as exact-source validation of the final photo-inclusive build.

The workflow uploaded screenshot and QA kit artifacts; these artifacts were **not personally viewed or image-inspected** in this audit. Do not call the final photo composition aesthetically accepted on the strength of native test counts.

## 3. Owner launch and remaining feedback

On their Windows PC, owner opens existing GitHub Desktop branch `feature/p7-sqlite-sandbox-20261102` and **Fetch/Pull**, then opens the repo root `CMakeLists.txt` in Qt Creator, choosing **Qt 6.10.2 MinGW 64-bit** and `rental-studio-local` preset. Build and run **`rental_studio_qtquick_spike` with NO command-line switches**. Fleet should contain 100 fictional vehicles with representative local images, filtered search and sort, keyboard Up/Down/Left/Right routes, and Add Vehicle still enabled for temporary fictional sessions. Validate visual spacing, smooth scroll/navigation and photo legibility in compact/large windows. **No repeated QA ZIP download needed**.

This phase is specifically a **R0 portfolio project**, not commercial licensing, production customer data, live operator rollout or a demand for exact vehicle authenticity. The images are free CC0, with attribution retained. The project is not making a recurring-cost API request.

**Formal ledger unchanged:** **45/74 owner-accepted criteria, fixed-weight 70.6%**; P5 8/8, P6 9/9, P7 0/8. Automated validation is not owner acceptance. D1 generated-fictional SQLite engine authorization remains narrow; pending P7 commercial/data-policy D2-D8, real scale/Narrator acceptance, P8 installer and P9 release remain open. [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) is unmerged and stacked on P6, protected stable `main` untouched.
