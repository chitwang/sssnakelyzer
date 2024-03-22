class ShiftReduceParser:

  def __init__(self, name_: str):
    self.srname: str = name_


class LR0Parser(ShiftReduceParser):

  def __init__(self, myname_: str, parentname_: str):
    self.lr0name: str = myname_
    self.srname = parentname_


class CLRParser(ShiftReduceParser):

  def __init__(self, myname_: str, parentname_: str):
    self.clrname: str = myname_
    # ShiftReduceParser.__init__(self, parentname_)
    self.srname = parentname_


class LALRParser(CLRParser):

  def __init__(self, myname_: str, clrname_: str, srname_: str):
    self.lalrname: str = myname_
    # CLRParser.__init__(self, clrname_, srname_)
    self.clrname = clrname_
    self.srname = srname_
  def foo(self):
    a: int = 5
    print('SLR name:')
    print(self.srname)
    print('CLR name:')
    print(self.clrname)
    print('LALR name:')
    print(self.lalrname)


def main():
  obj: LALRParser = LALRParser('LALR', 'CLR', 'Shift-Reduce')
  obj.foo()


if __name__ == "__main__":
  main()
