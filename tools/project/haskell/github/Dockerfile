# hadolint ignore=DL3007
FROM toxchat/haskell:latest

RUN ["rm", "-rf", "/work/hs-{PACKAGE}"]
COPY --chown=builder:users . /work/hs-{PACKAGE}
RUN ["stack", "build", "{PACKAGE}"]
