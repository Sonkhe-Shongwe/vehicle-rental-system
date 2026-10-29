# Development continuity | 29 October 2026

**Goal:** Portfolio-ready C++/Qt Vehicle Rental System for a remote Software Engineer (Full-Stack) Graduate application due **30 October 2026**.

**Actual repository at audit start:** Public but empty. First documentation commit bootstrapped on `main`. Original code is in an uploaded local ZIP, **not yet the GitHub source tree**.

**Prepared local upgrade ZIP:** Complete original C++/Qt application with isolated test-directory constructor, `QSaveFile` saves and error propagation, rental-ledger authoritative status, non-mutating loading, tighter domain validation, CTest tests, fictional data, .gitignore, GitHub Actions definition and source documentation. Raw customer records and customer screenshots removed. Original input ZIP remains untouched.

**Verification boundary:** Qt dev libraries are absent from audit environment; CMake configuration blocked before compile. Actual Qt Creator build, CTest and GUI walkthrough must occur before claiming success.

**Next:** Upload the *revised* local package into the initialized repo, run Qt build and CTest, complete manual smoke test, publish sanitized results and use the project in the application. Maintain `docs/AUDIT.md`, `docs/ROADMAP.md` and this file after substantial changes.

**Preservation:** Do not overwrite user data. Default storage still uses legacy `__FILE__` source directory for compatibility. Source was originally authored in July 2026. Avoid rewriting the GUI for deadline. Current project is desktop Qt, **not a finished full-stack web/API product**.

**Known open risks:** Missing Qt execution evidence; silent invalid historical row skipping; path/install migration; IDs reused after deletion; floating-point money; incomplete storage-level durability; monolithic MainWindow; no SQLite/REST API.
