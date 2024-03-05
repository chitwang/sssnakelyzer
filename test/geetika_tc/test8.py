class LR0Parser(a=1,b="geet"):

  def __init__(self, myname_: str, parentname_: str):
    self.lr0name: str = myname_
    ShiftReduceParser.__init__(self, parentname_)
