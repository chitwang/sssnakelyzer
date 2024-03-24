class Shape:
    def area(self):
        raise NotImplementedError("Subclasses must override area()")

class Rectangle(Shape):
    def __init__(self, length, width):
        self.length = length
        self.width = width

    def area(self):
        return self.length * self.width

class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius
    def good(self,s: str, x: int) -> int:
        print(s)
        print(x)
    def good(self,s: int, x: str,y:int) -> int:
        print(s)
        print(x)
        print(x)
    def area(self):
        return 3.14 * self.radius * self.radius

# Usage (polymorphism in action based on object type)
shapes = [Rectangle(4, 5), Circle(3)]
for shape in shapes:
    print(shape.area())  # Output: 20, 28.26

x: Shape = Rectangle(4,5)
y: Circle = Circle(3)
y.good("hello", 3)
