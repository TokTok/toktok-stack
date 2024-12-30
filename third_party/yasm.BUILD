load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

PLUGINS = [
    ("arch", "lc3b"),
    ("arch", "x86"),
    ("listfmt", "nasm"),
    ("parser", "gas"),
    ("parser", "nasm"),
    ("preproc", "nasm"),
    ("preproc", "raw"),
    ("preproc", "cpp"),
    ("preproc", "gas"),
    ("dbgfmt", "cv8"),
    ("dbgfmt", "dwarf2"),
    ("dbgfmt", "null"),
    ("dbgfmt", "stabs"),
    ("objfmt", "dbg"),
    ("objfmt", "bin"),
    ("objfmt", "elf"),
    ("objfmt", "elf32"),
    ("objfmt", "elf64"),
    ("objfmt", "elfx32"),
    ("objfmt", "coff"),
    ("objfmt", "win32"),
    ("objfmt", "win64"),
    ("objfmt", "macho"),
    ("objfmt", "macho32"),
    ("objfmt", "macho64"),
    ("objfmt", "rdf"),
    ("objfmt", "xdf"),
]

genrule(
    name = "init_plugin",
    outs = ["init_plugin.c"],
    cmd = """
    echo '#include <libyasm.h>' > $@
    echo '#include <libyasm/module.h>' >> $@
    echo '' >> $@
    {externs}
    echo '' >> $@
    echo '#ifdef _MSC_VER' >> $@
    echo '__declspec(dllexport)' >> $@
    echo '#endif' >> $@
    echo 'void' >> $@
    echo 'yasm_init_plugin(void)' >> $@
    echo '{{' >> $@
    {register_modules}
    echo '}}' >> $@
    """.format(
        externs = "\n".join(["echo 'extern yasm_%s_module yasm_%s_LTX_%s;' >> $@" % (
            kind,
            mod,
            kind,
        ) for (kind, mod) in PLUGINS]),
        register_modules = "\n".join(["echo '    yasm_register_module(YASM_MODULE_%s, \"%s\", &yasm_%s_LTX_%s);' >> $@" % (
            kind.upper(),
            mod,
            mod,
            kind,
        ) for (kind, mod) in PLUGINS]),
    ),
)

cc_binary(
    name = "genstring",
    srcs = ["genstring.c"],
)

genrule(
    name = "license",
    srcs = ["COPYING"],
    outs = ["license.c"],
    cmd = "$(location genstring) license_msg $@ $(location COPYING)",
    tools = [
        "genstring",
    ],
)

genrule(
    name = "config",
    outs = ["config.h"],
    cmd = """
    echo '#define CMAKE_BUILD 1'                > $@
    echo '#define PACKAGE_VERSION "1.3.0"'      >> $@
    echo '#define PACKAGE_STRING "yasm 1.3.0"'  >> $@
    echo '#ifndef _WIN32'                       >> $@
    echo '#define HAVE_UNISTD_H 1'              >> $@
    echo '#endif'                               >> $@
    echo '#define HAVE_TOASCII 1'               >> $@
    echo '#define CPP_PROG "/usr/bin/cpp"'      >> $@
    """,
)

genrule(
    name = "x86insns",
    srcs = ["modules/arch/x86/gen_x86_insn.py"],
    outs = [
        "x86insns.c",
        "x86insn_nasm.gperf",
        "x86insn_gas.gperf",
    ],
    cmd = "PYTHONUSERBASE=/tmp/.local python3 $< && mv x86insns.c x86insn_gas.gperf x86insn_nasm.gperf $$(dirname $(location x86insns.c))/",
)

cc_binary(
    name = "genmacro",
    srcs = ["tools/genmacro/genmacro.c"],
)

cc_binary(
    name = "genversion",
    srcs = [
        "config.h",
        "modules/preprocs/nasm/genversion.c",
    ],
)

cc_binary(
    name = "genperf",
    srcs = [
        "libyasm-stdint.h",
        "libyasm/compat-queue.h",
        "libyasm/coretype.h",
        "libyasm/errwarn.h",
        "libyasm/phash.c",
        "libyasm/phash.h",
        "libyasm/xmalloc.c",
        "libyasm/xstrdup.c",
        "tools/genperf/genperf.c",
        "tools/genperf/perfect.c",
        "tools/genperf/perfect.h",
        "tools/genperf/standard.h",
        "util.h",
    ],
    copts = [
        "-I$(GENDIR)/external/yasm",
        "-Iexternal/yasm",
    ],
)

genrule(
    name = "version_mac",
    outs = ["version.mac"],
    cmd = "$(location genversion) $@",
    tools = ["genversion"],
)

genrule(
    name = "nasm_version",
    srcs = ["version.mac"],
    outs = ["nasm-version.c"],
    cmd = "$(location genmacro) $@ nasm_version_mac $(location version.mac)",
    tools = ["genmacro"],
)

genrule(
    name = "nasm_macros",
    srcs = ["modules/parsers/nasm/nasm-std.mac"],
    outs = ["nasm-macros.c"],
    cmd = "$(location genmacro) $@ nasm_standard_mac $(location modules/parsers/nasm/nasm-std.mac)",
    tools = ["genmacro"],
)

genrule(
    name = "win64_nasm",
    srcs = ["modules/objfmts/coff/win64-nasm.mac"],
    outs = ["win64-nasm.c"],
    cmd = "$(location genmacro) $@ win64_nasm_stdmac $(location modules/objfmts/coff/win64-nasm.mac)",
    tools = ["genmacro"],
)

genrule(
    name = "win64_gas",
    srcs = ["modules/objfmts/coff/win64-gas.mac"],
    outs = ["win64-gas.c"],
    cmd = "$(location genmacro) $@ win64_gas_stdmac $(location modules/objfmts/coff/win64-gas.mac)",
    tools = ["genmacro"],
)

genrule(
    name = "x86regtmod",
    srcs = ["modules/arch/x86/x86regtmod.gperf"],
    outs = ["x86regtmod.c"],
    cmd = "$(location genperf) $(location modules/arch/x86/x86regtmod.gperf) $@",
    tools = ["genperf"],
)

genrule(
    name = "x86cpu",
    srcs = ["modules/arch/x86/x86cpu.gperf"],
    outs = ["x86cpu.c"],
    cmd = "$(location genperf) $(location modules/arch/x86/x86cpu.gperf) $@",
    tools = ["genperf"],
)

genrule(
    name = "x86insn_nasm",
    srcs = ["x86insn_nasm.gperf"],
    outs = ["x86insn_nasm.c"],
    cmd = "$(location genperf) $(location x86insn_nasm.gperf) $@",
    tools = ["genperf"],
)

genrule(
    name = "x86insn_gas",
    srcs = ["x86insn_gas.gperf"],
    outs = ["x86insn_gas.c"],
    cmd = "$(location genperf) $(location x86insn_gas.gperf) $@",
    tools = ["genperf"],
)

cc_binary(
    name = "re2c",
    srcs = glob([
        "tools/re2c/*.c",
        "tools/re2c/*.h",
    ]),
    copts = select({
        "@toktok//tools/config:windows": [],
        "//conditions:default": [
            "-Wno-unused",
            "-Wno-switch",
        ],
    }),
)

genrule(
    name = "lc2bid",
    srcs = ["modules/arch/lc3b/lc3bid.re"],
    outs = ["lc3bid.c"],
    cmd = "$(location re2c) -b -o $@ $(location modules/arch/lc3b/lc3bid.re)",
    tools = ["re2c"],
)

genrule(
    name = "gas_token",
    srcs = ["modules/parsers/gas/gas-token.re"],
    outs = ["gas-token.c"],
    cmd = "$(location re2c) -b -o $@ $(location modules/parsers/gas/gas-token.re)",
    tools = ["re2c"],
)

genrule(
    name = "nasm_token",
    srcs = ["modules/parsers/nasm/nasm-token.re"],
    outs = ["nasm-token.c"],
    cmd = "$(location re2c) -b -o $@ $(location modules/parsers/nasm/nasm-token.re)",
    tools = ["re2c"],
)

genrule(
    name = "libyasm_stdint",
    outs = ["libyasm-stdint.h"],
    cmd = "echo '#include <stdint.h>' > $@",
)

cc_library(
    name = "genfiles",
    hdrs = [
        "license.c",
        "nasm-macros.c",
        "nasm-version.c",
        "win64-gas.c",
        "win64-nasm.c",
        "x86insn_gas.c",
        "x86insn_nasm.c",
        "x86insns.c",
    ],
)

cc_binary(
    name = "yasm",
    srcs = glob(
        [
            "frontends/yasm/*.c",
            "frontends/yasm/*.h",
            "libyasm/*.c",
            "libyasm/*.h",
            "modules/*/*/*.c",
            "modules/*/*/*.h",
        ],
        exclude = [
            "**/gen*.c",
            "frontends/yasm/yasm-plugin.c",
            "modules/preprocs/yapp/**",
        ],
    ) + [
        "config.h",
        "gas-token.c",
        "init_plugin.c",
        "lc3bid.c",
        "libyasm.h",
        "libyasm-stdint.h",
        "nasm-token.c",
        "util.h",
        "x86cpu.c",
        "x86regtmod.c",
    ],
    copts = [
        "-D_DEFAULT_SOURCE",
        "-DHAVE_CONFIG_H",
        "-I$(GENDIR)/external/yasm",
        "-Iexternal/yasm",
        "-Wno-array-bounds",
    ],
    visibility = ["//visibility:public"],
    deps = [":genfiles"],
)
