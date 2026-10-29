> **Local-first delivery preparation (29 October 2026):** To reduce reliance on Actions, `tools/local_windows_acceptance.py` and [Windows Local-First Guide](WINDOWS_LOCAL_FIRST.md) are now staged. They create a disposable Git-exported source copy with fictional records, offer local CMake/CTest and ten screenshots if Qt/compilers exist, and write a manual physical acceptance checklist. **Not yet run on real Windows, so still pending verification.** No source app code or workflows touched in this increment.

> **Staging checkpoint 2 (29 October 2026, NOT hosted-run verified):** Commit [b6a8e2b](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/b6a8e2b9784d24f4bdffc0b04363cf1ed2513e20) prepares three workflow changes and a pure-Python classifier, *only* on this non-PR branch. The existing always-reported PR job `build-test` is preserved. A known Markdown-only PR diff skips **Qt installation, configuration, compilation and CTest only**, not fixture hygiene or the existing screenshot-integrity check. Code, asset binaries, tests, workflows, ambiguous diffs, failed Git comparisons and all `main` pushes still request the **full** Qt suite. Development PR CI and Linux screenshot pushes cancel obsolete runs; Windows workflow push runs cancel their predecessors, while manual Windows acceptance runs have their own unique group and are never cancelled by push concurrency. README-only edits no longer trigger the expensive Linux capture workflow; image-credit Markdown does not trigger Windows screenshot CI. Static source audit and local Python classifier tests (documentation-only, mixed code, main push, invalid revision, empty diff) passed; **these are not GitHub-hosted execution results**. No changes are in PR #4 or `main`. Budget reset on 1 November remains expected but **not yet verified**. Promotion must include actual required-check and screenshot workflow verification and a final manual Windows acceptance gate.

# Engineering Workflow Strategy: Fast Progress, Full Quality

**Project:** Vehicle Rental Management System (C++17, Qt Widgets, CMake, CTest)  
**Decision date:** 29 October 2026  
**Status:** **Agreed operating approach; CI refactor is PLANNED, not implemented.**  
**Primary development branch:** `feature/qt-hybrid-visual-spike-20261029`  
**Draft PR:** [#4](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/4) · **Tracking issue:** [#2](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/issues/2)  
**Protected boundary:** `main` stays untouched; do not merge the draft before actual acceptance.

> **Implementation staging update | 29 October 2026:** The first screenshot-workflow optimisation is now **PREPARED ON THIS NON-PR DOCUMENTATION BRANCH ONLY**. Its `.github/workflows/qt-visual-review.yml` retains Qt CMake/CTest, publication-link validation and all ten compiled-Qt renders; replaces the branch-writing screenshot bot with a ten-PNG, 14-day Actions artifact; restricts repository token permission to `contents: read`; and disables persisted checkout credentials. Source-level checks confirmed exactly ten generated/captured filenames and no remaining `git push` or `git commit` commands. **NOT HOSTED-CI-VERIFIED, NOT IN PR #4, NOT MERGED.** The existing checked-in screenshot gallery stays unchanged until a deliberate curation action. Promotion and Linux Qt verification must wait for confirmed Actions availability after the reported 1 November renewal. This staging does **not** change the always-on `ci.yml` pull-request trigger, Windows workflow, or branch-protection requirements.

## 1. Why we are changing the process

We want faster, repeatable software delivery **without reducing safety, functionality, security, portability, data protection or product quality**. Our previous approach proves the value of tests but repeats remote builds, auto-commits screenshot files, and copies the same progress report across many documents.

GitHub Actions usage is a real operational constraint: the **project owner reports that the Actions usage allowance/limit has been reached and is expected to renew on 1 November 2026**. This is a **user-reported account/billing condition**, not independently confirmed with GitHub's billing API. Do not infer that GitHub is banning the account or guarantee the quota will be restored on that date. Check the account's actual Actions availability before resuming CI.

**Critical repository detail:** `.github/workflows/ci.yml` uses `pull_request:` without a path filter. **Even documentation-only commits to the open PR branch can cause CI to run.** The Qt visual and Windows workflows have narrower path filters, but they do not eliminate this general PR trigger.

This strategy is recorded on a **separate docs-only branch without a PR** to avoid triggering the current PR checks. Its eventual transfer to the active PR must occur only when budget is confirmed and verification is permitted.

## 2. Temporary Actions-budget protection (through 31 October 2026)

- **Do not commit to the active PR branch**, run `workflow_dispatch`, rerun failed jobs, touch workflow files, or trigger a rebuild simply to update status during the reported usage-limit window, unless the owner explicitly authorises an exception.
- Use GitHub source inspection, architecture review, coding plans, test-case design, static validation and available **local** Qt Creator/CMake tests. Only claim a local test ran if it actually ran; if no configured local Qt toolchain is available, mark the change **UNVERIFIED**.
- For review documents, prefer a separate **non-PR documentation branch** or Issue #2 comment. A PR comment does not itself change source. Do not update `README.md` or the active PR head merely for documentation.
- Prepare related fixes and photographic candidates together, but keep them logically separated into reviewable changes. Maintain fictional-data-only handling and verify image licence, source, model appropriateness and hashes.
- Preserve the current verified evidence; do **not** turn off required checks, fake successful CI runs or merge unverified code.

**Re-entry trigger:** On or after **1 November 2026**, first check GitHub Actions billing/usage and repository run availability. If still limited, continue the no-CI process. Do not start multiple trial builds just to detect whether the restriction has lifted.

## 3. Standard development lifecycle for all future software projects

| Step | Output | Fast-quality rule |
| --- | --- | --- |
| **1. Scope** | One bounded requirement and a written acceptance contract | Identify changed files, invariants and expected failure cases before coding |
| **2. Inspect** | Exact source names, interfaces, expected labels, existing tests and dependencies | Avoid test failures caused by guessed UI titles, object names or hidden widgets |
| **3. Implement** | Small, coherent and reversible code change | No unrelated refactor, unapproved dependencies or alternate business logic |
| **4. Fast feedback** | Relevant local/static checks and targeted tests | Iterate locally where executable; report unexecuted checks honestly |
| **5. Integration** | Linux + Windows verified exact source revision | For functional C++ changes, both hosted platforms before acceptance |
| **6. Visual review** | Real Qt captures, critical geometry/state assertions and visual comparison | A structurally valid PNG is **not** proof of a visually correct UI |
| **7. Approve** | Explicit owner acceptance, known limitations and release decision | No automatic PR merge, no implied manual Windows signoff |
| **8. Record** | Concise result with tested SHA, links and remaining blockers | One authoritative current state, historic detail in an archive |

A development batch is complete when its **applicable checks are green** and unresolved risks are stated. Do not call a full milestone complete until **all mandatory acceptance gates** pass.

## 4. Risk-based verification, without reducing the final gate

| Change type | Immediate feedback | Integration rule | Final milestone gate |
| --- | --- | --- | --- |
| Docs and comments only | Markdown, links, spelling, technical consistency | Avoid expensive build unless docs affect generated software or a required check must run | Existing required status rules must remain valid |
| C++ domain / persistence | Focused domain tests, rejected actions, file-state comparisons | **Linux + Windows CMake/CTest mandatory** | Full lifecycle, real data-safety and regression evidence |
| Qt interactions / keyboard / navigation | Relevant GUI test, controls and modal/focus assertions | **Linux + Windows Qt build/CTest mandatory** | Full keyboard/mouse, cancellation and persistence coverage |
| Layout, style and resources | Geometry, pixel dimensions, local Qt resource decode, source licence | Both platforms for changed Qt sources/assets | Baseline visual comparison at target sizes/scales and owner review |
| Build, workflow or dependency changes | Parse/validate configuration, inspect permissions and triggers | Test the actual affected platform/workflow | Full pipeline and branch-protection review |
| Final acceptance / merge | All required checks | **Full Linux and Windows suites** | Manual native Windows 100/125/150% scaling, live resize, accessibility, licences and explicit owner signoff |

**Never waive** double-booking rejection, safe return/archival/deletion, cancellation non-mutation, persistence/restart, validation and fictional-data isolation because a change appears small.

## 5. GitHub Actions redesign, to implement after budget renewal

### A. Stop CI from pushing screenshot commits

- Change Linux visual CI to upload screenshots through `actions/upload-artifact` instead of pushing every 10-image capture back to the PR branch.
- Give normal testing workflows **read-only repository permissions**; isolate rare, intentionally approved publishing actions with least privilege.
- Compare changed screens with known **approved** baselines, using consistent platform, Qt version, fonts, dimensions and scale. Treat image-diff thresholds as a review aid, not proof of correctness.
- Commit final curated image assets and only explicitly approved permanent gallery screenshots. Temporary evidence lives in CI artifacts with stated retention.

### B. Preserve predictable mandatory PR checks

- Audit `ci.yml`, visual and Windows workflows, branch protection and required status names **before** altering triggers.
- Keep a small, stable, always-reported required PR status. Conditionally run expensive work for code/resource changes; avoid a completely skipped required workflow becoming permanently pending.
- Use `concurrency` to cancel obsolete **development** runs of the same ref/workflow, while preserving final acceptance runs and evidence.
- Avoid self-triggering commits from CI, accidental recursive jobs, and duplicate full builds on documentation edits.

### C. Improve build and test cost only when measured

- Introduce suitable `CMakePresets.json` for reproducible local, Linux and Windows configurations, retaining machine-specific Qt paths outside tracked presets.
- Prefer incremental local compilation for developer feedback; keep clean CI builds as release verification.
- Evaluate compiler/dependency caching based on measured elapsed time, not guesswork. Windows Qt dependency caching already exists.
- Split the monolithic real Qt lifecycle CTest into independent, isolated cases (navigation, validation, rental, return, cancellation, archival, persistence, geometry) while retaining one complete end-to-end smoke test. Consider Qt Test/`QSignalSpy` for deterministic GUI interactions.
- Add compiler warnings and appropriately scoped static analysis, without introducing an unbounded CI minute burden.
- Pin third-party workflow actions to reviewed immutable revisions when practical, and minimise workflow token permissions.

**Implementation order:** First remove screenshot self-commits and ensure status checks remain dependable; then add concurrency; then refine test selection and build presets; then introduce visual diffs and additional static analysis. Test each workflow change rather than implementing all changes blindly in one giant untested commit.

## 6. Evidence and continuity policy

Keep documentation focused and audit-friendly:

- `docs/AI_HANDOFF_CURRENT.md`: short live state, current code SHA, latest successful Linux/Windows evidence, active risks, next action and link to this policy. It must not become an ever-growing history dump.
- `docs/CONTINUITY.md`: dated decision and progress history, appended only for meaningful milestones, incidents or verified results.
- `docs/TESTING.md`: what is tested, actual CI runs, untested boundaries and how to reproduce.
- `docs/ROADMAP.md`: next deliverables, priorities, exit conditions. Do not duplicate CI logs.
- PR #4 and Issue #2: one concise material update per accepted batch, with links to the canonical record, rather than duplicate paragraphs in every location.

Always distinguish **implemented**, **locally tested**, **CI verified**, **visually inspected**, **owner approved**, and **merged/released**. Do not say CI was green for a document-only commit merely because an earlier code commit passed, and do not treat simulated DPI as physical Windows verification.

## 7. Current Qt milestone: finish rather than expand indefinitely

**Active and exclusive phase:** Qt Widgets redesign acceptance, not SQLite, API, browser UI or cloud. Provenance-reviewed Ford Ranger front-three-quarter photo is now in Draft PR #4; its showroom setting and China-market registration remain aesthetic caveats. Corolla composition and Honda/Yamaha photos still need licensed source review.

Remaining **release blockers**:
1. Actual Windows Qt Creator use with safe disposable/fake records, mouse, Tab/Shift+Tab/Enter/Escape, focus, No/cancel and return/rental lifecycle.
2. Genuine Windows **100%, 125%, 150%** OS display scale and live drag-resize, with explicit observation of clipping and focus visibility.
3. Final suitable model photographs, visual comparison and licence/source record, plus **explicit owner aesthetic signoff**.
4. Final full Linux + Windows CI on the exact candidate revision and approval to merge Draft PR #4.

Do not convert the milestone into an endless stream of small speculative aesthetic changes. Research images in one shortlist, validate their provenance, review selected candidates together, then run a cohesive Qt visual acceptance batch.

## 8. Baseline and effectiveness measures

Observed recent hosted run durations (GitHub Actions creation-to-update, **not just compilation**): Linux visual **64 seconds** and Windows Qt **122 seconds** for the Ford photo revision; an earlier Windows run took **136 seconds**. Parallel jobs are bounded in wall-clock time by the slowest required check. These are examples, not guaranteed future timings.

Track for the **next three meaningful completed increments**:
- Avoidable CI failures from incorrect expected text/object names; target zero.
- Full CI executions per accepted batch; ideally one successful integration round, with failures fully reported.
- CI-pushed screenshot commits; target **zero** for normal verification.
- Actual elapsed feedback time, build/queue time, and GitHub Actions minutes (measure separately).
- Number of duplicate continuity updates and drift between handoff/roadmap.
- Domain, persistence and UI regression pass rates; **never** reduce mandatory coverage.
- Manual acceptance gates completed vs still open.

**Do not claim a guaranteed percentage time saving.** A 30–50% coordination/rework reduction may be a hypothesis to test, not a measured benefit.

## 9. Adoption record and next action

This document records the **agreed strategy**, not a claim that CI configuration was already changed. As of 29 October 2026, active PR #4 and `main` remain untouched by this documentation. Our user-reported Actions usage-limit constraint takes precedence over routine pushes until the expected 1 November renewal is checked.

**Next concrete action after confirming allowance:** integrate this document into the active PR, replace automatic screenshot commits with artifacts, establish cost-aware required checks, and verify the new CI design. Then finish the Qt visual and native Windows acceptance batch. Maintain the existing code, domain invariants and test coverage throughout.
