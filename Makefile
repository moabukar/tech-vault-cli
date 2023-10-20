# vars
PROJECT_NAME := techvault
DOCKER_IMG_NAME := moabukar/techvault
VERSION := 1.0
TEST_PATH := ./pkg/questions/
FILES   := $(shell git ls-files */*.go)

all: build

build:
	@echo "Building $(PROJECT_NAME)..."
	go build -o $(PROJECT_NAME) ./cmd/techvault

# 'make run' to build and run CLI
run: build
	@echo "Running $(PROJECT_NAME)..."
	./$(PROJECT_NAME)

.PHONY: setup
setup: ## Install required libraries/tools for build tasks
	@command -v gofumpt 2>&1 >/dev/null       || go install mvdan.cc/gofumpt@v0.3.1
	@command -v golangci-lint 2>&1 >/dev/null || go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.45.2


.PHONY: fmt
fmt: setup ## Format source code
	gofumpt -w $(FILES)

.PHONY: lint
lint: setup ## Run all lint related tests upon the codebase
	golangci-lint run -v --fast

test:
	@echo "Running tests in $(TEST_PATH)..."
	go test -v $(TEST_PATH)

docker-build:
	@echo "Building Docker image $(DOCKER_IMG_NAME):$(VERSION)..."
	docker build -t $(DOCKER_IMG_NAME):$(VERSION) .

docker-run: docker-build
	@echo "Running Docker container from image $(DOCKER_IMG_NAME):$(VERSION)..."
	docker run --rm $(DOCKER_IMG_NAME):$(VERSION)

.PHONY: release
release: ## Build & release the binaries (stable)
	git tag -d edge
	goreleaser release --rm-dist
	find dist -type f -name "*.snap" -exec snapcraft upload --release stable,edge '{}' \;

.PHONY: prerelease
prerelease: setup ## Build & prerelease the binaries (edge)
	@\
		REPOSITORY=$(REPOSITORY) \
    	NAME=$(NAME) \
    	GITHUB_TOKEN=$(GITHUB_TOKEN) \
    	.github/prerelease.sh

# 'make clean' will remove the compiled Go application
clean:
	@echo "Cleaning..."
	go clean
	rm -f $(PROJECT_NAME)

