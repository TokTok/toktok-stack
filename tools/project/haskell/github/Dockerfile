FROM toxchat/toktok-stack:haskell AS build

RUN ["rm", "-rf", "/work/hs-{PACKAGE}"]
COPY --chown=builder:users . /work/hs-{PACKAGE}
RUN ["stack", "install", "{PACKAGE}"]

FROM scratch
COPY --from=build /home/builder/.local/ /
