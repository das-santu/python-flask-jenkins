# Makefile

# Copyright(c) 2023, Santu Das, Corp. All rights reserved.
#

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Make for App Management
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

VENV_DIR := env
PYTHON := $(VENV_DIR)/bin/python
PIP := $(VENV_DIR)/bin/pip

.PHONY: setup format lint test clean

# Default target
all: setup format lint test

# Create a virtual environment and install dependencies
setup:
	@echo -e '\nInstalling Python3 Virtual Environment..................!\n'
	python3 -m venv $(VENV_DIR)
	@echo -e '\n\nInstalling App Dependencies.............................!\n'
	$(PIP) install --no-cache-dir -r requirements.txt
	@echo -e '\nApp environment setup has been successfully completed...!\n'

# Format code using Black
format:
	$(PYTHON) -m black . --check --diff

# Lint code using Flake8
lint:
	$(PYTHON) -m flake8

# Format and Lint code using Black and Flake8
ctest: format lint

# Run unit tests
test:
	$(PYTHON) -m unittest discover -s tests -p "test_*.py" --verbose

# Start the app
run:
	$(PYTHON) -m flask run --host=0.0.0.0 --debug

# Clean up virtual environment and generated files
clean:
	rm -rf $(VENV_DIR)
	find . -type f -name *.pyc -delete
	find . -type d -name __pycache__ -delete

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Make for Bump Version
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Bump app patch version
bump-patch:
	$(PYTHON) -m bumpversion patch

# Bump app minor version
bump-minor:
	$(PYTHON) -m bumpversion minor

# Bump app major version
bump-major:
	$(PYTHON) -m bumpversion major

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Make for Docker Management
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

JSON_FILE = version.json
CONTAINER_NAME = $(shell jq -r .NAME $(JSON_FILE))
VERSION = $(shell jq -r .VERSION $(JSON_FILE))
APP_PORT = $(shell jq -r .APP_PORT $(JSON_FILE))
DOCKER_HUB_USER = $(shell jq -r .DOCKER_HUB_USER $(JSON_FILE))
DOCKER_IMAGE_NAME = ${DOCKER_HUB_USER}/${CONTAINER_NAME}:${VERSION}

# Build app docker image
docker-build:
	docker build . -t ${DOCKER_IMAGE_NAME}

# Run docker app container
docker-run:
	docker run -d --name $(CONTAINER_NAME) -p ${APP_PORT}:${APP_PORT} $(DOCKER_IMAGE_NAME)

# Get bash of app container
docker-bash:
	docker exec -it $(CONTAINER_NAME) bash

# Start docker app container
docker-start:
	docker start $(CONTAINER_NAME)

# Stop docker app container
docker-stop:
	docker stop $(CONTAINER_NAME)

# Remove docker app container
docker-rm:
	docker rm -f $(CONTAINER_NAME)

# Remove app docker image
docker-rmi:
	docker rmi -f $(DOCKER_IMAGE_NAME)

# Stop and Remove app docker container
docker-clean: docker-stop docker-rm

.PHONY: docker-build docker-run docker-bash docker-start docker-stop docker-rm docker-rmi docker-clean