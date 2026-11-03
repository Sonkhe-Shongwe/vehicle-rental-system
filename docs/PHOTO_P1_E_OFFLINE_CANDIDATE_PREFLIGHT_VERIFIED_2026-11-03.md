# PHOTO-P1-E | Offline candidate image preflight, independently verified

**3 November 2026. Status: VERIFIED ENGINEERING TOOL; NO IMAGERY OR OWNER VISUAL ACCEPTANCE.**

**Exact tool source:** [`f76851460600b8379a160e1643265ca4032c0d57`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/f76851460600b8379a160e1643265ca4032c0d57), development branch `feature/p7-sqlite-sandbox-20261102`, stacked draft [PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) against the P6 feature branch. **Exact CI:** [run 41647940737](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41647940737) completed **SUCCESS**.

## Why it was needed

The latest genuine Fleet screenshot review exposed competing background vehicles in the current Hyundai i20, a busy Ranger showroom, dark/cluttered Corolla and duplicate neutral motorcycle illustrations. Earlier photograph-acquisition attempts returned [HTTP 429 on all nine Commons originals](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41631655379) and [HTTP 400 on all five Commons thumbnails](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641126446). Those network review workflows remain suspended. A blocked photo host or source-page licence summary does **not** establish an image file's legal availability, exact source bytes or approved artwork.

## Actual implementation

- [`tools/offline_photo_review.py`](../tools/offline_photo_review.py) accepts **one to five** direct, lawfully obtained local image files, each associated with one of the five existing generated-fictional Fleet IDs using a local JSON manifest. There are no network/image retrieval calls, automatic fallback hosts, hard-coded rights exemptions or writes into `assets/`.
- Validation rejects unknown/duplicate IDs, duplicate filenames, missing creator/licence/source claims, traversals, symlinked originals, empty files, unsupported decoded media, corrupt formats, excessive dimensions/bytes, and nonempty or overlapping output folders.
- Valid candidate originals are SHA-256 hashed, correctly oriented, and converted into **review-only**, EXIF-stripped JPEG derivatives with their own hashes. A contact sheet contrasts the full image with centered **2.73:1 Gallery-style** and Inspector-style crops. This is an approximate image-stage preflight, **not** a replacement for real native Qt crop and focus inspection.
- Outputs carry `rights_verified=false`, `owner_visual_approved=false`, `installed_in_application=false`. User-supplied creator, origin, licence strings are **claims, not independent licence verification**. The tool does not recognise subject identity, faces, number plates, actual vehicle ownership or trademark clearance.
- [Operator guide](../design/photo_review/OFFLINE_REVIEW_README.md), [first i20 input template](../design/photo_review/OFFLINE_REVIEW_INPUT_TEMPLATE.json), local-results `.gitignore`, and a restricted [CI workflow](../.github/workflows/photo-offline-review.yml) were added. CI generates only synthetic test images and never commits candidate photos.

## Verified exact-source execution

| Runner | Exact SHA / test | Actual result |
|---|---|---|
| Ubuntu 24.04, Python 3.11, Pillow 11.3.0 | `f768514`, [CI 41647940737](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41647940737) | **12/12 Python synthetic tests PASS**, 0 failed |
| Windows Server 2022, Python 3.11, Pillow 11.3.0 | same exact source and run | **12/12 Python synthetic tests PASS**, 0 failed |
| Local synthetic-only visual preflight | One generated placeholder labelled C003, no real car photography | Contact sheet generated and manually checked for readable source/contain/crop comparison. No source JPEG or rights evidence obtained. |
| Existing Qt Quick app native evidence, separate commit | [`2995ddc`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/2995ddcef5e89cba7ffd7600e6aee45354be59eb), [Qt CI 41641573481](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41641573481) | **117/117 CTests EACH Ubuntu GCC / hosted Windows MSVC**, unchanged. **Not recompiled** for the Python-only review utility. |

Earlier candidate-preflight source `624e454` passed the first Linux 9-test job, and `08d8333` passed 11/11 on both platforms; exact latest result above supersedes these for the tool only. No user-supplied or new legally confirmed photographed source has yet been reviewed by this utility.

## Governance and next move

P1 final five-model photography, source-rights verification, real Qt screenshot review **of actual replacement imagery**, and owner 10/10 whole-gallery aesthetic acceptance remain **OPEN**. The tool is only a safe path for doing those later, starting with obtaining a usable legally documented **regular Hyundai i20** original. Do not confuse creator/licence claims in a local manifest with independent verification or use the generated derivatives in the compiled Qt app without separate review and explicit approval.

Official P5/P6 signoffs remain valid; **formal total 45/74 accepted, 70.6% weighted**, unchanged, not commercial/release readiness. Physical Windows Qt Creator/MinGW, OS 100/125/150% scaling and Narrator, P7 customer data policies, P8/P9 release/installer, and PR merge all remain unauthorised or unverified. `main` was not changed.
