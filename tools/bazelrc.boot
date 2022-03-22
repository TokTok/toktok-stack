# We enable color always, starting from the first aquery. This isn't strictly
# required, but otherwise we'd put it in the command line arguments anyway.
build --color=yes

# Flags that control how the workspace is laid out. These must be shared with
# the initial aquery in the Docker build, otherwise the second aquery will
# reinitialise the entire workspace.
build --experimental_disable_external_package
build --experimental_ninja_actions
build --experimental_repository_cache_hardlinks

# We enable these to get Bazel deprecation warnings for future feature changes.
# Disable them if you're running with an older version of Bazel that doesn't
# support some of the --incompatible flags.
#
# They need to be in bazelrc.boot because some of them affect how the workspace
# is laid out. We could figure out which ones do and which don't, but then we'd
# need to split them between two files. It's better to keep them all here.
#
# https://docs.bazel.build/versions/main/backward-compatibility.html
build --all_incompatible_changes

# Some incompatible_changes are incompatible with some of our dependencies,
# including Bazel itself (woohoo).
build --incompatible_disallow_struct_provider_syntax="false"          # bazel_tools
build --incompatible_enable_cc_toolchain_resolution="false"           # TODO(iphydf): This breaks remote-exec.
build --incompatible_enforce_config_setting_visibility="false"        # rules_go
build --incompatible_load_cc_rules_from_bzl="false"                   # bazel-toolchains
build --incompatible_load_python_rules_from_bzl=false                 # cython
build --incompatible_no_rule_outputs_param="false"                    # rules_scala
build --incompatible_require_linker_input_cc_api="false"              # io_bazel_rules_go
build --incompatible_struct_has_no_methods="false"                    # rules_haskell
build --incompatible_use_platforms_repo_for_constraints="false"       # bazel_toolchain
build --incompatible_use_toolchain_resolution_for_java_rules="false"  # TODO(https://github.com/bazelbuild/bazel/issues/7849): Enable.

# rules_apple uses old style list commands.
# TODO(https://github.com/bazelbuild/rules_apple/issues/736): Remove.
build:macos --incompatible_run_shell_command_string="false"

# Java toolchain.
build:rbe --extra_toolchains=@bazel_toolchain//toolchain/java:all

# C/C++ toolchain.
build:rbe --extra_toolchains=@bazel_toolchain//toolchain/config:cc-toolchain
build:rbe --crosstool_top=@bazel_toolchain//toolchain/cc:toolchain

# Platform flags:
# The toolchain container used for execution is defined in the target indicated
# by "extra_execution_platforms", "host_platform" and "platforms".
# More about platforms: https://docs.bazel.build/versions/master/platforms.html
build:rbe --extra_execution_platforms=@bazel_toolchain//toolchain/config:platform
build:rbe --host_platform=@bazel_toolchain//toolchain/config:platform
build:rbe --platforms=@bazel_toolchain//toolchain/config:platform

# Docker image build toxchat/toktok-stack running clang-14 in the
# toxchat/builder image.
build:docker --config=rbe
