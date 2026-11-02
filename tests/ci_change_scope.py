#!/usr/bin/env python3
"""Classify the PR *head-to-head* delta, not the cumulative stacked PR diff.

Full tests are mandatory on an initial/reopened PR, main push, manual dispatch,
missing/invalid SHA, Git failure, and ANY non-document change. On synchronize,
skip expensive jobs only if every changed path is a document. The lightweight
scope check itself stays green and visible even when native/core jobs skip.
"""
from __future__ import annotations

import os
import re
import subprocess
import sys
from pathlib import PurePosixPath


SHA = re.compile(r"^[0-9a-fA-F]{40}$")


def is_document(path: str) -> bool:
    # Documentation does not include workflow YAML, CMake files or C++ assets.
    return path.startswith("docs/") or (
        bool(path) and PurePosixPath(path).suffix.lower() == ".md"
    )


def needs_full_tests(paths: list[str]) -> bool:
    # Empty/ambiguous diffs fail closed and run tests.
    return not paths or any(not is_document(path) for path in paths)


def scope(event_name: str, action: str, before: str, after: str) -> tuple[bool, str]:
    if event_name != "pull_request" or action != "synchronize":
        return True, "initial, reopened, manual or main-branch run"
    if not SHA.fullmatch(before or "") or not SHA.fullmatch(after or ""):
        return True, "missing PR before/after revisions; conservative full suite"
    try:
        result = subprocess.run(
            ["git", "diff", "--no-renames", "--name-only", "-z", before, after],
            capture_output=True,
            check=True,
            timeout=25,
        )
        names = [os.fsdecode(v) for v in result.stdout.split(b"\x00") if v]
        # Deliberately no differential filtering by the cumulative PR base.
        if needs_full_tests(names):
            return True, "non-doc/empty head delta; full suite"
        return False, f"documentation-only head delta: {len(names)} file(s)"
    except (OSError, subprocess.SubprocessError):
        return True, "git diff unavailable; conservative full suite"


def self_test() -> None:
    assert not needs_full_tests(["docs/TESTING.md", "README.md"])
    assert not needs_full_tests(["docs/staging/file.txt"])
    assert not needs_full_tests(["tests/p7_sandbox/README.md"])
    assert needs_full_tests([])
    assert needs_full_tests(["docs/TESTING.md", "tests/p7_sandbox/main.cpp"])
    assert needs_full_tests([".github/workflows/ci.yml"])
    assert needs_full_tests(["CMakeLists.txt"])
    assert needs_full_tests(["src/application/model.cpp"])
    assert needs_full_tests(["tests/test_repo_hygiene.py"])
    assert needs_full_tests(["docs/notes.md", "spikes/qtquick_p2/Main.qml"])
    assert is_document("docs/plan_2026-11-02.rst")
    assert not is_document("src/config.yml")
    assert SHA.fullmatch("a" * 40)
    assert scope("push", "", "", "")[0]
    assert scope("pull_request", "synchronize", "", "")[0]
    assert scope("pull_request", "opened", "", "")[0]
    print("PR head-delta scope self-check PASS")


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        self_test()
    elif sys.argv[1:] == ["--emit"]:
        full, why = scope(
            os.environ.get("CI_EVENT_NAME", ""),
            os.environ.get("CI_EVENT_ACTION", ""),
            os.environ.get("CI_BEFORE", ""),
            os.environ.get("CI_AFTER", ""),
        )
        value = "true" if full else "false"
        print(f"CI scope decision: run_full={value}; {why}")
        with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as file:
            file.write(f"run_full={value}\n")
    else:
        raise SystemExit("Use --self-test or --emit")
