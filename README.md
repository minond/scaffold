`scaffold` - scaffolded build tasks using [GNU
Make](http://ftp.gnu.org/old-gnu/Manuals/make-3.79.1/html_chapter/make_1.html).

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
-include vendor/minond/scaffold/plugins/js.mk

install:
	npm install

dependencies:
	git submodule update --init

lint: dependencies js-lint
test: dependencies js-test
```

now you can run `make test` or `make lint` and this will run tasks defined as
javascript tests and javascript code analysis in `plugins/js.mk` (see source
for details)

#### conventions

1. plugins should provide a `[name]-configure` target that does anything needed
   to use the plugin. this includes things such as installing dependencies
   or outputting instructions on how to do so. `make [name]-configure` should
   only be ran once per project, so if it does things that are environment
   specific, or need to be repeated, this needs to go under another target.

2. always roll your own `dependencies` target that downloads the `scaffold`
   project and puts it in the right location. I preffer to use submodule for
   this. (see [install](#install) section)
