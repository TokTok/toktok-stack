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
# https://docs.bazel.build/versions/master/skylark/backward-compatibility.html
#build --all_incompatible_changes

build --incompatible_allow_python_version_transitions
build --incompatible_always_check_depset_elements
build --incompatible_applicable_licenses
build --incompatible_auto_configure_host_platform
build --incompatible_default_to_explicit_init_py
build --incompatible_depset_for_libraries_to_link_getter
build --incompatible_disable_cc_configuration_make_variables
build --incompatible_disable_cc_toolchain_label_from_crosstool_proto
build --incompatible_disable_crosstool_file
build --incompatible_disable_depset_in_cc_user_flags
build --incompatible_disable_depset_items
build --incompatible_disable_expand_if_all_available_in_flag_set
build --incompatible_disable_late_bound_option_defaults
build --incompatible_disable_legacy_cc_provider
build --incompatible_disable_legacy_cpp_toolchain_skylark_api
build --incompatible_disable_legacy_crosstool_fields
build --incompatible_disable_legacy_flags_cc_toolchain_api
build --incompatible_disable_legacy_proto_provider
build --incompatible_disable_native_android_rules="false"
build --incompatible_disable_nocopts
build --incompatible_disable_proto_source_root
build --incompatible_disable_runtimes_filegroups
build --incompatible_disable_static_cc_toolchains
build --incompatible_disable_sysroot_from_configuration
build --incompatible_disable_target_provider_fields
build --incompatible_disable_third_party_license_checking
build --incompatible_disable_tools_defaults_package
build --incompatible_disallow_empty_glob
build --incompatible_disallow_legacy_javainfo
build --incompatible_disallow_legacy_java_provider
build --incompatible_disallow_legacy_py_provider
build --incompatible_disallow_resource_jars
build --incompatible_disallow_struct_provider_syntax="false"
build --incompatible_do_not_emit_buggy_external_repo_import
build --incompatible_do_not_split_linking_cmdline
build --incompatible_dont_emit_static_libgcc
build --incompatible_dont_enable_host_nonhost_crosstool_features
build --incompatible_enable_cc_toolchain_resolution="false"  # TODO(iphydf): This breaks remote-exec.
build --incompatible_enable_legacy_cpp_toolchain_skylark_api
build --incompatible_enable_profile_by_default
build --incompatible_generated_protos_in_virtual_imports
build --incompatible_linkopts_in_user_link_flags
build --incompatible_linkopts_to_linklibs
build --incompatible_load_cc_rules_from_bzl="false"
build --incompatible_load_java_rules_from_bzl="false"
build --incompatible_load_proto_rules_from_bzl
build --incompatible_load_python_rules_from_bzl
build --incompatible_make_thinlto_command_lines_standalone
build --incompatible_merge_genfiles_directory
build --incompatible_new_actions_api
build --incompatible_no_attr_license
build --incompatible_no_implicit_file_export="false"
build --incompatible_no_rule_outputs_param="false"
build --incompatible_objc_compile_info_migration
build --incompatible_prohibit_aapt1
build --incompatible_provide_cc_toolchain_info_from_cc_toolchain_suite
build --incompatible_py2_outputs_are_suffixed
build --incompatible_py3_is_default
build --incompatible_remote_results_ignore_disk
build --incompatible_remote_symlinks
build --incompatible_remove_binary_profile
build --incompatible_remove_cpu_and_compiler_attributes_from_cc_toolchain
build --incompatible_remove_legacy_whole_archive
build --incompatible_remove_local_resources
build --incompatible_remove_old_python_version_api
build --incompatible_require_ctx_in_configure_features
build --incompatible_require_feature_configuration_for_pic
build --incompatible_require_java_toolchain_header_compiler_direct
build --incompatible_require_linker_input_cc_api="false"  # io_bazel_rules_go
build --incompatible_restrict_string_escapes="false"  # kythe
build --incompatible_run_shell_command_string
build --incompatible_skip_genfiles_symlink
build --incompatible_strict_action_env
build --incompatible_use_cc_configure_from_rules_cc
build --incompatible_use_native_patch
build --incompatible_use_platforms_repo_for_constraints="false"
build --incompatible_use_python_toolchains
build --incompatible_use_specific_tool_files
build --incompatible_use_toolchain_resolution_for_java_rules="false"  # TODO(https://github.com/bazelbuild/bazel/issues/7849): Enable.
build --incompatible_validate_top_level_header_inclusions
build --incompatible_visibility_private_attributes_at_definition

# rules_apple uses old style list commands.
# TODO(https://github.com/bazelbuild/rules_apple/issues/736): Remove.
build:macos --incompatible_run_shell_command_string="false"
