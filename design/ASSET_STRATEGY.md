# Automotive Photography and Visual Asset Strategy — Rebuild

**3 NOV 2026 ACTIVE:** [Five-model 3/10 to 10/10 photography charter](FLEET_PHOTOGRAPHY_10_OF_10_MISSION_2026-11-03.md) | [live model identity source/CI report](../docs/PHOTO_P1_A_MODEL_IDENTITY_NATIVE_VERIFIED_2026-11-03.md). Historical CI-pending material below is superseded by verified Qt 117/117 per OS. Car artworks and motorcycle fallbacks remain original and **not owner-approved**; no image binary was changed by the identity fix.

**Decision date:** 29 October 2026  
**Status:** art direction **not approved**; three previously bundled model photos have licences recorded but are **not necessarily suitable for the new design**.

## Approved principles

1. Fleet cards and vehicle detail drawers should feel genuinely automotive and inviting. Imagery must reinforce the actual make/model without implying an owned physical vehicle, exact year/trim or manufacturer endorsement.
2. Prefer a coherent photography set with comparable camera angle, crop, visual noise, natural light and background. For an unapproved/missing model image, use a designed car or motorcycle silhouette; never substitute an unrelated car photo.
3. No enormous photo banner simply to fill dashboard whitespace; meaningful operational content comes first. The gallery and detail drawer are the primary image experiences.
4. Every asset must have **documented usage rights and a verifiable source URL**, creator/licence terms, hash, date, derivative processing and display use, before it is bundled. No web-only URLs in the offline production GUI.
5. Check faces/plates/signage; use respectful non-deceptive cropping. No manufacturer logo, advertising or fake real-world rental fleet ownership claims.

## Five fictional demo vehicles

| Vehicle | Current status | New visual task |
|---|---|---|
| C001 Toyota Corolla | CC0 illustrative derivative already bundled | Review crop/background and year/variant disclosure; keep only if matches new card direction |
| C002 Ford Ranger | Hyins CC0 China-market XLT derivative already bundled | Image is from busy showroom with visible China-market plate; consider replacing with calmer source after inspection |
| C003 Hyundai i20 | CC0 illustrative derivative already bundled | Check quality and crop consistency with other models |
| M001 Honda CB500F | No approved model photograph | Licence/quality research or coherent motorcycle silhouette |
| M002 Yamaha MT-07 | No approved model photograph | Licence/quality research or coherent motorcycle silhouette |

**Existing source register:** [assets/README.md](../assets/README.md). The previous licensed files remain in the old Qt resource bundle for historical/source compatibility. **Copyright permission is not aesthetic approval.**

## Asset acceptance record per image

- ID/model and filename; verified original file page; author, declaration and licence URI.
- Technical: raw/derivative SHA-256, EXIF removal, dimensions/format, Qt resource registration.
- Artistic: card crop at compact and wide, content focus, direction/light and background quality.
- Ethical: illustrative disclaimer, no real-car identity/registration misrepresentation.
- Approval: specifically **accepted into the new visual baseline** (not implied by existing use).

## Motion, icons and fonts

A consistent line icon family, a verified licensed font (system font acceptable), colour and accessible fallbacks. New design components should not depend on remote APIs, font CDNs or stock image URLs for offline operation.

## Gate

**UX-Q3 CURRENT SOURCE, NO NATIVE RECHECK YET (3 Nov 2026):** [`9c64305`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9c6430503341364382911e1055480ac331cf4d21) now includes embedded illustrative Corolla/Ranger/i20, fallback bikes, optional fictional offline photo picker, compact Fleet Inspector overlay, native `Image.Ready` / geometry tests, and explicit Qt Quick Dialogs link. [Verification and Wikimedia motorcycle candidate audit](UX_Q3_PHOTO_VERIFICATION_AND_MOTORCYCLE_CANDIDATES_2026-11-03.md). A CI-only [draft PR #18](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/18) was opened and connector-reopened to trigger native workflows, but **no new run appeared**; previous [Qt Linux/Windows 115/115](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095) belongs to pre-image `8a7a1ed`. Two new photo CTests are registered, **NOT PASSED**. Motorcycle photos remain unintegrated pending model/crop/licensing approval. P1 and formal **45/74, 70.6%** unchanged; no merge/release.

**UX-Q3 SOURCE STAGED, NATIVE TESTS NOT YET RUN (3 Nov 2026):** [`daeeab9` candidate source](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/daeeab937d4a7df8ce93a7b013044f076d030241) implements generated-fictional offline Fleet images: rights-audited illustrative Corolla/Ranger/i20 embedded JPEG resources, Honda/Yamaha silhouette fallback, optional local image picker/staged preview on Add Vehicle, replace action in Inspector, C++ validation/re-encoded image sidecars under the controlled fictional root and new wide/compact native photo tests. [Full exact-source/pending-test audit](UX_Q3_FLEET_PHOTOS_SOURCE_PENDING_2026-11-03.md). **No new GitHub Actions run has appeared for the new code; do not claim it passed Qt native tests.** Previously compiled baseline is [`8a7a1ed` native Linux/Windows 115/115 each](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095) and does NOT test images. Default disposable demo photos/vehicles do not persist after full app exit; proper persistent image storage, the two motorcycle photos and final imagery/visual approval remain open. Formal **45/74, 70.6%** unchanged; no release or real customer records.

Research candidate assets together, review a cohesive gallery set, and select final images **only after** the owner approves their appearance. None of the old files are obligatory. Archive/correct previous registration as needed; keep licences and source history.
