class GrandParent:
  def __init__(self):
    self.a:bool = False

  def show(self, num:int) -> bool:
    print("Hi")
    print(num)
    print(self.a)
    return self.a

  # def show(self) -> bool:
  #   print("Hi")
  #   return self.a


class Parent(GrandParent):
  def __init__(self, num:int):
    self.num:int = num
    self.a = True

  def ret_grand_parent(self) -> list[GrandParent]:
    g1:GrandParent = GrandParent()
    g2:GrandParent = GrandParent()
    g3:GrandParent = GrandParent()
    g4:GrandParent = GrandParent()

    return [g1, g2, g3, g4]


class Child(Parent):
  def __init__(self, name:str, num:int, b:bool):
    self.num = num
    self.name: str = name
    self.a = b

  def ret_parent(self) -> list[Parent]:
    p1:Parent = Parent(1)
    p2:Parent = Parent(2)
    p3:Parent = Parent(3)
    p4:Parent = Parent(4)
    p5:Parent = Parent(5)
    p6:Parent = Parent(6)
    p7:Parent = Parent(7)
    p8:Parent = Parent(8)
    p9:Parent = Parent(9)
    p10:Parent = Parent(10)

    obj:list[Parent] = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]
    return obj
  
  def display(self) -> None:
    print(self.name)
    print(self.num)
  

def main():
  c:Child = Child("Yello", 100, True)
  obj:GrandParent = GrandParent()
  # print(c.ret_parent()[9].num)
  # print(c.ret_parent()[3].ret_grand_parent()[1].show())
  # print(c.ret_parent()[3].ret_grand_parent()[1].show(5))
  print(c.ret_parent()[3].ret_grand_parent()[1].show(c.ret_parent()[9].num))
  # print(obj.show(1))
  c.display()

if __name__ == "__main__":
  main()
