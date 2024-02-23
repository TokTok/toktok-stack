import helloworld
import sys


class Derived(helloworld.Foo):

    def __init__(self):
        super().__init__()
        print("Derived init", file=sys.stderr)


class Main:
    ob = Derived()


Main()
