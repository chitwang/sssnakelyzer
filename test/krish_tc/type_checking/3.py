#check the return type of the function actually matches what is returned  --> done

def func() -> float:
    a : int = 3
    return a
#implicit type conversion

def func1() -> None:
    a : int = 3
    return
#error in return type 

def func2() -> int:
    a : int = 3
    return a
#error in return type

def func3() -> int:
    a : int = 3
    return a
#eeror in return type

#total number of errors are 3

#ARRAY INDEXING CANNOT BE DONE BY FLOAT, STRING OR OBJECT  --> done test
a : list[int] = [9,9,9]
# a[3.0]
# a[""]
# a[func()]
# a[func1()]
a[func2()]
#3 errors in array indexing 
