"""Entry point for YouCompleteMe."""

from __future__ import print_function

import json
import os
import subprocess  # nosec
import sys

if sys.version_info.major == 3:
    SELF_DIR = os.path.dirname(os.path.abspath(__file__))
    sys.path.append(os.path.join(SELF_DIR, "tools", "kythe"))
    # pylint: disable=wrong-import-position,unused-import
    from ycm_extra_conf import Settings

elif sys.version_info.major == 2:

    # pylint: disable=invalid-name
    def Settings(**kwargs):
        """Invokes this script with JSON-serialised parameters."""
        process = subprocess.Popen(["python3", __file__],  # nosec
                                   stdin=subprocess.PIPE,
                                   stdout=subprocess.PIPE,
                                   stderr=subprocess.PIPE)
        stdout, stderr = process.communicate(json.dumps({
            "language": kwargs["language"],
            "filename": kwargs.get("filename", None),
        }))
        if process.returncode == 0:
            return json.loads(stdout)
        if process.returncode == 2:
            raise Exception(json.loads(stdout)["message"])
        else:
            raise Exception(stderr)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        print(Settings(
            language="cfamily",
            filename=os.path.abspath(sys.argv[1]),
        ))
    else:
        try:
            print(json.dumps(Settings(**json.loads(sys.stdin.read()))))
        except Exception as exn: # pylint: disable=broad-except
            print(json.dumps({"message": str(exn)}))
            sys.exit(2)
