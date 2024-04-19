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

class T:
  def __init__(self, num:int):
    self.num: int = num
    self.alk:bool = False


def main():
    obj: C = C()
    print(obj.obj.a)
    x: int = obj.add(3)
    print(x)

    a:T = T(1)
    b:T = T(2)
    c:T = T(3)
    d:T = T(4)
    e:T = T(5)
    f:T = T(6)
    li: list[T] = [a, b, c, d, e, f]
    i: int
    for i in range(2, len(li)):
      i *= 1
      print(li[i].num)

if __name__ == "__main__":
    main()
    