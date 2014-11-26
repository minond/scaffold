include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk

.PHONY: minify-cofigure

JSMIN = $(NPM_BIN)/jsmin
CSSMIN = $(NPM_BIN)/cssmin
HTMLMIN = $(NPM_BIN)/htmlmin

minify-cofigure:
	$(NPM) i --save jsmin cssmin htmlmin
