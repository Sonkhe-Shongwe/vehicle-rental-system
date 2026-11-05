# Precision Automotive Light | Rentals Phase 1D source increment

**Date:** 5 November 2026. **Status:** QML source implemented; real Qt compile, native test and owner physical acceptance pending.

Refines the existing Rentals workspace with a stronger Contract Management hierarchy, actual C++ snapshot/unavailable notice, boxed Contract Actions and Contract Views, a labelled read-only contract register, and text-backed lifecycle status pills. Rental IDs, vehicles, due timing and booked amounts stay C++-bound. Existing booking, return, archive, exact-confirmation deletion, filter and keyboard behaviours remain in their established order. No payments, fake customer metadata, fourth workspace, operational datasets, SQL cutover, fixture changes or installer.

**Validation required:** Run complete existing Qt CTests on Linux/Windows and inspect real 1500x860 and 1280x720 images. Owner then reviews with GitHub Desktop Pull and Qt Creator 6.10.2 MinGW, including keyboard, scrolling, return confirmations, contract details, Narrator and 100/125/150% OS scaling where available.

No acceptance increment until evidence. Formal status **45/74 criteria, 70.6% weighted, P7 0/8**. PR #17 remains DRAFT; main untouched.
