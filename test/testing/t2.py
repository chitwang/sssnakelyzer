def foo(s:str) -> None:
    print(s)

class B:
    def __init__(self, a:str) -> None:
        self.a:str = a
        print(self.a)


def main():
    # s:str = "Hello"
    # foo(s)
    # print(s)
    # foo("Gello")

    a:list[str] = ["a", "b", "c", "d"]
    # i:int
    print(a[0])
    # for i in range(len(a)):
    #     print(a[i])

    obj:B = B("f")

if __name__ == "__main__":
    main()
