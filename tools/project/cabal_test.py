#!/usr/bin/env python3

import collections
import json
import re
import sys

def parse_bazel(build):
    data = {}
    def store(rule):
        def f(name, **kwargs):
            data[name] = kwargs
            data[name]["rule"] = rule
        return f

    # pylint: disable=exec-used
    exec(open(build).read(), {
        "load": lambda bzl, *symbols: None,
        "project": lambda **kwargs: None,
        "alex_lexer": lambda **kwargs: None,
        "happy_parser": lambda **kwargs: None,
        "glob": lambda include, exclude=[]: None,
        "hazel_library": lambda name: name,
        "haskell_library": store("haskell_library"),
        "hspec_test": store("hspec_test"),
    })
    return json.loads(json.dumps(data))

def parse_cabal(cabal):
    rec_dd = lambda: collections.defaultdict(rec_dd)
    data = rec_dd()
    section = data['']['']
    key = None
    value = None

    with open(cabal, "r") as fh:
        for line in fh.readlines():
            line = line.rstrip()
            res = re.match(r"\s*([a-z-]+):\s*(.*)$", line)
            if res:
                if key:
                    values = value.split(", ")
                    if len(values) > 1:
                        section[key] = values
                    else:
                        section[key] = value
                    key = None
                key, value = res.group(1, 2)
                continue
            res = re.match(r"([a-z-]+)\s*([a-z-]*)$", line)
            if res:
                if key:
                    values = value.split(", ")
                    if len(values) > 1:
                        section[key] = values
                    else:
                        section[key] = value
                    key = None
                section = data[res.group(1)][res.group(2)]
                section["__name__"] = line
                continue
            value += line.strip()
        if key:
            values = value.split(", ")
            if len(values) > 1:
                section[key] = values
            else:
                section[key] = value
            key = None
    return json.loads(json.dumps(data))

def resolve_bazel_deps(bazel, data, name):
    def go(name):
        deps = []
        rule = data.get(name, None)
        if not rule:
            print(f"missing rule for '{name}' in {bazel}")
            sys.exit(1)
        for dep in rule["deps"]:
            if dep.startswith(":hs-"):
                deps.append(dep[4:])
            elif dep.startswith("//hs-"):
                deps.append(dep[5:])
            elif dep.startswith("//c-"):
                pass # ignore native deps for now
            elif dep.startswith(":"):
                if name != "testsuite":
                    deps.extend(go(dep[1:]))
            else:
                deps.append(dep)
        return deps
    return set(go(name))

def must_list(maybe_list):
    if isinstance(maybe_list, list):
        return maybe_list
    else:
        return [maybe_list]

def check_deps(bazel, cabal, bazel_data, bazel_name, cabal_section):
    bazel_deps = resolve_bazel_deps(bazel, bazel_data, bazel_name)
    cabal_deps = {dep.split(" ")[0]
            for dep in must_list(cabal_section["build-depends"])}

    cabal_missing = sorted(bazel_deps - cabal_deps)
    if cabal_missing:
        print(f"{cabal} is missing deps for section "
                f"'{cabal_section['__name__']}' from {bazel} '{bazel_name}': "
                f"{cabal_missing}")
        sys.exit(1)

    bazel_missing = sorted(cabal_deps - bazel_deps)
    if bazel_missing:
        print(f"{bazel} is missing deps for '{bazel_name}' from "
                f"{cabal} section '{cabal_section['__name__']}: "
                f"{bazel_missing}")
        sys.exit(1)

def check_version(root, bazel_data, package_name):
    cabal_version = root["version"]
    bazel_version = bazel_data["hs-" + package_name]["version"]
    if cabal_version != bazel_version:
        print(f"bazel version ({bazel_version}) and cabal version "
                f"({cabal_version}) disagree")
        sys.exit(1)

def main(args):
    bazel, cabal = args

    bazel_data = parse_bazel(bazel)
    cabal_data = parse_cabal(cabal)

    root = cabal_data[""][""]
    package_name = root["name"]

    check_deps(bazel, cabal, bazel_data,
            "hs-" + package_name, cabal_data["library"][""])
    check_deps(bazel, cabal, bazel_data,
            "testsuite", cabal_data["test-suite"]["testsuite"])

    check_version(root, bazel_data, package_name)

main(sys.argv[1:])
