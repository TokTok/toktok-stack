# cython: language_level=3, linetrace=True
from typing import Optional


cdef class Bar:

    cdef int bar(self):
        return 0


cdef class Foo:

    cdef foo(self, Bar bar):
        bar.bar()

    def __init__(self, bar: Optional[Bar] = None):
        self.foo(bar)


Foo()
