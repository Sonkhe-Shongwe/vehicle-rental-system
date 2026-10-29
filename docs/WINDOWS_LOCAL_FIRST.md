# Local-first Windows Qt acceptance — no GitHub Actions required

**Status:** helper **staged only** on the separate non-PR optimisation branch; Windows runtime execution is **not yet verified**. Do not confuse its evidence with physical Windows acceptance.

## What it does

`tools/local_windows_acceptance.py` uses **local Git archive** to export the committed feature-branch source into a brand-new, separate directory, copies only `demo/vehicles.txt` and `demo/rentals.txt` to that disposable source folder, and records the exact source Git SHA. It refuses existing output paths and source-tree output paths. It does **not** copy untracked or ignored operational files. No `git push`, remote requests or GitHub Actions are involved.

It can then configure and build using the selected Windows Qt desktop kit, run CTest including the real Qt GUI lifecycle, optionally capture and PNG-validate ten real Qt *offscreen* screenshots and compare demo fixture SHA-256 before/after. Logs and a `RESULT.json` report go to the disposable workspace. It generates a Markdown checklist covering the physical Windows desktop gates, which **must be completed manually**.

## Run on your Windows computer

Use **Python 3.10+ and Git**. For the automated CMake/CTest path, install **Qt 6 desktop**, CMake and Visual Studio 2022 C++ tools, with a matching Qt MSVC2022_64 kit. Open a terminal with the appropriate compiler environment. A separate Qt Creator local-build path is available if terminal CMake cannot locate Qt.

Start in a **local clone** of the repository. Run the following from its root. `git fetch` and `git switch` do **not** use GitHub Actions minutes. The switch uses a **detached read-only review position**; it will refuse to replace incompatible local working-tree modifications, so save any personal work first:

```powershell
git fetch origin
git switch --detach origin/docs/ci-budget-development-strategy-20261029
git rev-parse origin/feature/qt-hybrid-visual-spike-20261029
py -3 tools/local_windows_acceptance.py --prepare-only
```

If you do not have the repository locally yet, first clone `https://github.com/Sonkhe-Shongwe/vehicle-rental-system.git` and open the cloned folder in your terminal. The helper itself runs from the staging branch but exports the **separate Qt review branch**, not the workflow-staging branch.

The command prints a newly created workspace, usually `%USERPROFILE%\VehicleRentalReviews\acceptance-<timestamp>`. Open its `source/CMakeLists.txt` in Qt Creator and build using your compatible Qt 6 desktop kit. Ensure the application's **working directory is the disposable `source` folder** (Qt Creator → Projects → Run settings). The app's source-adjacent data paths then reference only fake records. Do not open or modify the original checkout's `vehicles.txt`/`rentals.txt`.

For a complete local build and automated functional regression in an appropriate Windows CMake/Qt environment:

```powershell
py -3 tools/local_windows_acceptance.py --qt-prefix "C:\Qt\6.8.3\msvc2022_64" --screenshots
```

Adjust the Qt prefix to your installed version and compiler kit. With Ninja/MinGW or a compatible alternative, use `--generator Ninja` and launch from that kit's configured terminal. Do not mix MSVC and MinGW Qt libraries.

**Important:** this helper is still on the isolated optimisation branch, and its default `--ref` is the remote-tracking **`origin/feature/qt-hybrid-visual-spike-20261029`**. Use `git fetch origin` to update that ref before preparing your disposable acceptance workspace. The script records the exact source SHA. It does not merge anything, run GitHub Actions or modify the original checkout. A locally created feature branch can instead be selected with `--ref feature/qt-hybrid-visual-spike-20261029`.

## Evidence and completion

Inspect `RESULT.json`, the individual `logs/` files, optional `screenshots/`, and `MANUAL_WINDOWS_ACCEPTANCE.md`. A local CTest pass does **not** mean real Windows 100%, 125%, 150% OS scale, mouse/keyboard, live resize, modal Escape, or visual quality have been accepted.

**Non-negotiable:** use isolated fictional records, retain exact tested commit SHA, complete the real native manual checklist with observed results, and obtain explicit owner approval before moving Draft PR #4 out of draft or merging. Report unsupported or failed local steps truthfully rather than claiming success.

**Progress / CI allowance:** This enables useful verification without GitHub Actions while the owner-reported limit is in effect. The staged CI redesign and full Linux/Windows independent hosted release gates still require later verification before merge.
