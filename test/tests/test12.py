def print(a:str):
    a="geet"
class MyClass:
    x: int = 9
    def method1(self):
        print("Method 1")

    def method2(self):
        print("Method 2")
        self.method1()  # Calling method1 using self

    def method3(self):
        print("Method 3")
        self.x = 10
        print("sdf")
        self.method1() 
        # self.method3()# Calling method1 without using self
obj:MyClass = MyClass()
obj.method1()  # Output: Method 1
obj.method2()  # Output: Method 2, Method 1
obj.method3()  # Output: Method 3, Method 1
((obj)).method1()
