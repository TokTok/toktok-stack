# We enable color always, starting from the first aquery. This isn't strictly
# required, but otherwise we'd put it in the command line arguments anyway.
build --color=yes

# Flags that control how the workspace is laid out. These must be shared with
# the initial aquery in the Docker build, otherwise the second aquery will
# reinitialise the entire workspace.
build --experimental_disable_external_package
build --experimental_ninja_actions
build --experimental_repository_cache_hardlinks
build --record_rule_instantiation_callstack
