# Development Roadmap - Deadline: 30 October 2026

Goal: credible, demonstrable graduate software engineering project. Preserve existing Qt workflow. Prioritize evidence and correctness rather than speculative features.

**29 October update:** P0A source and sanitized screenshots have been published; GitHub Actions Qt 6 Linux build, hygiene check and CTest **passed** ([run 40872123623](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/40872123623)). Windows Qt Creator GUI verification remains outstanding.

| Priority | Work package | Why now | Acceptance gate |
| --- | --- | --- | --- |
| P0A - Today | Publish sanitized complete source, README, screenshots and `.gitignore` to GitHub. | Empty repository fails recruiter inspection; real rental records cannot be public. | Public tree shows CMake, sources, docs, tests and only safe fixtures. |
| P0B - Today | Run Qt build and CTest on Windows with Qt Creator. Correct any compilation/test failures. | All source-level changes are unverified until executed. | CMake configure + build + `ctest` green; report kit/version and test output. |
| P0C - Today | Smoke test add, search, rent, double-book rejection, return, archive, delete, restart, and storage failure with a disposable dataset. | Protect original functionality. | Evidence in `docs/TESTING.md` or a dated test log; no personal records. |
| P0D - Today | Display safe screenshots and include concise CV-ready project description. | Recruiter can judge user-facing product quickly. | Screenshots accurate, hyperlinks work, documented scope truthful. |
| P1 - Next | Replace source-directory persistence with Qt application-data path and safe migration/backups. | Installability and data protection. | Upgrade from old data preserves full records, old files are untouched. |
| P1 - Next | Make parsing errors explicit and retain originals before migration. | Silent invalid-row dropping risks history integrity. | Malformed records produce actionable diagnostics; no discarded source. |
| P1 - Next | Add durable monotonically increasing ID allocation and money in integer cents. | Avoid identity reuse and floating-point financial drift. | Test deletion/restart/id reuse and monetary edge cases. |
| P2 | Introduce SQLite and transactional fleet/rental storage. | Atomic state changes, relational data modelling, SQL skills. | Rollback, unique constraints, foreign keys and transaction tests pass. |
| P2 | Split large `MainWindow` into presentation widgets/view-models and a service/repository layer. | Maintainability and separation of concerns. | Existing user journeys have parity tests. |
| P2 | Expand tests, code formatting, static analysis, Windows CI or reproducible manual Windows matrix. | Quality and review readiness. | Green repeatable pipeline and published commands/results. |
| P3 | Optional REST API, API contract and a small browser UI. | Full-stack relevance to Retipuj Zoft, **only after** reliable core. | Independent API tests, access validation and working integration demo. |
| P3 | Packaging and signed release considerations. | Distribution and deployment. | Clean Windows installation and startup tested. |

## What not to attempt before the application deadline

Do not rewrite the project in React, add cloud AI, or claim a REST API without a verified implementation. A polished smaller project with passing tests has stronger interview credibility than a wide feature list with failing builds.

## Mapped job criteria

- Programming fundamentals: C++17 domain logic and polymorphism.
- Software design: separation between Qt GUI, rental service and domain models.
- Debugging/problem solving: explicit audit defects, regression fixtures and reproducible correction notes.
- Testing: standalone CTest domain suite and manual GUI checklist.
- Databases / APIs: currently **not implemented**; planned architecture evolution, not CV keywords for the current app.
- Git and teamwork: public repository history, reviewable changes, documented decisions, CI (green on Linux Qt 6, with Windows interactive verification pending).
- Deployment: reproducible CMake/Qt Creator build instructions; standalone installer still planned.
