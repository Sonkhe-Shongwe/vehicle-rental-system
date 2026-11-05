# Rental Studio 2.0 | UX-CTRL-002/003 physical owner QA

**Prepared:** 5 November 2026. **Status:** NOT EXECUTED. Use the exact-source fictional QA kit from [run #42022249850](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42022249850), artifact `13412208694`, or the locally built `rental_studio_qtquick_spike` in Qt Creator 6.10.2 MinGW. This form records owner observations; the successful hosted build is **not** physical signoff.

**Source commit actually tested:** ____  
**Windows version / real OS display scale:** ____  
**Screen/window size:** ____  
**Launch method + Qt kit:** ____  
**Narrator enabled?** ____  
**Owner test date:** ____

Mark **PASS / FAIL / NOT TESTED** for each:

| ID | Expected observed behaviour | Result |
|---|---|---|
| U01 | Sidebar Down focuses Fleet without switching from Overview; Enter then activates Fleet. | |
| U02 | Sidebar Up/Down reverses; active workspace and focused, hovered, selected state remain visually distinct. | |
| U03 | Active Overview Right visits Review active rentals, Open Fleet, Review overdue; Left reverses. Enter activates. | |
| U04 | Fleet Search keeps native caret arrows, with predictable filters and Gallery/Table focus. | |
| U05 | Fleet records navigate by arrows, Enter inspects exact vehicle and never books. | |
| U06 | Up from first Fleet record returns to Gallery/Table choice; focus memory and scroll reveal are reliable. | |
| U07 | Rentals horizontal All, Active, Returned, Archived, History routes work; Up from All returns to lookup. | |
| U08 | Down from All -> Overdue -> Find rental -> record; Up reverses to Find. | |
| U09 | Enter on focused rental opens only read-only contract details, never Return/Archive/Delete. | |
| U10 | Exactly one visible RENTAL CONTRACT heading, rental ID/vehicle/status/due-state are correct. | |
| U11 | Cards order: duration/rate, start/expected, actual return, Mint booked total, read-only summary, Close; no clipping. | |
| U12 | Contract total explicitly means booked value, not payment receipt; Escape/Close restores focus without write. | |
| U13 | Destructive removal/delete red, hover/focus/disabled distinct, confirmation remains mandatory. | |
| U14 | Real Windows scale 100%, 125%, 150% where available: note separate outcomes, legibility and clipping. | |
| U15 | Narrator reads relevant destinations, records, status and Close meaningfully. Record spoken observations. | |
| U16 | Qt Creator 6.10.2 MinGW CMake preset builds and runs the intended source; record exact SHA. | |

For a failure: **ID __; steps __; expected __; actual __; screenshot/log __; scale/window/kit/SHA __.**

**Separate photo review:** 50 individually licensed staging photos are NOT owner-visually accepted or integrated into Qt. Inspect 5 staged contact sheets and record each photo's accept/reject against make/model identity, crop and quality before any image-map integration. Six proposed models remain unsourced as of 5 November.

Formal acceptance remains **45/74 and 70.6% fixed-weight; P7 SQLite 0/8** unless the owner explicitly signs off particular criteria. Keep main and stacked draft PRs untouched.
