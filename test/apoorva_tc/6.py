class A:
    def __init__(self, value):
        self.value = value

class B(A):
    def __init__(self, value):
        super().__init__(value)

class C(B):
    def __init__(self, value):
        super().__init__(value)

def print_primitive_or_class(obj):
    primitive_types = [int, float, str, bool]
    if isinstance(obj, primitive_types):
        print(obj)
    elif isinstance(obj, object):
        # print(obj.__class__.__name__)
        if hasattr(obj, '__dict__'):
            print("Random")
    else:
        print("Error: Not a primitive type or class object")

# Test cases
print_primitive_or_class(10)
print_primitive_or_class(3.14)
print_primitive_or_class("Hello")
print_primitive_or_class(True)
print_primitive_or_class(None)

obj_a = A(5)
print_primitive_or_class(obj_a)

obj_b = B(10)
print_primitive_or_class(obj_b)

obj_c = C(15)
print_primitive_or_class(obj_c)

# • Support for classes and objects, including multilevel inheritance and constructors. Ignore
# multiple inheritance (i.e., a class can have only one parent class).
