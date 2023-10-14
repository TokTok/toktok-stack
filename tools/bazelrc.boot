# We enable color always, starting from the first aquery. This isn't strictly
# required, but otherwise we'd put it in the command line arguments anyway.
build --color=yes

# Flags that control how the workspace is laid out. These must be shared with
# the initial aquery in the Docker build, otherwise the second aquery will
# reinitialise the entire workspace.
build --experimental_disable_external_package
build --experimental_repository_cache_hardlinks

# This project uses a GHC provisioned via nix.
# We need to use the rules_haskell nix toolchain accordingly:
build --host_platform=@io_tweag_rules_nixpkgs//nixpkgs/platforms:host
run --host_platform=@io_tweag_rules_nixpkgs//nixpkgs/platforms:host

# Java toolchain.
build --java_runtime_version=nixpkgs_java_11
build --tool_java_runtime_version=nixpkgs_java_11
build --java_language_version=11
build --tool_java_language_version=11
