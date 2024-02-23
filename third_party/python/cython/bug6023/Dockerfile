FROM alpine:3.19.0

RUN ["apk", "add", \
 "gcc", \
 "gdb", \
 "git", \
 "musl-dev", \
 "py3-pip", \
 "python3", \
 "python3-dbg", \
 "python3-dev"]

ENV CFLAGS="-O0 -g3"
RUN python3 -m venv /path/to/venv
RUN . /path/to/venv/bin/activate \
 && pip install git+https://github.com/cython/cython.git@53ff506512377e70602b617adcc69940d3f7b4b9

WORKDIR /work
COPY helloworld.pyx setup.py /work/
RUN . /path/to/venv/bin/activate \
 && python setup.py build_ext --inplace
COPY main.py /work/
RUN . /path/to/venv/bin/activate \
 && gdb \
   -ex "r" \
   -ex "bt" \
   --args python main.py
