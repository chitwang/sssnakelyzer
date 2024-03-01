def print_primitive(value):
    primitive_types = [int, float, str, bool]
    if isinstance(value, primitive_types):
        print(value)
    else:
        print("Error: Not a primitive type")

# Test cases
print_primitive(10)
print_primitive(3.14)
print_primitive("Hello")
print_primitive(True)
print_primitive(None)
print_primitive([1, 2, 3])  # Should not print
