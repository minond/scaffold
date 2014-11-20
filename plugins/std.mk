BASE_DIR = vendor/minond/scaffold
CONFIG_DIR = $(BASE_DIR)/config
BUILD_DIR = build

.PHONY: clean

clean:
	@if [ -d $(BUILD_DIR) ]; then rm -r $(BUILD_DIR); fi
