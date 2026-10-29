#!/usr/bin/env python3
"""Conservative PR documentation-only change classifier, using standard Python.

Never skip the required workflow/job. For an ambiguous diff, unknown path,
missing base commit, or failed Git command, always request the full Qt build.
"""
from __future__ import annotations
import os
from pathlib import PurePosixPath
import re
import subprocess

SHA = re.compile(r"^[0-9a-fA-F]{40}$")
EXACT = frozenset(
    {"README.md", "SECURITY.md", "CONTRIBUTING.md", "LICENSE.md", "assets/README.md"}
)
FOLDERS = ("docs/", "design/qt-spike/")


def is_doc(path: str) -> bool:
    if not path or "\\" in path or path.startswith("/") or ".." in PurePosixPath(path).parts:
        return False
    return path in EXACT or (path.endswith(".md") and path.startswith(FOLDERS))


def must_build(changed: list[str]) -> bool:
    return not changed or any(not is_doc(path) for path in changed)


def self_test() -> None:
    assert not must_build(["README.md", "docs/ROADMAP.md"])
    assert not must_build(["design/qt-spike/VISUAL_REVIEW.md", "assets/README.md"])
    for case in ([], ["mainwindow.cpp"], [".github/workflows/ci.yml"],
                 ["tests/gui_lifecycle_tests.cpp"], ["demo/vehicles.txt"],
                 ["assets/ford_ranger.jpg"], ["design/qt-spike/dashboard-qt.png"],
                 ["docs/test.py"], ["docs/../mainwindow.cpp"],
                 ["docs\\ROADMAP.md"], ["README.md", "mainwindow.cpp"]):
        assert must_build(case), f"Unsafe docs-only categorization: {case}"
    print("PASS: docs-only path classifier self-tests")


def needs_build() -> tuple[bool, str]:
    event = os.environ.get("CI_EVENT", "")
    if event != "pull_request":
        return True, "Non-PR or unknown event: full Qt tests"
    base = os.environ.get("CI_BASE_SHA", "")
    head = os.environ.get("CI_HEAD_SHA", "")
    if not SHA.fullmatch(base) or not SHA.fullmatch(head):
        return True, "Unknown base/head revision: full Qt tests"
    try:
        result = subprocess.run(
            ["git", "diff", "--name-only", "-z", "--diff-filter=ACDMRTUXB", base, head],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
            check=False, timeout=25,
        )
    except (OSError, subprocess.TimeoutExpired) as exc:
        return True, f"Git diff unavailable ({exc}): full Qt tests"
    if result.returncode:
        return True, "Git diff failed: full Qt tests. " + result.stderr.decode(
            "utf-8", errors="replace"
        )[:300]
    changed = [part.decode("utf-8", errors="surrogateescape")
               for part in result.stdout.split(b"\0") if part]
    return must_build(changed), (
        f"PR files: {len(changed)}, Qt build required: {must_build(changed)}"
    )


if __name__ == "__main__":
    self_test()
    build, reason = needs_build()
    print(reason)
    output = os.environ.get("GITHUB_OUTPUT")
    if output:
        with open(output, "a", encoding="utf-8") as stream:
            stream.write(f"needs_build={str(build).lower()}\n")
    else:
        print(f"needs_build={str(build).lower()}")
