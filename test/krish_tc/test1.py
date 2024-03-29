# Class definition
class Parent:
    def __init__(self, name:str):
        self.name: str = name

    def display_name(self) -> None:
        print("Parent's name:")
        print(self.name)

class Child(Parent):
    def __init__(self, name:str, age:int):
        self.age:int = age

    def display_info(self) -> None:
        print("Child's name:")
        print(self.name)
        print("Child's age:")
        print(self.age)


# Function declaration
def my_function(n: int) -> None:
    # For loop
    i:int
    for i in range(n):
        print("Iteration")
    
    # While loop
    while n > 0:
        n -= 1
        if n % 2 == 0:
            print("n is even")
        else:
            print("n is odd")
    
    print("Loop ended")


# Main part
if __name__ == "__main__":
    print("Starting the program...")
    # Object instantiation
    obj:Child = Child("Alice", 10)
    obj.display_info()

    # Function call
    my_function(5)

    print("Program completed.")
