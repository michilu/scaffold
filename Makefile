all: app/build

PUB_SPEC=$(shell find . -type d -name build -prune -o -type f -name pubspec.yaml -print)
PUB_LOCK=$(PUB_SPEC:.yaml=.lock)
.SUFFIXES: .yaml .lock
.yaml.lock:
	(cd $(dir $@) && pub get)

app/.packages: $(PUB_LOCK)
	(cd $(dir $@) && pub get)

app/build: app/.packages
	(cd app\
	&& pub run build_runner build --config=release --fail-on-severe --output build\
	&& pub run pwa --exclude "packages/**,.packages,*.dart,*.js.deps,*.js.info.json,*.js.map,*.js.tar.gz,*.module"\
	)

deploy: app/build
	firebase deploy

.PHONY: app/build
