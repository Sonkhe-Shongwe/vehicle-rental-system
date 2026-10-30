# Rental Studio 2.0 | CANONICAL CURRENT STATE

**Snapshot audited:** 30 October 2026 (Africa/Johannesburg, UTC+02:00).  
**Authority:** This is the concise CURRENT state for seamless handoff. [Full evidence and documentation audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) provides the trace. [General-purpose continuation prompt](AI_CONTINUATION_PROMPT.md) tells any future assistant how to use it. All three are intentionally synchronized; future work must update this file first, and refresh the other two if any durable claim changes. GitHub's live state supersedes this dated snapshot.

## 1. What is actually being built

**Product:** Rental Studio 2.0, an offline-first Windows desktop vehicle rental-management application and software-engineering portfolio project. Preserve working C++ rental behaviour while replacing the aesthetically rejected historical Qt Widgets presentation with a coherent light-first experience. No cloud service, payments, reservations, account login, production installer, SQLite migration or completed rental rewrite is implied.

**Owner-selected visual direction:** Midnight Navy `#17324D`; Emerald Teal `#0F766E`; Cloud White canvas `#F6F8FA`; Ice Blue sidebar `#EAF0F4`; Soft Mint quote `#E8F5F0`; corrected muted text `#5F6F82`. One left-navigation shell, with **Overview operational-first**, **Fleet vehicle-first**, **Rentals transaction-first**. Fleet Gallery and Table share search, filtering, sorting and selected vehicle ID with Inspector. Rentals design reference: Vehicle → Customer → Review with a visibly labelled **LIVE QUOTE / NOT A PAYMENT**, and Active, History and Return. Selected owner PDF is the design *direction*, **not full-product final aesthetic approval**; licensed/model-accurate photos and comprehensive accessibility remain outstanding. The rejected dark graphite/lime Qt Widgets design and speculative sage/copper/blue palettes are history, not current choices.

## 2. Live GitHub topology, verified during audit

| Purpose | Name | Audited head / state |
|---|---|---|
| Repo | [Sonkhe-Shongwe/vehicle-rental-system](https://github.com/Sonkhe-Shongwe/vehicle-rental-system) | Public GitHub source of truth |
| Stable baseline | `main` | `9bfca8786af1c64b0284a5a1bb3e2186573147a4`, no merge |
| Authoritative planning / product-reset docs | `docs/product-rebuild-reset-20261029` | `fbfdf78cbcc599bbe2924dbb2949b18dbb718c80` **before this audit's documentation commit** |
| Active P2 source / Windows local checkout | `spike/p2-qtquick-fleet-20261030` | `e5474d6f39b415ecbfa9f232ab9a757df872b60f` **before this audit's documentation commit** |
| Active tracking | [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5) | OPEN; earlier reset text is historical, latest owner/test evidence in comments |
| Active review | [Draft PR #6](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/6) | OPEN, DRAFT, base is product-reset docs branch, **not main** |
| Old prototypes | [Draft PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4), [Draft PR #3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/3) | OPEN DRAFT historical/rejected visual work, do not merge |

**Rule:** These commit hashes are dated audit pointers, NOT commands to reset a moving branch. At session start check branches, PRs and Actions afresh. Documentation audit commits after this snapshot intentionally advance the planning and P2 branch heads without changing C++/QML source, tests or release status.

## 3. Engineering: implemented versus only designed

**Historical C++17 Qt Widgets baseline:** fleet add/search/remove, immediate same-day rentals for 1–365 days, quote, double-booking rejection, return, archive/delete in permitted states, tests, disposable fixtures. Risks remain: monolithic MainWindow, source-adjacent legacy text storage, two individually atomic QSaveFile files (not one transactional unit), `double` money, ID reuse after deletion, incomplete malformed-record diagnostics. This is reference functionality, not the approved final look.

**Actual P2 Qt Quick/C++ application (read-only feasibility spike):** isolated CMake option `BUILD_QTQUICK_P2_SPIKE=ON` (OFF by default); real `RentalSystem` domain on temporary copies of pinned fictional fixtures, `QAbstractListModel`, `QSortFilterProxyModel`, synchronized Gallery/Table/filter/sort/vehicle-ID Inspector, navy/teal shell. No rental mutations, persistence writes or production image gallery. P2 source lives under `spikes/qtquick_p2/` **on the spike branch**, not merged into main or into the standalone planning branch.

**Desktop toolchain seen on user's Windows computer:** Qt Creator with **Desktop Qt 6.10.2 MinGW 64-bit Debug**; CMake configured using a fresh build directory after a moved-folder cache conflict; `BUILD_QTQUICK_P2_SPIKE=ON`, `BUILD_TESTING=ON`; actual Qt Quick executable **built, launched, and displayed on the user's Windows PC**. The exact local Git SHA and Qt Creator application version were not displayed/independently captured; don't invent them. Local full CTest output is not supplied. A subsequent actual Windows Settings screenshot confirms **150% Recommended**, physical **1920×1080 Recommended**, Landscape, but no simultaneous application rendering/focus test with that recorded setting.

**New real physical Windows display-settings evidence (30 October 2026):** User screenshot of **Settings → System → Display** confirms **150% (Recommended)** scale, **1920 × 1080 (Recommended)** physical resolution and Landscape orientation. The Settings screenshot contains personal account identifiers, so only its technical values are logged on [Issue #5](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5#issuecomment-6523145162), never the full image. This verifies the OS **setting**, not a simultaneous Qt app rendering at that scale, physical 100/125% behavior, full keyboard support or a measured 1500×860 logical viewport. At 150% the nominal logical desktop is ~1280×720 before taskbar, so a 1500×860 logical window cannot fit fully; don't call that clipping a UI defect. **P2 still 3/6, weighted 18.4%.**

## 4. Exact verified evidence and limits

| Evidence level | What passed | Source |
|---|---|---|
| Legacy Widgets regression | Two source-domain/GUI CTests historically green | [Linux 40944222722](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222722); [Windows 40944222486](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222486), old SHA |
| Owner-theme browser review | 19/19 original + 63/63 extra Chromium checks, 1500×860/1280×720 captures | [Final R1 audit](../design/r1/FINAL_VISUAL_AUDIT_2026-10-30.md), **not Qt code** |
| Native P2 hosted | **8/8 CTests Linux and 8/8 Windows** on exact source `3620d83518cc01bce047b6f0a17deab0b96079b6` | [Actions 41047388629](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41047388629) |
| P2 portable Windows | `windeployqt` bundle, moved-folder model + Qt compact UI smoke, changed-fictional-file rejection | Same run; [kit report](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/spike/p2-qtquick-fleet-20261030/docs/P2_WINDOWS_PHYSICAL_KIT_VERIFIED_2026-10-30.md) |
| Later source-branch docs head | Actions run reported **SUCCESS** on `e5474d6f39b415ecbfa9f232ab9a757df872b60f` | [41048156914](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41048156914), docs-only commit; don't assume it introduces new feature coverage |
| **Owner physical Windows** | Qt Quick app launched; Corolla C001 Inspector says 4 doors, R450/day, available; selection survives Gallery → Table; Available removes rented Ford Ranger; Rate sort correctly yields Honda R280 → Yamaha R300 → Hyundai R400 → Corolla R450; **Escape clears selection**; readable compact Table screenshot shows no obvious horizontal overlap | Actual screenshots and explicit Escape confirmation from current ChatGPT conversation; Issue #5 comments [manual Fleet](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5#issuecomment-6522494136), [Esc/key decision](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/5#issuecomment-6522603939). **Not independently reproduced by an assistant on the PC** |

**Critical limitations:** Hosted `QT_SCALE_FACTOR=1.25/1.5` is **synthetic**, distinct from the owner's independently recorded physical Windows **150% / 1920×1080** Settings screenshot. An application screenshot's pixel size alone is not proof of what Windows Settings displayed at capture time or exact logical dimensions. Native manual Tab/Shift+Tab, arrow navigation, full resizing, screen readers, physical multiple scales and toolkit decision remain **open**. In one Gallery screenshot upper cards appeared partially scrolled/clipped; mechanism not established, keep as review observation, not confirmed defect.

**Traceable failed run:** [41045247197](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045247197) failed 7/8 due Qt visual delegate lookup in new keyboard test. Fixed in [`eeb0848`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/eeb08485245ef127d6a9e53c2d80ec68bca66c0b); following [41045646448](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41045646448) passed 8/8 on both hosted platforms without disabling assertions.

## 5. P0–P9 transparent progress (frozen until criteria verified)

| Phase | Weight | Verified | Phase % | Contribution | Gate |
|---|---:|---:|---:|---:|---|
| P0 Baseline/safety | 5% | 5/5 | 100% | 5.0% | Historical baseline documented |
| P1 Complete design/assets/approval | 12% | 7/10 | 70% | 8.4% | OPEN |
| P2 Qt Quick/C++ feasibility | 10% | 3/6 | 50% | 5.0% | OPEN |
| P3 Domain/app boundaries | 12% | 0/7 | 0% | 0% | Not started |
| P4 Native shared UI + keyboard design | 12% | 0/7 | 0% | 0% | Not started |
| P5 Durable Corolla rental slice | 16% | 0/8 | 0% | 0% | Not started |
| P6 Fleet/rental feature parity | 14% | 0/9 | 0% | 0% | Not started |
| P7 Storage reliability/migration | 9% | 0/8 | 0% | 0% | Not started |
| P8 Offline Windows distribution | 5% | 0/6 | 0% | 0% | Not started |
| P9 Hardening/release signoff | 5% | 0/8 | 0% | 0% | Not started |
| **Total** | **100%** | **15/74** | Not a simple average | **18.4%** | **NOT RELEASED** |

Formula: `overall = SUM(phase weight × (verified acceptance checks / total acceptance checks))`. This is **evidence-weighted checklist coverage**, not percent complete code or release readiness. A test being added, an old result being repeated, a prompt being updated or owner screenshots supporting only part of a compound criterion does **not** automatically add progress. [Full criterion plan](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md). Do not change weights/status without clear dated exact-source evidence and a logged gate decision.

## 6. Open gates and logical next steps

**P1:** owner final whole-product design approval **NOT GIVEN**; model-matched properly licensed car/bike images outstanding; broader native accessibility/screen reader review outstanding. The visual direction is selected; don't re-run the rejected palette search.

**P2:** actual local Qt Creator **launch now observed**, and mouse-based Fleet interaction + Escape confirmed. Need record installed Qt Creator version, source SHA, local CTest output; **150% Settings baseline is confirmed**, but app-at-scale evidence and other supported Windows 100/125% settings, real resize/keyboard flow with screenshots remain open; test focus, list keyboard and accessible semantics. Gather failures, fix exact-source branch, then request **explicit owner Qt Quick go/no-go**. There is no owner technology approval yet.

**Keyboard decision:** implement **predictable group-based focus**, not global nearest-pixel arrows: Tab/Shift+Tab between regions; Up/Down within list/table/vertical menu; Left/Right for meaningful horizontal siblings; Enter/Space activation; Escape dismissal; preserve caret/arrow behaviour in input/editable dropdowns. Qt `FocusScope`/`KeyNavigation` and real keyboard tests belong to **P4**, although P2 establishes feasibility.

**After P2 gate:** P3 small typed C++ app/service/domain boundaries, P4 native design system; then P5 genuine persisted Corolla quote/rent/restart and failure path; P6 parity, P7 separate storage decision, P8 clean installer, P9 release. Do **not** begin SQLite migration, full rewrite, payment/API/AI/cloud, or release merely because current P2 screenshots are attractive.

## 7. Safety and collaboration contract

- **GitHub:** assistant may use connected tools for documented reviewed changes on the active isolated branch. GitHub Desktop on user's PC should show `vehicle-rental-system`, `spike/p2-qtquick-fleet-20261030`, clean working tree, and Fetch/Pull origin. Owner locally uses Qt Creator to compile/run and supplies screenshot/CTest/logs. Remote assistant cannot directly see/control the physical desktop.
- **Local path:** currently `C:\Users\Lenovo\Downloads\Github Projects\vehicle-rental-system`; earlier nested `Pilot_ODIN` directory was reorganized. Moving project broke a CMake cache, resolved by clean build directory such as `C:\Users\Lenovo\QtBuilds\VehicleRentalP2-Debug`. Treat current paths as user-reported, recheck before prescribing destructive operations.
- **Keep branches safe:** no force-push/merge to `main`, no automatic merging of draft PR #3/#4/#6, no editing real vehicle/customer files, no new background promises, no confidential assets in screenshots. Old source-behaviour and CI evidence must not be laundered into a new-version PASS.
- **Standalone kit:** P2 compiled Windows acceptance artifact is for testing only, may expire in Actions; portable binary is not a Qt Creator source checkout, and the owner's Qt **6.10.2 MinGW** local kit differs from hosted **Qt 6.8.3 MSVC**.
- **Design controls:** do not invent Pending, Save draft, advance reservations, paid/collected revenue or a new customer data model. Date-derived overdue status is not a stored enum.
- **Reporting:** distinct statuses PROPOSED / SOURCE CREATED / STATIC REVIEW / BUILT / AUTOMATED TESTED / OWNER PHYSICAL CHECKED / OWNER APPROVED / MERGED / RELEASED. Failure/negative results stay visible.

## 8. Seamless continuation protocol

At any new turn: (1) read this file and [audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md); (2) fetch live Issue #5/PR #6/branches/latest Actions, not just the prompt; (3) treat source branch as code authority, planning branch as documentation authority; (4) select the exact requested task, preserving current P2/P1 blockers; (5) implement/test only authorized scope; (6) record exact source SHA, OS, result and failures; (7) update **this file**, audit if an evidence/decision changes, [AI continuation prompt](AI_CONTINUATION_PROMPT.md) if workflow changes, P-phase table only with real accepted checks, and Issue #5/PR #6 when material. Keep GitHub status and user-visible response consistent. Do not ask the user to repeat information visible here or in the current conversation.

**Canonical companion files:** [full document audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) · [general-purpose continuation prompt](AI_CONTINUATION_PROMPT.md) · [progress criteria](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) · [design tokens](../design/r1/OWNER_THEME_DIRECTION_2026-10-30.md).
