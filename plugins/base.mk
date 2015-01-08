# scaffold directory structure
BASE_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../
CONFIG_DIR = $(BASE_DIR)/config

# project directory structure
BUILD_DIR = build
SOURCE_DIR = src
TEST_DIR = test

# standard packages and libs/bins
NPM = npm
NPM_BIN = `$(NPM) bin`

# output helpers
ok = ✔

.PHONY: clean all

default::

clean::
	-rm -r $(BUILD_DIR)
