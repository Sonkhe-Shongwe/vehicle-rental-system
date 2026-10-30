# Real Qt Quick proof, opt-in only. This does not replace the Qt Widgets target.
find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Test)
qt_add_executable(rental_studio_qtquick_spike main.cpp
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
    ${PROJECT_SOURCE_DIR}/src/application/rental_archive_controller.cpp)
target_link_libraries(rental_studio_qtquick_spike
    PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::QuickControls2 Qt6::Test)
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
    QML_FILES Main.qml DesignTokens.qml FocusFrame.qml WorkspaceNavButton.qml
              AccessibleTextField.qml DomainMessage.qml RentalStatusLabel.qml
              ConfirmActionDialog.qml)
if(BUILD_TESTING)
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
    # P4 shared QML token/focus/shell regression at real native window sizes.
    add_test(NAME rental_studio_p4_shared_shell_wide
        COMMAND rental_studio_qtquick_spike --p4-shell-smoke)
    add_test(NAME rental_studio_p4_shared_shell_compact
        COMMAND rental_studio_qtquick_spike --p4-shell-smoke --compact)
    set_tests_properties(
        rental_studio_p4_shared_shell_wide
        rental_studio_p4_shared_shell_compact
        PROPERTIES ENVIRONMENT "QT_QUICK_BACKEND=software" TIMEOUT 55)
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
