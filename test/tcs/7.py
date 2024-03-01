
class MyClass:




    def __init__(self, value):
        self.value = value
    
    def method1(self):
        print("Method 1 called")

    def method2(self, arg):
        print("Method 2 called with argument:", arg)

    def static_method():

        
        print("Static method called")

    def class_method(cls):


        
        print("Class method called")


def print_primitive_or_class(obj):


    primitive_types = [int, float, str, bool]



    if isinstance(obj, primitive_types):


        print(obj)
    elif isinstance(obj, object):
        print(obj.__class__.__name__)
        # Print methods
        for method_name in dir(obj):
            

            
            if callable(getattr(obj, method_name)) and not method_name.startswith("__"):


                
                print("Method:", method_name)
    else:
        print("Error: Not a primitive type or class object")

# Test cases
my_instance = MyClass(42)


# jfijfefeijjfeiofje
print_primitive_or_class(my_instance)

print("Calling methods:")
my_instance.method1()


my_instance.method2("argument")


MyClass.static_method()



MyClass.class_method()

# Method overloading
class OverloadTest:
    def method(self, arg):
        print("Method with one argument called:", arg)


        

    def method(self, arg1, arg2):

        
        
        
        print("Method with two arguments called:", arg1, arg2)

overload_instance = OverloadTest()
overload_instance.method("argument1", "argument2")  # This should call the second method definition

#oiwhdasknlz,m

