class c:
    def __init__(self):
        self.x:int = 9898
        self.z:bool = 0
        print(self.x)
class A(c):
    a : int = 90
    b:float= 0.0
    def __init__(self):
        self.a = self.a + 1
    def good(self,a:int,b: bool, c:str, d:int)-> None:
        print(a+1)

class B(A):
    k:bool = 1
    def __init__(self):
        self.x = 1
        self.k = 0
        print(self.x)

    def bad(self,b:int) -> None:
        print(9)
        # self.x
        # self.good(b) 
        # print(self.a)

b : B = B()
b.bad(3)
# b.good(3)
e:list[int]=[1,2,3,4,5]
e[a+b]


