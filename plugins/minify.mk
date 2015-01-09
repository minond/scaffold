ifneq ($(SCAFFOLDED), 1)
include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk
endif

npm ?= npm
npm_bin ?= `$(npm) bin`

jsmin = $(npm_bin)/jsmin
cssmin = $(npm_bin)/cssmin
htmlmin = $(npm_bin)/htmlmin

.PHONY: minify-configure

help::
	@echo
	@echo "minify:"
	@echo "  minify-configure     # bootstrap plugin"
	@echo
	@echo "  \$$jsmin               # jsmin binary ($(jsmin))"
	@echo "  \$$cssmin              # cssmin binary ($(cssmin))"
	@echo "  \$$htmlmin             # htmlbin binary ($(htmlmin))"

minify-configure:
	$(npm) i --save jsmin cssmin htmlmin
