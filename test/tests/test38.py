a: list[int] = [1,2,3,4,5]

class A:
    def __init__(self):
        self.b :list[str] = ["hello", "world"]


i: int
for i in range(10):
    if i>7:
        continue
    print(i)
    

else:
    print(i+1)
