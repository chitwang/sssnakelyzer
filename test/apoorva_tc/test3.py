# Arithmetic operators
a = 10
b = 5
c = a + b
d = a - b
e = a * b
f = a / b
g = a // b
h = a % b

# Comparison operators
if a > b:
    print("a is greater than b")
if a < b:
    print("a is less than b")
if a >= b:
    print("a is greater than or equal to b")
if a <= b:
    print("a is less than or equal to b")
if a == b:
    print("a is equal to b")
if a != b:
    print("a is not equal to b")

# Logical operators
x = True
y = False
if x and y:
    print("Both x and y are true")
if x or y:
    print("At least one of x or y is true")
if not y:
    print("y is false")

# Bitwise operators
m = 10  # 1010 in binary
n = 4   # 0100 in binary
o = m & n  # Bitwise AND
p = m | n  # Bitwise OR
q = m ^ n  # Bitwise XOR
r = ~m     # Bitwise NOT
s = m << 1  # Bitwise left shift
t = m >> 1  # Bitwise right shift

# Augmented assignment expressions
u = 5
u += 2
v = 8
v -= 3
w = 10
w *= 2
x = 15
x /= 3
y = 20
y //= 4
z = 25
z %= 6

print(c, d, e, f, g, h)
print(o, p, q, r, s, t)
print(u, v, w, x, y, z)
