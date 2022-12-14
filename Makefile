#VERSION ?= $(shell git describe --tags)
COMMIT  ?= $(shell git rev-parse HEAD)
LDFLAGS ?= -X main.version=${VERSION} -X main.commit=${COMMIT}

.PHONY: build
build:
	@echo "==> Building native binary"
	@GO111MODULE=on go build -mod=vendor -v -ldflags="${LDFLAGS}" -o github-repo-activity ./cmd/cli
	@GO111MODULE=on go build -mod=vendor -v -ldflags="${LDFLAGS}" -o github-repo-activity-server ./cmd/server

.PHONY: test
test:
	@echo "==> Running tests"
	@GO111MODULE=on go test -mod=vendor -v ./...

.PHONY: vendor
vendor:
	@echo "==> Updating vendored packages"
	@GO111MODULE=on go mod tidy
	@GO111MODULE=on go mod vendor
