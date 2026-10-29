cmake_minimum_required(VERSION 3.16)

project(VehicleRentalSystem_A3 VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOUIC OFF)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

set(PROJECT_SOURCES
    main.cpp
    mainwindow.cpp
    mainwindow.h
    vehicle.cpp
    vehicle.h
    car.cpp
    car.h
    motorcycle.cpp
    motorcycle.h
    rental.cpp
    rental.h
    rentalsystem.cpp
    rentalsystem.h
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(VehicleRentalSystem_A3
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
else()
    add_executable(VehicleRentalSystem_A3
        ${PROJECT_SOURCES}
    )
endif()

target_link_libraries(VehicleRentalSystem_A3
    PRIVATE Qt${QT_VERSION_MAJOR}::Widgets
)

set_target_properties(VehicleRentalSystem_A3 PROPERTIES
    WIN32_EXECUTABLE TRUE
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(VehicleRentalSystem_A3)
endif()

# Tests exercise the domain without opening the GUI. Each test uses QTemporaryDir.
include(CTest)
if(BUILD_TESTING)
    add_executable(vehicle_rental_tests
        tests/rental_system_tests.cpp
        vehicle.cpp car.cpp motorcycle.cpp rental.cpp rentalsystem.cpp
    )
    target_include_directories(vehicle_rental_tests PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
    target_link_libraries(vehicle_rental_tests PRIVATE Qt${QT_VERSION_MAJOR}::Core)
    add_test(NAME vehicle_rental_domain COMMAND vehicle_rental_tests)
endif()
