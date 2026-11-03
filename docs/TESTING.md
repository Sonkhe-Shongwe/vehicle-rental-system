# Rental Studio 2.0 | Verification policy and current evidence

**Current independently native-tested Qt source:** [PHOTO-P1-H Qt source `03831a7`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/03831a790db4429487a20ddfa56f3d6546c38c8a), [native Actions 41660314884](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884) **SUCCESS** with 117/117 Qt CTests each Ubuntu 24.04 GCC and Windows Server 2022 MSVC. `rental_studio_fleet_photo_wide` and `_compact` capture 4 actual **modal-open** reference-image screenshots per hosted OS: i20+Corolla × wide/compact, which were missing in PHOTO-P1-G. Native assertions validate image status, PreserveAspectFit, selected ID/name, contained disclosure/Close, Escape/focus return and stale-selection close. [Linux screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884/artifacts/13241074550), [Windows screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884/artifacts/13242113524), [PHOTO-P1-H evidence](PHOTO_P1_H_NATIVE_OPEN_IMAGE_EVIDENCE_AND_I20_SOURCE_2026-11-03.md). Independently viewed representative genuine screenshots across both hosted OS; no physical Qt Creator/MinGW/100%/125%/150%/Narrator manual signoff. Pexels source page research is separate from byte-based image review.

**Previous PHOTO-P1-G Qt baseline:** [`66253ee`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/66253ee3d2e4eb326d37af85059ffdbafa7074ae) / [run 41656937822](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41656937822) passed 117/117 each on Linux/Windows. That earlier run did not capture the modal open; PHOTO-P1-H above is the latest independently native-tested exact-source execution.

**Previous native Qt source test (PHOTO-P1-F):** [`d2d494f`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/d2d494f6b1337b9bb17e24eabf189e506ffc324d) / [run 41649565389](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41649565389) passed 117/117 each Linux/hosted Windows and validated fallback model names. Superseded for latest compiled-source attribution by PHOTO-P1-G `66253ee` above. PHOTO-P1-E offline Python 12/12 each OS is separate. Owner physical Windows tests and final imagery remain OPEN.

**Separate latest PHOTO-P1-E tool QA (not Qt CTest):** [PHOTO-P1-E source `f768514`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f76851460600b8379a160e1643265ca4032c0d57), [offline CI run 41647940737](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41647940737), **12/12 Python synthetic tests PASS each** on Ubuntu 24.04 and Windows Server 2022 (Python 3.11/Pillow 11.3). Tests include source SHA-256 and derivative SHA-256, actual injected EXIF removal, output preservation/refusal, path traversal, symlink, unsupported/oversized media and incomplete 1-of-5 review honesty. The local test created an unapproved synthetic contact sheet that was inspected for legible contain/crop layout; **no real photography was approved or bundled**. [PHOTO-P1-E verification](PHOTO_P1_E_OFFLINE_CANDIDATE_PREFLIGHT_VERIFIED_2026-11-03.md). The last native Qt app evidence remains [run 41641573481](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481), 117/117 per OS at `2995ddc`; do not attribute it to the latest Python-only tool commit.

**Post-run screenshot inspection:** Downloaded actual Linux/hosted Windows artifact ZIPs from [run 41641573481](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481). Independently viewed all five Linux compact full-frame captures, a contact sheet of compact Gallery/Inspector and wide Inspector crops for all models, and Windows compact i20. Confirmed the known background/clutter/duplicate-bike-art problems and visible controls in reviewed frames. This is qualitative visual QA and does **not** replace owner Windows MinGW/Narrator/OS scaling or P1 art approval. See [PHOTO-P1-D addendum](PHOTO_P1_D_FIVE_MODEL_NATIVE_BASELINE_2026-11-03.md).

**Evidence audit: 3 November 2026.** [Checkpoint](LATEST_CHECKPOINT.md) | [Formal acceptance](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | [Roadmap](ROADMAP.md). Native screenshots, automated green builds, physical Windows testing and owner acceptance are **different evidence levels**.

**Previous PHOTO-P1-D baseline: [source `2995ddc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2995ddcef5e89cba7ffd7600e6aee45354be59eb) / [native Actions 41641573481](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481).** Same Qt 6.8.3 OS kits; **117/117 CTests PASS each** including native five-model photo checks and hosted Windows portable PS7/5.1 checks. [PHOTO-P1-D evidence](PHOTO_P1_D_FIVE_MODEL_NATIVE_BASELINE_2026-11-03.md). The QML test produces ten additional real Fleet screenshot files per hosted platform (five IDs × wide/compact) from existing photo assets/fallback only. No manual screenshot pixel-review or owner aesthetic certification claimed. Photo-source run 41641126446 (640px thumbnails) failed all five with HTTP 400; prior 41631655379 original-file download failed all nine with HTTP 429. External acquisition is now manual-only, 4xx fail-fast.

## Latest exact-source successful native execution

| Field | Verified observation |
|---|---|
| Executable source commit | [`03831a790db4429487a20ddfa56f3d6546c38c8a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/03831a790db4429487a20ddfa56f3d6546c38c8a) |
| GitHub Actions | [run 41660314884](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884), **completed SUCCESS** |
| Linux | Ubuntu 24.04 / GCC / Qt 6.8.3, **117/117 CTests passed**, 0 failed; genuine Qt GUI/screenshot jobs completed |
| Hosted Windows | Windows Server 2022 / MSVC / Qt 6.8.3, **117/117 CTests passed**, 0 failed; actual QML test screenshots |
| Windows portable verification | PowerShell 7 and Windows PowerShell 5.1 checks passed in hosted workflow |
| UI layouts captured | Four PHOTO-P1-H **real modal-open** Qt screenshots per OS: C001 Corolla, C003 i20 × 1280×720 and 1500×860, plus existing five-model Fleet Gallery/Inspector evidence; [Linux screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884/artifacts/13241074550), [Windows screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884/artifacts/13242113524). Only representative screenshots were independently pixel-inspected. |
| Previous source evidence | PHOTO-P1-G [`66253ee`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/66253ee3d2e4eb326d37af85059ffdbafa7074ae) / [run 41656937822](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41656937822) tested full-image modal interactions but did NOT save modal-open screenshots. PHOTO-P1-F `d2d494f` / 41649565389 tested motorcycle fallback names; earlier PHOTO-P1-D `2995ddc` is historical. |
| Hard limitations | No physical owner's Windows 6.10.2 MinGW/Qt Creator build, actual 100/125/150% OS scaling, Narrator, production data, clean offline installer or release |

Both 117/117 summaries and checkout of exact source `2995ddcef5e89cba7ffd7600e6aee45354be59eb` were verified in actual Linux and hosted Windows job logs, including native `rental_studio_fleet_photo_wide` and `_compact` PASS. Actual screenshot ZIP artifacts were uploaded, not pixel-inspected independently here. The existing `UX-Q6` test improvements and all previous fixture tests remain enabled.

**Latest feature-specific report:** [UX-Q6 native media-state labels](UX_Q6_FLEET_MEDIA_STATE_NATIVE_VERIFIED_2026-11-03.md). The tests assert truthful Gallery/Inspector labels on seeded pictures, motorcycle illustrations, oversized/corrupt image fallback and later valid-media recovery, while preserving the fixture-byte checks. No formal acceptance increment.

## Independently failed work

The [photo-original review job 41631655379](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379) failed on nine out of nine Wikimedia download attempts with HTTP 429. **Zero original media files** were retrieved, so there was no valid resulting contact sheet, SHA-256 source register or photo acceptance. Preserve the failure; do not mark the workflow passed or silently retry rate-limited originals. Retain neutral non-final motorcycle fallback until suitable licensed material and owner visual approval.

## Existing automated protection

- C++/Qt native tests cover typed rental quote/confirm, return/archive, denied double booking, failure and rollback, fictional fixture byte integrity, QML Gallery/Inspector/photo fallback, keyboard focus and main-screen wide/compact geometry.
- P7 SQLite tests and the opt-in real-app fictional Lab are **bounded**, not default storage or commercial migration tests. `BUILD_P7_SQLITE_SANDBOX=ON` is an opt-in build path; ordinary launch retains QSaveFile-backed workflows.
- The PR changes classifier skips expensive CI compilation only on proven documentation-only deltas. Code/QML/CMake/workflow changes must run applicable full source tests. A green docs-only classification job is not another compiled software verification.
- Real screenshots must come from the compiled native Qt executable. Do not substitute a web mockup, generated art or a screenshot from an older commit.

## Required checks for further code work

For each meaningful change: record its source SHA and precise compiled jobs; inspect failed logs; run relevant core CTest, native Qt 6.8.3 Linux/Windows where available, wide/compact UI checks and protected SHA-pinned fixture/rollback cases. Preserve test intent; never remove or weaken tests for green CI. Record changed test counts **only from a completed run**.

## Physical/owner gates still open

- Owner's current Qt Creator 6.10.2 MinGW source build/CTest where compatible.
- Real Windows display scaling at 100%, 125% and 150% where supported, appropriate 1920 x 1080/taskbar/compact window fitting, no clipped focus or invisible actions.
- Keyboard-only Tab/Shift+Tab/arrows/Enter/Space/Escape, dialog focus containment/return and Microsoft Narrator names/status announcements.
- Owner-approved whole-product P1 visuals, five-model photography licence and suitability, P7 real-data policies, genuine offline installer and final release validation.

Follow [WINDOWS_ACCEPTANCE](WINDOWS_ACCEPTANCE.md) and [P1/P2/P4 consolidated physical review](P1_P2_P4_ONE_SESSION_PHYSICAL_REVIEW_2026-11-03.md). **P5 8/8 and P6 9/9 are already owner-accepted** for the bounded fictional scope, but this is not physical Windows certification.

**Historical test logs and intermediate failures:** [dated reports and audit index](AUDIT.md), [2 Nov full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-11-02.md), and [pre-sync Git revision](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/22fd40375ecc68c464e2bbb6a12e197a35e9a376/docs). Do not reintroduce superseded “pending” run statements at the top of living files.
