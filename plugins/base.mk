# scaffold directory structure
base_dir = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../
config_dir = $(base_dir)/config

# project directory structure
build_dir = build
source_dir = src
test_dir = test

# standard packages and libs/bins
npm = npm
npm_bin = `$(npm) bin`

# output helpers
ok = "`tput setaf 150`  ✔`tput sgr0`"
error = "`tput setaf 1`  ×`tput sgr0`"

default::

clean::
	-rm -r $(build_dir)

.PHONY: clean all
