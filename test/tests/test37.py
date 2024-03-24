class A:
    def __init__(self ):
        self.x :int = 90
        print("bad")
    def foo(self) -> None:
        print("foo")
class B:
    def __init__(self, x:A ):
        self.x : A = x
        print("ggod")
a : A = A()
a.foo()

b : B = B(a)
