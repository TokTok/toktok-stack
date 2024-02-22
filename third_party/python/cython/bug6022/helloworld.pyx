# cython: language_level=3, linetrace=True
import sys


cdef class Foo:

    def __init__(self):
        print("Foo init", file=sys.stderr)

    def __dealloc__(self):
        print("__dealloc__", file=sys.stderr)
        self.cleanup()
