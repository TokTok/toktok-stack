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
            "$(location @haskell_alex//:alex)",
            "-t external/toktok/third_party/haskell/alex/templates",
            "-o $(location %s)" % out,
            "$(location %s)" % src,
        ]),
        tools = ["@haskell_alex//:alex"],
    )
