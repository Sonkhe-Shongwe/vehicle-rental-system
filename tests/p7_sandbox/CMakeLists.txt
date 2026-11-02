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

# P7-G: direct, opt-in, real RentalSystem / RentalConfirmService / SQLite
# adapter seam. Strictly generated fictional local temp roots; NO Qt GUI,
# commercial persistence migration, real customer data, or app QtSql linkage.
add_executable(rental_studio_p7_domain_bridge
    p7_domain_bridge_tests.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_confirm_service.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_quote_service.cpp
    ${PROJECT_SOURCE_DIR}/rentalsystem.cpp
    ${PROJECT_SOURCE_DIR}/rental.cpp
    ${PROJECT_SOURCE_DIR}/vehicle.cpp
    ${PROJECT_SOURCE_DIR}/car.cpp
    ${PROJECT_SOURCE_DIR}/motorcycle.cpp)
target_include_directories(rental_studio_p7_domain_bridge
    PRIVATE ${PROJECT_SOURCE_DIR})
target_link_libraries(rental_studio_p7_domain_bridge PRIVATE Qt6::Core Qt6::Sql)
foreach(CASE IN ITEMS booking lifecycle failure)
    add_test(NAME rental_studio_p7_bridge_${CASE}
        COMMAND rental_studio_p7_domain_bridge ${CASE})
endforeach()
set_tests_properties(
    rental_studio_p7_bridge_booking
    rental_studio_p7_bridge_lifecycle
    rental_studio_p7_bridge_failure
    PROPERTIES TIMEOUT 40)

# P7-H: normalized typed repository using exact cents + atomic IDs in one
# transaction. OFF by default with P7 sandbox, no GUI / PII / data import.
add_executable(rental_studio_p7_normalized_repository
    p7_normalized_repository_tests.cpp)
target_include_directories(rental_studio_p7_normalized_repository PRIVATE ${PROJECT_SOURCE_DIR})
target_link_libraries(rental_studio_p7_normalized_repository PRIVATE Qt6::Core Qt6::Sql)
add_test(NAME rental_studio_p7_normalized_lifecycle COMMAND rental_studio_p7_normalized_repository lifecycle)
add_test(NAME rental_studio_p7_normalized_rollback COMMAND rental_studio_p7_normalized_repository rollback)
add_test(NAME rental_studio_p7_normalized_money_ids COMMAND rental_studio_p7_normalized_repository money_ids)
add_test(NAME rental_studio_p7_normalized_future_schema COMMAND rental_studio_p7_normalized_repository future_schema)
add_test(NAME rental_studio_p7_normalized_contention COMMAND rental_studio_p7_normalized_repository contention)
set_tests_properties(
    rental_studio_p7_normalized_lifecycle rental_studio_p7_normalized_rollback
    rental_studio_p7_normalized_money_ids rental_studio_p7_normalized_future_schema
    rental_studio_p7_normalized_contention PROPERTIES TIMEOUT 45)

# P7-I: real Qt Quick UI -> QObject command facade -> P7-H normalized SQLite.
# Opt-in ONLY via BUILD_P7_SQLITE_SANDBOX, independent preview executable,
# unique generated temporary fictional database; NOT normal Rental Studio.
find_package(Qt6 6.5 REQUIRED COMPONENTS Gui Qml Quick QuickControls2 Test)
add_executable(rental_studio_p7_qml_preview
    p7_qml_preview_tests.cpp
    ${PROJECT_SOURCE_DIR}/src/application/p7_sandbox/repository_preview_controller.h)
target_include_directories(rental_studio_p7_qml_preview PRIVATE ${PROJECT_SOURCE_DIR})
target_link_libraries(rental_studio_p7_qml_preview PRIVATE
    Qt6::Core Qt6::Sql Qt6::Gui Qt6::Qml Qt6::Quick Qt6::QuickControls2 Qt6::Test)
qt_add_resources(rental_studio_p7_qml_preview p7_fictional_qml
    PREFIX "/p7" FILES p7_fictional_preview.qml)
add_test(NAME rental_studio_p7_qml_journey COMMAND rental_studio_p7_qml_preview journey)
add_test(NAME rental_studio_p7_qml_rollback COMMAND rental_studio_p7_qml_preview rollback)
set_tests_properties(
    rental_studio_p7_qml_journey rental_studio_p7_qml_rollback
    PROPERTIES TIMEOUT 40)
