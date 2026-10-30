# R1 | Owner-Selected Navy / Emerald Whole-Product Browser Review

**30 October 2026 | Owner-selected visual system implemented in an interactive DESIGN PROTOTYPE. Whole-product owner acceptance still open.**

**User-provided source:** `Rental_Studio_Theme_Redesign_Proposal_Expanded.pdf` (9 pages, owner selected this direction). This report records browser-only review against the PDF. It does not claim real Qt/QML source, CTest or Windows execution.

## 1. Implemented in the standalone browser prototype

- All owner-selected tokens: Cloud White `#F6F8FA` page, Ice Blue `#EAF0F4` left navigation, Midnight Navy `#17324D` structure/selected tab, Emerald Teal `#0F766E` primary actions, Soft Mint `#E8F5F0` live quote, white elevated forms; corrected `#5F6F82` muted text.
- Coherent **Overview** (live fictional stats / due/overdue attention / recent contracts); **Fleet Gallery and Table** with one shared search/status/sort/selected vehicle context, right inspector and simulated validated Add Vehicle form; **Rentals** (Vehicle → Customer → Review, separate visible soft-mint quote); Active, History and Return with guarded fictional confirmation.
- Standard 5-vehicle / 2-rental **fictional repository demo** values: 4 available, 1 active, booked R2,300 (NOT payments); Corolla R450/day × 3 days = R1,350 estimate. The illustrative data is not an actual customer dataset.
- Review scenario picker: normal, empty fleet, long vehicle names, simulated storage error. Actions update browser memory only and reset on reload. No new rental status of Pending or persistent Save draft claim.
- Original generic car and motorcycle SVG shapes explicitly designated illustrative placeholders; final licence-verified model-matched photography is still unresolved.
- Standalone review HTML and PNG contact sheets supplied as downloadable attachments in the current ChatGPT conversation. **These artifacts are not committed GitHub source nor Qt screenshots.**

## 2. Actual verification and evidence boundary

**Source HTML SHA-256:** `9ff5afcf72adb3a163ed7e5b1b247b73a8044634309ddf86f7af980aa64f2d10`; `Rental_Studio_2.0_Owner_Theme_Interactive_Review.html`, self-contained.  
**Environment:** Debian GNU/Linux 13, Chromium `144.0.7559.96`, Python Playwright headless.  
**Browser render PASS:** Seven principal real browser view screenshots at **1500×860 and 1280×720** (14 cases); no document-level horizontal overflow in those checked views. Three 1024×768 screen horizontal checks PASS.
**Interactive browser PASS at both target sizes:** source demo figures, gallery/table search (Honda → 1 in both), selected detail / Escape, quoted R1,350 Corolla, guided customer and review, cancelled create no new record, simulated confirmed create/return/history, Add Vehicle empty-name inline error and valid fictional Add, empty Fleet, long vehicle label, simulated write-error no-mutation. No captured page JavaScript exceptions.
**Visual inspection:** Navy navigation, emerald actions, mint estimate and legible working surfaces remain coherent at both target sizes; compact 1280×720 form may require ordinary vertical scrolling to reach final controls, not a horizontal overflow defect.

**Colour arithmetic:** white on teal 5.47:1; navy on cloud-white 12.33:1; corrected muted ink `#5F6F82` on cloud-white 4.83:1. Earlier `#64748B` is 4.47:1 and is unsuitable for normal text on cloud-white. These are selected pairs, not a full accessibility audit.

**Not run / not validly claimed:** CMake or CTest for a *new* UI, actual Qt Quick/QML, typed C++ models, real disk writes, restart persistence, Windows Qt Creator, physical 100/125/150% OS DPI, screen-reader audit, complete focus-trap audit, photographic signoff, install packaging, owner full-app aesthetic approval.

## 3. Decision / next gate

R1/G1 is **IMPLEMENTED AS INTERACTIVE BROWSER REVIEW, TECHNICALLY BROWSER-TESTED, NOT OWNER-APPROVED IN FULL**. User should review Overview, Fleet Gallery/Table/Inspector, guided Vehicle/Customer/Review, Active/History/Return, empty/long/error and the two sizes. Correct accepted design defects and record explicit whole-product signoff before R2/G2 Windows Qt Quick/typed C++ feasibility. Do not merge old Draft PR #4; keep stable `main` untouched.

**Reproducibility caution:** Browser assets use no remote image/font fetch. Current test results do not inherit historical Qt Widgets CI status.
