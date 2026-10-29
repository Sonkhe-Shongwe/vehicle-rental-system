#!/usr/bin/env python3
"""Fetch verified CC-licensed Wikimedia Commons originals into the *design branch*.
Does not modify any C++ source or claim the photos show the rental operator's actual vehicles.
"""
from __future__ import annotations
import hashlib, io, json, time, urllib.parse, urllib.request
from pathlib import Path
from PIL import Image, ImageOps

root = Path(__file__).resolve().parent
manifest = json.loads((root/'PHOTO_SOURCES.json').read_text())
photos = root/'photos'; photos.mkdir(exist_ok=True)
output=[]
for m in manifest['items']:
    name=m['file']
    url='https://commons.wikimedia.org/wiki/Special:Redirect/file/'+urllib.parse.quote(name, safe='')+'?width=1300'
    error=None; content=None
    for attempt in range(4):
        try:
            req=urllib.request.Request(url, headers={'User-Agent':'VehicleRentalPortfolioDesign/1.0 (GitHub design research; asset attribution documented)', 'Accept':'image/jpeg,image/png,image/*;q=0.8'})
            with urllib.request.urlopen(req, timeout=50) as response:
                if response.headers.get('Content-Type','').lower().split(';')[0] not in ('image/jpeg','image/png','image/webp'):
                    raise ValueError('Unexpected download Content-Type')
                content=response.read(16_000_001)
            if len(content)>16_000_000: raise ValueError('Image exceeded 16MB limit')
            break
        except Exception as e:
            error=e; time.sleep(2*(attempt+1))
    if content is None: raise RuntimeError(f'Could not fetch {m["id"]} from {url}: {error}')
    image=ImageOps.exif_transpose(Image.open(io.BytesIO(content)))
    image.load()
    if image.width<640 or image.height<480: raise ValueError(f'Insufficient source resolution: {name}')
    if image.width*image.height>30_000_000: raise ValueError('Source image too many pixels')
    image=image.convert('RGB')
    image.thumbnail((1300,975), Image.Resampling.LANCZOS)
    path=photos/(m['slug']+'.jpg')
    image.save(path, 'JPEG', quality=83, optimize=True, progressive=True, exif=b'')
    out={'id':m['id'],'path':str(path.relative_to(root)),'source':m['source'],'credit':m['credit'],
      'license':m['license'],'license_url':m['license_url'],'width':image.width,'height':image.height,
      'size_bytes':path.stat().st_size,'sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
      'transformations':'EXIF stripped, resized to fit 1300×975, JPEG quality 83'}
    output.append(out)
    print('FETCHED',m['id'],image.size,path.stat().st_size)
(photos/'MANIFEST.json').write_text(json.dumps({'date':'2026-10-29','photos':output},indent=2)+'\n')
assert len(output)==5
print('SUCCESS:',len(output),'reviewable authentic photo derivatives')
