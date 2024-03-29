class Shape:
    def __init__(self, color: str) -> None:
        self.color: str = color

    def display_color(self) -> None:
        print("Color:")


class Circle(Shape):
    def __init__(self, color: str, radius: float) -> None:
        self.radius: float = radius

    def area(self) -> float:
        return 3.14 * self.radius ** 2


class Rectangle(Shape):
    def __init__(self, color: str, width: float, height: float) -> None:
        self.width: float = width
        self.height: float = height

    def area(self) -> float:
        return self.width * self.height


if __name__ == "__main__":
    circle: Circle = Circle("adf",2)

    rectangle: Rectangle = Rectangle(color, width, height)

    circle.display_color()
    print("Circle area:")
    print(circle.area())

    rectangle.display_color()
    print("Rectangle area:")
    print(rectangle.area())
