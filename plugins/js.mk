ifneq ($(SCAFFOLDED), 1)
include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk
endif

js_tests_output = $(build_dir)/tests/js/report
js_mocha_unit_test_files = $(test_dir)/*_test.js
js_mocha_integration_test_files = $(test_dir)/integration/*.js

js_istanbul_unit_test_files ?= $(js_mocha_unit_test_files)
js_istanbul_flags ?= --report lcov --dir $(js_tests_output)
js_istanbul_extra_flags ?=

js_complexity_flags = --format markdown
js_complexity_files = $(source_dir)

js_jshint_flags = --config $(config_dir)/jshintrc.json
js_jshint_files = $(source_dir) $(test_dir)

js_jscs_flags = --config $(config_dir)/jscsrc.json --reporter inline
js_jscs_extra_flags ?=
js_jscs_files = $(source_dir) $(test_dir)
js_jscs_report_file = $(build_dir)/source/js/complexity.md

.PHONY: js-complexity js-configure js-coveralls js-jscs js-jshint js-lint \
    js-mocha js-mocha-coverage js-test js-test-coverage

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
	@echo $(ok) jscs

# http://www.jshint.com/docs/
js-jshint:
	@$(npm_bin)/jshint $(js_jshint_flags) $(js_jshint_files)
	@echo $(ok) jshint

# http://jscomplexity.org/complexity
js-complexity:
	@$(npm_bin)/cr $(js_complexity_flags) $(js_complexity_files) --silent
	@echo $(ok) js complexity

js-complexity-report:
	@$(npm_bin)/cr $(js_complexity_flags) $(js_complexity_files) > $(js_jscs_report_file)
	@echo $(ok) js complexity (report)

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
	-rm -r node_modules
