# UX-Q3 | Fleet photo verification status, compact inspector correction, motorcycle candidate shortlist

**3 November 2026. Latest code SHA: [`9c6430503341364382911e1055480ac331cf4d21`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9c6430503341364382911e1055480ac331cf4d21).** Source is present on [Draft PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17), **not merged**. **Status: SOURCE READY FOR CI; native Linux/Windows compilation and 2 new photo tests STILL NOT RUN.** Formal 45/74 criteria, weighted 70.6%, unchanged.

## Source changes since original Q3 staging

- [`256e920`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/256e920f9f00af3b1498f07190063ed39f68cc01) keeps **Change photo** inside the selected Fleet image panel, instead of adding a vertical row that could clip the **Book selected vehicle** action at 1280×720. New actual-Qt photo smoke checks both controls' scene rectangle against window bounds and requires rendered `Image.status == Ready` for both seed C001 and selected uploaded C004.
- [`9c64305`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/9c6430503341364382911e1055480ac331cf4d21) explicitly links **Qt6::QuickDialogs2** to match the new native `FileDialog` QML imports. This is intended to make desktop/runtime dependency and Windows packaging explicit. **Not yet compiled** on any runner.
- Original UX-Q3 source [`a2222b1`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/a2222b1206729bc3b6a3efaecf19edb32739b51a), follow-up [`00cf7ca`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/00cf7ca2bbe3fed74c19e513b7a1ab3889735602), and photo sidecar safety [`daeeab9`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/daeeab937d4a7df8ce93a7b013044f076d030241) remain included. Full initial scope and warnings: [Q3 engineering report](UX_Q3_FLEET_PHOTOS_SOURCE_PENDING_2026-11-03.md).

## GitHub Actions blocker, exact findings, no false green claim

- On 3 November, both the ordinary PR #17 `synchronize` commits and a newly opened [**CI-only draft PR #18**](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/18) from the same exact source received **no corresponding GitHub Actions runs**. The CI-only PR was closed/reopened by the connector to try `pull_request: reopened`, also without a run. It was then aligned to source `9c64305`. The relevant repository workflows explicitly enable PR `opened,synchronize,reopened`; the source classifier runs full tests on reopened.
- **Do not infer 117/117 from two newly registered tests.** The last genuine passing [Qt native run 41517964095](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964095) did **115/115 Linux and Windows**, on old source `8a7a1ed` **before** optional photo imports existed. [Core C++ 13/13](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/41517964414) is also old-code evidence.
- The connector does **not** expose an Actions workflow dispatch/create action; GitHub REST `fetch` allows only GET, and the local work container has **no Qt6 headers, QML runtime or access to the GitHub hosted runner**, so native tests cannot be executed by pretending this environment is Windows.
- **Practical user-initiated verification:** Reopen closed CI-only PR #18 in GitHub under the owner's own account, which should trigger the existing `pull_request: reopened` workflow on the **exact SHA `9c64305`**. If that event is still blocked, inspect the repository's Actions permissions and use a standard manual source push (not force-push) from the owner account on the verification branch, or trigger an allowed Actions run through the GitHub UI if available. Never merge the verification-only PR. Look for **new** core test logs, full native Linux GCC and Windows MSVC CTest logs, and specifically `rental_studio_fleet_photo_wide` and `rental_studio_fleet_photo_compact`.
- Once verified, update this checkpoint with exact run IDs, pass totals, failing/fixed iterations and real Windows screenshots. If compile/runtime or test failures occur, **do not waive tests**; make targeted code fixes and rerun.

## Real model-matched motorcycle photograph candidates, NOT YET SELECTED OR BUNDLED

The source repository currently has three photo candidates from the old licensing audit for C001 Corolla, C002 Ranger and C003 i20. The current Q3 branch attempts to load them as offline illustrative Qt resources (NOT visually approved). Honda M001 and Yamaha M002 intentionally **still use silhouettes**, rather than unrelated web/stock images.

Potential openly licensed exact-model files, from the original [Wikimedia Commons File page](https://commons.wikimedia.org/), checked 3 November 2026:

| Fictional model | Specific candidate (source page) | Creator/license | Editorial caveat / current decision |
|---|---|---|---|
| **M001 Honda CB500F** | [`2021 Honda CB500F.jpg`](https://commons.wikimedia.org/wiki/File:2021_Honda_CB500F.jpg), 1288×1055, photographed at Honda BigWing in Thailand | **Chanokchon**, Creative Commons **CC BY-SA 4.0**; attribution, licence link, and derivative/share-alike duties apply | Accurate model but **2021** year, red model, dealer background; fictitious Fleet seed does not specify year/trim; owner must approve crop and look |
| **M001 alternate** | [`Honda CB500F@Motodays 2017 01.jpg`](https://commons.wikimedia.org/wiki/File:Honda_CB500F@Motodays_2017_01.jpg), exhibition | **Nicholas Gemini**, Creative Commons **CC BY-SA 4.0** | Review stage/background and visual cohesion; no image added yet |
| **M002 Yamaha MT-07** | [`YAMAHA MT-07.JPG`](https://commons.wikimedia.org/wiki/File:YAMAHA_MT-07.JPG), 2464×1784, photographed in 2014 | **Tokumeigakarinoaoshima**, **CC0 1.0** public-domain dedication | Preferred rights simplicity, but year/background/colour may be unsuitable for the final premium Gallery. Owner visual review required |
| **M002 alternate** | [`2021 Black Yamaha MT-07.jpg`](https://commons.wikimedia.org/wiki/File:2021_Black_Yamaha_MT-07.jpg), 3031×1903 | **PackMecEng**, Creative Commons **CC BY-SA 4.0** | Modern black motorbike, potentially better visual consistency; attribution/derivative licence obligations |

**No binary downloads or images committed from these motorcycle sources.** License descriptions are from each File page, not assumptions from an image thumbnail or a search result. Real vehicle year/trim/colour is unknown, so images are **illustrative examples**, not actual rental stock or manufacturer endorsement. The owner must approve final photos/crop and license obligations before P1 photography acceptance.

## Scope still unchanged

All images are fictional-only and offline, with optional local picker and an explicit silhouette fallback. The default Add Vehicle inventory and photo directory are **temporary**, not persistent across full process exit. A business-persistent import/upload mechanism remains a separate future decision; P7 real customer data, retention, backups and SQLite cutover are unapproved. All PRs are draft/unmerged; stable `main` unchanged. **Formal acceptance remains 45/74, weighted 70.6%.**
