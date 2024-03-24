# def is_prime(n:int):
#     if n <= 1:
#         return False
#     if n <= 3:
#         return True
#     if n % 2 == 0 or n % 3 == 0:
#         return False
#     i = 5
#     while i * i <= n:
#         if n % i == 0 or n % (i + 2) == 0:
#             return False
#         i += 6
#     return True

# def fibonacci(n:int):
#     fib_sequence = [0, 1]
#     while len(fib_sequence) < n:
#         fib_sequence.append(fib_sequence[-1] + fib_sequence[-2])
#     return fib_sequence

# def is_fibonacci(num:int):
#     fib_sequence = fibonacci(num)
#     return num in fib_sequence

# def prime_fibonacci(data: list[int]) -> list[int]:
#     nums: list[int] = [i for i in range(len(data))]
#     res : list[int] = (data[i] for i in nums if is_prime(i))
#     print(*res)

# def main():
#     print("This program checks if a number is prime and if it is in the Fibonacci sequence.")
#     num = int(input("Enter a number: "))
#     print(num, "is a prime number.") if is_prime(num) else print(num, "is not a prime number.")
    
#     if is_fibonacci(num):
        
#         print(num, "is in the Fibonacci sequence.")
#     else:
#         print(num, "is not in the Fibonacci sequence.")

#     prime_fibonacci([2,3,5,8,13,21,34])
c1:int = 0
if __name__ == "__main__":
    # check:int=4
    main()
