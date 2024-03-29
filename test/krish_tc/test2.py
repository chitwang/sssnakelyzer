# Class definition
class Animal:
    def __init__(self, species):
        self.species = species

    def display_species(self):
        print("Species:", self.species)


class Dog(Animal):
    def __init__(self, species, name):
        super().__init__(species)
        self.name = name

    def bark(self):
        print("Woof! My name is", self.name)


# Function declaration
def count_down(start):
    while start > 0:
        print(start)
        start -= 1
    print("Blast off!")


# Main part
if __name__ == "__main__":
    print("Welcome to the animal world!")
    # Object instantiation
    animal = Animal("Canine")
    animal.display_species()

    # Object instantiation
    my_dog = Dog("Canine", "Max")
    my_dog.display_species()
    my_dog.bark()

    # Function call
    count_down(5)

    print("End of the program.")

