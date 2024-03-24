class A:

  def __init__(self,a:int,b:int):
    self.x: list[int] = [8,9,1,6,7]
    self.y: float = b


class B(A):

  def __init__(self):
    self.x = [9,8]
    self.y = 3.14
    self.z: str = "I am new"


def main():
  a: A = A(3,6)
  b: B = B()

def func(x: int, y: int) -> int:
  return x*y

# 
if __name__ == '__main__':
  main()
  # a: A = A(1,2)
  # func(1,2)
  
# def func(a:int) -> int:
# # a popparam
#   b:int=a+1
#   return b
i : int = 81

# for i in range(0):
#   print(i)
#   if()
# # else:
#   print(5)
  # param 24
  # call allocmem 1
  # t1 popparam
  # a = t1
  # param a
  # call A.init 1
  # t2 = popparam
  # a = t2
