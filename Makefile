# Makefile

# Copyright(c) 2023, Santu Das, Corp. All rights reserved.
#

VENV_DIR := env
PYTHON := $(VENV_DIR)/bin/python
PIP := $(VENV_DIR)/bin/pip

.PHONY: setup format lint test clean

# Default target
all: setup format lint test

# Create a virtual environment
setup:
	python3 -m venv $(VENV_DIR)
	$(PIP) install -r requirements.txt

# Format code using Black
format:
	$(PYTHON) -m black . --check --diff

# Lint code using Flake8
lint:
	$(PYTHON) -m flake8

# Run unit tests
test:
	$(PYTHON) -m unittest discover -s tests -p "test_*.py" --verbose

# Clean up virtual environment and generated files
clean:
	rm -rf $(VENV_DIR)
	find . -type f -name *.pyc -delete
	find . -type d -name __pycache__ -delete