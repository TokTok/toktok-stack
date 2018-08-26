"""Skylark build rule for assembly code to be assembled by yasm."""

def _asm_library_impl(ctx):
    yasm = ctx.executable._yasm

    hdrs = [hdr for lbl in ctx.attr.hdrs for hdr in lbl.files.to_list()]
    srcs = [src for lbl in ctx.attr.srcs for src in lbl.files.to_list()]

    asmopts = [ctx.expand_make_variables("cmd", opt, {}) for opt in ctx.attr.asmopts]

    outs = []
    for src in srcs:
        out = ctx.actions.declare_file(src.path[:-4] + ".o")
        outs.append(out)
        ctx.actions.run(
            arguments = asmopts + [
                ctx.attr.execfmt,
                "-o",
                out.path,
                src.path,
            ],
            executable = yasm.path,
            inputs = hdrs + [src],
            mnemonic = "Assemble",
            outputs = [out],
            progress_message = "Assembling " + src.path,
            tools = [yasm],
        )

    return DefaultInfo(files = depset(outs))

_asm_library = rule(
    attrs = {
        "srcs": attr.label_list(allow_files = [".asm"]),
        "hdrs": attr.label_list(allow_files = [".asm"]),
        "asmopts": attr.string_list(),
        "execfmt": attr.string(),
        "_yasm": attr.label(
            default = Label("@yasm"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
    },
    implementation = _asm_library_impl,
)

def asm_library(name, srcs = [], hdrs = [], asmopts = []):
    _asm_library(
        name = name,
        srcs = srcs,
        hdrs = hdrs,
        asmopts = asmopts,
        execfmt = select({
            "@toktok//tools/config:freebsd": "-felf64",
            "@toktok//tools/config:linux": "-felf64",
            "@toktok//tools/config:osx": "-fmacho64",
        }),
    )
