#!/usr/bin/env python3
"""Check README's five compiled-Qt screenshot references and PNG integrity.

This confirms published image files exist and are structurally valid. It does
not claim that each image was generated from the latest source commit, that
human visual approval occurred, or that native Windows DPI was tested.
"""
from pathlib import Path

from verify_qt_png import verify

ROOT = Path(__file__).resolve().parent.parent
EVIDENCE = (
    ("Dashboard, actual Qt Widgets application", "dashboard-qt.png"),
    ("Fleet Inventory", "fleet-qt.png"),
    ("New Rental", "rent-qt.png"),
    ("Rental History", "history-qt.png"),
    ("Return Processing", "return-qt.png"),
)


def main():
    readme = (ROOT / "README.md").read_text(encoding="utf-8")
    for label, filename in EVIDENCE:
        path = f"design/qt-spike/{filename}"
        markdown = f"![{label}]({path})"
        if markdown not in readme:
            raise ValueError(f"README missing real-Qt screenshot reference: {markdown}")
        verify(ROOT / path, 1500, 860)
    print("PASS: README references five verified compiled-Qt PNG files")


if __name__ == "__main__":
    main()
