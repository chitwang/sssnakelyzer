# i : int = 1

# while i < 10:
#     i = i + 1
#     print(i)
#     if i == 5:
#         break 
#     else:
#         continue
#     print(i)
# print(i)

array : list[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
array[2] = len(array)

# class C:
#     def __init__(self):
#         self.i = 0

#     def func(self):
#         print(self.i)

# class A:
#     def __init__(self):
#         self.i : int = 0

#     def func(self):
#         print(self.i)
    
#     def f1(self, d : int):
#         print(d)

# a_obj : A = A()
# a_obj.f1(1)
# a_obj.c_obj.func()
# # self_get_mangaled(A) = base addr A 
# # 3ac 
# a_obj = memalloc
# push_param atom->node_name[atom_name.size() - 3]
# call_func
# print --> global 
#

class A:
    def __init__(self) -> None:
        self.i : int = 0
        self.j : float = 2
        self.k : str = "hello"
    def f1(self, d : int) -> None:
        print(d)

class B(A):
    def __init__(self) -> None:
        self.i = 0
        self.j = 2
        self.k = "hello"
        self.l: int = 3
        self.m: float = 4
    def f2(self, d : int) -> None:
        print(d)

def main():
    a_obj : A = A()
    b_obj : B = B()
    a_obj.f1(1)
    b_obj.f2(2)
    a : list[int] = [1,2,3,4,5]
    a[2] = 3
    x : list[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    x[2] = len(x)
    b:int  = len(a)
    print(b)
    # x : int = a_obj.i
    # print(a_obj.i)
    # print(a_obj.j)
    # print(a_obj.k)
    # print(b_obj.i)
    # print(b_obj.j)
    # b_obj.f1(1)

if __name__ == "__main__":
    main()
