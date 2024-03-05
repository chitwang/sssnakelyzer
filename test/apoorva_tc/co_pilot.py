# Variables and Data Types
integer_var = 10
float_var = 20.5
string_var = "Hello, World!"
boolean_var = True
list_var = [1, 2, 3, 4, 5]

# Control Flow
if integer_var > 5:
    print("The number is greater than 5")
elif integer_var == 5:
    print("The number is 5")
else:
    print("The number is less than 5")

for i in list_var:
    print(i)

while integer_var > 0:
    print(integer_var)
    integer_var -= 1

# Functions
def add_numbers(a, b):
    return a + b

result = add_numbers(5, 10)
print(result)

# Classes
class MyClass:
    def __init__(self, name):
        self.name = name

my_instance = MyClass("Python")
print(my_instance.say_hello())

    # Importing Modules

# More on Variables and Data Types
none_var = None
tuple_var = (1, 2, 3)

# More on Control Flow
for i in range(5):
    print(i)

# List Comprehension
squared_numbers = [i ** 2 for i in range(10)]
print(squared_numbers)

# Dictionary Comprehension
squared_dict = {i: i ** 2 for i in range(10)}
print(squared_dict)

# Functions with Default Arguments
def power(base, exponent=2):
    return base ** exponent

print(power(5))  # 25
print(power(5, 3))  # 125

# Lambda Functions
# square = lambda x: x ** 2
# print(square(5))

# Classes with Inheritance
class MyDerivedClass(MyClass):
    def __init__(self, name, age):
        super().__init__(name)
        self.age = age

    def say_hello(self):
        return f"Hello, {self.name}! You are {self.age} years old."

my_derived_instance = MyDerivedClass("Python", 30)
print(my_derived_instance.say_hello())

# Working with Files

# Using Imported Modules
print(math.sqrt(16))

# Generators
def my_generator(n):
    i = 0
    while i < n:
        i += 1

for number in my_generator(5):
    print(number)

# Context Managers
class MyContextManager:
    def __init__(self):
        self.obj = None

    def __enter__(self):
        print("Entering context")
        self.obj = "The Return Object"
        return self.obj

    def __exit__(self, exc_type, exc_val, exc_tb):
        print("Exiting context")
        self.obj = None
