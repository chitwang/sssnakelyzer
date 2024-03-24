class base:
    x: int

class derived(base):
    

    def func(self, a: int) -> int:
        # print("line 9")
        z: int = 5
        return z

    def __init__(self):
        self.x = 5
        self.func(5)
        # print(self.func())

def main():
    # obj: derived = derived()
    # obj
    x: int = 5
    # print(x)
    obj: derived = derived()
    obj.func()
__name__ = "main"
if __name__ == "main":
    main()


