# V3 Research — Professional Blue, Clarity and Feasibility Blueprint

**30 October 2026 | Design research and source-grounded feasibility, not an approved design or implemented Qt UI**

**Owner's latest decision:** The Overview/Fleet/Rentals information architecture, Gallery ↔ Table fleet, vehicle drawer and guided rental structure are **accepted as the desired structure**. The V1 and V2 visual language (fonts, colour, theme, excessive bright surfaces) is rejected. Explore **professional, clear, generous white space, restrained light-blue character without generic vivid-blue SaaS styling**. Keep a light-first interface but do not make it glaring or sterile. The visual system must feel modern and dynamic through purposeful interaction.

**Governing source:** [Product Rebuild Master Audit](../docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md). **Tracking:** [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5).

## Executive verdict

**Technically feasible in Qt 6.8 / QML + C++, with conditions.** QML has documented support for customized controls, responsive Grid/Row/Column layouts, C++ model views, TableView, ListView/GridView, drawers and property transitions. The current CMakeLists.txt links only Qt Widgets; migration is a **real presentation-layer rebuild** requiring Qt Quick and Qt Quick Controls modules, appropriate CMake setup, C++ adapters, new UI interaction tests and hardware validation. Existing successful Qt Widgets hosted runs do **not** prove QML works in the owner's Windows kit.

**Aesthetic feasibility: promising, not proven by research alone.** Discipline in surfaces, type, product-specific photography, whitespace and full-screen component consistency is what will differentiate the product—not one special accent colour. Do not call the theme approved before inspecting working wide/compact prototypes.

## 1. What reference products/design systems actually show

| Source | Directly observed / source guidance | Adopt | Do not copy |
|---|---|---|---|
| [Microsoft Fluent 2 — Color](https://fluent2.microsoft.design/color), [Typography](https://fluent2.microsoft.design/typography), [Layout](https://fluent2.microsoft.design/layout), [Design Tokens](https://fluent2.microsoft.design/design-tokens) | Neutrals define structural hierarchy, brand accents mark intention; Segoe is readable; structured spacing separates related elements; semantic tokens avoid scattering raw hex values | Neutral-first, clear 14px/20px default body, predictable emphasis and compact but generous spacing | WinUI3 glass effects, default Azure-blue branding, entire Windows app chrome |
| [Atlassian Design — Foundations](https://atlassian.design/foundations) | Semantic tokens, consistent typography, spacing, borders, radius, and elevations establish systematic UI decisions | Tokenized components and states, a single source of theme truth | Atlassian colours, branded UI chrome or dense Jira copy |
| [Linear — 2024 redesign post](https://linear.app/now/how-we-redesigned-the-linear-ui) and [March 2026 interface refresh](https://linear.app/now/behind-the-latest-design-refresh) | Explicitly worked to remove navigation noise, align panels and refine density, themes and hierarchy; 2026 refresh prioritised predictable actions | Quiet navigation, predictable toolbar position, good text-to-surface contrast; test ALL states rather than one hero | Generic clone of Linear, broad light-purple sidebar or monochrome issue-tracker aesthetic |
| [Booqable inventory screenshots](https://booqable.com/industries/camera-rental-software/) | Actual rental product uses clear selected item, status, filters, product hierarchy and contextual order details | Fleet table operational clarity, selected vehicle detail and status with text | Unimplemented payments, booking calendar, stock quantities or industry-specific categories |
| [Fleetio official dashboards](https://www.fleetio.com/features/advanced-analytics) | Vehicle operations and attention panels grounded in actual state | Concise active/attention KPIs | Invented repair costs, fuel graphs or fake fleet analytics |
| [Selected concept visual on Dribbble](https://dribbble.com/shots/26244727-Fleet-Vehicle-Interface-Case-Study) | A **design concept**, not proof of working product | Readable table spacing and restrained filtering ideas | Treating dribbble shots as production-tested usability evidence |

**Synthesis:** "Professional Blue" must be principally **warm/cool neutral hierarchy**, with pale blue in selection and scoped feature areas, deeper slate-blue for meaningful actions, and precise typography. Blue is supporting architecture, not wallpaper.

## 2. V3 candidate palette — "Architectural Blue" (proposal, not approved)

All shades below are authored trial tokens, **not** exact values from Fluent, Atlassian, Linear or Booqable.

| Semantic role | Proposed hex | Actual use |
|---|---|---|
| App canvas | #F3F6F8 | Subtly cool background behind content |
| Sidebar | #F5F8FC | Light, toned navigation distinct from pure-white cards |
| Base card/panel | #FFFFFF | Clean workspace surfaces, chosen sparingly |
| Tinted panel | #EAF1F7 | Featured attention/info, filter rail, secondary toolbar |
| Selected row/tab | #DDECF7 | Low-saturation active context behind readable dark text |
| Text / main | #1F2F42 | All important headings and body copy |
| Text / secondary | #526578 | Captions, supporting labels with adequate legibility |
| Primary interactive | #315F89 | Main CTAs, selected controls, focus, important links |
| Primary hover | #254E75 | Emphasized hover / active state |
| Hairline | #D9E4EC | Nonessential surface outlines; not sole affordance indicator |
| Decorative steel blue | #6D95B7 | Graphic accents only: **not normal text on white** |
| Success | #256E5A | Text + icon + label, never green alone |
| Warning | #9A5829 | Text + icon + label for returns needing attention |
| Danger | #A43A41 | Destructive action state |
| Surface selection focus | #315F89 outline | Strong accessibility border beyond a pale tinted background |

### Contrast audit (relative luminance, W3C formula, checked 30 October 2026)

- White on primary steel blue #315F89: **~6.71:1**.
- Primary text #1F2F42 on white: **~13.61:1**.
- Secondary text #526578 on white: **~6.01:1**.
- Secondary text #526578 on tinted panel #EAF1F7: **~5.28:1**.
- Decorative #6D95B7 on white: **~3.17:1** and **must not be used for small body text**.
- Pale borders #D9E4EC on white: **~1.29:1**, so an input requiring a perceivable boundary needs a stronger focus/shape treatment; do not claim all controls WCAG-compliant because text passes.

WCAG 2.2 recommends **4.5:1 for normal text, 3:1 for large text and 3:1 for essential UI component affordances**: https://www.w3.org/TR/WCAG22/ . These colour checks are *preliminary pairwise numbers only*; antialiasing, hover, focus, errors and complete screen audits remain unverified.

## 3. Typography, spacing and components

- **Typography candidate**: Segoe UI (or Segoe UI Variable when available on Windows); 14px / ~20px body; 12px min for secondary nonessential captions; 16px section titles; 22–24px page titles; 26–30px prominent single KPI when genuinely important; use semibold rather than ubiquitous bold. Avoid serif, novelty display fonts, all-caps paragraphs, overtracking and weak letter spacing. Fonts delivered by the OS should be checked on the owner's actual Windows version.
- **8px-oriented spacing family** with 4/8/12/16/24/32, but do not pad everything equally. Structural gutter ~24–32px wide desktop, ~18–24 compact. Cards ~20–24 internal padding; tables ~44–52px row height; inputs ~40–44px; buttons ~38–44px.
- **Radius**: buttons/fields ~7–9px, cards/drawer ~10–12px, tiny pills fully rounded; uniform 20px curves on everything would look toy-like.
- **Elevation**: mostly 1px subtle delineation, shadows only on hover/drawer/dialog, no shadow on every metric. Fluency comes from layout and coherent lighting, not glow.
- **Icons**: one coherent licensed thin/medium stroke family; icons accompany readable text, not replace it. Prefer 16–20px icons and aligned baselines.
- **Motion candidate**: 120–220ms for selection/drawer/hover, only meaningful state changes; honour reduced-motion setting; no continuously moving progress graphics. Confirm timings in real Qt Windows tests.

These are proposed measurement targets, not rigid pixel contracts; verify at Windows physical 100%,125%,150% scale rather than forcing fixed heights.

## 4. Apply the new visual system without changing accepted structure

### Overview
Same primary information hierarchy. Use a quiet top heading, three concise KPI zones, one lightly blue-tinted "attention / due returns" card and recent rental list. **No large saturated blue welcome panel**. Show value as booked rental value, never payments received. Due/overdue based on actual dates; fictional R001's due date 30 October 2026 must be contextual to run date.

### Fleet gallery (default)
Same gallery, search, filters and view switch. White product cards on slightly cool canvas with coherent 16:10-ish car photography area; model and daily rate in legible dark ink; status as small text-plus-tone chip. Highlight only selected/hovered card with restrained steel-blue outline. At roomy desktop 3 columns; compact 2 or 1 depending usable logical width and DPI. No 5 identical awkward stock photos; coherent silhouettes until licensed matched images selected.

### Fleet table
Same data, filters and selection; full-width neutral table in clean container; pale tinted header, meaningful col widths, ~48px rows, subtle row hover and a clear active selection. Do not tint alternating rows dark blue. The table's value is speed, not cinematic appearance.

### Vehicle detail drawer
White floating panel with selected vehicle and clear specs; one steel-blue "Start rental" button only if available. Rented vehicle has appropriate inspect action. 180–220ms modest transition and clear focus handling. Critical text always visible at small logical widths.

### New rental / history / returns
Preserve guided Vehicle → Customer → Review journey; calm form labels and relaxed spacing, a tinted-but-not-dark quote summary; obvious totals, errors and cancellation. Rental history remains a readable operational table. Return attention is appropriately coloured with reason text.

## 5. Can Qt 6.8 achieve this?

**Yes, the capabilities are explicitly documented** — not a promise of automatically beautiful screens.

| Desired behaviour | Likely native implementation | Evidence |
|---|---|---|
| Custom primary buttons, fields, pills, tables | Qt Quick Controls customized from Basic style or a cohesive custom style | https://doc.qt.io/qt-6.8/qtquickcontrols-customize.html |
| Responsive widths and two/three-column gallery | QtQuick.Layouts GridLayout / RowLayout / ColumnLayout with meaningful breakpoints | https://doc.qt.io/qt-6.8/qtquicklayouts-responsive.html |
| Rich gallery with real vehicle records | GridView/ListView with typed C++ data model | https://doc.qt.io/qt-6.8/qtquick-modelviewsdata-cppmodels.html |
| Proper fast fleet table | TableView with appropriate table-model/proxy adapter, column widths and selection | https://doc.qt.io/qt-6/qml-qtquick-tableview.html |
| Selected vehicle drawer | Qt Quick Controls Drawer or explicit responsive side panel | https://doc.qt.io/qt-6/qml-qtquick-controls-drawer.html |
| Smooth state changes | Qt Quick Behavior / NumberAnimation, avoiding costly per-frame JS | https://doc.qt.io/qt-6.8/qml-qtquick-behavior.html |
| Smooth scrolling / component reuse | Delegate reuse, reasonable bindings, async heavy backend tasks | https://doc.qt.io/qt-6.8/qtquick-performance.html |

**Repository-specific reality:** Current CMakeLists.txt finds only Widgets and links Qt::Widgets; mainwindow.cpp contains ~2,384 lines and nine views; GUI tests target the old widget structure. Qt Quick migration needs new Quick + QuickControls2 dependencies, QML module packaging, main entry, C++ QObject/QAbstractItemModel adapters, a shared view/selection state and replacement GUI tests. Keep domain behaviour, negative tests and isolated fake-data files working. Do **not** embed an entire new app as a QQuickWidget in the old shell just to avoid refactoring.

**Hardware caveat:** old hosted Windows Qt 6.8.3 Widgets pass is not proof the owner's local kit has Qt Quick installed, its GPU path is smooth, or Native Windows DPI is good. Measure, build and click on the actual machine before migration decision.

## 6. Feasibility hazards and mitigations

| Risk | Why it matters | Mitigation / decision |
|---|---|---|
| Generic "SaaS blue" | Saturated azure buttons and white cards can look like any template | Use steel-blue role only for actions/selection, strong neutrals and authentic automotive content |
| Too pale / washed out | Tiny pale labels are hard to read | Adopt 14px body, verified secondary ink, clear focus outlines |
| Too much empty white | Previous V1 was sterile | Slate/cool surfaces divide tasks; purposeful hierarchy, bounded lists rather than giant vacant tables |
| QML control style drift | Mixing Windows/Material/Basic controls looks inconsistent | Choose one cross-platform Base style, create reuse components and tokens |
| Complex gallery/table sync | Separate views can reset filter/selection; view delegate reuse loses state | Store shared filter/sort/selectedVehicleId in C++/application state, not row delegate internals |
| Over-animating | Flicker, poor low-end integrated-GPU performance | Animate only selected properties; performance gate, reduced-motion handling |
| Mismatched vehicle photography | Removes premium character; licence risk | Licensed model-matched curated set with clear illustrative disclaimer or first-party silhouettes |
| Single attractive Dashboard | Previous fatal mistake | Whole-product state matrix at 1500×860 and 1280×720 before approval |
| Premature Qt migration | C++ model/API/test complexity; shipping risk | Small **Windows Qt Quick proof** first; maintain recoverable Qt Widgets branch |
| Inaccurate business states | Fake charts or stale dates undermine credibility | All new metrics and due states derived from domain/dates and test fixtures |

## 7. Measurable gate — when to say "this design can be pulled off"

**Design gate (owner review):**
- Build a coherent V3 Overview, Fleet Gallery, Table, selected-vehicle drawer, New Rental/Review, History/Return and empty/error states at both target widths.
- Compare exact V3 typography, spacing, imagery placeholders and blue balance side-by-side with V2. Is it legible, not glaring, not corporate-blue cliché, and distinctively automotive?
- Owner explicitly says **approve** the complete art direction, not merely that the structure is good.

**Technical gate (local Windows Qt Creator):**
- Configure Qt 6.8+ kit with Qt Quick / Qt Quick Controls modules (confirm installation).
- Compile tiny actual Qt Quick desktop window, render real fictional C++ fleet data, switch Gallery ↔ Table and open/close drawer; preserve selected vehicle ID and filter state.
- Verify 1280×720 and 1500×860, real 100%, 125%, 150% display scale, mouse/keyboard/Tab/Enter/Escape, no clipping and acceptable smoothness.
- Run CTest domain parity in disposable location; no real customer records. Document exact SHA, kit, results and failures.

**Decision:** If both visual and technical gates pass, proceed with Qt Quick design system and reusable components. If QML is technically unstable on the user's exact PC, compare a Qt Widgets/custom paint route before migrating the whole product. If visuals fail, adjust the design before source changes.

## Sources and scope note

Research checked official Microsoft Fluent 2, Atlassian Foundations, Linear's own redesign articles, Booqable and Fleetio official pages, W3C WCAG 2.2, and **Qt 6.8** documentation. Dribbble imagery, when considered, is inspiration only, not verified product behaviour or performance. The 2026 project/source state is established by existing CMakeLists, C++ sources, tests and Product Rebuild Master Audit.

**This research does not modify the application, declare the V3 palette approved, attest that QML builds on the user's PC, or authorize a merge.**
