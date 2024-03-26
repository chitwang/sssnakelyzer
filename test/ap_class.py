#class definition
class Person:
    def __init__(self, name : str, age : int) -> None:
        self.name : str = name
        self.age : int = age

    def myfunc(self) -> None:
        print(self.name)
    
    def myint(self) -> int:
        return 5

class Student(Person):
    def __init__(self, name : str, age : int, year : int) -> None: 
        self.name = name
        self.age = age
        self.graduationyear : int = year

    def welcome(self) -> None:
        print(self.graduationyear)

#class with object of another class inside it
class Person2:
    def __init__(self, fname : str, lname : str) -> None:
        self.per_obj : Person = Person(fname, 36)
        self.firstname : str = fname
        self.firstname = fname
        self.lastname : str = lname
        self.per_obj.myfunc()

    def printname(self) -> None:
        print(self.firstname)
    
    def getage(self) -> int:
        return self.per_obj.age
    
class Person3:
    def __init__(self, name : str, age : int) -> None:
        self.name : str = name
        self.age : int = age

    def myfunc(self) -> None:
        print(self.name)

    def myint(self) -> int:
        return 5

def main() -> None:
    #object creation
    p1 : Person = Person("John", 36)
    #method calling
    p1.myfunc()
    # inheritance object creation
    s1 : Student = Student("Mike", 36, 2019)
    # inheritance method calling
    s1.welcome()
    #object of another class inside it
    p2 : Person2 = Person2("John", "Doe")
    p2.printname()
    #changing variable of class
    p2.per_obj.age = 40
    p2.per_obj.myfunc()
    #getting variable of class
    x: int = p2.getage()


if __name__ == "__main__":
    main()
