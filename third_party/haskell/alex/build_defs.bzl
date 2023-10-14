"""Haskell Alex lexer generator."""

_ALEX = "@haskellPackages.alex//:alex"

def alex_lexer(name, src):
    out = src[:src.rindex(".")] + ".hs"

    native.genrule(
        name = name,
        srcs = [src],
        outs = [out],
        cmd = " ".join([
            "$(location %s)" % _ALEX,
            "--ghc",
            "-o $(location %s)" % out,
            "$(location %s)" % src,
        ]),
        tools = [_ALEX],
    )
