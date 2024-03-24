class A:
    def __init__(self):
        self.x : int = 1
a : A = A()
b: A = a
b.x = 2
print(a.x) # 2