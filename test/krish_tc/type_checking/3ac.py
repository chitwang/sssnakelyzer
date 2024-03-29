# a : int = 2
# a = 0
# x : list [int]  = [1, 2, 3]
# def f(a: int , b: int):
#     return a + b
# f(1, 2)
class A:
    def __init__(self, a: int) -> int:
        self.a : int = a
        return a
a_obj: A = A(2)
a_obj.a = 3
a_obj.a = 2
# x : list[int] = [2 , 2, 2]
# x[2] = 2

