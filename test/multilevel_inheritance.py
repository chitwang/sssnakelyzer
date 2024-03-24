class A:
    def __init__(self):
        self.a: int = 2
        self.b: float = 15.324

    def add(self, x: int) -> int:
        return x + self.a
    
class B(A):
    def __init__(self, num: int):
        self.a = 5
        self.c: str = "Hey!"
        self.b = 132.132
        self.obj: A = A()
        self.num: int = num
    
class C(B):
    def __init__(self):
        self.x: bool = False

def main():
    obj: C = C()
    print(obj.obj.a)
    x: int = obj.add(3)
    print(x)

if __name__ == "__main__":
    main()
    