# P7 D1 | Owner authorization: SQLite intended engine and fictional-only Qt Quick integration

**Decision date:** 2 November 2026. **Decision category:** narrowly scoped owner authorization for engineering, not a production, privacy, migration, sales or release approval.

## Exact decision and scope

The owner explicitly answered **"YES I APPROVE"** to the immediately preceding request:

> "Do you approve SQLite as the intended storage engine for a fictional-only integration into Rental Studio, while keeping all real customer data disabled and the remaining commercial/privacy decisions pending?"

**Recorded result: D1 SQLite choice APPROVED for the stated fictional-only integration scope.** The intended future offline single-operator storage engine is SQLite through a typed C++/QtSql repository, subject to remaining policy and acceptance gates.

This permission authorizes a controlled, explicitly selected **generated-fictional SQLite integration into the actual Rental Studio Qt Quick executable**, with a safe pre-existing QSaveFile default. It does **not** authorize silent switching of the normal real workflow, true customer/contact records, automatic legacy import, unapproved schema migration, operational backups, installer or a merge/release.

## Implemented first controlled integration, P7-O

[P7-O source](https://github.com/Sonkhe-Shongwe/vehicle-rental-system/commit/4c63b6a34240c2c762f14976b928f5fb7b54078b) provides a fourth opt-in **SQLite Lab** workspace in the actual `rental_studio_qtquick_spike` executable.

Safety gates:
- The build option `BUILD_P7_SQLITE_SANDBOX` remains **OFF by default**. Only when explicitly ON does the Qt Quick target compile/link QtSql and the already-isolated fictional repository/controller and value-only Fleet read model.
- The lab appears **only** for `--p7-fictional-sql-lab` or dedicated `--p7-fictional-sql-app-smoke` CI mode. The parser rejects combining these with persistent demo/other modes. There is **no general path argument or input**, automatic migration or real-data acceptance.
- `PreviewController` creates its own temporary generated-fictional SQLite DB with exact marker and C001 sample, and destroys it at process end. The normal Overview, Fleet and Rentals still read and write only their prior protected synthetic text files.
- Real Qt Quick lab commands use typed SQLite quote, committed booking, return, archive and retire; Fleet and Rentals read model refresh signals occur **only on a successful commit**; failed booking issues no receipt or new rental and does not change available vehicle counts.
- Both 1500×860 and 1280×720 real-application native tests verify the isolation, success and failure paths, and unchanged hashes/bytes of protected legacy demo fixtures. They are test scenarios, not operator acceptance.

## Decisions NOT approved by the owner message

The other [P7 D1–D8 proposals](P7_OWNER_DECISION_BRIEF_2026-11-02.md) remain pending and must not be automatically upgraded:
- **D2:** business-specific price ceilings and real historical money policy.
- **D3:** migration high-water policy for unknown deleted identifiers.
- **D4:** commercial retirement, retention and history deletion rules.
- **D5:** purpose, privacy, access, retention and deletion of real contact/licence data.
- **D6:** physical storage root, backup encryption, retention, restore and OS permissions.
- **D7:** any legacy file inspection/import, cutover or migration approvals.
- **D8:** final P7 acceptance rubric, physical Windows MinGW/scaling/Narrator/QA and commercial rollout.

The owner may approve additional decisions separately. **"Continue"/"next" does not equal blanket permission for these.** P7 formal acceptance remains 0/8; total 28/74 formally accepted, 40.6% weighted until formal rubric/owner acceptance evidence changes. P8 installer and P9 release QA remain not started. No merge, main update or public release is authorized.
