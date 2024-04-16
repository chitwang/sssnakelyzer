def foo() -> bool:
    a:bool = 767667
    return a+1

def func(a:int)->int:
    return 54646

class A:
    def __init__(self, foo:int) -> None:
        self.foo:int = foo
        print(foo)
        print(func(2))
    
def main():
    # print(foo())
    a:A = A(52)

main()

