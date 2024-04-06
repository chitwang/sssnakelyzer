# flag:bool = True
 
# if flag:
#     print(1324)
#     print(13254)
# elif flag:
#     x:int = 1
#     a:str = "idk"
# elif flag:
#     print("Aergsdf")
#     print(True)
# elif flag:
#     b:bool = 94
#     y:float = 345.1345
# else:
#     print(a)

# y = 0.0

# def foo() -> int:
#   return 0

# a:int = 5
# print(foo())
# b:int = 5
# class A:
#   def __init__(self):
#     self.x: int = 1
#     self.y:int = 2
  
class B:
  def __init__(self):
    self.a:int = 4

  def foo(self, a:int, b:int, c:int) -> int:
    return a+b+c

def foo(a:int, b:int, c:int) -> int:
    return a+b+c

# obj:B = B()
# print(obj.foo().x)

# if "compare" > "Compare" > "compare":
def main():
  # a:list[int] = [1, 2, 3]
  # b:list[int] = [1, 2, 3]
  i:int = 0
  j:int = 1
  # a[i] = b[j] + 1
  # a[i] = b[j] + b[j - 1]
  # a[i] = b[j]
  # a[i] += b[j]
  # if a[0]:
  #     print("false")
  # x:list[str] = ["a", "b", "c"]
  # s:str = "asdfa"
  # strm:str = "new"
  # if x[0] > x[1]:
  #     print("True")
  # li:list[int] = [1, 2, 3]

  # print(b[1])

  # obj:B = B()
  ac:int = 4 + 5
  ab:int = 5
  c:int = ab + 43

  # p:int = obj.foo(ac, c, 3)
  p:int = foo(ac, c, 3)
  print(p)

# main()
