import subprocess  # nosec
import sys

ARG_TO_ENV = {
    "--flakiness": "FLAKYNET_FLAKINESS",
    "--seed": "FLAKYNET_SEED",
    "--headstart": "FLAKYNET_HEADSTART",
    "--verbose": "FLAKYNET_VERBOSE",
    "--syscalls": "FLAKYNET_SYSCALLS",
}

args = sys.argv[1:]
flakynet_args = []
while args:
    if args[0].startswith("--"):
        flakynet_args.append(args.pop(0))
        continue
    break

env = {"LD_PRELOAD": "tools/debug/flakynet.so"}
for arg in flakynet_args:
    k, v = arg.split("=", 1)
    env[ARG_TO_ENV[k]] = v

proc = subprocess.run(args, check=True, env=env)  # nosec
