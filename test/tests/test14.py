def func( b: int ) -> None:
    func(b-1)

class A:
    m: int = 9
    def func(self, a: int ) -> None:
        self.func(a)
        self.m  = 9

    def b(self, a : int) -> None:
        self.func(a)

obj: A = A()
obj.b(7)
obj.m
