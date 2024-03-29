class A:
  def __init__(self, num:int):
    self.num: int = num
    self.alk:bool = False

def main():
  a:A = A(1)
  b:A = A(2)
  c:A = A(3)
  d:A = A(4)
  e:A = A(5)
  f:A = A(6)
  li: list[A] = [a, b, c, d, e, f]
  i: int
  for i in range(2, len(li)):
    i *= 1
    print(li[i].num)

if __name__ == "__main__":
  main()
