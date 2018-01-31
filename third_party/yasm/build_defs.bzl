"""Skylark build rule for assembly code to be assembled by yasm."""

def _asm_library_impl(ctx):
  yasm = ctx.executable._yasm

  hdrs = [hdr for lbl in ctx.attr.hdrs for hdr in lbl.files]
  srcs = [src for lbl in ctx.attr.srcs for src in lbl.files]

  outs = []
  for src in srcs:
    out = ctx.actions.declare_file(src.path[:-4] + ".o")
    outs.append(out)
    ctx.actions.run(
        outputs = [out],
        inputs = hdrs + [
            yasm,
            src,
        ],
        executable = yasm.path,
        arguments = ctx.attr.asmopts + [
            "-felf64",
            "-o",
            out.path,
            src.path,
        ],
        mnemonic = "Assemble",
        progress_message = "Assembling " + src.path,
    )

  return DefaultInfo(files = depset(outs))

asm_library = rule(
    attrs = {
        "srcs": attr.label_list(allow_files = [".asm"]),
        "hdrs": attr.label_list(allow_files = [".asm"]),
        "asmopts": attr.string_list(),
        "_yasm": attr.label(
            default = Label("@yasm"),
            executable = True,
            cfg = "host",
            allow_single_file = True,
        ),
    },
    implementation = _asm_library_impl,
)
