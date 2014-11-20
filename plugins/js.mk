NPM = npm
NPM_BIN = `$(NPM) bin`

JS_FILES = src/**.js
JS_TESTS = tests/**.js

JS_TESTS_OUTPUT = build/tests/js/report

JS_COMPLEXITY_FLAGS = --format markdown
JS_COMPLEXITY_FILES = $(JS_FILES)

JS_JSHINT_FLAGS = --config $(CONFIG_DIR)/jshintrc.json
JS_JSHINT_FILES = $(JS_FILES) $(JS_TESTS)

JS_JSCS_FILES = $(JS_FILES) $(JS_TESTS)

.PHONY: js-configure js-complexity js-test js-test-coverage js-hint \
    js-coveralls js-jscs

js-configure:
	$(NPM) i --save-dev istanbul@0.3.2
	$(NPM) i --save-dev mocha@2.0.1
	$(NPM) i --save-dev complexity-report@1.0.6
	$(NPM) i --save-dev jshint@2.5.10
	$(NPM) i --save-dev jscs@1.7.3

js-jscs:
	$(NPM_BIN)/jscs $(JS_JSCS_FILES)

js-jshint:
	$(NPM_BIN)/jshint $(JS_JSHINT_FLAGS) $(JS_JSHINT_FILES)

js-complexity:
	$(NPM_BIN)/cr $(JS_COMPLEXITY_FLAGS) $(JS_COMPLEXITY_FILES)

js-mocha:
	$(NPM_BIN)/mocha $(JS_TESTS)

js-mocha-coverage:
	$(NPM_BIN)/istanbul cover $(NPM_BIN)/_mocha --report lcov \
		--dir $(JS_TESTS_OUTPUT) -- -R spec $(JS_TESTS) --recursive

js-coveralls:
	cat $(JS_TESTS_OUTPUT)/lcov.info | $(NPM_BIN)/coveralls

js-test: js-mocha
js-test-coverage: js-mocha-coverage
js-lint: js-complexity js-jshint js-jscs