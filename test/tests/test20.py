class A:
    global c
    def f(self, a : int):
        global c
        print(a)
a : A = A()
a.f(10)

