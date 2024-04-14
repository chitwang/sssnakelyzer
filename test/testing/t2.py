def foo(s:str) -> None:
    print(s)

class B:
    def __init__(self, a:str, b:int, c:list[int]) -> None:
        self.r:str = a
        self.g:int = 7
        print(self.r)


def main():
    # s:str = "Hello"
    # foo(s)
    # print(s)
    # foo("Gello")

    a:list[str] = ["a", "b", "c", "d"]
    i:int
    # print(a[0])
    for i in range(len(a)):
        print(a[i])
    obj:B = B(a[1])
    print(obj.g)
if __name__ == "__main__":
    main()
