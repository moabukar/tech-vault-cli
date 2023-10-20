# vars
PROJECT_NAME := techvault
DOCKER_IMG_NAME := moabukar/techvault
VERSION := 1.0
TEST_PATH := ./pkg/questions/

all: build

build:
	@echo "Building $(PROJECT_NAME)..."
	go build -o $(PROJECT_NAME) ./cmd/techvault

# 'make run' to build and run CLI
run: build
	@echo "Running $(PROJECT_NAME)..."
	./$(PROJECT_NAME)

test:
	@echo "Running tests in $(TEST_PATH)..."
	go test -v $(TEST_PATH)

docker-build:
	@echo "Building Docker image $(DOCKER_IMG_NAME):$(VERSION)..."
	docker build -t $(DOCKER_IMG_NAME):$(VERSION) .

docker-run: docker-build
	@echo "Running Docker container from image $(DOCKER_IMG_NAME):$(VERSION)..."
	docker run --rm $(DOCKER_IMG_NAME):$(VERSION)

# 'make clean' will remove the compiled Go application
clean:
	@echo "Cleaning..."
	go clean
	rm -f $(PROJECT_NAME)
