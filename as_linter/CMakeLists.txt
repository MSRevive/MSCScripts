cmake_minimum_required(VERSION 3.16)
project(as_linter LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Static MSVC runtime for standalone distribution
if(MSVC)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    add_compile_options(/W3 /EHsc)
    add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
endif()

# Paths to AngelScript SDK and addons in the game repo
set(AS_ROOT "${CMAKE_SOURCE_DIR}/../../../Documents/GitHub/MSC/MasterSwordRebirth/thirdparty/angelscript")
set(ADDON_ROOT "${CMAKE_SOURCE_DIR}/../../../Documents/GitHub/MSC/MasterSwordRebirth/src/game/shared/ms/angelscript/addons")

# Allow overriding from command line
if(DEFINED ANGELSCRIPT_ROOT)
    set(AS_ROOT "${ANGELSCRIPT_ROOT}")
endif()
if(DEFINED ADDON_DIR)
    set(ADDON_ROOT "${ADDON_DIR}")
endif()

message(STATUS "AngelScript SDK: ${AS_ROOT}")
message(STATUS "Addons dir:      ${ADDON_ROOT}")

# Collect AngelScript SDK source files
file(GLOB AS_SDK_SOURCES "${AS_ROOT}/*.cpp")

# Addon source files
set(ADDON_SOURCES
    "${ADDON_ROOT}/scriptstdstring/scriptstdstring.cpp"
    "${ADDON_ROOT}/scriptstdstring/scriptstdstring_utils.cpp"
    "${ADDON_ROOT}/scriptarray/scriptarray.cpp"
    "${ADDON_ROOT}/scriptdictionary/scriptdictionary.cpp"
    "${ADDON_ROOT}/scriptbuilder/scriptbuilder.cpp"
    "${ADDON_ROOT}/scriptmath/scriptmath.cpp"
)

# Our linter source files
set(LINTER_SOURCES
    src/main.cpp
    src/linter_engine.cpp
    src/linter_registration.cpp
    src/linter_report.cpp
    src/linter_include_handler.cpp
)

add_executable(as_linter
    ${LINTER_SOURCES}
    ${AS_SDK_SOURCES}
    ${ADDON_SOURCES}
)

target_include_directories(as_linter PRIVATE
    "${AS_ROOT}/include"
    "${ADDON_ROOT}"
    "${CMAKE_SOURCE_DIR}/src"
)

# On Windows x86, AngelScript needs the asm caller
if(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 4)
    target_compile_definitions(as_linter PRIVATE AS_MAX_PORTABILITY)
endif()
