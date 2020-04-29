# hadolint ignore=DL3007
FROM toxchat/kythe-buildenv:latest

COPY kythe /src/workspace
RUN ["/opt/build_index.sh"]
