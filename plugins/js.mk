include $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/base.mk

JS_TESTS_OUTPUT = $(BUILD_DIR)/tests/js/report
JS_MOCHA_UNIT_TEST_FILES = $(TEST_DIR)/*_test.js

JS_ISTANBUL_UNIT_TEST_FILES ?= $(JS_MOCHA_UNIT_TEST_FILES)
JS_ISTANBUL_FLAGS ?= --report lcov --dir $(JS_TESTS_OUTPUT)
JS_ISTANBUL_EXTRA_FLAGS ?=

JS_COMPLEXITY_FLAGS = --format markdown
JS_COMPLEXITY_FILES = $(SOURCE_DIR)

JS_JSHINT_FLAGS = --config $(CONFIG_DIR)/jshintrc.json
JS_JSHINT_FILES = $(SOURCE_DIR) $(TEST_DIR)

JS_JSCS_FLAGS = --config $(CONFIG_DIR)/jscsrc.json
JS_JSCS_FILES = $(SOURCE_DIR) $(TEST_DIR)

.PHONY: js-complexity js-configure js-coveralls js-jscs js-jshint js-lint \
    js-mocha js-mocha-coverage js-test js-test-coverage

js-configure:
	$(NPM) i --save-dev istanbul@0.3.2
	$(NPM) i --save-dev mocha@2.0.1
	$(NPM) i --save-dev complexity-report@1.0.6
	$(NPM) i --save-dev jshint@2.5.10
	$(NPM) i --save-dev jscs@1.7.3
	$(NPM) i --save-dev coveralls@2.11.2

# https://github.com/jscs-dev/node-jscs
js-jscs:
	$(NPM_BIN)/jscs $(JS_JSCS_FLAGS) $(JS_JSCS_FILES)

# http://www.jshint.com/docs/
js-jshint:
	$(NPM_BIN)/jshint $(JS_JSHINT_FLAGS) $(JS_JSHINT_FILES)

# http://jscomplexity.org/complexity
js-complexity:
	$(NPM_BIN)/cr $(JS_COMPLEXITY_FLAGS) $(JS_COMPLEXITY_FILES)

# http://mochajs.org/
js-mocha:
	$(NPM_BIN)/mocha $(JS_MOCHA_UNIT_TEST_FILES)

# https://github.com/gotwarlost/istanbul
js-mocha-coverage:
	$(NPM_BIN)/istanbul cover $(NPM_BIN)/_mocha \
		$(JS_ISTANBUL_FLAGS) \
		$(JS_ISTANBUL_EXTRA_FLAGS) \
		-- $(JS_ISTANBUL_UNIT_TEST_FILES)

# https://coveralls.zendesk.com/hc/en-us
# https://www.npmjs.org/package/coveralls
js-coveralls:
	cat $(JS_TESTS_OUTPUT)/lcov.info | $(NPM_BIN)/coveralls

js-test: js-mocha
js-test-coverage: js-mocha-coverage
js-lint: js-complexity js-jshint js-jscs
