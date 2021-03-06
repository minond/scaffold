ifneq ($(SCAFFOLDED), 1)
include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk
endif

ifneq ($(SCAFFOLDED_JS), 1)
include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/js.mk
endif

SCAFFOLDED_ES6 = 1

js_mocha_flags = --compilers js:mocha-traceur

es6_babel_output ?= -d $(build_dir)/$(source_dir)
es6_babel_input ?= $(source_dir)
es6_babel_flags ?=

es6_eslint_files ?= $(source_dir) $(test_dir)
es6_eslint_flags ?= --config .scaffold/config/eslint.json

.PHONY: es6-configure es6-compile

help::
	@echo
	@echo "es6:"
	@echo "  es6-configure                      # bootstrap plugin"
	@echo "  es6-compile                        # run babel \"$(es6_babel_input)\" => \"$(es6_babel_output)\""
	@echo
	@echo "  \$$es6_babel_output                  # compiled js output directory ($(es6_babel_output))"
	@echo "  \$$es6_babel_input                   # es6 code directory ($(es6_babel_input))"
	@echo "  \$$es6_babel_flags                   # flags passed to babel ($(es6_babel_flags))"
	@echo
	@echo "  [\$$js_mocha_flags]                  # flags passed to mocha ($(js_mocha_flags))"

es6-configure:
	$(npm) i --save-dev mocha-traceur babel eslint babel-eslint

# https://babeljs.io/docs/using-babel
es6-compile:
	@$(npm_bin)/babel $(es6_babel_flags) $(es6_babel_output) $(es6_babel_input)
	$(call pass, "babel")

# https://medium.com/@dan_abramov/lint-like-it-s-2015-6987d44c5b48
es6-lint:
	@$(npm_bin)/eslint $(es6_eslint_flags) $(es6_eslint_files)
	$(call pass, "eslint")
