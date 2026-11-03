# PHOTO-P1-H | Open-image native screenshot and i20 source evidence

**3 November 2026. Engineering QA verified, image sourcing/approval not completed.**

**Compiled source:** [`03831a790db4429487a20ddfa56f3d6546c38c8a`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/03831a790db4429487a20ddfa56f3d6546c38c8a) on `feature/p7-sqlite-sandbox-20261102`. **Actual run:** [41660314884](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884) **SUCCESS**. Development remains stacked draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), targeting the P6 feature branch. `main` unchanged.

## Verified native behavior and new evidence

The earlier PHOTO-P1-G real Qt tests exercised the View full dialog and returned focus, but **did not capture screenshots while the dialog was actually open**. PHOTO-P1-H extends the existing `--fleet-photo-smoke` inside the same compiled QML app, not a separate mocked UI.

At both **1280×720 compact** and **1500×860 wide**, tests now:
- Open the current fictional **C001 Toyota Corolla** photo via keyboard, assert the decoded image is the current C++ selected photo, assert QML `Image.PreserveAspectFit` (uncropped), heading/disclosure/Close geometry, and save a real **`ux-q3-full-reference-C001-<SIZE>.png`** before clicking Close and asserting keyboard focus return.
- Open the existing **C003 Hyundai i20** photo by the same native action, assert its **correct authoritative C++ identity and source**, image fit and fully visible controls, save **`ux-q3-full-reference-C003-<SIZE>.png`**, and confirm **Escape** closes it and restores focus.
- Reopen the i20 photo and change C++ selection to Corolla while the dialog is open; the real QML viewer must dismiss the now-stale selected image without leaving a visible popup.
- Continue the previous existing five-model Gallery/Inspector capture, truthfully labelled illustration fallback, photo import/rejection, keyboard, domain and storage/rollback regression suite.

| Actual runner | Exact-source result | Real open-modal artifacts |
|---|---|---|
| Ubuntu 24.04 GCC, Qt 6.8.3 | **117/117 CTests PASS**, Fleet wide/compact PASS | [Linux screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884/artifacts/13241074550), 4 new modal screenshots |
| Hosted Windows Server 2022 MSVC, Qt 6.8.3 | **117/117 CTests PASS**, Fleet wide/compact PASS | [Windows screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41660314884/artifacts/13242113524), 4 new modal screenshots |
| Hosted Windows portable PowerShell | PS7 and Windows PowerShell 5.1 **PASS** | Physical user device scaling, Qt Creator/MinGW and Narrator **NOT TESTED** |

Both job logs fetch `03831a790db4429487a20ddfa56f3d6546c38c8a`; the CI run concludes **SUCCESS**. Independently viewed actual Linux i20 compact/wide and Corolla wide full-frame popup PNGs and Windows i20 compact popup PNG; also inspected a four-panel Linux/Windows comparison from **real** screenshots (i20 compact and Corolla wide). In these reviewed frames the current C003 image visibly includes a **white Volkswagen on the left** and a **blue car on the right** next to the centered white Hyundai i20; the dialog properly reveals this underlying problem without clipping heading, disclosure or Close. The comparison is available as a chat artifact, not a new source photograph. Not all eight open-modal screenshots were individually pixel-reviewed.

## Independent Pexels source lead, not a product asset

[Full research and usage limits](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/feature/p7-sqlite-sandbox-20261102/design/photo_review/PHOTO_P1_H_PEXELS_I20_SOURCE_RESEARCH_2026-11-03.md) | [Structured unapproved record](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/feature/p7-sqlite-sandbox-20261102/design/photo_review/PHOTO_P1_H_I20_SOURCE_RECORD_2026-11-03.json).

A separate [Pexels Gray Hyundai i20, photo 17156941](https://www.pexels.com/photo/gray-hyundai-i20-17156941/) lists **Subhan Patanaik** as creator and **Free to use**. The [Pexels Licence](https://www.pexels.com/license/) says photo use in software/app contexts is permitted, but forbids implied brand/person endorsement and does not independently clear incidental third-party rights. The remote preview depicts a single apparent i20 at a front-three-quarter angle, with a visible registration plate, wide sky and a building. It may be clearer than the bundled three-car shot, **but original JPEG bytes were not retrieved** in this session. Local source download failed, so no original SHA-256, image pixel/crop assessment, provenance-chain attestation, modification/redaction, rights approval, owner visual selection, or integrated Qt image exists. The GitHub research records explicitly use `false` / `null` for those gates. A photo found via an authorised independent provider is **not** a licence or approval to replace `assets/hyundai_i20.jpg`.

**Next:** obtain this or another regular Hyundai i20 original through the official permitted download, run [offline review preflight](../design/photo_review/OFFLINE_REVIEW_README.md), assess full-vehicle Gallery/Inspector framing and visible plate handling, then obtain owner final visual/licensing approval before any real source photo installation. Repeat for other four make/model references.

## Governance

The proposed product-quality objective remains subjective owner 3/10 to 10/10 photography; **no new owner score was awarded**. P5 8/8 and P6 9/9 fictional operations remain accepted. Overall **45/74 formally accepted, weighted 70.6%**, unchanged. P1 final five-photo art/right set, physical Windows device P2/P4 accessibility/scale tests, P7 D2-D8 commercial data rules, P8 installer, P9 release and draft PR merges remain OPEN. `main` unchanged.
