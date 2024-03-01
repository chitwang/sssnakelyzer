# Primitive Data Types:
x = 10
y = 3.14
z = "hello"
is_valid = True

# Lists
my_list = [1, 2, 3, 4, 5]

#Basic Operators:
result = 10 + 5
result = 10 - 5
result = 10 * 5
result = 10 / 5
result = 10 // 5
result = 10 % 3
result = 10 ** 2

result = (10 == 5)
result = (10 != 5)
result = (10 > 5)
result = (10 < 5)
result = (10 >= 5)
result = (10 <= 5)

result = (True and False)
result = (True or False)
result = not True

result = 10 & 5
result = 10 | 5
result = 10 ^ 5
result = ~10
result = 10 << 2
result = 10 >> 2

x = 10
x += 5
x -= 5
x *= 5
x /= 5
x //= 5
x %= 3
x **= 2
x &= 5
x |= 5
x ^= 5
x <<= 2
x >>= 2

# Control Flow
if x > 5:
    print("x is greater than 5")
elif x < 5:
    print("x is less than 5")
else:
    print("x is equal to 5")

for i in range(5):
    print(i)

while x > 0:
    print(x)
    x -= 1

# Functions
def add_numbers(a, b):
    return a + b

result = add_numbers(5, 10)
print(result)

# Classes

class MyClass:
    def __init__(self, name):
        self.name = name

    def say_hello(self):
        return "hello"
    
#print fucntion
print(10)
print(3.14)
print("hello")
print(True)

#classes and objects

class Vehicle:
    def __init__(self, color):
        self.color = color

class Car(Vehicle):
    def __init__(self, color, brand):
        super().__init__(color)
        self.brand = brand

my_car = Car("red", "Toyota")

#methods calls
class MyClass:
    def my_method(self):
        print("Hello from my_method")

obj = MyClass()
obj.my_method()

#static polymorphism 

class Math:
    def add(self, x, y):
        return x + y

    def add(self, x, y, z):
        return x + y + z

m = Math()
result1 = m.add(1, 2)
result2 = m.add(1, 2, 3)

#inheritance
class Vehicle:
    def __init__(self, color):
        self.color = color

class Car(Vehicle): 
    def __init__(self, color, brand):
        super().__init__(color)
        self.brand = brand

my_car = Car("red", "Toyota")

   
