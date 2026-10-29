# Automotive Photography and Visual Asset Strategy — Rebuild

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

Research candidate assets together, review a cohesive gallery set, and select final images **only after** the owner approves their appearance. None of the old files are obligatory. Archive/correct previous registration as needed; keep licences and source history.
