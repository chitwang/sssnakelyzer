class a:
    def __init__(self):
        self.x:int  = 1
        self.y:int  = 2
        self.z:str = "yhuy"

    def f(self):
        return self.x + self.y

b : a = a()
b.x = 9 
print(b.y)
print(b.z)
b.z = "uiu"
 # offset  = 0
 # b -> t1
 # t2 = t1 + 0 
 # b.x --> temporary = *t2
 # *(t1 + 0) = 9
 # print(*(t1 + 4))