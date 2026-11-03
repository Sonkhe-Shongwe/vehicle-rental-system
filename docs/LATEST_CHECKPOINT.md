# Rental Studio 2.0 | Latest verified checkpoint

**Reconciled 3 November 2026 (Africa/Johannesburg).** This is a dated evidence snapshot, not a live branch alias. Recheck GitHub before starting the next session. [Canonical product state](PROJECT_STATE_CANONICAL.md) | [Formal P0-P9 ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md) | [Testing](TESTING.md) | [Evergreen prompt](AI_CONTINUATION_PROMPT.md).

**UX-Q6 | Fleet reference-image versus illustration status (3 November 2026).** The [exact compiled source](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/087c923fcde13f8a5515c22e53e7883a15b6d5b4) adds truthful media badges in real Gallery cards and selected Inspector, including unloaded/invalid image fallback and recovery. [GitHub Actions 41637857962](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962) **PASS: 117/117 CTests each on Ubuntu 24.04 GCC and hosted Windows Server 2022 MSVC with Qt 6.8.3**, with both actual Qt Fleet-photo wide/compact scenarios and hosted Windows PowerShell 7/5.1 checks passed. [Dated details](UX_Q6_FLEET_MEDIA_STATE_NATIVE_VERIFIED_2026-11-03.md). Physical owner Windows/MinGW/scaling/Narrator, final P1 licensed photos, customer-data policy and release remain OPEN. **Formal 45/74, weighted 70.6%, unchanged**.

## Source, review and verified execution

- Repository: `Sonkhe-Shongwe/vehicle-rental-system` (public at audit). Active stacked development branch: `feature/p7-sqlite-sandbox-20261102`.
- Pre-synchronisation documentation HEAD [`22fd403`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/22fd40375ecc68c464e2bbb6a12e197a35e9a376) remains historical; intervening documentation-only commits are not a new compiled source.
- Latest **compiled and native-tested application source**: [`087c923`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/087c923fcde13f8a5515c22e53e7883a15b6d5b4); workflow [41637857962](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962). **117/117 CTests passed on EACH** Ubuntu 24.04 GCC and hosted Windows Server 2022 MSVC, Qt 6.8.3. Hosted Windows portable-package verification passed with PowerShell 7 and Windows PowerShell 5.1. The exact checkout SHAs and full CTest summaries were independently checked in both job logs. Prior PHOTO-P1-C source [`8f1d8cc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/8f1d8cc0afa00af2feb8930ab5f02d2d1cde76ea) and [run 41632213416](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41632213416) remain historical evidence.
- Real Qt screenshot artifacts for the wide 1500 x 860 and compact 1280 x 720 Fleet states were generated on both hosted platforms: [Linux artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962/artifacts/13232086999) and [Windows artifact](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41637857962/artifacts/13232021763). The strengthened automated tests checked media labels in the real QML scene; independent manual visual inspection of this new run's screenshots and physical owner Windows/Qt Creator/OS-scaling/Narrator acceptance are **not claimed**.
- The separate [photo-source review workflow 41631655379](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379) **FAILED**: all nine Wikimedia original-media fetches returned HTTP 429, so no original image files, contact sheet or file hashes were obtained from that run. Do not automatically repeat blocked requests.
- Current open draft stack, in ancestry order: [P7/photography #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) -> [P6 #14](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/14) -> [P5 #12](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/12) -> [P4 #10](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/10), with earlier P3/P2 drafts below. The actual PR bases were inspected; `main` remains unmerged and protected from unapproved edits. Recheck the stack in live GitHub.

## Genuine product changes in the latest tested source

- The Qt Quick/QML interface presents an operational Overview, Fleet Gallery/Table/Inspector, guided Rentals, quotes, booking/return/archive and typed C++ services for generated-fictional data.
- PHOTO-P1-A binds illustrative vehicle images to actual C++ make/model rather than ID aliases.
- UX-Q3 uses decoded `Image.Ready` checks, safe silhouette fallback and keyboard focus restoration around photo picker/reset.
- PHOTO-P1-C replaces the bicycle-like motorcycle placeholder with original, neutral road-motorcycle vector fallback and adds native wide/compact selected-motorcycle screenshot checks. This is **not** an approved final photograph or logo.
- UX-Q6 labels decoded vehicle pictures as **Reference image** and neutral/failed-loading media as **Illustration** in Gallery and Inspector. Real Qt test assertions cover seeded cars, motorcycle fallback, invalid image refusal and recovery without changing image-store or rental-domain authority.
- An opt-in generated-fictional P7 SQLite Lab exists behind bounded safeguards. Ordinary application launches retain their approved QSaveFile-backed workflows. It is **not** a commercial database cutover.

## Acceptance and limits

Owner-approved functional P5 **8/8**, P6 **9/9**. Overall **45/74 formal criteria; 70.6% weighted accepted coverage** as defined in the [frozen ledger](P0_P9_PROGRESS_TRANSPARENCY_2026-10-30.md). P1 7/10, P2 4/6, P4 5/7, P7 0/8, P8 0/6, P9 0/8 remain partial/open. The weighted result is **neither product completeness nor release readiness**; passing automated tests alone does not award owner acceptance.

## Next priorities, without inventing permission

1. Complete **P1 five-model licensed-photo review** using lawful, non-rate-limited source material, proper model/variant validation, native Gallery/Inspector cropping and owner visual approval. Avoid downloading further media from blocked hosts without a compliant approach. The existing neutral fallbacks are safe to retain meanwhile.
2. Complete one genuine physical Windows Qt Creator/MinGW, 100/125/150% where applicable, keyboard/focus/Narrator and visual review for the remaining P1/P2/P4 criteria. Hosted Windows MSVC is not a substitute.
3. Continue focused fictional-data UI/reliability work if the specific task warrants it. Keep P7 real-data decisions D2-D8 owner-gated, and do not enable imports, commercial contacts, production SQLite storage or destructive history policy.
4. P8 offline installer, P9 final QA, release, PR merges and `main` changes are separately gated.

**Evidence:** [UX-Q6 exact-source report](UX_Q6_FLEET_MEDIA_STATE_NATIVE_VERIFIED_2026-11-03.md), [PHOTO-P1-C dated report](PHOTO_P1_C_MOTORCYCLE_FALLBACK_NATIVE_VERIFIED_2026-11-03.md), [UX-Q3 report](UX_Q3_PHOTO_FALLBACK_AND_FOCUS_NATIVE_VERIFIED_2026-11-03.md), [P5 approval](P5_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md), [P6 approval](P6_OWNER_APPROVED_ACCEPTANCE_2026-11-03.md), [photo mission](../design/FLEET_PHOTOGRAPHY_10_OF_10_MISSION_2026-11-03.md).

Historical checkpoint wording is preserved in [the audited Git revision](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/22fd40375ecc68c464e2bbb6a12e197a35e9a376/docs) and dated milestone reports. Do not keep appending obsolete "CURRENT" paragraphs here.
