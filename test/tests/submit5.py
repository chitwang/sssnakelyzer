def add(x, y):
    return x + y

def subtract(x, y):
    return x - y

def multiply(x, y):
    return x * y

def divide(x, y):
    if y == 0:
        return "Cannot divide by zero!"
    return x / y

def power(x, y):
    return x ** y

def main():
    print("Simple Calculator")
    print("Select operation:")
    print("1. Add")
    print("2. Subtract")
    print("3. Multiply")
    print("4. Divide")
    print("5. Power")
    while True:
        choice = int(input("Enter choice (1/2/3/4/5): "))
        if choice in (1, 2, 3, 4, 5):
            break
        else:
            print("Invalid choice! Please enter a number between 1 and 5.")
    num1 = float(input("Enter first number: "))
    num2 = float(input("Enter second number: "))
    if choice == 1:
        print(num1, "+", num2, "=", add(num1, num2))
    elif choice == 2:
        print(num1, "-", num2, "=", subtract(num1, num2))
    elif choice == 3:
        print(num1, "*", num2, "=", multiply(num1, num2))
    elif choice == 4:
        print(num1, "/", num2, "=", divide(num1, num2))
    elif choice == 5:
        print(num1, "^", num2, "=", power(num1, num2))

if __name__ == "__main__":
    main()
