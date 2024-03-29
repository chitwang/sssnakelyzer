def Fibonacci(n: int) -> int:
    # Check if input is 0 then it will
    # print incorrect input
    if n < 0: # akbdasdnfna lsdk f
        # print("Incorrect input)
        n = 1
 
    # Check if n is 0
    # then it will return 0
    elif n == 0:
        return 0
 
    # Check if n is 1,2
    # it will return 1
    elif n == 1 or n == 2:
        n += 100
        return n
    
    else:
        return Fibonacci(n-1) + Fibonacci(n-2)
 
def if_else_check(n : int)-> None:
    if n == 0:
        print("zero")
        n += 4564
        n *= 98
    elif n == 1:
        print("one")
        n += 87455
        n ^= 5
    else:
        print("nonzero")
        n -= 977
        n //= 87
    return
# Driver Program
# print(Fibonacci(9))
