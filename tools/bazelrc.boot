# We enable color always, starting from the first aquery. This isn't strictly
# required, but otherwise we'd put it in the command line arguments anyway.
build --color=yes

# Flags that control how the workspace is laid out. These must be shared with
# the initial aquery in the Docker build, otherwise the second aquery will
# reinitialise the entire workspace.
build --experimental_disable_external_package
build --experimental_repository_cache_hardlinks
build --incompatible_disable_target_provider_fields
build --incompatible_disallow_empty_glob
# TODO(iphydf): This breaks rules_kotlin.
#build --incompatible_no_implicit_file_export
build --incompatible_top_level_aspects_require_providers

# This project uses a GHC provisioned via nix.
# We need to use the rules_haskell nix toolchain accordingly:
build --host_platform=@io_tweag_rules_nixpkgs//nixpkgs/platforms:host
run --host_platform=@io_tweag_rules_nixpkgs//nixpkgs/platforms:host

# Java toolchain.
build --java_runtime_version=nixpkgs_java
build --tool_java_runtime_version=nixpkgs_java
build --java_language_version=11
build --tool_java_language_version=11
