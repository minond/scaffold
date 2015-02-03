ifneq ($(SCAFFOLDED), 1)
include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk
endif

SCAFFOLDED_NPM = 1

npm ?= npm
npm_bin ?= node_modules/.bin

help::
	@echo
	@echo "npm:"
	@echo "  npm-install     # runs npm install"
	@echo
	@echo "  \$$npm            # npm binary ($(npm))"
	@echo "  \$$npm_bin        # node module binaries ($(npm_bin))"

npm-install:
	@npm install
