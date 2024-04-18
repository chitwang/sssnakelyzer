def if_else_check(n : int)-> int:
    if n < 0:
        return -n
    
    if n == 0:
        print("zero")
        n += 4564
        n *= 98
        return if_else_check(n - 3)
    elif n == 1:
        print("one")
        n += 87455
        n ^= 5
        return if_else_check(n - 3)
    elif n == 2:
        print("two")
        n //= 435
        n **= 34
        return if_else_check(n - 3)
    else:
        print("nonzero")
        n -= 977
        n //= 87
        return if_else_check(n - 3)

def main():
    x:int = if_else_check(364)
    print(x)

if __name__ == "__main__":
    main()
