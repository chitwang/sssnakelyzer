#explicit and implicit line joining
a:int = 5
b:int \
= 5
print(b)


li = [5,5,
      6,8]
print(li)


def foo(a, 
        b):
    print(a+b)

foo([5,6],
    [4,
     8] )

d:int
d:int = 5 + 6

a = [[5,
      4],
      [6,7]]

# Augmented assignment operators
num7 = 8
num8 = \
         2
num7 += num8
num8 **= 2

print("\nAugmented Assignment Operators:"
          )
print("num7 \t += num8:", num7)
print("num8 **= 2:", num8)

def random_fn(a:int, 
               b:float,
              c:list[int])->float:
    #doing random things here
    f:int
    f:int = 5 + 6
    l:\
  bool = False
    
    return c[a**2] \
        + b*2 + \
a//b + f
