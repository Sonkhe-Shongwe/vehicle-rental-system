# Rental Studio 2.0 | First hands-on Windows functionality preview

**Status:** Functional **fictional-only QA preview**, NOT a Windows installer, final fleet population, production-data import or release certification. Exact tested commit in `SOURCE_COMMIT.txt`. The application comes with its Qt runtime libraries and **five generated fictional test vehicles**, not a finished vehicle catalogue.

## Launch the application

1. Download **the entire** `p2-windows-physical-acceptance-kit` ZIP from the verified GitHub Actions run, then **Extract All** into a new ordinary local folder (for example, Documents). Never run from within the ZIP or copy DLLs out separately. Do not place it in a customer/rental-data folder.
2. Double-click **`Launch-Rental-Studio.cmd`**. It opens the real Qt desktop application using protected fictional records only. No administrator rights, network calls or changes to Windows Display settings. The script strips inherited Qt test overrides from its own child environment.
3. If Windows security or antivirus warns about an unsigned executable, **do not override your device's policy**. This is a source-built QA artifact, not an approved/signed release. The Microsoft Visual C++ 2015-2022 x64 Redistributable may need to be installed through Microsoft's official installer if absent.
4. To validate the protected demo fixtures without opening the GUI, from a CMD window in the extracted folder run `Launch-Rental-Studio.cmd --verify`. It runs the packaged C++ model self-test against the exact bundled demo records. For additional native packaged GUI checks use the reviewed `Verify-P2-Windows.ps1 -VerifyOnly` and `Verify-P4-Windows.ps1 -VerifyOnly` scripts following your organisation's execution policy.

## Functional walkthrough in the actual app

| Step | Action to perform | What a successful preview should do |
|---|---|---|
| 1 | Open **Overview**, then **Fleet** and **Rentals** | All three workspaces show nonempty, correctly labelled fictional information |
| 2 | In Fleet switch **Gallery/Table**, search/filter and select a vehicle | The selected Inspector agrees with the C++ vehicle ID and availability |
| 3 | Select **Add vehicle**, add one fictional car or motorcycle | A valid temporary vehicle appears without replacing any of the protected five source fixtures |
| 4 | Select an **available** vehicle and choose **Create rental** | Guided quote uses authoritative C++ daily rate; review and confirm with **fictional** contact values only |
| 5 | In Rentals locate the new ID, review active status and **Return** | Availability and rental/Overview metrics refresh only after a successful C++ commit |
| 6 | Try empty or invalid input, duplicate booking, and Cancel/Escape | Invalid operations refuse success; Cancel/Escape do not fabricate a booking receipt |
| 7 | Close and reopen **this default launcher** | It intentionally **resets to the original five fictional records**; everything you created in this preview is temporary |

**Important functional mode distinction:** The default double-click launcher uses disposable, isolated data to let you test Add Vehicle and complete the full fictional lifecycle. **It does not retain changes across launches.** Separately, the executable's existing opt-in `--persistent-fictional-demo` mode supports a fixed fictional-only booking session, **but Fleet creation is intentionally disabled there** pending formal persistent-data rules. Do not interpret one mode as a real business database.

## Record observed problems

If any step fails, note **which action** you performed, whether you used keyboard/mouse, source SHA from `SOURCE_COMMIT.txt`, Windows version and actual Windows display Scale (100/125/150% where supported). Share application-only screenshots and error messages, but no identifying PC/user information or personal customer records.

The launcher adjusts the Qt desktop window to the *available logical screen size* and keeps the established 1024×660 minimum. On a display with less usable space than the minimum, some clipping may remain. Hosted MSVC automation **cannot** substitute for your own physical Windows Qt Creator/MinGW, Narrator or display scaling tests.

## Boundaries

Existing Fleet/Booking/Return workflows are P5/P6 owner-accepted only for **fictional** demo operations. No final five-photo set, final fleet size, real imports, commercial-data policy, signed installer or release exists yet. No task here modifies `main`, merges draft PRs or authorises operating a real rental business.

## Optional one-click automated functionality check

After extracting the ZIP, double-click **Check-Rental-Studio.cmd** to run the real compiled Qt application through **eight** automated fictional-only checks. They cover protected fixture verification before and after, native startup window, separate-process create/book/return/remove journeys at wide and compact sizes, restart/persistence inside an isolated synthetic directory, stale-quote refusal and cancelled-booking refusal. The check does **not** test actual customer persistence or the owner's manual GUI/Narrator experience.

The check writes a uniquely named functional-check-evidence-* folder alongside the executable, containing RESULTS.txt and per-test logs. Re-running creates a separate report without deleting earlier results. A failed result is a genuine diagnostic issue, not approval to bypass security or use real customer data. Review logs for local paths before sharing them. The protected fictional demo files must remain unchanged. Normal double-click Launch-Rental-Studio.cmd still opens the real graphical app for hands-on testing.

Success supports fictional functionality verification only, not commercial-data approval, a manual physical GUI signoff, an installer or release.
