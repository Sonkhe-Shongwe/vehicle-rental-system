# Rental Studio 2.0 | UX-VIS-002 single contract heading and native verification

**Date:** 5 November 2026 (Africa/Johannesburg)  
**Approved source:** [UX-CTRL-002](UX_CTRL_002_OWNER_APPROVED_DIRECTIONAL_NAVIGATION_SEMANTIC_COLORS_CONTRACT_DETAIL_2026-11-04.md) and [UX-CTRL-003](UX_CTRL_003_OWNER_APPROVED_SEAMLESS_BIDIRECTIONAL_NAVIGATION_2026-11-04.md).  
**Exact compiled source:** [`509692a2e39b391bec5ff7653b50d7206ad3e807`](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/509692a2e39b391bec5ff7653b50d7206ad3e807)  
**Successful run:** [#42022249850](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42022249850), completed SUCCESS on 5 November.  
**Development branch:** `feature/p7-sqlite-sandbox-20261102`, stacked [DRAFT PR #17](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/pull/17) based on P6; **main** remains `9bfca8786af1c64b0284a5a1bb3e2186573147a4`.  
**Status:** Source implemented and hosted-native verified. Owner's final physical UX, Qt Creator MinGW, display scale and Narrator acceptance are OPEN.

## Problem observed in real Windows captures

Previous exact-source [UX-VIS-001 run #42006817384](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42006817384) passed 130/130 CTests on EACH OS, including a newly captured open contract dialog at 1500x860 and 1280x720. The screenshots established layout visibility, field order, booked total, and Close without clipping at those logical sizes. Manual screenshot inspection also revealed a **duplicate small Qt default dialog title** above the owner-approved in-card **RENTAL CONTRACT** heading, wasting space and weakening the hierarchy.

This is a presentation defect. It does not authorize changing the existing C++ selected-contract data projection, booked values, rental lifecycle, payment policy, keyboard navigation or business confirmations.

## Exact source correction

- `spikes/qtquick_p2/Main.qml`: retains Dialog `title: "Rental contract"` for its built-in dialog semantics, overrides the style-specific default header with an invisible zero-implicit-height Item named `rentalContractSuppressedDefaultHeader`, and preserves the owner's prominent custom heading.
- `spikes/qtquick_p2/main.cpp`: UX-VIS-002 native assertion reads `Dialog.header` directly and verifies header identity/invisibility while retaining the semantic title. Existing real QML contract tests still validate R001/C002, status, dates, rate, Mint booked total, order, Close focus, Escape restoration, cancelled write prevention and fictional source integrity.
- No payment receipt, customer PII, real-data connection, fixture rewrite or new production SQLite action was introduced.

## Transparent failure-and-fix audit

| Run | Commit | Observed result | Diagnosis and correction |
|---|---|---|---|
| [#42020802800](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42020802800) | `dbb2f554` | **128/130 on each OS**, two contract detail smoke failures | `Accessible.name` attached to QML Dialog (a Popup rather than an Item) emitted `Accessible must be attached to an Item or an Action`. Removed the unsupported attachment; kept Dialog's built-in title. |
| [#42021704268](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42021704268) | `c6ec068c` | **128/130 on each OS**, two contract detail smoke failures | Native test used a deliberately visible-only `find()` helper to locate an intentionally hidden header. Replaced with direct `Dialog.header` property inspection. |
| [#42022249850](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42022249850) | `509692a` | **130/130 native CTests EACH Linux and Windows**, zero failures; Windows functional 8/8; PowerShell 5.1 PASS | Corrected UX-VIS-002 and original UX-VIS-001 actual QML smoke pass in wide and compact modes. |

Both prior failures are retained, not presented as passes. Source `509692a` is the successful exact executable checkpoint. A later documentation-only HEAD is not itself a new compiled source validation.

## Successful CI and artifact evidence

| Check | Platform | Outcome |
|---|---|---|
| Complete 130 CTest suite | Ubuntu GCC + Qt 6.8.3 | **130/130 PASS** |
| Complete 130 CTest suite | Windows Server 2022 MSVC + Qt 6.8.3 | **130/130 PASS** |
| Real contract detail wide #67, compact #68 | BOTH platforms | **PASS**, including hidden default header and accessible semantic title |
| Relocated fictional Windows portable functional checks | Hosted Windows | **8/8 PASS** |
| Packaged PowerShell 5.1 verification | Hosted Windows | **PASS** |

GitHub job references: [Linux](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42022249850/job/127229832041), [Windows](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/actions/runs/42022249850/job/127229831904).

The following genuine artifacts were downloaded and verified to be structurally readable ZIP files with exact matching GitHub SHA-256 digests:

- **Windows QA kit** artifact `13412208694`, `p2-windows-physical-acceptance-kit`, 40,639,832 bytes, SHA-256 `accdd50e00e8b77858d501700b7a4c49d55ce4414940640d45316ef5b7de6553`. Its `SOURCE_COMMIT.txt` is exactly `509692a2e39b391bec5ff7653b50d7206ad3e807`; it has 1,393 ZIP entries and no corrupt entry.
- **Windows screenshots** artifact `13411829588`, `p2-qtquick-windows-screenshots`, 12,971,522 bytes, SHA-256 `0e90dc760885d67ca2b8757c0d0dde0488cce52faf7b4a55b2952af8fb7b2843`. It contains 66 PNGs, including `p6-qt-contract-detail-1280x720.png` and `p6-qt-contract-detail-1500x860.png`.
- **Linux screenshots** artifact `13412632926`, 13,795,994 bytes, SHA-256 `af9626994312baaae3ad63b0d56d5aad7964e47b912d69f276fe846cc7f5b874`, with 66 images.

Artifacts were live/non-expired when retrieved on 5 November; they are scheduled to expire around 12 November 2026. GitHub Actions archives are not permanent release download pages. The portable Windows QA kit is **unsigned fictional QA software**, not an installer.

Both latest **real hosted Windows** screenshots were opened and inspected. They show a single custom RENTAL CONTRACT heading, correct R001/C002 identity, Active/Overdue badges, duration/rate, start/expected and actual return rows, Mint BOOKED CONTRACT TOTAL `R 1,400.00`, explicit **Booked value, not a payment receipt**, read-only summary and visible Close. At the two tested logical viewport sizes, no visible clipping of these elements was observed. This does **not** prove all physical OS scaling modes or Narrator announcements.

## Owner physical acceptance still required

Use the newest 5 November fictional QA kit (artifact `13412208694`), or GitHub Desktop Pull on the P7 branch then Qt Creator 6.10.2 MinGW `rental-studio-local` build of `rental_studio_qtquick_spike`. Read `SOURCE_COMMIT.txt` before testing the portable executable. Run `Launch-Rental-Studio.cmd` after extracting all files.

For the owner: test sidebar Up/Down then Enter, Overview three Right/Left quick actions, Fleet caret/filters/Gallery/Table and Enter inspect, Rentals All/Overdue/Find/record bidirectional arrows, Enter opening contract read-only and Escape restoring focus. Confirm a single contract heading, correct monetary disclaimer, hovering and red irreversible actions, no unexpected booking/return/archive/delete and adequate visible focus. Repeat where safe at actual OS 100%, 125% and 150% scaling, Narrator, and the Qt Creator 6.10.2 MinGW kit. Use [separate 16-check review form](UX_CTRL_002_003_OWNER_PHYSICAL_QA_2026-11-05.md), recording observed PASS/FAIL/NOT TESTED and exact commit, kit, window size and screenshots.

**No new owner acceptance granted by hosted CI.** Formal **45/74 owner-accepted, 70.6% fixed-weight, P5 8/8, P6 9/9, P7 0/8** remains unchanged. No PR merged; no protected main change, no production SQLite cutover, no payments, no real customer information and no release certification.
