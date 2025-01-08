load("@rules_cc//cc:defs.bzl", "cc_library")

exports_files([
    "libexec/repc",
])

[cc_library(
    name = mod.lower(),
    hdrs = glob(["include/Qt%s/**" % mod]),
    defines = ["QT_%s_LIB" % mod.upper()],
    includes = [
        "include",
        "include/Qt" + mod,
    ],
    visibility = ["//visibility:public"],
    deps = ["@qt6.qtremoteobjects.out//:" + mod.lower()],
) for mod in [
    "RemoteObjects",
]]
