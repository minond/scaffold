include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk

.PHONY: minify-cofigure

JSMIN = $(NPM_BIN)/jsmin
CSSMIN = $(NPM_BIN)/cssmin
HTMLMIN = $(NPM_BIN)/htmlmin

minify-configure:
	$(NPM) i --save jsmin cssmin htmlmin
