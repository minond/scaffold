include plugins/base.mk

.PHONY: minify-cofigure

minify-cofigure:
	$(NPM) i --save jsmin cssmin htmlmin
