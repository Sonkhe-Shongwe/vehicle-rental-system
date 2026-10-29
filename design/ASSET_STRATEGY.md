# Authentic Vehicle Photography | V2 Asset Direction

**Project:** Vehicle Rental System portfolio | **Decision recorded:** 29 October 2026  
**Owner direction:** Hybrid of Precision Atelier and Editorial Grand Touring, using authentic vehicle photography. The application is intended to remain **non-commercial** as a graduate software engineering portfolio project. **Status:** Design and sourcing policy approved; specific images are **not yet selected, downloaded, cleared or integrated**. Current C++/Qt application source is unchanged.

## Aesthetic decision

Use genuine, high-quality vehicle photographs in a distinctive, restrained layout. Keep the technical graphite / warm-mineral canvas, precise typography, selective lime brand accent, and editorial automotive imagery.

- **Dashboard:** one carefully cropped authentic vehicle hero image, possibly a contextual vehicle detail or highlighted return card. Actual data figures retain priority.
- **Fleet:** authentic thumbnail for each vehicle when a suitable rights-cleared photograph exists; selected-vehicle inspector gets a larger, higher-quality image. Keep a clean table-based interface, not a photo catalogue.
- **Rentals:** a small corresponding photo for the selected vehicle if useful; the rental amount and dates remain visually dominant.
- **Fallback:** consistent illustrated vehicle class silhouette whenever a suitable licensed photo is unavailable. Never substitute an unrelated model without disclosing it.
- **Avoid:** mismatched image styles, noisy backgrounds behind table text, large watermarks, arbitrary manufacturer advertising, and car photographs on every dashboard card.

### Demo fleet and image matching

| Demo vehicle | Desired photograph | Acceptable fallback |
| --- | --- | --- |
| Ford Ranger | Actual Ford Ranger pickup, correct generation/variant if verified | Neutral pickup class image, labelled representative |
| Nissan X-Trail | Actual Nissan X-Trail SUV | Generic SUV illustration |
| Toyota Corolla | Actual Toyota Corolla sedan | Generic sedan illustration |
| Volkswagen Polo | Actual VW Polo hatchback | Generic hatchback illustration |
| Hyundai i20 | Actual Hyundai i20 hatchback | Generic hatchback illustration |

The demo data does not independently establish vehicle production year, exact trim, colour or photographic match. Never represent a stock photograph as an actual vehicle from a real rental fleet; the demo fleet and photos are illustrative.

## Rights and sourcing

Non-commercial intent is **not** permission to reuse an arbitrary photograph. A public GitHub repository and any packaged application still reproduce and redistribute visual assets, and an image may contain additional trademark or publicity rights.

**Preferred sources, in order:**
1. Owner's own photographs, with permission from any other rights holders and appropriate removal of personal details (e.g., registration plates or people).
2. Wikimedia Commons files with a clear per-file compatible license (CC0, CC BY, CC BY-SA where compatible), creator attribution, license link and adaptation notes. Review each source file's license.
3. Pexels / Unsplash individually sourced standard-license photographs with permissible integration; record photographer, page and license at time of acquisition, and avoid implying brand endorsement.
4. Manufacturer press photography **only** after checking the exact photographer/content rights and distribution terms or obtaining permission. Editorial-only media library terms do not automatically permit application-bundled demo assets.

The terms of a photo may not include third-party logos, vehicle trademarks or recognizable people. Factual model names are not an assertion of brand partnership. Add a portfolio disclaimer: *Independent demonstration project. Not affiliated with or endorsed by any vehicle manufacturer.*

**Official source references checked 29 October 2026:**
- Pexels license: https://www.pexels.com/license/
- Unsplash license: https://unsplash.com/license
- Unsplash logos and third-party rights: https://help.unsplash.com/en/articles/14224409-what-if-there-is-a-brand-logo-in-an-image-on-unsplash
- Wikimedia Commons per-file obligations: https://commons.wikimedia.org/wiki/Commons:Reusing_content_outside_Wikimedia/licenses
- Creative Commons reuse/attribution: https://creativecommons.org/reusing-cc-licensed-content/
- Ford Media Center editorial-only terms: https://media.ford.com/content/fordmedia/fap/en/multimedia.html

## Asset provenance register (required before adding images)

For **every** photograph, maintain a line in `design/ASSET_CREDITS.md` with:
- Local asset path and filename, vehicle represented, source page URL, photographer/rightsholder.
- Explicit license/permission and link, access date, whether attribution is mandatory, attribution text.
- Transformations (crop, colour adjustment, background removal), model/year/trim accuracy status.
- Image dimensions and compressed file size, whether redistributed inside the app or used only in screenshots.
- Restrictions, brand/trademark notices where relevant and license reassessment if the project use changes.

No unverified download, watermark removal, or pasted image-search URL is an asset clearance procedure. Store rights-cleared images locally in the repository or Qt resource bundle; **do not hotlink to arbitrary third-party sites in a desktop release**.

## Image quality and Qt integration criteria

- Keep consistent composition (3/4 exterior angles, deliberate lighting, limited distracting backgrounds).
- Use one visual temperature and consistent image treatment; do not fake manufacturer identity.
- Create optimised separate thumbnail and large-preview versions (candidate: ~480–720 px thumbnail, ~1280–1600 px large, adjust after measurement); avoid megabyte-heavy assets across many vehicles.
- Preserve aspect ratio/crops through fixed image containers, never stretch the car.
- Confirm Qt deployment can load assets offline using Qt resources or app-managed paths, with graceful fallback when absent.
- Keep source credits and license manifest alongside any packaged version.
- Test Windows high-DPI (100%, 125%, 150%), display quality, window resize, rendering cost, and colour/text contrast over any photographic overlays.

## Scope boundary and next steps

**Confirmed:** Non-commercial portfolio intent and permission to pursue authentic vehicle photography as a design direction. **Not confirmed:** rights to any specific manufacturer or photographer image; final asset choices; final hybrid design; actual Qt implementation; commercial redistribution rights.

1. Shortlist candidate **rights-cleared** photographs for the five demo vehicles with a source/license record, preferably consistent angle and visual atmosphere.
2. Create a final hybrid Dashboard, Fleet and Rentals concept set with the selected assets and factual demo data.
3. Review consistency and quality in side-by-side design captures before integrating into C++/Qt.
4. Include images in the Qt resource system only after license checks, optimisation, visual review and Windows runtime verification.
5. If the project becomes monetised or redistributed under a different purpose, reassess all licenses before release.

**Do not commit unlicensed photos or replace real Qt screenshots with design-only concepts.**
