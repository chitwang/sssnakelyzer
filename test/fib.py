def Fibonacci(n):
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
        return 
    
    else:
        return Fibonacci(n-1) + Fibonacci(n-2)
 
 
# Driver Program
# print(Fibonacci(9))
