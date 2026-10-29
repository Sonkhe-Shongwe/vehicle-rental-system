# Deadline-focused engineering roadmap | Application 30 October 2026

## P0: must finish before submitting
1. **Repository import:** Commit complete improved C++/Qt source package, `CMakeLists.txt`, tests, sanitized `demo/` fixtures and safe screenshots. Never use the raw private ZIP for upload.
2. **Reproducible build:** With a Qt Desktop kit, run `cmake -S . -B build -DBUILD_TESTING=ON`, `cmake --build build --config Release`, `ctest --test-dir build -C Release --output-on-failure`. Record output and Qt/compiler versions.
3. **Manual regression:** With disposable data, confirm add/search/rent, double booking prevention, return, archive, deletion, restart and save-error handling. Keep old real data backed up.
4. **Portfolio polish:** README, architecture explanation, screenshots with no customer data, a concise honest CV project bullet and working repository link.

**Stop gate:** If a core test fails, fix it before adding features. Never describe unexecuted tests as passing.

## P1: reliability after the deadline
- Application-data storage and backup-compatible migration.
- Visible parsing/IO errors instead of silently dropping malformed rows.
- Monotonic durable ID allocation and integer-cents money.
- More negative tests and a Windows build verification matrix.

## P2: architecture and testing
- Transactional SQLite persistence with foreign keys and migrations.
- Split the large MainWindow class into smaller widgets/presenters and a repository/service layer.
- CI, code formatting, static analysis, fault injection and reviewer-friendly PR history.

## P3: role-aligned full-stack extensions
- Optional documented REST API and thin web client backed by verified domain rules.
- Authorization, API tests, deployment and cloud fundamentals as separate proved milestones.

## Why this order
Retipuj Zoft values programming fundamentals, testing, debugging, maintenance, collaboration, SQL/APIs, and continuous improvement. A verifiable C++/Qt domain project is valuable already; claiming React, APIs or databases that are not in the code would weaken credibility. Focus on correctness and traceable engineering first.
