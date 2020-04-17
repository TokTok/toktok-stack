FROM ubuntu:16.04
MAINTAINER iphydf@gmail.com
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 binutils \
 curl \
 default-jdk \
 default-jre \
 libc6-dev \
 libstdc++-4.9-dev \
 python3 \
 python3.5-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN curl https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/clang_rc47f971694be0159ffddfee8a75ae515eba91439.tar.gz | tar zxv -C /usr/local/
RUN curl https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/libcxx-msan_rc47f971694be0159ffddfee8a75ae515eba91439.tar.gz | tar zxv -C /usr/local/
