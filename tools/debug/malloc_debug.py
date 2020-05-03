"""Common functions for run_mallocfail and run_oomer."""

import math
import subprocess
import time


def build(exe: str, malloc: str) -> str:
    """Build a bazel target and return its bazel-bin executable path."""
    if exe.startswith("//"):
        proc = subprocess.run(
            ["bazel", "build", exe, "--custom_malloc=//tools/debug:" + malloc],
            capture_output=True,
            check=True,
        )
        exe = next(
            line
            for line in proc.stderr.decode("utf-8").split("\n")
            if line.startswith("  bazel-bin/")
        ).strip()

    return exe


def timeout(exe: str) -> int:
    """Heuristically determine the timeout a program should get.

    This is done by running the program and adding a bit of slack to allow it
    to take more time under oomer/mallocfail.
    """
    # Run the test program without mallocfail, check how long it takes.
    start_time = time.time()
    # Oomer sets a default timeout of 5 seconds, so we override that here. 60
    # seconds ought to be enough for anyone (and our tests shouldn't take that
    # much time, or oomer will not be very useful).
    subprocess.run([exe], check=True, env={"OOMER_TIMEOUT": "60"})
    elapsed_time = time.time() - start_time

    # Give the program 20% more time under mallocfail/oomer, and at least 2
    # seconds.
    program_timeout = math.ceil(elapsed_time * 1.2 + 2)
    print(f"\x1b[0;32mProgram gets a timeout of {program_timeout}s\x1b[0m")
    return program_timeout
