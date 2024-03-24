def create_class(name):

  class MyClass:

    def __init__(self, value):
      self.value = value

    def get_value(self):
      return self.value

  return MyClass

MyClass = create_class("MyClass")  # Call the function to create the class

obj = MyClass(10)  # Create an instance of the class
print(obj.get_value())  # Output: 10
