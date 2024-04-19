
def foo(a:int, 
        b:int) -> None:
    print(a+b)
    return

def random_fn(a:int, 
               b:float,
              c:list[int])->float:
    #doing random things here
    f:int = 5 + 6
    l:\
  bool = False
    
    return c[a**2] \
        + b*2 + \
a//b + f

def main():
    #explicit and implicit line joining
    a:int = 5
    b:int \
    = 5
    print(b)

    li:list[int] = [5,5,
          6,8]
    i:int
    for i in range(2,len(li)):
        print(li[i])
    
    d:int = 5 + 6

    # Augmented assignment operators
    num7:int = 8
    num8:int = \
            2
    num7 += num8
    num8 **= 2

    print("\nAugmented Assignment Operators:"
              )
    print("num7 \t += num8:")
    print("num8 **= 2:")

    x:float = random_fn(1, 4, [1, 3, 5])
    print(x)
    print(li[-1])

if __name__ == "__main__":
    main()
