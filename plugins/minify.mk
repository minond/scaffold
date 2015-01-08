include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk

.PHONY: minify-configure

jsmin = $(npm_bin)/jsmin
cssmin = $(npm_bin)/cssmin
htmlmin = $(npm_bin)/htmlmin

minify-configure:
	$(npm) i --save jsmin cssmin htmlmin
