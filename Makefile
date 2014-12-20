include plugins/base.mk
include plugins/js.mk
include plugins/minify.mk

all:: check-versions

check-versions:
	@$(MAKE) tmp clean
	@echo '{}' > package.json
	@$(MAKE) js-configure
	@$(MAKE) minify-configure
	@$(NPM) install npm-check-updates
	cat package.json
	$(NPM_BIN)/npm-check-updates
	@$(MAKE) clean untmp

tmp:
	@mkdir .tmp
	@cd .tmp

untmp:
	@cd ..
	@if [ -d .tmp ]; then rm -r .tmp; fi

clean::
	@if [ -d node_modules ]; then rm -r node_modules; fi
	@if [ -f package.json ]; then rm package.json; fi
