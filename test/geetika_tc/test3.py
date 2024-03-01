
def func(a,b):
    b=3
class MyClass:
    a = [9,8]
    def method_to_call(self, x):
        return x + self.value

obj = MyClass()
a  = obj.a
a[0] = 10
b=4
c=b
c=3
func(a, b)
print(b)
# print(obj.a)
