# Rental Studio 2.0 | Fleet photography 3/10 to 10/10 mission

**Supplemental actual screenshot review (3 November 2026):** [PHOTO-P1-D addendum](../docs/PHOTO_P1_D_FIVE_MODEL_NATIVE_BASELINE_2026-11-03.md) confirms the owner-already-identified model issues through downloaded real Qt screenshots. Immediate image replacement priority: ambiguous Hyundai i20 first; showroom Ranger and dark busy Corolla second; two indistinguishable motorcycle fallbacks third. This is *engineering's review of current artwork*, not final owner aesthetic selection or a new asset rights determination. No revised 3/10→10/10 owner score.

**Mission adopted:** 3 November 2026. **Status:** ACTIVE, not visually completed or owner accepted. The user set a clear new target: take the Fleet photography and related presentation from a subjective **3/10** to an owner-accepted **10/10** while retaining truthful model association, legally documented image rights, offline operation and full Qt/C++ functionality.

**PHOTO-P1-D engineering update, 3 November 2026.** [PHOTO-P1-D evidence](PHOTO_P1_D_FIVE_MODEL_NATIVE_BASELINE_2026-11-03.md): [source `2995ddc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2995ddcef5e89cba7ffd7600e6aee45354be59eb), [native Actions 41641573481](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481), **117/117 native Qt CTests PASS each** Linux and hosted Windows. Actual QML wide and compact Fleet Gallery+Inspector screenshots now captured for **all five existing models** from pinned fictional data, with reference-photo vs neutral-motorcycle illustration assertions. No final artwork installed, all candidate sources unapproved, screenshots not independently pixel-inspected in this session. Source-download attempts are suspended after [originals 9× HTTP 429](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379) and [thumbnails 5× HTTP 400](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641126446). Stage/source selection and P1 visual owner approval remain outstanding; baseline subjective 3/10 is not replaced by a test percentage.

## 1. Live source baseline and ground truth

- Development branch: `feature/p7-sqlite-sandbox-20261102`, stacked **draft PR #17** on draft P6 #14, stable `main` unchanged.
- Native verified before mission: UX-Q5 [`c04a4c4`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/c04a4c4b9ec8c57a05102b71f4497170cfb4c975), [117/117 tests on Linux and hosted Windows](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41614666826), **not** physical Windows Qt Creator/MinGW, Narrator, or final artwork approval.
- First mission code: [`f0332a8`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f0332a81a75849fd5013ce89cc302dee110772f9), changes reference-image matching from ID alias to live C++ make/model resolution and adds negative tests for recycled IDs, mismatched models and missing identity. **Verified:** [native GitHub Actions 41618236689](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41618236689), **117/117 tests on Linux and hosted Windows**, including real Qt wide/compact photo cases, plus Windows portable/PS5.1 checks. [Source report](../docs/PHOTO_P1_A_MODEL_IDENTITY_NATIVE_VERIFIED_2026-11-03.md).
- The current Qt Gallery has 112px image strips inside 214px cards (230px row cells). The Inspector has a 96px photo at 720px app height and 120px at wide height. Both use `Image.PreserveAspectCrop`. These are useful functional layouts but not yet art-directed photo stages.
- Current verified asset register: [`assets/README.md`](../assets/README.md), [`design/ASSET_CREDITS.md`](ASSET_CREDITS.md). **C001 Toyota Corolla**, **C002 Ford Ranger**, **C003 Hyundai i20** bundle CC0-derived *illustrative* photos. **M001 Honda CB500F** and **M002 Yamaha MT-07** show the same original generic motorcycle line illustration. No real photographed inventory is represented.
- The existing vehicle models do not specify trim, year or colour. Each example image requires an **illustrative** disclosure, not an assertion that it depicts an owned/available specific unit. No final image, licence, crop or entire product look has owner signoff.

## 2. Current problem ledger

| Fleet model | Current treatment | Reason not approved | Target action |
|---|---|---|---|
| Toyota Corolla | Black outdoor Commons image, house and garden prominent | Car weak relative to bright/cluttered background; night-like shadows | Review cleaner front-three-quarter CC0/attributable alternatives; keep exact make and body style |
| Ford Ranger | Black Hyins 2025 China-market showroom pickup, CC0 | Reflections, display text, crowded setting, foreign-market plate and trim implication | Replace with uncluttered, correctly identified illustrative Ranger if a better licensed candidate exists |
| Hyundai i20 | Older-generation white i20 photo, multiple vehicles nearby, CC0 | Subject ambiguity, inconsistent vehicle generation and clutter | Highest-priority car photo replacement |
| Honda CB500F | Generic original two-wheel line art, no stock photo | Outline resembles a bicycle and does not convey CB500F identity | Select licensable accurately model-labelled Honda photo, or redesign true motorcycle placeholder |
| Yamaha MT-07 | Same motorcycle line art | Two distinct models appear identical | Select licensable accurately model-labelled MT-07 photo, or redesign true motorcycle placeholder |

**Do not conflate licence and aesthetics.** A legally reusable photo may still fail this review. Maintain the original bundled assets until actual substitutes and owner decisions are documented.

## 3. Target art direction: premium honest automotive catalogue

- **Lead angle:** front three-quarter where possible, entire vehicle unobstructed, comparable eye/headlight-level camera perspective. Motorcycle hero should reveal the tank, chassis, engine and two wheels without adjacent vehicles competing for attention.
- **Framing:** landscape-oriented, stable image-stage aspect ratio chosen and tested against the **real Qt layout**. Preserve full bumpers, tail, roofline, wheels, mirrors and handlebars. Avoid hard cropping into bumper/headlight details at 1280x720.
- **Lighting and background:** clear exposure, readable dark paint, neutral or low-noise backgrounds, no visually dominant fences, dealer signage, ads, crowds or unrelated cars. Do not fabricate a location or misrepresent the actual demo inventory.
- **Consistent set:** compare all five vehicles side by side; aim for comparable vehicle scale, orientation, horizon, lighting and colour treatment. A gallery assembled from five unrelated photographic styles is a failure even if each source is individually sharp.
- **Layout design:** image stage distinct from the information area, with adequate height without sacrificing vehicle rates/status, Book action, keyboard focus or compact Windows usability. Assess both aspect ratios and letterbox/crop behavior from actual Qt screenshots, never concept-only mockups.
- **Transparency:** maintain an intelligible "Illustrative" marker for model references. User-chosen demo images are fictional-local overrides, not audited actual fleet photos.
- **Access:** photo descriptions based on real model identity, not recycled IDs; proper failed-photo fallback; keyboard and Narrator review remain open until performed on owner Windows.

Research basis, not a source of image rights: [Auto Trader's listing photo suggestions](https://help.autotrader.co.uk/hc/en-gb/articles/9102857201565-What-photos-should-I-take-for-my-advert), [Lotra's consistent vehicle photography workflow](https://getlotra.com/resources/guides/dealership-stock-photography-workflow), and [Creative Commons attribution FAQ](https://creativecommons.org/faq/).

**PHOTO-P1-B research update (3 Nov 2026):** [Nine source-page candidates and model-accuracy exclusions](PHOTO_P1_B_SOURCE_SHORTLIST_2026-11-03.md), [machine-readable candidate register](photo_review/PHOTO_P1_B_CANDIDATES_2026-11-03.json). No source binaries, derivatives or live Qt artwork changed; candidates are source/rights preliminaries and their actual visual/crop QA remains open.

## 4. Reviewed source candidates, NOT selected or bundled

| Model | File page | Licensing information | Artistic/legal caution |
|---|---|---|---|
| Corolla | [2019–2022 Toyota Corolla](https://commons.wikimedia.org/wiki/File:2019-2022_Toyota_Corolla.jpg) | Declared CC0, artist TTTNIS | Panoramic original ratio, not yet composition-approved; body/trim must be checked |
| Ranger | [2025 China-market Ranger photo currently used](https://commons.wikimedia.org/wiki/File:2nd_Gen_2025_Ford_Ranger_T6_RA_XLT_4WD_P789_China_Front_Three_Quarter_View.jpg) | Declared CC0, artist Hyins | Temporary reference only; busy showroom and China-market plate |
| i20 | [2022 Hyundai i20](https://commons.wikimedia.org/wiki/File:2022_Hyundai_i20.jpg) | Declared CC BY-SA 4.0, artist Calreyn88 | Later generation, but crop/scene and attribution need independent review |
| CB500F | [2021 Honda CB500F](https://commons.wikimedia.org/wiki/File:2021_Honda_CB500F.jpg) | Declared CC BY-SA 4.0, artist Chanokchon | Real CB500F in dealer setting, year unverified for fictional stock |
| MT-07 | [YAMAHA MT-07](https://commons.wikimedia.org/wiki/File:YAMAHA_MT-07.JPG) | Declared CC0, artist Tokumeigakarinoaoshima | Older 2014 image; composition and year need review |
| MT-07 alternative | [2021 Black Yamaha MT-07](https://commons.wikimedia.org/wiki/File:2021_Black_Yamaha_MT-07.jpg) | Declared CC BY-SA 4.0, artist PackMecEng | Newer look, but crop/background and share-alike compliance require review |

**Research provenance:** individual Wikimedia Commons file pages inspected on 3 November 2026. These are only potential files. No preview thumbnail or web image result is an authorization to bundle or an assertion of ownership. If CC BY-SA candidates are later selected, retain creator and licence URLs, indicate modifications, and assess adapted-material licence obligations per [Creative Commons](https://creativecommons.org/faq/). Prefer clear CC0 assets where quality is comparable, but do not trade away composition and model accuracy merely for CC0.

## 5. Acceptance rubric (100 points, proposed, not scored yet)

| Evaluation dimension | Weight | Minimum passing behavior |
|---|---:|---|
| Model correctness, truthful disclosure, no ID crossover | 25 | All five identities exact; reused IDs and missing vehicles cannot show another model |
| Five-image visual consistency | 20 | Comparable hero orientation, subject scale, photographic treatment and cleanliness |
| Individual image quality | 20 | All five identifiable, adequately exposed, visually clean, no dominant clutter |
| Native layout/framing and compact readability | 15 | Real 1280x720 and 1500x860 Windows and Linux Qt screenshot review; complete subject and available controls |
| Source provenance and licensing | 10 | Each bundled asset documented with source, author, licence, derivative changes and hashes |
| Accessibility, fallbacks and operator feedback | 10 | Correct labels, safe placeholders, keyboard actions, import/restore success and failures |

**10/10 signoff requires:** all rubric dimensions meet expectations with no material critical defect, actual owner approval of the complete Gallery and Inspector at both sizes, and separate physical Windows/MinGW, supported scaling and Narrator checks where required by existing P1/P2/P4. A future weighted score or automated CI green does not itself award the owner's aesthetic 10/10.

## 6. Work sequence and safe gates

1. **Photo identity and integrity:** remove seed-by-ID alias and test mismatched/reused/unknown vehicle IDs; retain safe custom-photo handling and no real-data pathways. Status: source committed, CI verification independently tracked.
2. **Candidate selection:** prepare side-by-side five-model **review set**, not a deployment. Check exactly what each source photo depicts and verify licence individually. Identify alternatives to the original three and two good motorcycle sources; record candidate scores. **Owner selects visual direction and exact images.**
3. **Visual rebuild:** after selection, edit source crop/hero processing and adjust Qt Gallery / Inspector photo-stage geometry as a focused reversible commit. Do not break Book, Remove, current search/filter, keyboard or photo actions.
4. **Native QA:** full GitHub Qt 6.8.3 GCC/Linux and MSVC/Windows CTests, capture real 1280x720/1500x860 Gallery and selected Inspector photos (including all five models), inspect clipping, camera orientation, contrast, empty and override cases. Retain old synthetic regression cases.
5. **Review:** owner sees coherent before/after five-vehicle comparison, licence manifest, physical Windows checklist and exact evidence. Record individual accepted items without pre-emptively marking formal P1 complete.

### Research exclusion: false motorcycle identity

The Commons image named [`20250701 Honda CB500F in Lucca.JPG`](https://commons.wikimedia.org/wiki/File:20250701_Honda_CB500F_in_Lucca.JPG) depicts a classic **CB500 Four**, according to its source page, not the demo's modern CB500F. Exclude it on model-identity grounds.

## 7. Boundaries

No code or asset commit to `main`; no merge/tag/installer/release; no real customer records, generic production photo upload, internet image fetching in the offline application, unaudited logos, or false claims of licensed actual fleet imagery. P5 and P6 prior owner acceptances are preserved. **Formal acceptance remains 45/74, weighted 70.6%** until the owner explicitly records new P1/P2/P4 decisions.
