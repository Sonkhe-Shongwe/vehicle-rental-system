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
