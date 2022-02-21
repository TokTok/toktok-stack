# We need this for $(...) to work.
SHELL = bash

#######################################
# MyPy type checking

THIS_REPO_FILES := $(shell $(LS_FILES) | sed -e 's@^$(CURDIR)/@@' | grep -E -v $(FILTER))
PYTHON_LIB_FILES := $(filter-out .%,$(sort $(shell ls $(filter %.py,$(THIS_REPO_FILES)))))
PYTHON_BIN_FILES := $(shell ls $(THIS_REPO_FILES) | xargs grep -l '^\#!/usr/bin/.*python3')

MYPY_FLAGS :=				\
	--disallow-any-explicit		\
	--disallow-redefinition		\
	--color-output			\
	--strict

mypy: $(PYTHON_BIN_FILES:=.mypy)

%.mypy: % $(PYTHON_LIB_FILES)
	@echo "  MYPY  $<"
	@mypy $(MYPY_FLAGS) $+
