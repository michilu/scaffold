all: app/build

GO_LIST=$(shell go list)
GOPATH=$(shell go env GOPATH)
GOPHERJS=app/web/gopher.js
GO=$(shell find . -type d -name vendor -prune -o -type f -name "*.go" -print)

gopherjs: $(GOPHERJS)
$(GOPHERJS): $(GO)
	@# https://github.com/gopherjs/gopherjs/issues/598#issuecomment-282563634
	-find $(GOPATH)/pkg -depth 1 -type d -name "*_js" -exec rm -fr {} \;
	-find $(GOPATH)/pkg -depth 1 -type d -name "*_js_min" -exec rm -fr {} \;
	gopherjs build --tags gopherjs $(GO_LIST)/hackernews/gopherjs --output $@

PUB_SPEC=$(shell find . -type d -name build -prune -o -type f -name pubspec.yaml -print)
PUB_LOCK=$(PUB_SPEC:.yaml=.lock)
.SUFFIXES: .yaml .lock
.yaml.lock:
	(cd $(dir $@) && pub get)

app/.packages: $(PUB_LOCK)
	(cd $(dir $@) && pub get)

DART=hackernews/dart/lib/hackernews.dart
G_DART=$(DART:.dart=.g.dart)
.SUFFIXES: .dart .g.dart
.dart.g.dart:
	(cd hackernews/dart && pub run build_runner build)

app/build: $(GOPHERJS) $(PUB_LOCK) app/.packages $(G_DART)
	(cd app\
	&& pub run build_runner build --config=release --fail-on-severe --output build\
	&& pub run pwa --exclude ".DS_Store,packages/**,.packages,*.dart,*.js.deps,*.js.info.json,*.js.map,*.js.tar.gz,*.module"\
	)

serve: $(GOPHERJS) $(PUB_LOCK) $(G_DART)
	(cd app && pub run --mode=debug build_runner serve)

test:
	go test -v $(GO_LIST)/hackernews

deploy: app/build
	firebase deploy

clean:
	find . -name .DS_Store -delete

.PHONY: app/build
