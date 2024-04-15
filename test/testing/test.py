class Temp:
  def __init__(self):
    self.a:bool = True

  def show(self, x:list[int]) -> bool:
    return self.a + x[1]


def main():
  li:list[int] = [1, 2, 3]
  obj:Temp = Temp()
  print(obj.show([1, 2, 3]))
  # print(obj.show(obj.a))


if __name__ == "__main__":
  main()
