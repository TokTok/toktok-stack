FROM toxchat/toktok-stack:haskell AS build

RUN ["rm", "-rf", "/work/hs-schema"]
COPY --chown=builder:users . /work/hs-schema
RUN ["stack", "install", "schema"]

FROM scratch
COPY --from=build /home/builder/.local/ /
