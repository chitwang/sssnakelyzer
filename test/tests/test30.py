print(5)
def good(a: int ) -> int:
    return a+1

def bad(a: int, b: int) -> int:
    return a+b

good(1)
x: int = 4
print(good(1))

class A:
    x: int = 1

class B(A):
    y: int

obj: A = A()
obj.__init__()
obj.x = 10
# obj2.x = 20
print(obj.x)
# obj2: B = B()
# obj2.__init__()
