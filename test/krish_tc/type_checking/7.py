#entry of the same name already present in the symbol table
#parameter of a function name repeated
#errors in print and range

a : int = 0
def a():
    b : int = 3
    return
class a:
    b : int = 3

def func(a : int , a : int) -> int:
    return a
    

# this gives an error

# errors in print and range

x : int = 0
print(x)
xx : float = 0
print(xx)
xxx : bool = True
print(xxx)
xxxx : str = "j"
print(xxxx)

# yahan tak print m no error
# ab error aayega
print(1,2,3,4,5,6,7,8,9,10)

i : int = 0
for i in range(5):
    print(i)
for i in range(0,5):
    print(i)

# this gives no error

for i in range(5,0,-1):
    print(i)

# this gives an error
    
