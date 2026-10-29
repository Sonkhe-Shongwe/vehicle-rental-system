#!/usr/bin/env python3
"""Stage a rights-checked Commons photo candidate; do not replace Qt assets.

Fetches imageinfo over the public Wikimedia MediaWiki API on a disposable
GitHub Actions runner. Declared CC0 is necessary, and final licence/visual
review must still be conducted by a human. Never download arbitrary URLs.
"""
import hashlib
import io
import json
from pathlib import Path
import re
import sys
import time
from urllib.parse import urlencode, urlparse
from urllib.request import Request, urlopen

from PIL import Image, ImageOps

NAME = "2nd Gen 2025 Ford Ranger T6 RA XLT 4WD P789 China Front Three Quarter View.jpg"
PAGE = "https://commons.wikimedia.org/wiki/File:2nd_Gen_2025_Ford_Ranger_T6_RA_XLT_4WD_P789_China_Front_Three_Quarter_View.jpg"
DEST = Path("design/qt-spike/photo-candidates")
AGENT = "VehicleRentalSystem-Qt-VisualReview/1.0 (https://github.com/Sonkhe-Shongwe/vehicle-rental-system; only CC0 review photo)"
EXPECTED_AUTHOR = "Hyins"

def retrieve(url, *, max_bytes=8_000_000):
    req = Request(url, headers={"User-Agent": AGENT, "Accept": "application/json,image/jpeg,*/*"})
    with urlopen(req, timeout=35) as response:
        resolved = urlparse(response.geturl())
        if resolved.scheme != "https" or not resolved.hostname.endswith(("wikimedia.org", "wikipedia.org")):
            raise ValueError(f"Unexpected response host: {resolved.hostname}")
        raw = response.read(max_bytes + 1)
        if len(raw) > max_bytes:
            raise ValueError("Candidate exceeds 8 MB source limit")
        return raw

def main():
    errors = []
    info = None
    for site in ("https://commons.wikimedia.org", "https://en.wikipedia.org"):
        params = {
            "action": "query", "format": "json", "formatversion": "2",
            "titles": "File:" + NAME, "prop": "imageinfo",
            "iiprop": "url|size|mime|extmetadata", "iiurlwidth": "1280",
        }
        try:
            api = site + "/w/api.php?" + urlencode(params)
            raw = retrieve(api, max_bytes=300_000)
            payload = json.loads(raw)
            pages = payload.get("query", {}).get("pages", [])
            if len(pages) != 1 or "imageinfo" not in pages[0]:
                raise ValueError("Commons file metadata unavailable")
            info = pages[0]["imageinfo"][0]
            ext = info.get("extmetadata", {})
            licence = ext.get("LicenseShortName", {}).get("value", "")
            creator = re.sub(r"<[^>]+>", "", ext.get("Artist", {}).get("value", ""))
            if "CC0" not in licence.upper() and "CC-ZERO" not in licence.upper():
                raise ValueError(f"Candidate is not marked CC0: {licence}")
            if EXPECTED_AUTHOR.casefold() not in creator.casefold():
                raise ValueError(f"Creator metadata does not match {EXPECTED_AUTHOR}: {creator[:100]}")
            source = info.get("thumburl") or info.get("url")
            if not source:
                raise ValueError("Commons did not return a media URL")
            data = retrieve(source)
            if not data.startswith(bytes.fromhex("ffd8ff")):
                raise ValueError("Source is not JPEG")
            with Image.open(io.BytesIO(data)) as src:
                src.load()
                if src.format != "JPEG" or src.width < 960 or src.height < 500:
                    raise ValueError(f"Unexpected candidate photo {src.format} {src.size}")
                rgb = ImageOps.exif_transpose(src).convert("RGB")
            rgb.thumbnail((1300, 975), Image.Resampling.LANCZOS)
            DEST.mkdir(parents=True, exist_ok=True)
            derivative = DEST / "ford_ranger_hyins_review.jpg"
            rgb.save(derivative, format="JPEG", quality=84, optimize=True)
            record = {
                "review_status": "UNAPPROVED_CANDIDATE_NOT_BUNDLED",
                "commons_file_page": PAGE,
                "declared_license": licence, "artist": creator.strip(),
                "source_media_url": source,
                "source_download_sha256": hashlib.sha256(data).hexdigest(),
                "review_derivative_sha256": hashlib.sha256(derivative.read_bytes()).hexdigest(),
                "review_dimensions": list(rgb.size), "original_metadata": {
                    "width": info.get("width"), "height": info.get("height"),
                    "size": info.get("size"), "mime": info.get("mime"),
                },
                "disclosure": "Representative Ford Ranger, NOT an actual rental-fleet vehicle. Do not use in Qt until a separate visual review and licence acceptance.",
            }
            (DEST / "ford_ranger_hyins_review.json").write_text(
                json.dumps(record, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
            print(f"STAGED: {derivative} {rgb.size} {derivative.stat().st_size} bytes")
            return
        except Exception as exc:
            errors.append(f"{site}: {type(exc).__name__}: {exc}")
            print("Candidate retrieval attempt failed:", errors[-1], file=sys.stderr)
            time.sleep(2)
    raise SystemExit("Cannot retrieve and verify source image. No image staged. " + " | ".join(errors))

if __name__ == "__main__":
    main()
