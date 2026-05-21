# AGENTS.md — cpp_testing

## Build system
- **CMake** (install via `sudo apt install cmake` or `brew install cmake`).
- **Google Test** is fetched automatically via `FetchContent` — no manual install needed.
- **Compiler**: g++ (or any C++17-capable compiler).

## Quick start
```sh
# Install CMake (if not already installed)
sudo apt install cmake

# Configure the build (creates the "build/" directory)
cmake -B build

# Compile everything (library, app, and tests)
cmake --build build

# Run the app
./build/sum_app 3 4

# Run tests
cd build && ctest
# Or directly:
./build/utils_test
```

## Structure
- `CMakeLists.txt` — the build file (replaces Bazel's BUILD)
- `utils.h` / `utils.cpp` — library source (target `my_lib`)
- `main.cpp` — app entry point (target `sum_app`)
- `utils_test.cpp` — Google Test unit tests (target `utils_test`)
- `build/` — build output (gitignored)

## Quirks
- No CI, no linter, no formatter configured.
- No README. This file is the only developer documentation.
