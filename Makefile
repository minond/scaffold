include plugins/js.mk
include plugins/minify.mk

default:: check-versions clean

check-versions: clean
	@echo '{}' > package.json
	@$(MAKE) js-configure &> /dev/null
	$(call pass, "js-configure")
	@$(MAKE) minify-configure &> /dev/null
	$(call pass, "minify-configure")
	@$(npm) install npm-check-updates &> /dev/null
	$(call pass, "npm-check-updates install")
	@echo
	cat package.json
	$(npm_bin)/npm-check-updates

clean::
	@if [ -f package.json ]; then rm package.json; fi
