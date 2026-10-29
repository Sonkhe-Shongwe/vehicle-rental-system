# Testing Policy and Evidence — Product Rebuild

**Decision date:** 29 October 2026  
**Status:** new testing policy; **no new presentation code tested**.  
**Governing source:** [Master Rebuild Audit](PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md).

## What is actually verified, and what is not

**Historical Qt Widgets source only:** exact implementation/photo revision be184b6 has:
- [Ubuntu/Qt6/GCC run 40944222722](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222722): build, CTest **2/2**, ten genuine compiled Qt offscreen captures.
- [Windows Server 2022/MSVC2022/Qt6.8.3 run 40944222486](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222486): build, CTest **2/2**, **20** genuine compiled Qt offscreen screenshots across five screens, two standard sizes and synthetic 125/150% QT_SCALE_FACTOR rendering, original demo fixture SHA-256 unchanged.
- Existing tests cover domain lifecycle, duplicate booking rejection, restart, no/decline confirmation, some keyboard input, status contrast and geometry.

**Not verified:** rebuilt QML UI (doesn't exist), real native Windows Qt Creator human interactions, physical 100/125/150% Windows display scale, redesigned full-page visual quality, final photography, installer, migrations, production recoverability or owner signoff.

The prior detailed test results are preserved **exactly** at [Historical Qt Testing](archive/TESTING_QT_WIDGETS_PRE_RESET_2026-10-29.md). Do not reframe those runs as acceptance of future code.

## Testing pyramid for the new presentation

1. **Pure domain and use case tests:** availability, pricing, date handling, unique identifiers, create/return/archive/delete state transitions, invalid values and persistence on failure. Deterministic fictional data.
2. **Application boundary/model tests:** QAbstractListModel and exposed QObject properties/commands if QML selected; correct selection/filter, date/price binding, signal emissions, non-mutating cancel and error messages.
3. **Real UI interaction tests:** Qt Quick Test / QTest as appropriate for chosen stack; Gallery↔Table state preservation, drawer, keyboard, stepper validation, rental review and return. Test actual compiled UI, not a browser concept.
4. **Visual/state checks:** screenshot comparison at controlled platform/size/font versions, geometry/visibility, long text, state variants, source image appropriateness. PNG CRC alone is insufficient; human design review mandatory.
5. **Physical Windows acceptance:** actual Qt Creator kit and native monitor scale. Record screenshots and observed issues locally; no fake passing rows.
6. **Cross-platform independent CI:** CMake + domain/UI tests on Linux/Windows (when Actions/account allowance permits) on the exact build candidate, never inferred from a previous SHA.

## Minimum functional parity

- Add Car/Motorcycle; generated unique IDs; duplicate and invalid input rejection.
- Fleet search/filter and correct available/rented status; selection reflected in both Gallery and Table.
- Same-day 1–365 day rental; correctly recomputed quote, duplicate booking refusal, future due date and restart persistence.
- Return existing rental; reject double return; archive only returned; delete only archived.
- Declined or Escape-confirmation actions leave in-memory state **and on-disk files** unchanged.
- Invalid/failed data write produces visible actionable error; do not silently claim success.
- No personally identifying user data in tests, assets, screenshots, PR artifacts or build logs.

## CI usage and source management

No Actions runs for documentation-only updates while owner-reported usage limit is unresolved. This repository is public (normal standard GitHub-hosted runner cost may differ from account-specific limits), so identify the actual notice before asserting quota exhaustion. Do local Qt Creator/CMake/CTest first. Staged [CI optimisation branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/docs/ci-budget-development-strategy-20261029) includes artifact-first screenshots, conservative docs-only CI classification, concurrency and local Windows helper; **staged only, not hosted-tested or integrated**.

## New evidence record per significant change

| Field | Value |
|---|---|
| Commit SHA | exact source to reproduce |
| Date, kit, Windows version, physical scale | actually observed |
| Test commands | real commands, with pass/fail |
| Evidence | log / screenshot / artifact (fake data only) |
| Behaviour and UX states inspected | explicit positive + negative cases |
| Blockers | unverified or failed gates |
| Owner visual approval | explicit yes/no, not inferred |
| Branch status | whether merged/released |

**Release condition:** all required tests, actual Windows acceptance, aesthetic signoff and separately validated persistence/migration. The new UI does **not** inherit acceptance from old Qt Widgets screenshots.
