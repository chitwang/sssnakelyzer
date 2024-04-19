# # def foo(a:int) -> int:
# #     print(a)
# #     return a

# # def main():
# #     a:int = foo(3)
# #     print(a)

# x:int = 5
# bol:bool = True

# class B:
#     def __init__(self) -> None:
#         self.x:int = 4

# # class A:
# #     def __init__(self) -> None:
# #         self.obj:B = B()

# def foo() -> B:
#     obj:B = B()
#     return obj

# def main():
#     c:B = B()
#     a:B = foo()
#     print(a.x)
#     print(c.x)

# if __name__ == "__main__":
#     main()
    

def f1(a : int, b : int) -> int:
    c : int = a+b
    print(c)
    return c
 
def main() -> None:
    f1(1, 2)
    a:int = 0
    print(a)
    a = 453 
    print(a)

if __name__ == "__main__":
   main()
