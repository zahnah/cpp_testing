# Fast shortcuts for common CMake operations
# Usage: make build   — compile everything
#        make run     — run sum_app (pass CLI args via ARGS, e.g. make run ARGS="3 4")
#        make test    — run tests via ctest
#        make clean   — remove build directory

BUILD_DIR ?= build
APP       ?= $(BUILD_DIR)/sum_app
ARGS      ?= 3 4

.PHONY: all build run test clean rebuild

all: build

configure:
	cmake -B $(BUILD_DIR)

build: configure
	cmake --build $(BUILD_DIR)

run: build
	$(APP) $(ARGS)

test: build
	cd $(BUILD_DIR) && ctest --output-on-failure

clean:
	rm -rf $(BUILD_DIR)

rebuild: clean all
