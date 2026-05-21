# This is called CMakeLists.txt — it tells CMake how to build this project.
# Every CMake project must have one at the top level.

# ----------------------------------------------------------------
# 1. REQUIRE A MINIMUM CMAKE VERSION
# ----------------------------------------------------------------
# "cmake_minimum_required" sets the lowest CMake version this file supports.
# If the user's CMake is older, CMake will print an error and stop.
cmake_minimum_required(VERSION 3.16)

# ----------------------------------------------------------------
# 2. GIVE THE PROJECT A NAME
# ----------------------------------------------------------------
# "project()" names the project. CMake uses this name for generated
# files, IDE integration, and exports.
project(cpp_testing)

# ----------------------------------------------------------------
# 3. SET BUILD TYPE TO DEBUG (so debugger can find symbols)
# ----------------------------------------------------------------
# "Debug" adds the -g flag so GDB can see variable names, line
# numbers, and breakpoints. Change to "Release" for optimised builds.
set(CMAKE_BUILD_TYPE Debug)

# ----------------------------------------------------------------
# 5. SET C++ STANDARD
# ----------------------------------------------------------------
# We want C++17 (or 14/20). "set()" changes a CMake variable.
# CMAKE_CXX_STANDARD tells the compiler which C++ version to use.
set(CMAKE_CXX_STANDARD 17)
# Make the standard a hard requirement (not a fallback).
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# ----------------------------------------------------------------
# 4. BUILD THE LIBRARY (static)
# ----------------------------------------------------------------
# "add_library" creates a reusable library target.
# STATIC means it becomes a .a file (an archive of compiled code).
# We list the source file(s) that belong to this library.
add_library(my_lib STATIC utils.cpp)

# "target_include_directories" tells the compiler where to find header
# files when compiling anything that links against my_lib.
# The "PUBLIC" keyword means: anyone who links to my_lib also gets
# this include path automatically.
# "${CMAKE_CURRENT_SOURCE_DIR}" is the folder where CMakeLists.txt lives.
target_include_directories(my_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# ----------------------------------------------------------------
# 6. BUILD THE APPLICATION
# ----------------------------------------------------------------
# "add_executable" creates a runnable program from source files.
add_executable(sum_app main.cpp)

# "target_link_libraries" says: when building sum_app, also compile and
# link in my_lib. The PRIVATE keyword means the link is needed only
# by sum_app itself, not by anything that links sum_app.
target_link_libraries(sum_app PRIVATE my_lib)

# ----------------------------------------------------------------
# 7. BUILD TESTS (using Google Test)
# ----------------------------------------------------------------
# We enable testing support. This lets us use "ctest" and "make test".
enable_testing()

# --- 6a. Download Google Test automatically ---
# FetchContent is a CMake module that downloads code from the internet
# during the "configure" step. We use it so you don't have to install
# GTest manually.
include(FetchContent)

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG        v1.17.0
)

# "FetchContent_MakeAvailable" actually downloads and builds the library.
# If you already have a local copy, it skips the download.
FetchContent_MakeAvailable(googletest)

# --- 6b. Create test executable ---
add_executable(utils_test utils_test.cpp)

# Link the test against our library AND GTest.
# GTest's CMake installs targets named GTest::gtest and GTest::gtest_main.
# gtest_main provides a main() so you don't have to write one.
target_link_libraries(
  utils_test
  PRIVATE
    my_lib
    GTest::gtest
    GTest::gtest_main
)

# "gtest_discover_tests" is a convenient GTest helper that
# automatically finds and registers every TEST() macro in the binary.
# After this, "ctest" will run all discovered tests.
include(GoogleTest)
gtest_discover_tests(utils_test)
