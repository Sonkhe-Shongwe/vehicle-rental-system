# Rental Studio 2.0 | Architecture, Actual Source and Decision Boundary

**30 October 2026.** [Canonical current state](PROJECT_STATE_CANONICAL.md) · [Full audit](FULL_DOCUMENT_AUDIT_AND_CONTINUITY_2026-10-30.md) · [Research masterplan](ENGINEERING_MASTERPLAN_RESEARCH_2026-10-30.md).

## Existing software is two different things

**Historical C++17 Qt Widgets code:** working domain/GUI with `RentalSystem`, `Vehicle`, `Car`, `Motorcycle`, 1–365 day immediate rentals, validation, returns, archive and current text persistence. Domain and GUI tests exist. Its aesthetics are rejected. Structural risks: large MainWindow, source-relative files, per-ledger individual QSaveFile atomicity (not joint transaction), floating `double` money, potential ID reuse and weak malformed-row warnings. The rewrite must preserve rules, data protection and rollback.

**P2 source `spike/p2-qtquick-fleet-20261030`:** real, compiled and locally launched **Qt 6 Quick/QML** Fleet proof; optional OFF-by-default CMake target. C++ `QAbstractListModel` reads actual domain records, `QSortFilterProxyModel` shares filters/sort, one selected vehicle ID drives Gallery/Table and Inspector. Only fake, SHA-256-pinned demo files copied into `QTemporaryDir` are loaded. The P2 UI is intentionally read-only, no real new rental save, migration or production images. Hosted Qt6.8.3 8/8 PASS Linux/Windows; user physically ran Qt Creator Qt6.10.2 MinGW Debug and verified Fleet interactions. Formal toolkit choice and full OS DPI acceptance still open.

## Approved interaction design architecture (UX-CTRL-001)

[Keyboard, Focus and Interaction Contract](KEYBOARD_FOCUS_INTERACTION_CONTRACT.md) is owner-approved. It provides behaviour rules, **not a new framework or business layer**: Qt Quick FocusScopes/Control focus policies and GridView/ListView handle local keyboard navigation; Tab/Shift+Tab moves among meaningful groups; the C++ model owns authoritative vehicle IDs and commands; keyboard focus, collection currentIndex and selected vehicle ID stay distinct. Esc dismisses the topmost popup before nonmodal selection. Text fields and ComboBoxes retain native keys. P2 currently implements only Fleet proof, P3 preserves typed state boundaries, P4 extracts minimal repeated UI focus controls, and P5/P6 add rules as real transactional screens exist. No global nearest-element engine, business commands on focus, or speculative action registry.

## Conditional target architecture

```text
Qt Quick/QML presentations (visuals, accessibility, navigation only)
     |
Typed C++ application/view-model layer (commands, results, state)
     |
C++ fleet, price, availability and rental domain rules
     |
Repository abstraction (initial safe legacy adapter)
     |
Persisted data (versioned; SQLite only if separately justified/approved)
```

Do not put pricing or availability truth into QML; do not build one huge QML page/controller. P3 introduces independently testable typed boundaries, P4 unified native components with Tab and group-local arrows, P5 complete persisted Corolla quote/confirmation/cancel/restart/error, P6 full parity, P7 isolated money/ID/storage decision. Same-day-only current business behaviour is retained until scope explicitly changes. Never infer `Pending`, draft-saving, payments, authenticated multiuser, REST, AI/cloud or installation as existing.

**Approval requirement:** Finish P2 physical Windows/keyboard/Qt Creator evidence and owner go/no-go before major architecture migration; retain separate P1 aesthetic/imagery/accessibility gate. Stable main and all draft PRs unmerged until explicit owner consent.
