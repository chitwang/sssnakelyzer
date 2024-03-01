#recursive definition
def factorial(n):
    if n == 0:
        return 1
    else:
        return n * factorial(n - 1)

def fibonacci(n):
    if n <= 1:
        return n
    else:
        return fibonacci(n - 1) + fibonacci(n - 2)

def test_factorial():
    # Test factorial function
    result_0 = factorial(0)
    if result_0 != 1:
        print("Factorial of 0 failed")

    result_1 = factorial(1)
    if result_1 != 1:
        print("Factorial of 1 failed")

    result_5 = factorial(5)
    if result_5 != 120:
        print("Factorial of 5 failed")

    result_10 = factorial(10)
    if result_10 != 3628800:
        print("Factorial of 10 failed")

def test_fibonacci():
    # Test Fibonacci function
    result_0 = fibonacci(0)
    if result_0 != 0:
        print("Fibonacci of 0 failed")

    result_1 = fibonacci(1)
    if result_1 != 1:
        print("Fibonacci of 1 failed")

    result_2 = fibonacci(2)
    if result_2 != 1:
        print("Fibonacci of 2 failed")

    result_5 = fibonacci(5)
    if result_5 != 5:
        print("Fibonacci of 5 failed")

    result_10 = fibonacci(10)
    if result_10 != 55:
        print("Fibonacci of 10 failed")

if __name__ == "__main__":
    test_factorial()
    test_fibonacci()
    print("All test cases for recursion passed successfully!")
