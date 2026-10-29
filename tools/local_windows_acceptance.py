#!/usr/bin/env python3
"""Build/test the real Qt application in a disposable Windows workspace.

Requires Python 3.10+, Git, and (for --run-tests) CMake + Qt 6 desktop kit.
No network access, GitHub Actions, source-adjacent customer data, or mutation
of the original checkout. The exported source contains committed files only.

This helper cannot certify real monitor scaling or a person's keyboard review.
"""
from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import zipfile


DEFAULT_REF = "feature/qt-hybrid-visual-spike-20261029"
PAGES = {
    "dashboard": ("--portfolio-screenshot", "--portfolio-screenshot-small"),
    "fleet": ("--portfolio-fleet-screenshot", "--portfolio-fleet-screenshot-small"),
    "rent": ("--portfolio-rent-screenshot", "--portfolio-rent-screenshot-small"),
    "history": ("--portfolio-history-screenshot", "--portfolio-history-screenshot-small"),
    "return": ("--portfolio-return-screenshot", "--portfolio-return-screenshot-small"),
}


def run(command: list[str], *, cwd: Path, log: Path | None = None,
        env: dict[str, str] | None = None) -> str:
    if log is None:
        done = subprocess.run(command, cwd=str(cwd), env=env,
                              capture_output=True, text=True, encoding="utf-8",
                              errors="replace", check=False)
        if done.returncode:
            raise RuntimeError(f"Command failed ({done.returncode}): {command[0]}: {done.stderr[:700]}")
        return done.stdout.strip()
    with log.open("w", encoding="utf-8", errors="replace") as stream:
        done = subprocess.run(command, cwd=str(cwd), env=env, stdout=stream,
                              stderr=subprocess.STDOUT, check=False)
    if done.returncode:
        raise RuntimeError(f"{command[0]} exited {done.returncode}; see {log}")
    return ""


def contained(child: Path, parent: Path) -> bool:
    try:
        child.resolve().relative_to(parent.resolve())
        return True
    except ValueError:
        return False


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def export_ref(repo: Path, source: Path, archive: Path, ref: str) -> str:
    if not ref or ref.startswith("-"):
        raise ValueError("Ref must be a safe local Git branch, tag or SHA")
    head = run(["git", "rev-parse", "--verify", ref + "^{commit}"], cwd=repo)
    run(["git", "archive", "--format=zip", "--output=" + str(archive),
         head], cwd=repo)
    source.mkdir()
    with zipfile.ZipFile(archive) as package:
        for item in package.infolist():
            target = source / item.filename
            if not contained(target, source):
                raise RuntimeError("Ref archive contains path outside temporary source")
        package.extractall(source)
    for name in ("vehicles.txt", "rentals.txt"):
        if (source / name).exists():
            raise RuntimeError("Committed root runtime files unexpectedly present; abort")
        fixture = source / "demo" / name
        if not fixture.is_file():
            raise RuntimeError(f"Missing fictional demo fixture {fixture}")
        shutil.copyfile(fixture, source / name)
    return head


def build_and_test(source: Path, build: Path, logs: Path, args: argparse.Namespace) -> None:
    command = ["cmake", "-S", str(source), "-B", str(build),
               "-G", args.generator, "-DBUILD_TESTING=ON"]
    if args.generator.startswith("Visual Studio"):
        command += ["-A", "x64"]
    else:
        command += ["-DCMAKE_BUILD_TYPE=Release"]
    if args.qt_prefix:
        command += ["-DCMAKE_PREFIX_PATH=" + str(args.qt_prefix)]
    run(command, cwd=source, log=logs / "configure.log")
    run(["cmake", "--build", str(build), "--config", "Release", "--parallel", "2"],
        cwd=source, log=logs / "build.log")
    env = os.environ.copy()
    env["QT_QPA_PLATFORM"] = "offscreen"
    run(["ctest", "--test-dir", str(build), "-C", "Release", "--output-on-failure"],
        cwd=source, env=env, log=logs / "ctest.log")


def capture(source: Path, build: Path, output: Path,
            args: argparse.Namespace, logs: Path) -> int:
    exe = build / ("Release" if args.generator.startswith("Visual Studio") else "") / "VehicleRentalSystem_A3.exe"
    if not exe.is_file():
        raise RuntimeError(f"Expected compiled Windows Qt executable missing: {exe}")
    output.mkdir()
    env = os.environ.copy()
    env["QT_QPA_PLATFORM"] = "offscreen"
    env.pop("QT_SCALE_FACTOR", None)
    count = 0
    for page, switches in PAGES.items():
        for index, switch in enumerate(switches):
            suffix = "wide" if index == 0 else "1280"
            label = f"{page}-{suffix}"
            original = source / "portfolio-qt-review.png"
            original.unlink(missing_ok=True)
            run([str(exe), switch], cwd=source, env=env,
                log=logs / f"screenshot-{label}.log")
            if not original.is_file():
                raise RuntimeError(f"No screenshot produced: {label}")
            dimensions = (1500, 860) if index == 0 else (1280, 720)
            run([sys.executable, str(source / "tests" / "verify_qt_png.py"),
                 str(original), str(dimensions[0]), str(dimensions[1])],
                cwd=source, log=logs / f"verify-{label}.log")
            shutil.move(str(original), str(output / f"{label}.png"))
            count += 1
    if count != 10:
        raise RuntimeError(f"Expected 10 compiled Qt screenshots, got {count}")
    return count


def manual_checklist(output: Path, ref: str, sha: str, status: str) -> None:
    content = f"""# Actual Windows Qt Creator acceptance — operator record

**Source ref:** \`{ref}\`
**Exact source SHA:** \`{sha}\`
**Automated local status:** **{status}** (not a physical-display result)
**Workspace:** \`{output}\`

## Real desktop procedure — use this disposable workspace only

1. Open \`source/CMakeLists.txt\` in **Qt Creator** with a compatible Windows Qt 6 desktop kit; use \`source/vehicles.txt\` and \`source/rentals.txt\` only. Never copy personal customer files. Run the GUI *without* screenshot flags; keep your runtime working directory inside the disposable \`source\` folder.
2. On the actual Windows desktop, repeat the following at **100%, 125%, and 150%** Windows Settings → System → Display → Scale. Sign out or restart the application if Windows requires it. Do not confuse the Qt \`QT_SCALE_FACTOR\` environment variable with native display scaling.
3. On all five pages (Dashboard, Fleet, Rent Vehicle, Rental History, Return Processing), test mouse navigation, drag-resize, the 1280×720 layout and a larger desktop size. Observe text clipping, panel overlap, images and contrast.
4. Check **Tab / Shift+Tab / Enter / Escape** behaviour, focus visibility, modal confirmations and declining/cancelling each destructive action.
5. With fictional data only: Add a vehicle, rent it, reject a duplicate booking, restart, return it, reject a repeated return, archive it, and delete only the archived rental. Confirm expected messages and no mutation after declined actions.
6. Check source credits and suitability of every image. The Ford image is an *illustrative* China-market model; Honda/Yamaha photographs and final design approval remain open.

## Acceptance log — complete each item after personally observing it

- [ ] Qt Creator build and normal app launch succeeded on this Windows PC
- [ ] Native Windows 100% scale: all pages, focus and resize reviewed
- [ ] Native Windows 125% scale: all pages, focus and resize reviewed
- [ ] Native Windows 150% scale: all pages, focus and resize reviewed
- [ ] Mouse, Tab, Shift+Tab, Enter, Escape and visible focus work
- [ ] Rent/return/archive/delete confirmation **No** and Escape preserve records
- [ ] Complete fictional rental lifecycle and persistence after restart work
- [ ] Image licensing, visual crop, model disclosure and final aesthetics reviewed
- [ ] User has **explicitly approved** this Qt milestone

**Observations / defects / environment (Windows version, Qt kit, DPI):**

**Final approval:** PENDING. **Do not merge** PR #4 on the basis of generated captures alone.
"""
    (output / "MANUAL_WINDOWS_ACCEPTANCE.md").write_text(content, encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description="Isolated Windows Qt acceptance workspace; no GitHub Actions")
    parser.add_argument("--repo", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--ref", default=DEFAULT_REF, help="Local Git ref of the Qt review branch")
    parser.add_argument("--output", type=Path, help="New, previously nonexistent workspace path")
    parser.add_argument("--prepare-only", action="store_true", help="Export fictional project only; open in Qt Creator")
    parser.add_argument("--qt-prefix", type=Path, help="Qt desktop CMake prefix e.g. C:/Qt/6.8.3/msvc2022_64")
    parser.add_argument("--generator", choices=["Visual Studio 17 2022", "Ninja"],
                        default="Visual Studio 17 2022")
    parser.add_argument("--screenshots", action="store_true", help="Capture 10 offscreen Qt images after CTest")
    args = parser.parse_args()
    if sys.platform != "win32":
        parser.error("Run this helper on Windows with Python 3.10+; do not treat Linux as physical Windows evidence")
    if args.screenshots and args.prepare_only:
        parser.error("--screenshots requires a build; remove --prepare-only")
    repo = args.repo.resolve()
    if not (repo / "CMakeLists.txt").is_file():
        parser.error("--repo must refer to the project root with CMakeLists.txt")
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    dest = (args.output or Path.home() / "VehicleRentalReviews" / f"acceptance-{timestamp}").resolve()
    if contained(dest, repo) or contained(repo, dest):
        parser.error("Workspace must be separate from the original Git checkout")
    if dest.exists():
        parser.error("Workspace already exists; choose a new empty path (no overwriting)")
    dest.mkdir(parents=True)
    source, build, logs = dest / "source", dest / "build", dest / "logs"
    logs.mkdir()
    status, head, count = "NOT RUN", "UNRESOLVED", 0
    before = {}
    try:
        head = export_ref(repo, source, dest / "committed-source.zip", args.ref)
        before = {name: digest(source / name) for name in ("vehicles.txt", "rentals.txt")}
        if args.prepare_only:
            status = "PREPARED ONLY; NO LOCAL BUILD OR TEST"
        else:
            build_and_test(source, build, logs, args)
            status = "LOCAL CMAKE AND CTEST PASSED; PHYSICAL WINDOWS REVIEW PENDING"
            if args.screenshots:
                count = capture(source, build, dest / "screenshots", args, logs)
            after = {name: digest(source / name) for name in before}
            if before != after:
                status = "FAILED — DISPOSABLE DEMO FIXTURE MODIFIED"
                raise RuntimeError("Demo fixture hashes changed during local testing")
        print(f"Workspace: {dest}")
        print(f"Source revision: {head}")
        print(f"Status: {status}")
        return 0
    except Exception as exc:
        status = "FAILED — " + str(exc)
        print(f"Local acceptance preparation failed: {exc}", file=sys.stderr)
        return 1
    finally:
        manual_checklist(dest, args.ref, head, status)
        (dest / "RESULT.json").write_text(json.dumps({
            "source_ref": args.ref, "source_sha": head, "status": status,
            "photos": count, "fixture_sha256_before": before,
            "generated_at_utc": datetime.now(timezone.utc).isoformat(),
            "physical_windows_acceptance": "PENDING",
        }, indent=2) + "\n", encoding="utf-8")
        print(f"Recorded evidence at {dest / 'RESULT.json'}")


if __name__ == "__main__":
    raise SystemExit(main())
