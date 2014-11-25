include plugins/exec.mk

.PHONY: minify-cofigure

minify-cofigure:
	$(NPM) i --save jsmin cssmin htmlmin
