#!/usr/bin/env python3
"""Local-only, unapproved candidate review. No network access or app-asset edits."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import sys

from PIL import Image, ImageDraw, ImageFont, ImageOps, UnidentifiedImageError

MODEL_IDS = {
    "C001": "Toyota Corolla",
    "C002": "Ford Ranger",
    "C003": "Hyundai i20",
    "M001": "Honda CB500F",
    "M002": "Yamaha MT-07",
}
SUPPORTED_FORMATS = {"JPEG", "PNG", "WEBP"}
MAX_INPUT_BYTES = 20 * 1024 * 1024
MAX_PIXELS = 25_000_000
Image.MAX_IMAGE_PIXELS = MAX_PIXELS
ROOT = Path(__file__).resolve().parents[1]
PROTECTED_ASSETS = (ROOT / "assets").resolve()


class ReviewError(ValueError):
    """A potentially unsafe/unreviewable input was refused."""


def sha256(raw: bytes) -> str:
    return hashlib.sha256(raw).hexdigest()


def inside(path: Path, parent: Path) -> bool:
    return path == parent or parent in path.parents


def read_candidates(manifest: Path):
    try:
        data = json.loads(manifest.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise ReviewError(f"Cannot read input manifest: {exc}") from exc
    if not isinstance(data, dict) or not isinstance(data.get("candidates"), list):
        raise ReviewError("Input JSON must contain a candidates list")
    entries = data["candidates"]
    if not 1 <= len(entries) <= len(MODEL_IDS):
        raise ReviewError("Provide between one and five distinct fictional vehicle candidates")
    seen_ids, seen_files = set(), set()
    for entry in entries:
        if not isinstance(entry, dict):
            raise ReviewError("Every candidate must be an object")
        id_ = entry.get("vehicle_id")
        name = entry.get("file")
        if not isinstance(id_, str) or id_ not in MODEL_IDS or id_ in seen_ids:
            raise ReviewError(f"Unknown or duplicate vehicle ID: {id_!r}")
        if not isinstance(name, str) or not name or name != Path(name).name or name in (".", "..") or "/" in name or "\\" in name:
            raise ReviewError(f"Candidate filename must be a direct basename: {name!r}")
        if Path(name).suffix.lower() not in (".jpg", ".jpeg", ".png", ".webp"):
            raise ReviewError(f"Unsupported filename extension: {name!r}")
        if name.casefold() in seen_files:
            raise ReviewError("Two vehicle candidates cannot share the same input file")
        for field in ("creator_claim", "licence_claim", "source_note"):
            value = entry.get(field)
            if not isinstance(value, str) or not value.strip() or len(value) > 500:
                raise ReviewError(f"Missing/invalid {field} for {id_}; no rights inferred")
        seen_ids.add(id_)
        seen_files.add(name.casefold())
    return entries


def load_candidate(input_dir: Path, entry: dict):
    file = input_dir / entry["file"]
    if file.is_symlink() or not file.is_file() or file.resolve().parent != input_dir:
        raise ReviewError(f"Missing, non-local or symlinked candidate: {entry['file']}")
    if not 0 < file.stat().st_size <= MAX_INPUT_BYTES:
        raise ReviewError(f"Candidate exceeds 20 MiB or is empty: {entry['file']}")
    raw = file.read_bytes()
    try:
        with Image.open(file) as photo:
            if photo.format not in SUPPORTED_FORMATS:
                raise ReviewError(f"Unsupported decoded format: {photo.format}")
            w, h = photo.size
            if w < 600 or h < 350 or w * h > MAX_PIXELS:
                raise ReviewError(f"Unsafe/insufficient image dimensions: {w}x{h}")
            photo.load()
            transposed = ImageOps.exif_transpose(photo)
            if transposed.mode in ("RGBA", "LA") or "transparency" in transposed.info:
                rgba = transposed.convert("RGBA")
                result = Image.new("RGB", rgba.size, "#EAF0F4")
                result.paste(rgba, mask=rgba.getchannel("A"))
            else:
                result = transposed.convert("RGB")
    except (OSError, UnidentifiedImageError, Image.DecompressionBombError) as exc:
        raise ReviewError(f"Cannot safely decode {entry['file']}: {exc}") from exc
    return raw, result


def fit_contain(source: Image.Image, size):
    pane = Image.new("RGB", size, "#EAF0F4")
    scaled = ImageOps.contain(source, size, method=Image.Resampling.LANCZOS)
    pane.paste(scaled, ((size[0] - scaled.width) // 2,
                        (size[1] - scaled.height) // 2))
    return pane


def safe_output(input_dir: Path, output_dir: Path):
    if output_dir.is_symlink() or not output_dir.is_absolute():
        raise ReviewError("Output path must be an absolute non-symlink location")
    dest = output_dir.resolve()
    if inside(dest, input_dir) or inside(input_dir, dest):
        raise ReviewError("Output cannot overlap any source originals")
    if inside(dest, PROTECTED_ASSETS) or inside(PROTECTED_ASSETS, dest):
        raise ReviewError("Cannot write inside or above the application's assets directory")
    if dest.exists() and (not dest.is_dir() or any(dest.iterdir())):
        raise ReviewError("Output directory must be empty to prevent accidental overwrites")
    return dest


def run(input_dir: Path, manifest: Path, output_dir: Path) -> dict:
    src = input_dir.resolve()
    if not input_dir.is_dir() or input_dir.is_symlink():
        raise ReviewError("Input originals folder must be a regular local directory")
    entries = read_candidates(manifest)
    dest = safe_output(src, output_dir.absolute())
    records = []
    staged = []
    # Validate ALL files before creating any output, including hashes and decoding.
    for entry in entries:
        raw, im = load_candidate(src, entry)
        id_ = entry["vehicle_id"]
        staged.append((id_, im))
        ratio = 600 / 220
        aspect = im.width / im.height
        records.append({
            "vehicle_id": id_, "model": MODEL_IDS[id_], "input_file": entry["file"],
            "creator_claim_unverified": entry["creator_claim"],
            "licence_claim_unverified": entry["licence_claim"],
            "source_note_unverified": entry["source_note"],
            "original_sha256": sha256(raw), "original_bytes": len(raw),
            "original_decoded_dimensions": [im.width, im.height],
            "centered_gallery_crop_area_retained_percent": round(
                100 * min(aspect / ratio, ratio / aspect), 1),
            "rights_verified": False, "owner_visual_approved": False,
            "installed_in_application": False,
        })
    dest.mkdir(parents=True, exist_ok=True)
    board = Image.new("RGB", (1860, 156 + 360 * len(staged)), "#F6F8FA")
    draw = ImageDraw.Draw(board)
    title_font = ImageFont.load_default(size=32)
    label_font = ImageFont.load_default(size=24)
    info_font = ImageFont.load_default(size=21)
    draw.text((26, 18), "RENTAL STUDIO | OFFLINE PHOTOGRAPH REVIEW",
              font=title_font, fill="#17324D")
    draw.text((26, 65), "UNAPPROVED | source rights not verified | no Qt assets replaced",
              font=info_font, fill="#0F766E")
    for x, label in ((26, "Original (contain)"), (645, "Gallery center crop"),
                     (1263, "Inspector center crop")):
        draw.text((x, 108), label, font=label_font, fill="#17324D")
    for i, ((id_, im), row) in enumerate(zip(staged, records)):
        normalized = im.copy()
        normalized.thumbnail((1600, 1200), Image.Resampling.LANCZOS)
        filename = f"{id_}-review-only-normalized.jpg"
        target = dest / filename
        normalized.save(target, "JPEG", quality=88, optimize=True, exif=b"")
        row["review_derivative"] = filename
        row["review_derivative_sha256"] = sha256(target.read_bytes())
        y = 156 + 360 * i
        draw.rounded_rectangle((14, y, 1840, y + 345), radius=14,
                               fill="#FFFFFF", outline="#DCE4EB", width=2)
        draw.text((26, y + 12), f"{id_}  {MODEL_IDS[id_]}  |  RIGHTS NOT VERIFIED",
                  font=label_font, fill="#17324D")
        board.paste(fit_contain(im, (600, 240)), (26, y + 57))
        board.paste(ImageOps.fit(im, (600, 220), method=Image.Resampling.LANCZOS), (645, y + 57))
        board.paste(ImageOps.fit(im, (550, 260), method=Image.Resampling.LANCZOS), (1263, y + 57))
        draw.text((26, y + 309), "Full image preserved", font=info_font, fill="#17324D")
        draw.text((645, y + 309),
                  f"2.73:1 | {row['centered_gallery_crop_area_retained_percent']}% area retained",
                  font=info_font, fill="#17324D")
        draw.text((1263, y + 322), "Inspector crop", font=info_font, fill="#17324D")
    board.save(dest / "CONTACT_SHEET_UNAPPROVED.png", "PNG", optimize=True)
    summary = {
        "approval": "NONE - images are review-only; rights, actual subject and owner visual decisions still required",
        "source_files_modified": False, "app_assets_modified": False,
        "full_five_model_set": len(records) == 5,
        "candidate_count": len(records),
        "warnings": ["EXIF removed from derivatives, but visible faces, number plates and branding are NOT automatically redacted",
                     "User-supplied creator, licence and origin statements are UNVERIFIED",
                     "No model/year/trim identity or source-site licence has been independently verified"],
        "candidates": records,
    }
    (dest / "REVIEW_MANIFEST.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return summary


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input-dir", type=Path, required=True,
                        help="Non-committed folder with user-provided, lawfully obtained originals")
    parser.add_argument("--manifest", type=Path, required=True,
                        help="Source/creator/licence claims; claims remain unverified")
    parser.add_argument("--output-dir", type=Path, required=True,
                        help="New empty destination, never the app assets directory")
    args = parser.parse_args(argv)
    try:
        summary = run(args.input_dir, args.manifest, args.output_dir)
    except ReviewError as exc:
        print(f"REFUSED: {exc}", file=sys.stderr)
        return 2
    print(f"REVIEW PREPARED: {summary['candidate_count']} unapproved image(s), "
          "no app assets updated, licence and visual approval still open")
    return 0


if __name__ == "__main__":
    sys.exit(main())