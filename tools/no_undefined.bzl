"""Overrides cc_library to generate an empty binary in addition to the library.

This to ensure completeness of linkopts and dependencies for libraries. The
empty binary will fail to link if there are any undefined references.
"""

def cc_library(name, hdrs = [], srcs = [], linkopts = [], visibility = None, **kwargs):
    native.cc_library(
        name = name,
        srcs = srcs,
        hdrs = hdrs,
        linkopts = linkopts,
        visibility = visibility,
        **kwargs
    )

    native.genrule(
        name = "%s_empty_main" % name,
        outs = ["%s_empty_main.c" % name],
        cmd = "echo 'int main(void) { return 0; }' > $@",
    )

    native.cc_binary(
        name = "%s_bin" % name,
        srcs = hdrs + srcs + [":%s_empty_main.c" % name],
        linkstatic = True,
        linkopts = linkopts,
        **kwargs
    )
