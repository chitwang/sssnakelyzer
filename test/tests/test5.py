def add(x :int, y:int):
    return x + y

def subtract(x:int, y:int):
    return x - y

def multiply(x:int, y:int):
    return x * y

def divide(x:int, y:int):
    if y == 0:
        return "Cannot divide by zero!"
    return x / y

def power(x:int, y:int):
    return x ** y

def main():
    while True:
        choice:int = int(input("Enter choice (1/2/3/4/5): "))
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
