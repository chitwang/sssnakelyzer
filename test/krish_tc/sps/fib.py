def fib(a : int) -> int:
    if a == 0:
        return 0
    elif a == 1:
        return 1
    else:
        return fib(a - 1) + fib(a - 2)
if __name__ == "__main__":
    print(fib(10))
