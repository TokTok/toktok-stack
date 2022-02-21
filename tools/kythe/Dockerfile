# Extract index.
FROM toxchat/kythe-buildenv:latest

# From: https://kythe.io/examples/#extracting-other-bazel-based-repositories
COPY . /src/workspace

RUN ["/opt/build_index.sh"]
