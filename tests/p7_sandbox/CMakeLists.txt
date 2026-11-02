# Opt-in TEST-ONLY QtSql experiment, never linked to production.
find_package(Qt6 6.5 REQUIRED COMPONENTS Core Sql)
add_executable(rental_studio_p7_sqlite_sandbox p7_sqlite_sandbox_tests.cpp)
target_link_libraries(rental_studio_p7_sqlite_sandbox PRIVATE Qt6::Core Qt6::Sql)
add_test(NAME rental_studio_p7_sqlite_money COMMAND rental_studio_p7_sqlite_sandbox money)
add_test(NAME rental_studio_p7_sqlite_constraints COMMAND rental_studio_p7_sqlite_sandbox constraints)
add_test(NAME rental_studio_p7_sqlite_rollback COMMAND rental_studio_p7_sqlite_sandbox rollback)
add_test(NAME rental_studio_p7_sqlite_restart COMMAND rental_studio_p7_sqlite_sandbox restart)
add_test(NAME rental_studio_p7_sqlite_corrupt COMMAND rental_studio_p7_sqlite_sandbox corrupt)
set_tests_properties(rental_studio_p7_sqlite_money rental_studio_p7_sqlite_constraints
    rental_studio_p7_sqlite_rollback rental_studio_p7_sqlite_restart
    rental_studio_p7_sqlite_corrupt PROPERTIES TIMEOUT 35)

# P7-C is a separate Qt Core-only, fixed-case generated-fixture preflight.
# It never accepts user paths or creates/imports an actual database.
add_executable(rental_studio_p7_legacy_preflight p7_legacy_preflight_tests.cpp)
target_link_libraries(rental_studio_p7_legacy_preflight PRIVATE Qt6::Core)
foreach(CASE IN ITEMS clean duplicates legacy amounts malformed encoding)
    add_test(NAME rental_studio_p7_preflight_${CASE}
        COMMAND rental_studio_p7_legacy_preflight ${CASE})
endforeach()
set_tests_properties(
    rental_studio_p7_preflight_clean
    rental_studio_p7_preflight_duplicates
    rental_studio_p7_preflight_legacy
    rental_studio_p7_preflight_amounts
    rental_studio_p7_preflight_malformed
    rental_studio_p7_preflight_encoding
    PROPERTIES TIMEOUT 35)

# P7-D: machine-readable deterministic issue/aggregate evidence, generated-only.
foreach(CASE IN ITEMS manifest_clean manifest_blocked manifest_incomplete manifest_overflow)
    add_test(NAME rental_studio_p7_report_${CASE}
        COMMAND rental_studio_p7_legacy_preflight ${CASE})
endforeach()
set_tests_properties(
    rental_studio_p7_report_manifest_clean
    rental_studio_p7_report_manifest_blocked
    rental_studio_p7_report_manifest_incomplete
    rental_studio_p7_report_manifest_overflow
    PROPERTIES TIMEOUT 35)

# P7-E: independent staged SQLite backup/recovery proof with generated data only.
# No runtime app or production storage linkage; opted-in via P7 sandbox flag.
add_executable(rental_studio_p7_sqlite_backup p7_sqlite_backup_tests.cpp)
target_link_libraries(rental_studio_p7_sqlite_backup PRIVATE Qt6::Core Qt6::Sql)
foreach(CASE IN ITEMS snapshot readers uncommitted damaged refuse_overwrite locked)
    add_test(NAME rental_studio_p7_backup_${CASE}
        COMMAND rental_studio_p7_sqlite_backup ${CASE})
endforeach()
set_tests_properties(
    rental_studio_p7_backup_snapshot
    rental_studio_p7_backup_readers
    rental_studio_p7_backup_uncommitted
    rental_studio_p7_backup_damaged
    rental_studio_p7_backup_refuse_overwrite
    rental_studio_p7_backup_locked
    PROPERTIES TIMEOUT 45)

# P7-F: real separate-process crash, writer lock, restart and schema refusal;
# independent Qt Core/Sql test binary, protected by OFF-by-default P7 option.
add_executable(rental_studio_p7_sqlite_process p7_sqlite_process_tests.cpp)
target_link_libraries(rental_studio_p7_sqlite_process PRIVATE Qt6::Core Qt6::Sql)
foreach(CASE IN ITEMS recovery contention restart duplicate future_schema)
    add_test(NAME rental_studio_p7_process_${CASE}
        COMMAND rental_studio_p7_sqlite_process ${CASE})
endforeach()
set_tests_properties(
    rental_studio_p7_process_recovery
    rental_studio_p7_process_contention
    rental_studio_p7_process_restart
    rental_studio_p7_process_duplicate
    rental_studio_p7_process_future_schema
    PROPERTIES TIMEOUT 55)
