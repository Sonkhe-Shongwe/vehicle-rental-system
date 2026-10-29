# Rental Studio — Vehicle Rental Management System (Rebuild in Planning)

**Windows-first C++/Qt desktop application · Existing implementation: Qt Widgets · Candidate rebuild: Qt Quick/QML**

> **Product reset — 29 October 2026:** The owner has rejected the existing Qt Widgets UI's **aesthetic direction**. A new **light-first, warm, sophisticated and genuinely interactive** experience is being designed. The existing executable and functional tests remain valuable reference software, **not an approved visual baseline or released product**. No replacement QML UI has been built or validated. The [master product audit](docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md) records the decisions, risks and future acceptance gates.

## The intended product

A beautiful, approachable local rental-operations desktop experience for a small automotive fleet. The new information architecture has three workspaces: **Overview**, **Fleet**, and **Rentals**.

- **Overview:** real availability, active rentals, upcoming/overdue attention and meaningful activity, rather than a giant generic table.
- **Fleet:** an inviting **gallery-first / table-alternative hybrid**, shared search/filter/selection, model imagery or coherent fallback, contextual vehicle detail drawer and management operations.
- **Rentals:** guided vehicle → customer → quote/review, active contracts, returns, history and archive management; clear validation and durable state changes.

No dark software shell. Proposed visual language: warm ivory and white surfaces, muted sage accents, tasteful editorial hierarchy, meaningful photography and restrained motion. **Final palettes and high-fidelity screens are not yet owner-approved.**

[Full rebuild audit](docs/PRODUCT_REBUILD_MASTER_AUDIT_2026-10-29.md) · [Current experience spec](design/DESIGN_SPEC.md) · [Roadmap](docs/ROADMAP.md) · [Architecture](docs/ARCHITECTURE.md).

## What the existing application actually does today

The unmerged legacy implementation is a functioning **C++17 Qt Widgets desktop app**, not yet the approved new product. It currently provides:

- Register, search, filter and remove cars/motorcycles, with generated IDs and validation.
- Immediate same-day rentals for 1–365 days, calculated quote and duplicate-booking rejection.
- Return, repeat-return rejection, archive of returned rentals and deletion of archived records.
- Fleet/rental views and historical transaction records.
- Single-file atomic saves through QSaveFile and vehicle occupancy derived from the rental ledger during restart.

**Limitations:** source-adjacent text storage, no database transactions, no production packaging, incomplete parsing diagnostics, ID reuse risk, floating-point pricing, no multi-user/auth/payment/API/cloud. "Booked rental value" is **not** cash received.

## Existing implementation evidence (historical / visually rejected)

This project already has **passing automated evidence for the old Qt Widgets code**:
- [Linux run 40944222722](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222722): CMake/CTest 2/2 and ten real Qt screen captures at exact photographed code be184b6.
- [Windows run 40944222486](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40944222486): MSVC2022 / Qt 6.8.3 CTest 2/2 and twenty offscreen/synthetic-DPI captures at the same source revision.

These facts demonstrate the **old implementation's automated checks**, *not* aesthetic acceptance, QML readiness, manual Windows mouse/keyboard, physical 100/125/150% scaling, a successful rebuild, or production release.

[Rejected legacy Qt screenshots and critique](design/qt-spike/VISUAL_REVIEW.md) · [Historical evidence archive](docs/archive/README.md) · [Photo licensing](assets/README.md).

## Build and test the existing reference locally

Use an installed compatible Qt desktop kit, CMake 3.16+ and C++17 compiler. Open **CMakeLists.txt** in Qt Creator and select a matching kit. From a correctly configured terminal:

    cmake -S . -B build -DBUILD_TESTING=ON
    cmake --build build --config Release
    ctest --test-dir build -C Release --output-on-failure

Tests use disposable QTemporaryDir data. To inspect the normal GUI, use a **separate source checkout** seeded only with demo/vehicles.txt and demo/rentals.txt, and configure the run working directory carefully. The legacy default data location is **source-adjacent**, so never launch it from a folder containing real customer records. On Windows, consult [safe acceptance guidance](docs/WINDOWS_ACCEPTANCE.md). Do not mistake QT_SCALE_FACTOR screenshots for physical Windows OS DPI.

## Roadmap and development policy

- **Now:** plan and explicitly approve one coherent high-fidelity multi-screen design, including Overview, Fleet Gallery/Table, Drawer, New Rental, Active, History, Return, errors and responsive states.
- **Next:** independently prove a small Qt Quick/QML plus C++ binding UI on the actual Windows Qt Creator kit, with an alternative if the proof fails.
- **Then:** implement design system, three workspaces and functional parity, followed by separate persistence/packaging decisions and final native Windows plus cross-platform verification.
- The working reference stays recoverable. No automatic PR merge or silent domain regression.

We develop **local-first**. The owner reported GitHub Actions usage-limit concerns with expected 1 November 2026 reset; specific account restriction is not confirmed. A separate [engineering optimisation branch](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/tree/docs/ci-budget-development-strategy-20261029) contains **unintegrated, unverified** CI cost reductions and a local Windows testing helper. This documentation branch deliberately does **not** deploy those workflow changes.

[Draft PR #4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4) remains **draft/unmerged**; stable main has not been altered by the rebuild documentation.

**Do not represent this as an already completed modern rental platform, validated QML app, professional release or approved portfolio showcase.**
