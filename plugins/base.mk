SCAFFOLDED = 1

# scaffold directory structure
scaffold_base_dir = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../
scaffold_config_dir = $(scaffold_base_dir)config

# project directory structure
build_dir = build
source_dir = src
test_dir = test

# output helpers
pass = @echo "  `tput setaf 150`✔`tput sgr0`$1"
fail = @echo "  `tput setaf   1`×`tput sgr0`$1"
work = @echo "  `tput setaf 226`-`tput sgr0`$1"

.PHONY: clean default

help::
	@echo "Scaffold v0.0.0"
	@echo
	@echo "base:"
	@echo "  default         # whatever you want it to do"
	@echo "  clean           # delete output files"
	@echo "  rescaffold      # update scaffold package to lastest version"
	@echo
	@echo "  \$$build_dir      # name of build directory ($(build_dir))"
	@echo "  \$$source_dir     # name of main source directory ($(source_dir))"
	@echo "  \$$test_dir       # name of tests directory ($(test_dir))"

default::

clean::
	@-if [ -d $(build_dir) ]; then rm -r $(build_dir); fi
	$(call pass, "removed $(build_dir) directory")

rescaffold:
	$(call work, "updatating")
	@cd $(scaffold_base_dir); \
		git fetch --all &> /dev/null; \
		git pull --rebase origin master &> /dev/null; \
	$(call pass, "scaffold updated")
