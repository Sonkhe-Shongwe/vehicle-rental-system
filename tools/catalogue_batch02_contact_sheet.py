#!/usr/bin/env python3
"""Generate a visual review sheet from the already-acquired ten local images.

Does not download from outside, change source images, or integrate with Qt.
Refuses missing, changed or duplicated acquired files.
"""
import hashlib
import json
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

BASE = Path(__file__).resolve().parents[1] / "catalogue_acquisition" / "batch02"
META = BASE / "source_manifest.json"
OUT = BASE / "CONTACT_SHEET.jpg"

def main():
    info=json.loads(META.read_text(encoding="utf-8"))
    photos=sorted(info.get("images",[]),key=lambda x:x["model"])
    if len(photos)!=10 or info.get("omitted"):
        raise ValueError("Batch 02 must contain ten verified files")
    if len({p["sha256"] for p in photos})!=10:
        raise ValueError("Unreviewed identical images")
    width,height = 1120,1950
    page=Image.new("RGB",(width,height),(247,249,250))
    draw=ImageDraw.Draw(page)
    fontpath="/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
    try:
        title_font=ImageFont.truetype(fontpath,31)
        label_font=ImageFont.truetype(fontpath,22)
        sub_font=ImageFont.truetype(fontpath,17)
    except OSError:
        title_font=label_font=sub_font=ImageFont.load_default()
    draw.text((32,22),"Rental Studio | 10 free vehicle photos",font=title_font,fill=(24,49,72))
    draw.text((32,74),"Exact downloaded images. Staged for visual review, NOT yet in the app.",
              font=sub_font,fill=(75,91,105))
    for index,p in enumerate(photos):
        file=BASE/"images"/(p["slug"]+".jpg")
        raw=file.read_bytes()
        if hashlib.sha256(raw).hexdigest()!=p["sha256"]:
            raise ValueError("Hash mismatch: "+p["slug"])
        with Image.open(file) as im:
            im.load()
            if im.size!=(1024,680):raise ValueError("Unexpected image dimensions")
            thumb=im.convert("RGB").resize((518,344),Image.Resampling.LANCZOS)
        col,row=index%2,index//2
        x,y=32+col*548,116+row*364
        draw.rounded_rectangle((x-4,y-4,x+526,y+356),radius=9,
                               fill=(255,255,255),outline=(215,225,229),width=2)
        page.paste(thumb,(x,y))
        draw.text((x+6,y+314),p["model"],font=label_font,fill=(20,50,70),
                  stroke_width=0)
        draw.text((x+6,y+342),p["licence"],font=sub_font,fill=(68,93,109))
    page.save(OUT,"JPEG",quality=86,optimize=True)
    print("CONTACT_SHEET_CREATED",OUT,OUT.stat().st_size,flush=True)

if __name__=="__main__":
    main()
