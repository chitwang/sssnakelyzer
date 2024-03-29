#check lhs to be assignable --> done
#LHS cannot be CLASS, LITERAL OR FUNCTION in =
class A:
    def __init__(self : A , a: int) -> int:
        self.n : int 
        return a
def func() -> int:
    a : int = 3
    return a
# #this should give and error:
# # func() = 2
# A = 3
# # "ihh3ofi" = "ji"
# # 8 = 9
# # 5.0 = 6.0


#check true and false;
b : bool = True
c : bool = False

