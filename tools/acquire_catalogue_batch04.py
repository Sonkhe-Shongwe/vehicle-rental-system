#!/usr/bin/env python3
"""Acquire ten individually selected free Commons vehicle photos, without app integration.

This runs in a deliberate GitHub Action, NOT in Rental Studio at runtime.
No commercial API, customer data or arbitrary source. Images are transformed
to fixed-size JPEGs with source, artist, licence, SHA256 and source URL recorded.
"""
import hashlib
import html
import io
import json
import re
import sys
import time
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urlencode, quote, urlsplit
from urllib.request import Request, urlopen

from PIL import Image, ImageOps

ROOT = Path(__file__).resolve().parents[1]
CONFIG = ROOT / "catalogue_acquisition" / "batch04" / "sources.json"
OUT = ROOT / "catalogue_acquisition" / "batch04" / "images"
COMMONS_API = "https://commons.wikimedia.org/w/api.php"
USER_AGENT = "RentalStudio2Portfolio/0.1 (https://github.com/Sonkhe-Shongwe/vehicle-rental-system; free CC model-specific portfolio photos)"

class PlainHTML(HTMLParser):
    def __init__(self):
        super().__init__()
        self.parts = []
    def handle_data(self, data):
        self.parts.append(data)
    def text(self):
        return html.unescape("".join(self.parts)).strip()

def strip_html(data):
    parser = PlainHTML()
    parser.feed(data or "")
    return re.sub(r"\s+", " ", parser.text()).strip()

def load_url(url, accept, max_bytes=8_000_000):
    error = None
    for attempt in range(3):
        try:
            req = Request(url, headers={"User-Agent": USER_AGENT, "Accept": accept})
            with urlopen(req, timeout=35) as res:
                payload = res.read(max_bytes + 1)
                if len(payload) > max_bytes:
                    raise ValueError("image or metadata exceeds permitted size")
                return payload
        except Exception as exc:
            error = exc
            if attempt < 2:
                time.sleep((attempt + 1) * 2)
    raise RuntimeError(f"Failed to retrieve approved Commons content: {error}")

def main():
    conf = json.loads(CONFIG.read_text(encoding="utf-8"))
    entries = conf["sources"]
    slugs = [item["slug"] for item in entries]
    if len(entries) != 10 or len(set(slugs)) != 10:
        raise ValueError("Curated sources must be unique and contain at least ten choices")
    for item in entries:
        if not re.fullmatch(r"[a-z0-9_]+", item["slug"]) or item["expected_license"] != "FREE_CC":
            raise ValueError("Source manifest has an unsafe slug or unexpected licence")
        if not item["file_title"].lower().endswith((".jpg", ".jpeg", ".png")):
            raise ValueError("Source title must reference a JPEG or PNG file")

    params = urlencode({
        "action": "query", "format": "json", "formatversion": 2,
        "prop": "imageinfo", "iiprop": "url|extmetadata|size",
        "iiurlwidth": 1024,
        "titles": "|".join("File:" + x["file_title"] for x in entries)
    })
    result = json.loads(load_url(COMMONS_API + "?" + params, "application/json",
                                 max_bytes=5_000_000))
    pages = {item.get("title"): item for item in result.get("query", {}).get("pages", [])}
    OUT.mkdir(parents=True, exist_ok=True)
    rights = []
    failures = []
    for index, item in enumerate(entries):
        title = "File:" + item["file_title"]
        page = pages.get(title)
        if page is None:
            # The API normalises File: capitalisation and whitespace.
            page = next((p for p in pages.values() if
                         p.get("title", "").casefold() == title.casefold()), None)
        image_info = (page or {}).get("imageinfo") or []
        if not image_info:
            failures.append((item["slug"], "no Commons imageinfo"))
            continue
        info = image_info[0]
        metadata = info.get("extmetadata", {})
        name = strip_html(metadata.get("LicenseShortName", {}).get("value", ""))
        licence = strip_html(metadata.get("LicenseUrl", {}).get("value", ""))
        # Accept only individually validated CC0, CC BY, CC BY-SA. Reject
        # NC, ND, non-free, and ambiguous metadata; preserve official link.
        license_path = urlsplit(licence).path.lower().rstrip("/")
        license_host = urlsplit(licence).hostname
        permitted_path = (
            license_path.startswith("/publicdomain/zero/1.0") and
            name.upper().startswith("CC0")
        ) or (
            re.fullmatch(r"/licenses/(by|by-sa)/(2\.0|2\.5|3\.0|4\.0)",license_path)
            is not None and name.upper().startswith("CC BY")
        )
        if license_host not in ("creativecommons.org","www.creativecommons.org") or not permitted_path:
            failures.append((item["slug"], "unverified free CC licence: " + name + " / " + licence))
            continue
        artist = strip_html(metadata.get("Artist", {}).get("value", "")) or "See source page"
        source = "https://commons.wikimedia.org/wiki/" + quote(
            (page or {}).get("title", title).replace(" ", "_"), safe=":_()-'.")
        remote = info.get("thumburl") or info.get("url", "")
        parsed = urlsplit(remote)
        # Commons now issues thumbnails from thumb.wikimedia.org as well as
        # upload.wikimedia.org. Both must serve the fixed Commons media path.
        if parsed.scheme != "https" or parsed.netloc not in (
            "thumb.wikimedia.org", "upload.wikimedia.org"
        ) or not parsed.path.startswith("/wikipedia/commons/"):
            failures.append((item["slug"], "non-Wikimedia asset URL"))
            continue
        try:
            raw = load_url(remote, "image/jpeg,image/png,image/*", max_bytes=8_000_000)
            with Image.open(io.BytesIO(raw)) as im:
                im.load()
                if im.width * im.height > 35_000_000:
                    raise ValueError("unexpectedly large image dimensions")
                source_image = ImageOps.exif_transpose(im).convert("RGB")
                source_image.thumbnail((1000, 650), Image.Resampling.LANCZOS)
                result_image = Image.new("RGB", (1024, 680), (239, 243, 246))
                offset = ((1024-source_image.width)//2, (680-source_image.height)//2)
                result_image.paste(source_image, offset)
                output = OUT / (item["slug"] + ".jpg")
                result_image.save(output, "JPEG", quality=83, optimize=True, progressive=True)
            digest = hashlib.sha256(output.read_bytes()).hexdigest()
            rights.append({
                "slug": item["slug"], "model": item["make"] + " " + item["model"],
                "source_title": title,
                "source_page": source, "creator": artist,
                "licence": name, "licence_url": licence or
                    "https://creativecommons.org/publicdomain/zero/1.0/",
                "source_thumbnail_url": remote, "local_file": str(output.relative_to(ROOT)),
                "sha256": digest, "modification": "Resized, re-encoded, centred and letterboxed to 1024x680; CC BY-SA adaptations retain original licence"
            })
            print("OK", item["slug"], name, output.stat().st_size, flush=True)
        except Exception as exc:
            failures.append((item["slug"], str(exc)[:160]))
        time.sleep(0.2)
    rights.sort(key=lambda x:x["slug"])
    if len(rights) != 10:
        raise RuntimeError("Insufficient verified images; refusing partial asset commit: " +
                           repr(failures))
    credits = [
        "# Rental Studio | Batch 04 model-matched free image credits",
        "",
        "Ten free photographs were checked against live Wikimedia Commons licence metadata.",
        "STAGING ONLY: these are NOT YET connected to the rental application.",
        "Photos are recognisable make/model candidates; year and trim may differ.",
        "CC BY/CC BY-SA attribution and share-alike obligations apply to derivative photos.",
        "",
        "| Model | Local image | Creator | Commons source | Licence | SHA256 |",
        "|---|---|---|---|---|---|"
    ]
    for record in rights:
        artist = record["creator"].replace("|", "/").replace("[", "").replace("]", "")
        credits.append(
            f'| {record["model"]} | {record["local_file"]} | {artist[:110]} | '
            f'[Original]({record["source_page"]}) | '
            f'[{record["licence"]}]({record["licence_url"]}) | {record["sha256"]} |'
        )
    credits += ["", "Unresolved/unused candidates: " +
                (", ".join(slug for slug, _ in failures) if failures else "none"),
                "", "These illustrative assets do not guarantee an exact year, trim or",
                "model match to the fictional vehicle entries."]
    (OUT.parent / "IMAGE_CREDITS.md").write_text("\n".join(credits) + "\n", encoding="utf-8")
    (OUT.parent / "source_manifest.json").write_text(
        json.dumps({"images":rights, "omitted":failures}, indent=2, ensure_ascii=False)+"\n",
        encoding="utf-8")
    print("FINAL VERIFIED BATCH04 MODEL PHOTOS", len(rights), "/", len(entries), flush=True)

if __name__ == "__main__":
    main()
