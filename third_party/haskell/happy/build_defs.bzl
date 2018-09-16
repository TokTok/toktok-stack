def happy_parser(name, src):
    out = src[:src.rindex(".")] + ".hs"

    native.genrule(
        name = name,
        srcs = [
            src,
            "@toktok//third_party/haskell/happy/templates",
        ],
        outs = [out],
        cmd = " ".join([
            "$(location @haskell_happy//:happy)",
            "-t external/toktok/third_party/haskell/happy/templates",
            "-agc",
            "-o $(location %s)" % out,
            "$(location %s)" % src,
        ]),
        tools = ["@haskell_happy//:happy"],
    )
