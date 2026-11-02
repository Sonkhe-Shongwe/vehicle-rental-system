# Real Qt Quick proof, opt-in only. This does not replace the Qt Widgets target.
find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Test)
qt_add_executable(rental_studio_qtquick_spike main.cpp
    p5_synthetic_session.h p5_synthetic_session.cpp
    motion_policy.h motion_policy.cpp
    fleet_add_controller.h fleet_add_controller.cpp
    fleet_remove_controller.h fleet_remove_controller.cpp
    p6_archived_delete_controller.h p6_archived_delete_controller.cpp
    ${PROJECT_SOURCE_DIR}/src/application/fleet_read_service.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_read_service.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_list_model.h
    ${PROJECT_SOURCE_DIR}/src/application/rental_list_model.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_quote_service.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_confirm_service.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_return_controller.h
    ${PROJECT_SOURCE_DIR}/src/application/rental_return_controller.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_booking_controller.h
    ${PROJECT_SOURCE_DIR}/src/application/rental_booking_controller.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_archive_controller.h
    ${PROJECT_SOURCE_DIR}/src/application/rental_archive_controller.cpp
    ${PROJECT_SOURCE_DIR}/src/application/rental_admin_commands.cpp)
target_link_libraries(rental_studio_qtquick_spike
    PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::QuickControls2 Qt6::Test)
if(WIN32)
    target_link_libraries(rental_studio_qtquick_spike PRIVATE user32)
endif()
# Explicit fictional-only integration into this REAL Qt Quick executable.
# NOT the default workspace, not commercial storage and not a Widgets change.
if(BUILD_P7_SQLITE_SANDBOX)
    find_package(Qt6 6.5 REQUIRED COMPONENTS Sql)
    target_link_libraries(rental_studio_qtquick_spike PRIVATE Qt6::Sql)
    target_compile_definitions(rental_studio_qtquick_spike PRIVATE RENTAL_STUDIO_P7_SQL_LAB=1)
    target_sources(rental_studio_qtquick_spike PRIVATE
        ${PROJECT_SOURCE_DIR}/src/application/p7_sandbox/sqlite_repository.h
        ${PROJECT_SOURCE_DIR}/src/application/p7_sandbox/sqlite_read_projection.h
        ${PROJECT_SOURCE_DIR}/src/application/p7_sandbox/fictional_fleet_snapshot.h
        ${PROJECT_SOURCE_DIR}/src/application/p7_sandbox/fictional_operations_snapshot.h
        ${PROJECT_SOURCE_DIR}/src/application/p7_sandbox/repository_preview_controller.h)
endif()
# Compile the SHA-256 of the exact fictional fixtures into the executable.
# Neither a portable kit nor Qt Creator may ingest arbitrary operational records.
file(SHA256 "${PROJECT_SOURCE_DIR}/demo/vehicles.txt" P2_VEHICLES_SHA256)
file(SHA256 "${PROJECT_SOURCE_DIR}/demo/rentals.txt" P2_RENTALS_SHA256)
target_compile_definitions(rental_studio_qtquick_spike PRIVATE
    RENTAL_STUDIO_DEMO_DIR="${PROJECT_SOURCE_DIR}/demo"
    RENTAL_STUDIO_DEMO_VEHICLES_SHA256="${P2_VEHICLES_SHA256}"
    RENTAL_STUDIO_DEMO_RENTALS_SHA256="${P2_RENTALS_SHA256}")
target_include_directories(rental_studio_qtquick_spike PRIVATE "${PROJECT_SOURCE_DIR}")
target_sources(rental_studio_qtquick_spike PRIVATE
    "${PROJECT_SOURCE_DIR}/vehicle.cpp"
    "${PROJECT_SOURCE_DIR}/car.cpp"
    "${PROJECT_SOURCE_DIR}/motorcycle.cpp"
    "${PROJECT_SOURCE_DIR}/rental.cpp"
    "${PROJECT_SOURCE_DIR}/rentalsystem.cpp")
# Opt in to the standard qrc:/qt/qml prefix for engine.loadFromModule.
qt_policy(SET QTP0001 NEW)
qt_add_qml_module(rental_studio_qtquick_spike
    URI RentalStudioSpike
    VERSION 1.0
    QML_FILES Main.qml DesignTokens.qml FocusFrame.qml VehicleSilhouette.qml WorkspaceNavButton.qml FleetAddDialog.qml FleetRemoveDialog.qml P6ArchivedDeleteDialog.qml
              AccessibleTextField.qml DomainMessage.qml RentalStatusLabel.qml
              ConfirmActionDialog.qml OverviewMetricCard.qml P7FictionalSqlLab.qml)
if(BUILD_TESTING)
    if(BUILD_P7_SQLITE_SANDBOX)
        foreach(SIZE wide compact)
            set(P7_ARGS --p7-fictional-sql-app-smoke)
            if(SIZE STREQUAL "compact")
                list(APPEND P7_ARGS --compact)
            endif()
            add_test(NAME rental_studio_p7_actual_app_lab_${SIZE}
                COMMAND rental_studio_qtquick_spike ${P7_ARGS})
            set_tests_properties(rental_studio_p7_actual_app_lab_${SIZE}
                PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 65)
        endforeach()
    endif()
    # Real separate executable processes, opt-in fixed Qt TEST location.
    # Cleanup has its own fixture so CTest also runs it after failures.
    add_test(NAME rental_studio_p5_session_seed
        COMMAND rental_studio_qtquick_spike --p5-session-seed-test)
    add_test(NAME rental_studio_p5_session_reopen
        COMMAND rental_studio_qtquick_spike --p5-session-reopen-test)
    add_test(NAME rental_studio_p5_session_tamper
        COMMAND rental_studio_qtquick_spike --p5-session-tamper-test)
    add_test(NAME rental_studio_p5_session_clean
        COMMAND rental_studio_qtquick_spike --p5-session-clean-test)
    set_tests_properties(rental_studio_p5_session_seed PROPERTIES
        FIXTURES_SETUP p5_synthetic_session
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen" TIMEOUT 25)
    set_tests_properties(rental_studio_p5_session_reopen PROPERTIES
        FIXTURES_REQUIRED p5_synthetic_session
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen" TIMEOUT 25)
    set_tests_properties(rental_studio_p5_session_tamper PROPERTIES
        FIXTURES_REQUIRED p5_synthetic_session
        DEPENDS rental_studio_p5_session_reopen
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen" TIMEOUT 25)
    set_tests_properties(rental_studio_p5_session_clean PROPERTIES
        FIXTURES_CLEANUP p5_synthetic_session
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen" TIMEOUT 25)
    # P5 live native QML first booking, second-process real QML Dashboard
    # recovery, and isolated deterministic disk-write rollback.
    add_test(NAME rental_studio_p5_ui_session_seed
        COMMAND rental_studio_qtquick_spike --p5-ui-session-seed-test)
    add_test(NAME rental_studio_p5_ui_session_reopen
        COMMAND rental_studio_qtquick_spike --p5-ui-session-reopen-test)
    add_test(NAME rental_studio_p5_ui_session_clean
        COMMAND rental_studio_qtquick_spike --p5-ui-session-clean-test)
    set_tests_properties(rental_studio_p5_ui_session_seed PROPERTIES
        FIXTURES_SETUP p5_qml_persistent_session
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 55)
    set_tests_properties(rental_studio_p5_ui_session_reopen PROPERTIES
        FIXTURES_REQUIRED p5_qml_persistent_session
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 55)
    set_tests_properties(rental_studio_p5_ui_session_clean PROPERTIES
        FIXTURES_CLEANUP p5_qml_persistent_session
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen" TIMEOUT 20)
    add_test(NAME rental_studio_p5_ui_write_failure_wide
        COMMAND rental_studio_qtquick_spike --p5-ui-write-failure-test)
    add_test(NAME rental_studio_p5_ui_write_failure_compact
        COMMAND rental_studio_qtquick_spike --p5-ui-write-failure-test --compact)
    set_tests_properties(
        rental_studio_p5_ui_write_failure_wide
        rental_studio_p5_ui_write_failure_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 55)
    add_test(NAME rental_studio_p2_model COMMAND rental_studio_qtquick_spike --self-test)
    set_tests_properties(rental_studio_p2_model PROPERTIES
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen"
        TIMEOUT 20)
    add_test(NAME rental_studio_p2_qml_wide COMMAND rental_studio_qtquick_spike --ui-smoke)
    add_test(NAME rental_studio_p2_qml_compact COMMAND rental_studio_qtquick_spike --ui-smoke --compact)
    add_test(NAME rental_studio_p2_keyboard_resize COMMAND rental_studio_qtquick_spike --input-smoke)
    set_tests_properties(rental_studio_p2_keyboard_resize PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software"
        TIMEOUT 35)
    add_test(NAME rental_studio_p2_arrows_focus COMMAND rental_studio_qtquick_spike --arrows-smoke)
    set_tests_properties(rental_studio_p2_arrows_focus PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software"
        TIMEOUT 40)
    add_test(NAME rental_studio_p2_focus_edges COMMAND rental_studio_qtquick_spike --focus-edges-smoke)
    set_tests_properties(rental_studio_p2_focus_edges PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software"
        TIMEOUT 40)
    add_test(NAME rental_studio_p6_fleet_add_wide COMMAND rental_studio_qtquick_spike --p6-fleet-add-smoke)
    add_test(NAME rental_studio_p6_fleet_add_compact COMMAND rental_studio_qtquick_spike --p6-fleet-add-smoke --compact)
    set_tests_properties(rental_studio_p6_fleet_add_wide rental_studio_p6_fleet_add_compact PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 65)
    # P6-B: real native keyboard-driven confirmation, cancel/Escape,
    # rented-vehicle refusal, failed atomic writer rollback and reopen.
    add_test(NAME rental_studio_p6_fleet_remove_wide
        COMMAND rental_studio_qtquick_spike --p6-fleet-remove-smoke)
    add_test(NAME rental_studio_p6_fleet_remove_compact
        COMMAND rental_studio_qtquick_spike --p6-fleet-remove-smoke --compact)
    set_tests_properties(rental_studio_p6_fleet_remove_wide
        rental_studio_p6_fleet_remove_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 70)
    # P6-C: real Qt keyboard archive -> exact-confirmed permanent deletion.
    # Tests include Cancel/Escape, invalid phrase, active/returned refusal,
    # rejected storage commit rollback, fixed synthetic mode denial and restart.
    add_test(NAME rental_studio_p6_archived_delete_wide
        COMMAND rental_studio_qtquick_spike --p6-archived-delete-smoke)
    add_test(NAME rental_studio_p6_archived_delete_compact
        COMMAND rental_studio_qtquick_spike --p6-archived-delete-smoke --compact)
    set_tests_properties(rental_studio_p6_archived_delete_wide
        rental_studio_p6_archived_delete_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 75)
    # P6-M: full Qt operator journey across three independent executables,
    # exact stage-allowlisted fictional files, positive and refusal paths.
    add_test(NAME rental_studio_p6_integrated_wide
        COMMAND rental_studio_qtquick_spike --p6-integrated-flow)
    add_test(NAME rental_studio_p6_integrated_compact
        COMMAND rental_studio_qtquick_spike --p6-integrated-flow --compact)
    set_tests_properties(rental_studio_p6_integrated_wide
        rental_studio_p6_integrated_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 155)
    # P6-E: each CTest itself launches three genuinely independent native
    # Qt GUI processes within a unique parent-owned disposable synthetic root.
    # Original fixture hashes and strict child allowlisting protect all inputs.
    add_test(NAME rental_studio_p6_cross_process_wide
        COMMAND rental_studio_qtquick_spike --p6-restart-flow)
    add_test(NAME rental_studio_p6_cross_process_compact
        COMMAND rental_studio_qtquick_spike --p6-restart-flow --compact)
    set_tests_properties(rental_studio_p6_cross_process_wide
        rental_studio_p6_cross_process_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 150)
    # P3-F: genuine QQuickWindow and delegate-backed Rentals state, selection
    # and refresh after a committed C++ fictional-domain operation.
    add_test(NAME rental_studio_p3_rentals_qml_wide
        COMMAND rental_studio_qtquick_spike --rentals-smoke)
    add_test(NAME rental_studio_p3_rentals_qml_compact
        COMMAND rental_studio_qtquick_spike --rentals-smoke --compact)
    set_tests_properties(
        rental_studio_p3_rentals_qml_wide
        rental_studio_p3_rentals_qml_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 50)
    # P3-H: real wide/compact Qt Quick Active/History filter and keyboard
    # selection checks, never a QML implementation of lifecycle rules.
    add_test(NAME rental_studio_p3_filter_qml_wide
        COMMAND rental_studio_qtquick_spike --rentals-filter-smoke)
    add_test(NAME rental_studio_p3_filter_qml_compact
        COMMAND rental_studio_qtquick_spike --rentals-filter-smoke --compact)
    set_tests_properties(
        rental_studio_p3_filter_qml_wide
        rental_studio_p3_filter_qml_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 50)
    # P3-I: real confirmed-return QML dialog with domain QSaveFile,
    # post-commit only dual-model refresh, and protected demo source files.
    add_test(NAME rental_studio_p3_return_qml_wide
        COMMAND rental_studio_qtquick_spike --rentals-return-smoke)
    add_test(NAME rental_studio_p3_return_qml_compact
        COMMAND rental_studio_qtquick_spike --rentals-return-smoke --compact)
    set_tests_properties(
        rental_studio_p3_return_qml_wide
        rental_studio_p3_return_qml_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 60)
    add_test(NAME rental_studio_p3_booking_qml_wide
        COMMAND rental_studio_qtquick_spike --rentals-booking-smoke)
    add_test(NAME rental_studio_p3_booking_qml_compact
        COMMAND rental_studio_qtquick_spike --rentals-booking-smoke --compact)
    set_tests_properties(
        rental_studio_p3_booking_qml_wide
        rental_studio_p3_booking_qml_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 60)
    add_test(NAME rental_studio_p3_archive_qml_wide
        COMMAND rental_studio_qtquick_spike --rentals-archive-smoke)
    add_test(NAME rental_studio_p3_archive_qml_compact
        COMMAND rental_studio_qtquick_spike --rentals-archive-smoke --compact)
    set_tests_properties(
        rental_studio_p3_archive_qml_wide
        rental_studio_p3_archive_qml_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 60)
    # All booking-dismissal paths clear uncommitted contact data, revoke
    # C++ quotes, show honest cancellation and never write a rental.
    add_test(NAME rental_studio_p5_booking_cancel_wide
        COMMAND rental_studio_qtquick_spike --p5-booking-cancel-smoke)
    add_test(NAME rental_studio_p5_booking_cancel_compact
        COMMAND rental_studio_qtquick_spike --p5-booking-cancel-smoke --compact)
    set_tests_properties(
        rental_studio_p5_booking_cancel_wide
        rental_studio_p5_booking_cancel_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 65)
    # P5 stale rate and occupancy both require explicit fresh review; a
    # rejected quote cannot write an optimistic receipt or duplicate rental.
    add_test(NAME rental_studio_p5_stale_quote_wide
        COMMAND rental_studio_qtquick_spike --p5-stale-quote-smoke)
    add_test(NAME rental_studio_p5_stale_quote_compact
        COMMAND rental_studio_qtquick_spike --p5-stale-quote-smoke --compact)
    set_tests_properties(
        rental_studio_p5_stale_quote_wide
        rental_studio_p5_stale_quote_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 60)
    # P5 operator workflow: selected real C++ Fleet item into the guided
    # booking modal with a prefilled authoritative quote and no duplicate CTA.
    add_test(NAME rental_studio_p5_fleet_booking_wide
        COMMAND rental_studio_qtquick_spike --p5-fleet-to-booking-smoke)
    add_test(NAME rental_studio_p5_fleet_booking_compact
        COMMAND rental_studio_qtquick_spike --p5-fleet-to-booking-smoke --compact)
    set_tests_properties(
        rental_studio_p5_fleet_booking_wide
        rental_studio_p5_fleet_booking_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 60)
    # P6-K: purpose-limited native contract detail dialog, true actual dates,
    # hidden-selection guards, modal Escape/focus and no accidental writes.
    add_test(NAME rental_studio_p6_contract_detail_wide
        COMMAND rental_studio_qtquick_spike --p6-contract-detail-smoke)
    add_test(NAME rental_studio_p6_contract_detail_compact
        COMMAND rental_studio_qtquick_spike --p6-contract-detail-smoke --compact)
    set_tests_properties(
        rental_studio_p6_contract_detail_wide
        rental_studio_p6_contract_detail_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 60)
    # P6-J: genuine Qt window recent-contract read model and hidden-history
    # read-only routing at two sizes with source byte nonmutation.
    add_test(NAME rental_studio_p6_recent_activity_wide
        COMMAND rental_studio_qtquick_spike --p6-recent-activity-smoke)
    add_test(NAME rental_studio_p6_recent_activity_compact
        COMMAND rental_studio_qtquick_spike --p6-recent-activity-smoke --compact)
    set_tests_properties(
        rental_studio_p6_recent_activity_wide
        rental_studio_p6_recent_activity_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 60)
    # P5 scoped operational Overview: C++-owned KPIs, post-commit refresh,
    # real wide/compact QQuickWindow and selection-independent totals.
    add_test(NAME rental_studio_p5_overview_wide
        COMMAND rental_studio_qtquick_spike --p5-overview-smoke)
    add_test(NAME rental_studio_p5_overview_compact
        COMMAND rental_studio_qtquick_spike --p5-overview-smoke --compact)
    set_tests_properties(
        rental_studio_p5_overview_wide
        rental_studio_p5_overview_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 65)
    # P4 shared QML token/focus/shell regression at real native window sizes.
    add_test(NAME rental_studio_p4_shared_shell_wide
        COMMAND rental_studio_qtquick_spike --p4-shell-smoke)
    add_test(NAME rental_studio_p4_shared_shell_compact
        COMMAND rental_studio_qtquick_spike --p4-shell-smoke --compact)
    set_tests_properties(
        rental_studio_p4_shared_shell_wide
        rental_studio_p4_shared_shell_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 55)
    # Real component extraction regressions: native fields + shared modal
    # confirmation with explicit Cancel/Escape and zero disk mutations.
    add_test(NAME rental_studio_p4_components_wide
        COMMAND rental_studio_qtquick_spike --p4-components-smoke)
    add_test(NAME rental_studio_p4_components_compact
        COMMAND rental_studio_qtquick_spike --p4-components-smoke --compact)
    set_tests_properties(
        rental_studio_p4_components_wide
        rental_studio_p4_components_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 65)
    add_test(NAME rental_studio_p4_focus_route_wide
        COMMAND rental_studio_qtquick_spike --p4-tab-smoke)
    add_test(NAME rental_studio_p4_focus_route_compact
        COMMAND rental_studio_qtquick_spike --p4-tab-smoke --compact)
    set_tests_properties(
        rental_studio_p4_focus_route_wide
        rental_studio_p4_focus_route_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 65)
    # Validate the actual Qt accessibility interfaces and native keyboard
    # selection-state changes on both real viewport sizes, with fake files.
    add_test(NAME rental_studio_p4_accessibility_wide
        COMMAND rental_studio_qtquick_spike --p4-a11y-smoke)
    add_test(NAME rental_studio_p4_accessibility_compact
        COMMAND rental_studio_qtquick_spike --p4-a11y-smoke --compact)
    set_tests_properties(
        rental_studio_p4_accessibility_wide
        rental_studio_p4_accessibility_compact
        PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software;QT_LINUX_ACCESSIBILITY_ALWAYS_ON=1"
        TIMEOUT 65)
    # P4: both preference modes, both actual window sizes, live preference
    # change and protected synthetic file assertions. Never mutate host OS.
    foreach(MODE ordinary reduced)
        foreach(SIZE wide compact)
            set(args --p4-motion-smoke)
            if(MODE STREQUAL "reduced")
                list(APPEND args --p4-reduce-motion)
            endif()
            if(SIZE STREQUAL "compact")
                list(APPEND args --compact)
            endif()
            add_test(NAME rental_studio_p4_motion_${MODE}_${SIZE}
                     COMMAND rental_studio_qtquick_spike ${args})
            set_tests_properties(rental_studio_p4_motion_${MODE}_${SIZE}
                PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 55)
        endforeach()
    endforeach()
    add_test(NAME rental_studio_p2_synthetic_125 COMMAND rental_studio_qtquick_spike --dpi-smoke)
    add_test(NAME rental_studio_p2_synthetic_150 COMMAND rental_studio_qtquick_spike --dpi-smoke)
    set_tests_properties(rental_studio_p2_synthetic_125 PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software;QT_SCALE_FACTOR=1.25"
        TIMEOUT 35)
    set_tests_properties(rental_studio_p2_synthetic_150 PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software;QT_SCALE_FACTOR=1.5"
        TIMEOUT 35)
    set_tests_properties(rental_studio_p2_qml_wide rental_studio_p2_qml_compact PROPERTIES
        ENVIRONMENT "QT_QUICK_BACKEND=software"
        TIMEOUT 40)
endif()
