ifneq ($(SCAFFOLDED), 1)
include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk
endif

npm ?= npm
npm_bin ?= `$(npm) bin`

js_tests_output = $(build_dir)/tests/js/report
js_mocha_unit_test_files = $(test_dir)/*_test.js
js_mocha_integration_test_files = $(test_dir)/integration/*.js

js_istanbul_unit_test_files ?= $(js_mocha_unit_test_files)
js_istanbul_flags ?= --report lcov --dir $(js_tests_output)
js_istanbul_extra_flags ?=

js_complexity_flags = --format markdown
js_complexity_files = $(source_dir)

js_jshint_flags = --config $(scaffold_config_dir)/jshintrc.json
js_jshint_files = $(source_dir) $(test_dir)

js_jscs_flags = --config $(scaffold_config_dir)/jscsrc.json --reporter inline
js_jscs_extra_flags ?=
js_jscs_files = $(source_dir) $(test_dir)
js_jscs_report_file = $(build_dir)/source/js/complexity.md

.PHONY: js-complexity js-configure js-coveralls js-jscs js-jshint js-lint \
    js-mocha js-mocha-coverage js-test js-test-coverage

help::
	@echo
	@echo "js:"
	@echo "  js-configure                       # bootstrap plugin"
	@echo "  js-jscs                            # run jscs against \"$(js_jscs_files)\""
	@echo "  js-jshint                          # run jshint against \"$(js_jshint_files)\""
	@echo "  js-complexity                      # run cr against \"$(js_complexity_files)\""
	@echo "  js-complexity-report               # run cr against \"$(js_complexity_files)\" and save to \"$(js_jscs_report_file)\""
	@echo "  js-mocha                           # test \"$(js_mocha_unit_test_files)\" with mocha"
	@echo "  js-mocha-integration               # test \"$(js_mocha_integration_test_files)\" with mocha"
	@echo "  js-mocha-coveralls                 # test \"$(js_istanbul_unit_test_files)\" with mocha and save report to \"$(js_tests_output)\""
	@echo "  js-coveralls                       # send coverage report to coveralls.io"
	@echo "  js-lint                            # alias for js-complexity, js-jshint, and js-jscs"
	@echo "  js-test                            # alias for js-mocha"
	@echo "  js-test-coverage                   # alias for js-mocha-coverage"
	@echo
	@echo "  \$$js_tests_output                   # test coverage report location ($(js_tests_output))"
	@echo "  \$$js_mocha_unit_test_files          # mocha unit tests glob ($(js_mocha_unit_test_files))"
	@echo "  \$$js_mocha_integration_test_files   # mocha integration tests glob ($(js_mocha_integration_test_files))"
	@echo "  \$$js_istanbul_unit_test_files       # mocha istanbul unit tests glob ($(js_istanbul_unit_test_files))"
	@echo "  \$$js_istanbul_flags                 # default flags for istanbul ($(js_istanbul_flags))"
	@echo "  \$$js_istanbul_extra_flags           # user flags for istanbul ($(js_istanbul_extra_flags))"
	@echo "  \$$js_complexity_flags               # default flags for complexity report ($(js_complexity_flags))"
	@echo "  \$$js_complexity_files               # complexity report files glob ($(js_complexity_files))"
	@echo "  \$$js_jshint_flags                   # default jshint flags ($(js_jshint_flags))"
	@echo "  \$$js_jshint_files                   # jshint files glob ($(js_jshint_files))"
	@echo "  \$$js_jscs_flags                     # default jscs flags ($(js_jscs_flags))"
	@echo "  \$$js_jscs_extra_flags               # user jscs flags ($(js_jscs_extra_flags))"
	@echo "  \$$js_jscs_files                     # jscs files globl ($(js_jscs_files))"
	@echo "  \$$js_jscs_report_file               # jscs report file name ($(js_jscs_report_file))"

js-configure:
	$(npm) i --save-dev istanbul@0.3.2 \
		mocha@2.0.1 \
		complexity-report@1.0.6 \
		jshint@2.5.10 \
		jscs@1.7.3 \
		coveralls@2.11.2

# https://github.com/jscs-dev/node-jscs
js-jscs:
	@$(npm_bin)/jscs $(js_jscs_flags) $(js_jscs_extra_flags) $(js_jscs_files)
	$(call pass, "jscs")

# http://www.jshint.com/docs/
js-jshint:
	@$(npm_bin)/jshint $(js_jshint_flags) $(js_jshint_files)
	$(call pass, "jshint")

# http://jscomplexity.org/complexity
js-complexity:
	@$(npm_bin)/cr $(js_complexity_flags) $(js_complexity_files) --silent
	$(call pass, "js complexity")

js-complexity-report:
	@$(npm_bin)/cr $(js_complexity_flags) $(js_complexity_files) > $(js_jscs_report_file)
	$(call pass, "js complexity (report)")

# http://mochajs.org/
js-mocha:
	@$(npm_bin)/mocha $(js_mocha_unit_test_files)

js-mocha-integration:
	@$(npm_bin)/mocha --timeout 20000 $(js_mocha_integration_test_files)

# https://github.com/gotwarlost/istanbul
js-mocha-coverage:
	@$(npm_bin)/istanbul cover $(npm_bin)/_mocha \
		$(js_istanbul_flags) \
		$(js_istanbul_extra_flags) \
		-- $(js_istanbul_unit_test_files)

# https://coveralls.zendesk.com/hc/en-us
# https://www.npmjs.org/package/coveralls
js-coveralls:
	cat $(js_tests_output)/lcov.info | $(npm_bin)/coveralls

js-test: js-mocha
js-test-coverage: js-mocha-coverage
js-lint: js-complexity js-jshint js-jscs

clean::
	@-if [ -d node_modules ]; then rm -r node_modules; fi
	$(call pass, "removed node_modules directory")
