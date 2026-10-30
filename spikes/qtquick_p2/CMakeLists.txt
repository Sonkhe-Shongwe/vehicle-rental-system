# Real Qt Quick proof, opt-in only. This does not replace the Qt Widgets target.
find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Test)
qt_add_executable(rental_studio_qtquick_spike main.cpp)
target_link_libraries(rental_studio_qtquick_spike
    PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::QuickControls2 Qt6::Test)
target_compile_definitions(rental_studio_qtquick_spike
    PRIVATE RENTAL_STUDIO_DEMO_DIR="${PROJECT_SOURCE_DIR}/demo")
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
    QML_FILES Main.qml)
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
