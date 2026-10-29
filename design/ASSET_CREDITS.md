> **HISTORICAL ASSET CREDITS — design reset 29 October 2026.** Preserve creator/licence/source references for original concepts; this is not approval to reuse artwork in the replacement. Verify provenance and visual suitability under [new asset strategy](ASSET_STRATEGY.md).

# Authentic vehicle photograph candidate register — 29 October 2026

**Main branch status:** No photographic image binary is integrated into the compiled Qt app or merged into `main`. Three verified image derivatives have been uploaded **only to a design review branch** ([Draft PR #3](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/3)). Image-content, model/trim accuracy, photography consistency and Qt runtime use are not yet signed off. Photo licences were checked on individual source pages.

**Authoritative demo fleet:** Toyota Corolla C001, Ford Ranger C002, Hyundai i20 C003, Honda CB500F M001 and Yamaha MT-07 M002. Earlier proposals naming Nissan X-Trail and VW Polo as members of the five-item demo fleet were incorrect.

| Demo vehicle | Source / creator | Declared licence | Review-branch state | Caveat |
| --- | --- | --- | --- | --- |
| Toyota Corolla C001 | [01x07x2022000 on Commons](https://commons.wikimedia.org/wiki/File:Toyota_Corolla_IMG_6391.JPG) | [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) | JPEG fetched and hashed; visual review pending | Photo is representative, exact demo trim/year unknown |
| Ford Ranger C002 | [crash71100 on Commons](https://commons.wikimedia.org/wiki/File:Ford_Ranger_US-Spec_(52179269642).jpg) | CC0 1.0 | JPEG fetched and hashed; visual review pending | US-spec photograph; exact demo variant/year unknown |
| Hyundai i20 C003 | [Trop86 on Commons](https://commons.wikimedia.org/wiki/File:Hyundai_i20_133151.jpg) | CC0 1.0 | JPEG fetched and hashed; visual review pending | Older PB generation; exact demo variant/year unknown |
| Honda CB500F M001 | [Chanokchon on Commons](https://commons.wikimedia.org/wiki/File:2021_Honda_CB500F.jpg) | [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) | Source checked; photo fetch was rate-limited (HTTP 429) | Attribution and share-alike treatment required for modifications |
| Yamaha MT-07 M002 | [Tokumeigakarinoaoshima on Commons](https://commons.wikimedia.org/wiki/File:YAMAHA_MT-07.JPG) | CC0 1.0 | Source checked; binary fetch not attempted after rate limit | Exact demo variant/year unknown |

See the [full metadata and transformation manifest](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/design/authentic-photo-hybrid-20261029/design/v3/photos/MANIFEST.json), [photo candidates](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/design/authentic-photo-hybrid-20261029/design/v3/PHOTO_SOURCES.json) and [photo credits](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/blob/design/authentic-photo-hybrid-20261029/design/v3/PHOTO_CREDITS.md) in the review branch.

The source photos and their files must not be described as a real rental company's specific fleet. Manufacturer identity is illustrative, not endorsement. Do not hotlink in packaged Qt; only bundle inspected, resized and licensed photographs with appropriate photographer credit and acknowledgement of changes.

See [ASSET_STRATEGY.md](ASSET_STRATEGY.md) for visual and release constraints.
