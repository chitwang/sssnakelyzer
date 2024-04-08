# def foo(a:int) -> int:
#     print(a)
#     return a

# def main():
#     a:int = foo(3)
#     print(a)

x:int = 5
bol:bool = True

class B:
    def __init__(self) -> None:
        self.x:int = 4

# class A:
#     def __init__(self) -> None:
#         self.obj:B = B()

def foo() -> B:
    obj:B = B()
    return obj

def main():
    c:B = B()
    a:B = foo()
    print(a.x)
    print(c.x)

if __name__ == "__main__":
    main()
    
