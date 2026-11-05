# Rental Studio 2.0 | Everyday live-source development without recurring ZIP downloads

**Decision:** 5 November 2026. **Owner concern:** 30–50 MB GitHub Actions QA downloads after every small front-end change are cumbersome. **New default:** source pull in GitHub Desktop, then local Run in existing Qt Creator 6.10.2 MinGW setup.

## What to do after every new design commit

1. Open **GitHub Desktop**, select repository **`Sonkhe-Shongwe/vehicle-rental-system`**, and verify **Current Branch** is **`feature/p7-sqlite-sandbox-20261102`**. Do not switch to `main`, merge PR #17 or discard local work.
2. Check the **Changes** tab for your own uncommitted changes; commit or stash those before pulling. Click **Fetch origin**, then **Pull origin** only when the branch has updates.
3. Open the existing Qt Creator project. If never configured, **File → Open File or Project → repository-root `CMakeLists.txt`**, using **Desktop Qt 6.10.2 MinGW 64-bit** kit. Qt Creator must build the **`rental_studio_qtquick_spike`** run target, not the older Widgets app.
4. Use the existing **`rental-studio-local`** CMake preset if Qt Creator exposes it, otherwise check the equivalent settings: `BUILD_QTQUICK_P2_SPIKE=ON`, `BUILD_TESTING=ON`, `BUILD_P7_SQLITE_SANDBOX=ON`. The local build directory stays **`build/rental-studio-local`**, which is Git-ignored. The SQLite Lab remains opt-in fictional-only, not production persistence.
5. Press **Build/Run** (typically **Ctrl+R** in Qt Creator). GitHub Desktop updates the source; Qt Creator then compiles and runs those updated files. It does **not** automatically pull Git commits or install the hosted Windows executable, so repeat Fetch/Pull when a change is announced.
6. If the GUI appears unchanged, verify the working branch, the latest commit in GitHub Desktop, the `rental_studio_qtquick_spike` run configuration and the selected MinGW kit. Let Qt Creator reconfigure if CMake QML_FILES changed. Reuse the same build directory where possible; do not indiscriminately reset or clean the repo.

## How visual review works now

- **Routine changes:** the assistant commits a named bounded source increment, checks hosted GitHub Actions and gives the commit link plus small *individual* screenshots where useful. **No ZIP download is needed.**
- **Owner review:** pull once in GitHub Desktop, press Run in Qt Creator, and inspect the real current GUI. Describe issues or attach a screenshot directly. This is the source of truth for the actual Windows MinGW kit.
- **Hosted review:** GitHub Actions continues to run Linux GCC + Windows MSVC native CTests and capture actual QML screenshots. Open the run details online. Hosted screenshots remain optional and are not a substitute for physical review.
- **Occasional portable QA build:** use the larger `p2-windows-physical-acceptance-kit` ZIP **only for major milestones**, when another computer needs a self-contained executable or when explicitly requested. A ZIP is not a certified installer.
- **If your local Qt Creator project is not working**, use the older detailed setup and troubleshooting guide at [LOCAL_QT_CREATOR_WORKFLOW_AND_SCRIPT_AUDIT_2026-11-04.md](LOCAL_QT_CREATOR_WORKFLOW_AND_SCRIPT_AUDIT_2026-11-04.md).

## Boundaries and safety

The Git working tree, protected five-record fixtures, compiled app and GUI source are distinct from the separately hosted portable QA ZIP. Never replace `demo/vehicles.txt`, `demo/rentals.txt` or real customer records just to reproduce a screenshot. Ordinary Pull on this feature branch does not merge `main`. If Pull reports conflicts, **stop and inspect changes**, do not run `git reset --hard` or `git clean -fdx`. No installer, deployment, background auto-updater or direct remote access to the owner's Windows desktop has been added.

**Acceptance:** hosted CI pass is engineering evidence, not an owner physical Qt Creator 6.10.2 MinGW, 100/125/150% OS scaling, Narrator, premium aesthetic or release signoff. Formal owner 45/74 criteria, weighted 70.6%, P7 0/8 unchanged until explicitly accepted.
