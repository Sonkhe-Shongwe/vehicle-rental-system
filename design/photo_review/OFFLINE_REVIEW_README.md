# PHOTO-P1-E | Offline five-model photography candidate preflight

**Status:** Engineering review utility only, **not** selected/approved/final vehicle images.

This tool exists because both previous Wikimedia source-download attempts were blocked. It makes **zero network/image downloads**. Existing app photos and `assets/` remain untouched. Never use it to evade a rate limit or copy images without rights. Work only with local originals which you have lawfully obtained (including owner-created photographs). Do not submit private stock/customer photos, identifying number plates or images featuring people unless permissions and privacy treatment are in place.

## First candidate: Hyundai i20

1. Obtain a correctly identified regular Hyundai i20 photograph with documented redistribution rights. Do not assume a source-page description alone proves rights. Save the original, without edits, as `design/photo_review/local_originals/C003.jpg`.
2. Copy `design/photo_review/OFFLINE_REVIEW_INPUT_TEMPLATE.json` to `design/photo_review/local_manifest.json`. Replace the creator, licence and source placeholders with claims and evidence. This is *not* final legal verification.
3. Run from the repository root:

   ```bash
   python -m pip install Pillow==11.3.0
   python tools/offline_photo_review.py \
     --input-dir design/photo_review/local_originals \
     --manifest design/photo_review/local_manifest.json \
     --output-dir design/photo_review/local_output
   ```

   Windows PowerShell uses the same single-line command without shell continuation characters:

   ```powershell
   python tools/offline_photo_review.py --input-dir design/photo_review/local_originals --manifest design/photo_review/local_manifest.json --output-dir design/photo_review/local_output
   ```

4. Inspect `CONTACT_SHEET_UNAPPROVED.png` (full image versus exact Gallery-like 2.73:1 and Inspector-like crops), `REVIEW_MANIFEST.json` and `C003-review-only-normalized.jpg`. The record contains SHA-256 source/derivative hashes and unverified attribution data. **Do not commit these files or install the normalized derivative into Qt**. For another candidate, use a new empty output directory and change the manifest. The tool supports one to five model IDs, but never claims a complete set when only one is supplied.

The repo `.gitignore` excludes the local originals, private manifest, and results folders as an extra safeguard. They still contain candidate image content and must be treated as private until reviewed. The tool never mutates originals, strips EXIF from rendered review derivatives and refuses path traversal, symlinks, oversized/invalid images, shared filenames, unknown vehicle IDs and nonempty output directories. **It does not detect or redact visible faces, plates or trademarks, verify the identity of a photographed vehicle, or authenticate licences.** Those remain manual human gates. The output stays deliberately unapproved even for a well-formed local source.

## Verification

Run `python -m unittest discover -s tests -p 'test_offline_photo_review.py' -v`. The tests generate private synthetic images in temporary folders and cover 1/5 and 5/5 cases, hashes, decoding, real EXIF removal, file-size limits, path/overwrite safety, and provenance/approval refusals on Linux and hosted Windows. The dedicated GitHub Actions workflow only runs these synthetic tests. No candidate originals, review derivatives or licence assertions are uploaded by CI.