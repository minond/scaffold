ifneq ($(SCAFFOLDED), 1)
include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk
endif

SCAFFOLDED_NPM = 1

npm ?= npm
npm_bin ?= node_modules/.bin

npm-install:
	@npm install
