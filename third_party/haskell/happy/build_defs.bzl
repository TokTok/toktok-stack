"""Haskell Happy parser generator."""

_HAPPY = "@haskellPackages.happy//:happy"

def happy_parser(name, src, glr = False, preproc = None, preproc_tool = None):
    """Haskell Happy parser generator.

    Args:
      name: Rule name.
      src: Happy source (.y file).
      glr: Enable GLR parser driver.
      preproc: Optional program to pass the .y file through before passing it to happy.
      preproc_tool: Interpreter for the preprocessor program.
    """
    driver_out = src[:src.rindex(".")] + ".hs"
    data_out = src[:src.rindex(".")] + "Data.hs"
    if glr:
        happy_flags = ["--glr", "--decode"]
        outs = [driver_out, data_out]
    else:
        happy_flags = ["--ghc", "--coerce"]
        outs = [driver_out]

    if preproc:
        pp_src = "%s.preproc.y" % src[:src.rindex(".")]
        native.genrule(
            name = "%s_preproc" % name,
            srcs = [src],
            outs = [pp_src],
            cmd = " ".join((["$(location %s)" % preproc_tool] if preproc_tool else []) + [
                "$(location %s)" % preproc,
                "$<",
                "$@",
            ]),
            tools = [preproc] + ([preproc_tool] if preproc_tool else []),
        )
        src = pp_src

    native.genrule(
        name = name,
        srcs = [src],
        outs = outs,
        cmd = " ".join([
            "$(location %s)" % _HAPPY,
            "--array",
            "--strict",
            "-o $(location %s)" % driver_out,
            "$(location %s)" % src,
        ] + happy_flags),
        tools = [_HAPPY],
    )
