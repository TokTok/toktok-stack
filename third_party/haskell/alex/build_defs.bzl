"""Haskell Alex lexer generator."""

load("@ai_formation_hazel//tools:mangling.bzl", "hazel_binary")

def alex_lexer(name, src):
    out = src[:src.rindex(".")] + ".hs"

    native.genrule(
        name = name,
        srcs = [
            src,
            "@toktok//third_party/haskell/alex/templates",
        ],
        outs = [out],
        cmd = " ".join([
            "$(location %s)" % hazel_binary("alex"),
            "--ghc",
            "-t third_party/haskell/alex/templates",
            "-o $(location %s)" % out,
            "$(location %s)" % src,
        ]),
        tools = [hazel_binary("alex")],
    )
