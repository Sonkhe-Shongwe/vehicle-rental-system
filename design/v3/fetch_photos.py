#!/usr/bin/env python3
"""Download authentic Wikimedia Commons model photos conservatively for *design review*.

A rate-limit is a reason to record an unavailable asset, not a reason to hammer the host.
Only fetched, validated image files are marked ready. Does not change application code.
"""
from __future__ import annotations
import hashlib, io, json, time, urllib.parse, urllib.request
from pathlib import Path
from PIL import Image, ImageOps

root = Path(__file__).resolve().parent
catalogue = json.loads((root/'PHOTO_SOURCES.json').read_text())
photos = root/'photos'; photos.mkdir(exist_ok=True)
output=[]; pending=[]

for m in catalogue['items']:
    path=photos/(m['slug']+'.jpg')
    if path.exists():
        im=Image.open(path); im.verify()
        im=Image.open(path)
        if im.width < 400 or im.height < 300: raise ValueError('Existing asset too small: '+m['id'])
        print('CACHED',m['id'],im.size,flush=True)
    else:
        url='https://commons.wikimedia.org/wiki/Special:Redirect/file/'+urllib.parse.quote(m['file'],safe='')+'?width=1300'
        try:
            req=urllib.request.Request(url,headers={'User-Agent':'VehicleRentalPortfolioDesign/1.0 (GitHub design project; Wikimedia source and author credited)', 'Accept':'image/jpeg,image/png,image/*;q=0.8'})
            with urllib.request.urlopen(req,timeout=35) as response:
                if response.headers.get('Content-Type','').lower().split(';')[0] not in ('image/jpeg','image/png','image/webp'):
                    raise ValueError('Unexpected Content-Type from image source')
                content=response.read(16_000_001)
            if len(content)>16_000_000: raise ValueError('Source > 16 MB')
            im=ImageOps.exif_transpose(Image.open(io.BytesIO(content)))
            im.load()
            if im.width < 640 or im.height < 480 or im.width*im.height>30_000_000:
                raise ValueError('Image dimensions out of range')
            im=im.convert('RGB'); im.thumbnail((1300,975),Image.Resampling.LANCZOS)
            im.save(path,'JPEG',quality=83,optimize=True,progressive=True,exif=b'')
            print('FETCHED',m['id'],im.size,path.stat().st_size,flush=True)
        except Exception as e:
            code=getattr(e,'code',None)
            status='rate_limited' if code==429 else 'download_failed'
            pending.append({'id':m['id'],'status':status,'source':m['source'],'error':str(e)[:190]})
            print('PENDING',m['id'],status,str(e)[:100],flush=True)
            # 429 is an explicit stop for the Wikimedia source: no immediate reattempt.
            if code==429:
                for future in catalogue['items'][catalogue['items'].index(m)+1:]:
                    if not (photos/(future['slug']+'.jpg')).exists():
                        pending.append({'id':future['id'],'status':'not_attempted_after_rate_limit','source':future['source']})
                break
            continue
        time.sleep(3) # conservative automated download spacing
    output.append({'id':m['id'],'path':path.name,'source':m['source'],'credit':m['credit'],
        'license':m['license'],'license_url':m['license_url'],'width':im.width,'height':im.height,
        'size_bytes':path.stat().st_size,'sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
        'transformations':'EXIF stripped; resized to fit 1300×975; JPEG quality 83'})

manifest={'date':'2026-10-29','expected_count':len(catalogue['items']),'downloaded_count':len(output),
          'photos':output,'pending':pending,'review_status':'visual approval not yet completed'}
(photos/'MANIFEST.json').write_text(json.dumps(manifest,indent=2)+'\n')
if not output: raise RuntimeError('No photos downloaded; no verified assets to commit')
print('RESULT',len(output),'of',len(catalogue['items']),'downloaded; remaining expressly pending',flush=True)
