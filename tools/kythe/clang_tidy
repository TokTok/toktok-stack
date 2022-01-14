#!/usr/bin/env python3
"""Generates a compilation database and runs clang-tidy on it."""

import logging
import os
import shutil
import subprocess  # nosec
import sys

from typing import List

import builder


_CHECKS = [
    "-checks=-clang-analyzer-security.insecureAPI.strcpy",
]


class LogHandler(logging.Handler):
    """Prints log records in a similar way to Bazel."""

    def __init__(self) -> None:
        """Initialise the logger with cached log level prefix dict."""
        super().__init__()
        self._prefix = {
            logging.INFO: "\x1b[0;32mINFO:\x1b[0m",
            logging.ERROR: "\x1b[1;31mERROR:\x1b[0m",
        }

    def emit(self, record: logging.LogRecord) -> None:
        """Print the log message prefixed with the log level string."""
        print(self._prefix[record.levelno], record.getMessage())


logging.basicConfig(level=logging.DEBUG, handlers=[LogHandler()])


def find_clang_tidy() -> str:
    """Find clang-tidy or a variant of its name in $PATH."""
    for candidate in ("clang-tidy", "clang_tidy"):
        found = shutil.which(candidate)
        if found:
            logging.info("found clang-tidy: %s", found)
            return found
    logging.info("didn't find clang-tidy, going ahead anyway")
    return "clang-tidy"


def run_clang_tidy(bazel: builder.Builder, sources: List[str]) -> int:
    """Run clang-tidy on the source files for a given target."""
    clang_tidy = find_clang_tidy()
    errors = 0
    for source in sources:
        logging.info("running clang-tidy on '%s'", source)
        res = subprocess.run([  # nosec
            clang_tidy,
            "-p=" + bazel.execution_root(),
            "-header-filter=-external",
            "-warnings-as-errors=*",
            os.path.join(bazel.source_root(), source)] + _CHECKS)
        if res.returncode != 0:
            errors += 1
    return errors


def analyse(bazel: builder.Builder, target: str) -> None:
    """Generate compilation database and run clang-tidy."""
    sources = bazel.source_files(target, ".c")
    bazel.generate_compilation_database(sources)
    errors = run_clang_tidy(bazel, sources)
    if errors != 0:
        logging.error("found %d error(s) in %s source file(s)",
                      errors, len(sources))
        sys.exit(1)


def main(args: List[str]) -> None:
    """Run clang-tidy on the target provided."""
    try:
        bazel = builder.Builder()
        if len(args) == 2:
            analyse(bazel, args[1])
        else:
            analyse(bazel, "//c-toxcore/toxcore/...")
    except subprocess.CalledProcessError as exn:
        print(exn.stderr.decode("utf-8").strip())
        logging.exception(exn)


if __name__ == "__main__":
    main(sys.argv)
