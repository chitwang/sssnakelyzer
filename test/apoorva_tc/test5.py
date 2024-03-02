class Shape:
    def __init__(self, color: str):
        self.color: str = color

    def display_color(self) -> None:
        print("Color:", self.color)


class Circle(Shape):
    def __init__(self, color: str, radius: float):
        super().__init__(color)
        self.radius: float = radius

    def area(self) -> float:
        return 3.14 * self.radius ** 2


class Rectangle(Shape):
    def __init__(self, color: str, width: float, height: float):
        super().__init__(color)
        self.width: float = width
        self.height: float = height

    def area(self) -> float:
        return self.width * self.height


if __name__ == "__main__":
    circle: Circle = Circle(
        color="red",
        radius=5.0
    )

    rectangle: Rectangle = Rectangle(
        color="blue",
        width=4.0,
        height=6.0
    )

    circle.display_color()
    print("Circle area:", circle.area())

    rectangle.display_color()
    print("Rectangle area:", rectangle.area())
