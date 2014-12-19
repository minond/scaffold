BASE_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../
CONFIG_DIR = $(BASE_DIR)/config
BUILD_DIR = build

SOURCE_DIR = src
TEST_DIR = test

NPM = npm
NPM_BIN = `$(NPM) bin`

.PHONY: clean all

all:: clean

clean::
	@if [ -d $(BUILD_DIR) ]; then rm -r $(BUILD_DIR); fi
