def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def fibonacci(n):
    fib_sequence = [0, 1]
    while len(fib_sequence) < n:
        fib_sequence.append(fib_sequence[-1] + fib_sequence[-2])
    return fib_sequence

def is_fibonacci(num):
    fib_sequence = fibonacci(num)
    return num in fib_sequence

def main():
    print("This program checks if a number is prime and if it is in the Fibonacci sequence.")
    num = int(input("Enter a number: "))
    if is_prime(num):
        print(num, "is a prime number.")
    else:
        print(num, "is not a prime number.")
    
    if is_fibonacci(num):
        print(num, "is in the Fibonacci sequence.")
    else:
        print(num, "is not in the Fibonacci sequence.")
    print("Done")

if __name__ == "__main__":
    main()
