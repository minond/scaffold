`scaffold` - scaffolded build tasks using GNU Make.

#### install

download this code base into your project however you please. I tend to use
[git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules), like
this: `git submodule add http://github.com/minond/scaffold vendor/minond`. just
don't forget to run `git submodule update --init` when you install/update
your project.

#### usage

create a `Makefile` file and `-include` and plugin make files you want to use.
for example, let's say you have a javascript application in which you want to
run linters and unit tests, you could do something like this:

```Makefile
-include vendor/minond/scaffold/plugins/std.mk
-include vendor/minond/scaffold/plugins/js.mk

install:
	git submodule update --init
	npm install

lint: js-lint
test: js-test
```

now you can run `make test` or `make lint` and this will run tasks defined as
javascript tests and javascript code analysis in `plugins/js.mk` (see source
for details)

#### conventions

1. you always need to include include the `plugins/std.mk` plugin, as this
   inclues standard configuration and some generic targes.

2. plugins should provide a `[name]-configure` target that does anything needed
   to use the plugin. this includes things such as installing dependencies
   or outputting instructions. `make [name]-configure` should only be ran
   once per project, so if it does things that are environment specific, this
   needs to go under another command/target.

3. always roll your own `install` target that downloads the `scaffold` project
   and puts it in the right location. I preffer to use submodule for this.
