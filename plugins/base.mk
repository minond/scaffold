BASE_DIR = vendor/minond/scaffold
CONFIG_DIR = $(BASE_DIR)/config
BUILD_DIR = build

NPM = npm
NPM_BIN = `$(NPM) bin`

.PHONY: clean

clean::
	@if [ -d $(BUILD_DIR) ]; then rm -r $(BUILD_DIR); fi
