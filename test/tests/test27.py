
class c:
    def __init__(self):
        self.x:int = 9898
        print(self.x)
    def good(self):
        print(self.x)
class B(c):
    def __init__(self):
        self.x : float = 1
        print(self.x)
        self.good()
b : B = B()


