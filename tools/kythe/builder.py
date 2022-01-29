"""Module for generating a compilation database and running bazel query."""
import difflib
import json
import logging
import os
import pathlib
import re
import shlex
import subprocess  # nosec
import sys
from typing import Dict, Generator, List

KYTHE_REPO = "io_kythe"
KYTHE_TOOLS = "kythe/cxx/tools/generate_compile_commands"
EXTRACT_JSON = f"@{KYTHE_REPO}//{KYTHE_TOOLS}:extract_json"

_GCC_ONLY = (
    "-fno-canonical-system-headers",
    "-Wno-format-overflow",
    "-Wno-format-truncation",
    "-Wno-free-nonheap-object",
    "-Wold-style-declaration",
    "-Wunused-but-set-parameter",
)

_INC_FLAGS = (
    "-iquote",
    "-isystem",
    "-I",
)


def flags_for_clang(execroot: str, args: List[str]) -> List[str]:
    """Filter out gcc-only flags to make the command line ready for clang."""
    clang_args = []
    i = 0
    while i < len(args):
        if args[i] in _GCC_ONLY:
            # Skip gcc-specific flags not available in clang.
            i += 1
        elif args[i] in _INC_FLAGS:
            # Make include-flags absolute paths.
            clang_args.append(args[i])
            if args[i + 1].startswith("/"):
                clang_args.append(args[i + 1])
            else:
                clang_args.append(os.path.join(execroot, args[i + 1]))
            i += 2
        else:
            clang_args.append(
                re.sub('="([^"]+)"', "='\"\\1\"'", args[i]).replace(
                    "=external/", "=bazel-workspace/external/"
                )
            )
            i += 1
    return clang_args


def diff_commands(cmd1: str, cmd2: str) -> str:
    """Return a unified diff of two shell commands."""

    def diffable(cmd: str) -> List[str]:
        args = shlex.split(cmd)
        pretty = []
        i = 0
        while i < len(args):
            if args[i] in ("-o", "-iquote", "-isystem", "-MF"):
                pretty.append(args[i] + " " + args[i + 1])
                i += 2
            else:
                pretty.append(args[i])
                i += 1
        return pretty

    args1 = diffable(cmd1)
    args2 = diffable(cmd2)
    return "\n".join(tuple(difflib.unified_diff(args1, args2, n=999))[2:])


def _ancestors(path: str) -> Generator[str, None, None]:
    yield path
    parent = os.path.dirname(path)
    if parent != path:
        yield from _ancestors(parent)


def _workspace_dir() -> str:
    for path in _ancestors(os.environ["PWD"]):
        if os.path.exists(os.path.join(path, "WORKSPACE")) and os.path.exists(
            os.path.join(path, ".ycm_extra_conf.py")
        ):
            return path
    raise Exception("could not determine the project root")


def _build_file_for(filename: str) -> str:
    for path in _ancestors(filename):
        build_file = os.path.join(path, "BUILD.bazel")
        if os.path.exists(build_file):
            return build_file
    raise Exception(f"could not determine the BUILD.bazel for {filename}")


class Builder:
    """Provides functions to generate and work with compilation databases."""

    def __init__(self, bazel: str = "bazel", strict: bool = False):
        """Initialise a Bazel builder object.

        Args:
          bazel: Path to the "bazel" binary. Defaults to looking up via $PATH.
          strict: Set to True if you want to abort when multiple compilation
            commands exist for the same source file. Having this can lead to
            non-determinism in the behaviour of clang-tidy but should generally
            be harmless.
        """
        self._bazel = bazel
        self._info = self.bazel_info()
        self._strict = strict
        self._root = _workspace_dir()

    def _package_name(self, build_file: str) -> str:
        return os.path.dirname(os.path.relpath(build_file, self.source_root()))

    def _build_targets_for(self, sources: List[str]) -> List[str]:
        builds = {_build_file_for(os.path.join(self.source_root(), x)) for x in sources}
        return ["//" + self._package_name(build) + ":all" for build in builds]

    def execution_root(self) -> str:
        """Return the bazel execution_root path."""
        return self._info["execution_root"]

    def source_root(self) -> str:
        """Return the absolute path to the workspace root."""
        return self._root

    def json_root(self) -> str:
        """Return the absolute path to the directory with compile commands."""
        return os.path.join(
            os.path.dirname(self._info["bazel-bin"]),
            "extra_actions",
            KYTHE_TOOLS,
            "extra_action",
        )

    def bazel_info(self) -> Dict[str, str]:
        """Query bazel for the execution root and bazel-bin paths."""
        logging.info("querying bazel for execution root and bazel-bin paths")
        res = subprocess.run(
            [self._bazel, "info"], capture_output=True, check=True  # nosec
        )
        lines = res.stdout.strip().decode("utf-8").split("\n")
        return {kv[0]: kv[1] for kv in (line.split(": ") for line in lines)}

    def query(self, query: str) -> List[str]:
        """Query bazel for all the source files contributing to a given target.
        """
        logging.info('running bazel query: "%s"', query)
        cmd = [self._bazel, "query", query]
        res = subprocess.run(cmd, capture_output=True, check=True)  # nosec
        return list(res.stdout.strip().decode("utf-8").split("\n"))

    def source_files(self, target: str, suffix: str = "") -> List[str]:
        """Query bazel for all the source files contributing to a given target.
        """
        logging.info("querying bazel for source files")
        return sorted(
            target.replace(":", "/")[2:]
            for target in self.query(f"kind('source file', deps({target}, 1))")
            if target.endswith(suffix)
        )

    def collect_commands(self, sources: List[str]) -> List[Dict[str, str]]:
        """Read the compile_command.json files and parse them into one list."""
        commands: Dict[str, Dict[str, str]] = {}
        stems = tuple(os.path.splitext(src)[0] for src in sources)
        paths = pathlib.Path(self.json_root()).rglob("*.compile_command.json")
        for path in paths:
            with open(path, "r") as handle:
                command = json.loads(handle.read())
                # TODO(iphydf): Use shlex.join when Python 3.8 becomes more
                # widely available.
                command["command"] = " ".join(
                    flags_for_clang(
                        self.execution_root(), shlex.split(command["command"])
                    )
                )
                command["directory"] = command["directory"].replace(
                    "@BAZEL_ROOT@", self.execution_root()
                )
                file_name = command["file"]
                if file_name in commands:
                    diff = diff_commands(
                        commands[file_name]["command"], command["command"]
                    )
                    if self._strict and diff:
                        print(f"file {file_name} already in compilation " "database:")
                        print(diff)
                        sys.exit(1)
                elif os.path.splitext(file_name)[0] in stems:
                    commands[file_name] = command
        return list(commands.values())

    def generate_compile_commands(self, targets: List[str]) -> None:
        """Generate compile_command.json files for all rules."""
        cmd = [
            self._bazel,
            "build",
            "--experimental_action_listener=" + EXTRACT_JSON,
        ] + targets
        subprocess.run(cmd, check=True)  # nosec

    def generate_compilation_database(self, sources: List[str]) -> List[Dict[str, str]]:
        """Generate a compile_commands.json file using bazel and kythe."""
        logging.info("generating compile_commands.json for %d sources", len(sources))
        commands = self.collect_commands(sources)

        if len(commands) != len(sources):
            targets = self._build_targets_for(sources)
            logging.info(
                "compilation database not ready; regenerating for "
                "%d build target(s)",
                len(targets),
            )
            self.generate_compile_commands(targets)
            commands = self.collect_commands(sources)

        dump = json.dumps(commands, indent=2)
        database = os.path.join(self.execution_root(), "compile_commands.json")
        with open(database, "w") as handle:
            handle.write(dump)
        return commands
