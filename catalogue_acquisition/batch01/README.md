# Free model-matched photo acquisition | Batch 01

**Target:** Ten actual, distinct local model photographs for Hyundai Creta, Volkswagen Polo, Haval Jolion, Nissan Navara, Isuzu D-Max, Mazda CX-5, Honda CBR500R, Kawasaki Ninja 400, Mercedes-Benz G-Class and Volkswagen Golf GTI.

**State at this commit:** Named Wikimedia Commons File: pages selected and source manifest saved. Actual downloaded photos, licences and hashes require the GitHub acquisition workflow to complete successfully before any acquired status is claimed.

**Method:** The tool uses the official Commons MediaWiki API to verify the individually nominated file title, the free CC0/CC BY/CC BY-SA licence metadata, author and image URL; images are downloaded from official Wikimedia hosts, resized without stretching to 1024×680, and stored in `images/`. It records the original Commons link, creator, original image licence, notice of derivative resizing and SHA256 in `IMAGE_CREDITS.md` and `source_manifest.json`. It rejects any source whose metadata fails these checks.

**Isolation:** This folder is outside `assets/portfolio/` and no CMake Qt resource list includes it. The existing gallery still shows its old catalogue mapping. **This is research and collection, NOT an implementation of new Fleet photos.**

**Next gate:** Visually inspect the ten locally acquired images, reject weak matches, and only then propose a mapping change for the owner's review. No paid service, operational customer data or main-branch change.
