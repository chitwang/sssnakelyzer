# Class definition
class Parent:
    def __init__(self, name):
        self.name = name

    def display_name(self):
        print("Parent's name:", self.name)


class Child(Parent):
    def __init__(self, name, age):
        super().__init__(name)
        self.age = age

    def display_info(self):
        print("Child's name:", self.name)
        print("Child's age:", self.age)


# Function declaration
def my_function(n):
    # For loop
    for i in range(n):
        print("Iteration", i)

    # While loop
    while n > 0:
        n -= 1
        if n % 2 == 0:
            print(n, "is even")
        else:
            print(n, "is odd")
    
    print("Loop ended")


# Main part
if __name__ == "__main__":
    print("Starting the program...")
    # Object instantiation
    obj = Child("Alice", 10)
    obj.display_info()

    # Function call
    my_function(5)

    print("Program completed.")
