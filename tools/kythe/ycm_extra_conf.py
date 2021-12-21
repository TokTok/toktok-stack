"""Support module for YouCompleteMe."""

import logging
import os
import shlex

from typing import Any, Dict, List, Optional

import builder

logging.basicConfig(level=logging.DEBUG)


# pylint: disable=invalid-name
def Settings(
    language: str, filename: Optional[str] = None, client_data: Any = None,
) -> Dict[str, List[str]]:
    """Return flags for the file loaded into vim."""
    del client_data

    if language != "cfamily" or not filename:
        return {}
    bazel = builder.Builder()
    # Determine the path relative to the toplevel workspace dir.
    filename = os.path.relpath(filename, bazel.source_root())
    # Generate a compilation database with a single file in it.
    db = bazel.generate_compilation_database([filename])
    if not db:
        raise Exception(f"unable to build compilation database for {filename}")
    flags = builder.flags_for_clang(
        bazel.execution_root(), shlex.split(db[0]["command"])[1:]
    )
    return {"flags": flags}


if __name__ == "__main__":
    import sys

    print(Settings(language="cfamily", filename=os.path.abspath(sys.argv[1])))
