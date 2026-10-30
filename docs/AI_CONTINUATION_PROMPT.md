> **30 October 2026 precedence update:** The owner has now selected the expanded nine-page Rental Studio PDF as our visual direction. Read [owner-selected theme contract](../design/r1/OWNER_THEME_DIRECTION_2026-10-30.md) before new design work. Use navy `#17324D`, teal `#0F766E`, cloud-white canvas `#F6F8FA`, ice-blue sidebar `#EAF0F4`, mint quote `#E8F5F0`. The previous prompt's "no approved palette" statement is **superseded**, but whole-product design approval and Windows Qt Quick feasibility are STILL OUTSTANDING. Do not implement pending bookings/draft saves from illustrative UI components.

# AI Continuation Prompt | Vehicle Rental System 2.0

**Reconciled 30 October 2026.** This prompt supersedes the Qt Widgets redesign continuation previously published on main. Read the live records before acting; it does not approve a new design or a full rewrite.

## Copy-ready continuation instruction

Continue the public C++ Vehicle Rental System from `Sonkhe-Shongwe/vehicle-rental-system`, under the newer **Vehicle Rental System 2.0 Full Engineering Masterplan**. First fetch and review, at their current heads:

- `docs/product-rebuild-reset-20261029/docs/AI_HANDOFF_CURRENT.md`
- `docs/product-rebuild-reset-20261029/docs/ENGINEERING_MASTERPLAN_RESEARCH_2026-10-30.md`
- `docs/product-rebuild-reset-20261029/docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md`
- `docs/product-rebuild-reset-20261029/docs/ROADMAP.md`, `ARCHITECTURE.md`, `TESTING.md`
- `design/V4_RIVIAN_ARC_TIDE_REFERENCE_BREAKDOWN_2026-10-30.md` and `design/DESIGN_SPEC.md`
- Current **Issue #5** and its latest comments. Treat Issue #2 and Draft PR #4 as historical Qt Widgets evidence, not the active product gate.

**Authority order:** explicit latest owner decisions and Issue #5 > current product reset handoff and source audit > proposed masterplan gate sequence > old Qt acceptance handoff and archived documents. The masterplan is a **research proposal**, not accepted architecture, design or permission for all its phases. Always verify branch HEADs and Actions rather than relying on dated hashes.

**Approved product structure:** Overview, Fleet with synchronized Gallery/Table and contextual details drawer, and Rentals with guided Vehicle > Customer > Review, Active, History and Returns. Preserve existing C++ business outcomes, private data, cancellation non-mutation and rollback even when implementation changes.

**Current design gate:** G1 / R1 remains **IN REVIEW**. The old graphite/lime Qt Widgets style, white-heavy V1/V2 concepts and generic blue V3 identity were rejected. The latest research direction is **vehicle-first, medium-light tonal depth and purposeful motion**, informed by Rivian, Arc and Tide Guide. The exact layout, typography, palette, imagery and motion are **not approved**. Do not create further mockups or begin a QML rebuild before the owner has reviewed the V4 design-reference principles. Once reviewed, compare two cohesive grey-tone concepts across all workflows at 1500x860 and 1280x720, including keyboard, empty, error and unavailable states, then seek explicit whole-system visual approval.

**Technology:** Qt Quick/QML + typed C++ models is a candidate, not a proven or final toolkit. After design approval, validate the installed real Windows Qt Creator kit with an isolated QML/C++ gallery/table/selection/drawer proof. Retain old Qt Widgets source and tests as a regression reference. Then build a narrow persisted Corolla rental vertical slice before complete feature parity. Separately evaluate stable IDs, integer-cent currency, AppLocalDataLocation, safe SQLite migration and packaging. Do not conflate immediate rentals with future reservations or booked amounts with payments.

**Verification:** exact-source CMake/CTest, model/UI tests, disposable fictional demo records, persistence and restart, declined actions, failed writes, native Windows mouse/keyboard and physical 100/125/150% DPI. Historic Widgets CI does not validate the future QML UI. Account-specific Actions availability is unverified; prefer local testing and avoid triggering unnecessary workflows. Do not weaken tests or publish private records.

**Git safety:** stable `main` and historic Draft PR #4 remain unmerged. The active planning/documentation branch is `docs/product-rebuild-reset-20261029`, not the obsolete Qt feature branch. Open a separate, clearly described review branch for any future product code after the relevant gate; preserve traceability to the actual base SHA. Never merge or claim portfolio readiness without explicit owner sign-off.

**Reporting:** distinguish proposed, implemented, locally tested, independently CI-tested, visually reviewed, owner-approved and released. For each verified increment record actual commit, platform, result and unresolved gates in the current handoff/continuity/test records and Issue #5. Work one accepted gate at a time; do not repeat completed research or invent design approval.

## GitHub facts at reconciliation (not immutable pointers)

- Product-design/planning branch: `docs/product-rebuild-reset-20261029`, **pre-correction** head `a09c08d3f5a7bd72673b073a06af90374efe5482`.
- Historical unmerged Qt Widgets Draft PR #4 head: `d1704ec3174b765e3dc82ff03a5531f09e8b507e`.
- Latest observed stable `main`: `9bfca8786af1c64b0284a5a1bb3e2186573147a4`. Earlier reset notes cite old merge-base `64aac966631b262c8ced123f932496518ec9872e`; **do not mistake it for live main**.
- Most recent Qt review Linux Actions success at old head: [40944788568](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944788568). Historical Windows MSVC/Qt6.8.3 success for preceding application/photo revision `be184b6`: [40944222486](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222486). No current Gate G1 owner approval or G2 QML runtime test exists.

**Important:** This is a governance/continuity document. No production changes or new test passes are implied.
