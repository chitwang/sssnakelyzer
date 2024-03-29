# errors in global statements :
# ** cannot declare after writing global in the same scope.
# ** if after writing global a, a is no where to be found give error

a : int = 0
def f():
    global a
    a = 3
    return
# this gives and error
b: int = 1

global b
# this also gives an error

