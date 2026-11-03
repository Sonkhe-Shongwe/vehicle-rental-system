# PHOTO-P1-D | Five-model native Gallery and Inspector baseline

**3 November 2026 | Completed engineering baseline, not approved art.**

**Compiled source:** [`2995ddcef5e89cba7ffd7600e6aee45354be59eb`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2995ddcef5e89cba7ffd7600e6aee45354be59eb) on development branch `feature/p7-sqlite-sandbox-20261102`. **GitHub Actions:** [run 41641573481](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481) completed **SUCCESS**. [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) remains unmerged and based on the P6 development branch.

## Scope and implementation

The existing native `rental_studio_fleet_photo_wide` / `_compact` CTests now use the actual Qt Quick application (not a mockup) to select **C001 Toyota Corolla, C002 Ford Ranger, C003 Hyundai i20, M001 Honda CB500F and M002 Yamaha MT-07**. A temporary Fleet ID filter yields one visible Gallery card next to the selected Inspector, allowing reliable full-window review for each make/model at both 1500×860 and 1280×720.

For each model, assertions require the correct authoritative C++ selected ID and display name, onscreen Gallery and Inspector, **Reference image** for the existing three bundled car JPEGs or **Illustration** for both neutral motorcycle fallbacks, no simultaneous photo/fallback, and a successfully captured correctly sized PNG. Files follow `ux-q3-five-model-<ID>-<SIZE>.png`, 10 screenshots **per OS**. The earlier photo picker, replacement/reset, malformed/oversize media rejection, model-identity, book control and immutable fictional fixture tests are preserved.

No media-source asset, QML production layout, visual style selection, rental-domain logic, source photo licence, or protected data file was changed. The screenshot archive is evidence to support a later visual decision, **not** a claim of the owner's final five-photo review or actual stock photography.

## Genuine CI verification

| Job | Source, OS/toolchain | Result |
|---|---|---|
| Native Qt Linux | `2995ddc`, Ubuntu 24.04 GCC, Qt 6.8.3 | **117/117 CTests PASS**, Fleet photo wide/compact each PASS; [screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481/artifacts/13232748218) |
| Native Qt hosted Windows | same source, Windows Server 2022 MSVC, Qt 6.8.3 | **117/117 CTests PASS**, Fleet photo wide/compact each PASS; [screenshots](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481/artifacts/13233403628) |
| Windows portable QA | hosted PowerShell 7 and Windows PowerShell 5.1 | **PASS**, physical scaling/Narrator explicitly NOT TESTED |
| Source checkout | Both job logs explicitly fetch `2995ddcef5e89cba7ffd7600e6aee45354be59eb` | Verified exact-source attribution |

**Limits:** Real generated Qt screenshots were uploaded as GitHub artifacts, but were **not independently opened or pixel-inspected** in this session. Hosted Windows native QPA is not owner physical Qt Creator/MinGW, Microsoft Narrator or 100/125/150% OS display-scaling QA.

## Remote-photo acquisition outcome, separately failed

- Earlier [PHOTO-P1-B original image workflow 41631655379](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379) attempted nine source originals and received **HTTP 429 for all nine**. Zero original JPEGs, original hashes or valid contact sheet.
- A single subsequently redesigned [640px five-primary thumbnail workflow 41641126446](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641126446) requested one bounded thumbnail per model, with no original fallback, and received **HTTP 400 for all five**. Zero thumbnail previews. The run **FAILED** and uploaded a failure manifest, not approved images. No further automated retrieval was justified.
- [Follow-up source `2995ddc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2995ddcef5e89cba7ffd7600e6aee45354be59eb) makes that workflow **manual-only**, 4xx fail-fast. Do not retry failed hosts, use another host to evade a block, treat metadata from source-page registers as newly confirmed, or claim author/rights/final crop approval. The existing [candidate register](../design/photo_review/PHOTO_P1_B_CANDIDATES_2026-11-03.json) remains research-only.

## Formal gates and recommendation

P1 photographic quality/rights and complete five-model owner visual selection remain **OPEN**. The owner-approved P5 8/8 and P6 9/9 remain intact; overall **45/74 formally accepted and 70.6% weighted** unchanged. P7 commercial data, physical Windows accessibility/scaling, P8 installer and P9 release are also open. Draft PRs unmerged; `main` unchanged.

**Next most useful action:** inspect both actual Qt screenshot artifacts and assess which of the three existing car crops or neutral motorcycle fallbacks are visually unacceptable. Then secure genuine licensable model-correct image files through compliant access/owner-supplied material before attempting a visual replacement. Do not replace source media or change the licensed asset register without independent verification and owner visual approval.
