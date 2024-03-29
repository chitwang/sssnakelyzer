#check that add members declared inside init with self.a into the symbol table for class   --> done
#check that self.n karke kuch declare karre hain toh uska size badh raha hai end entry bhi declare hori hai --> test
class A:
    def f(self : A , a : int)-> int:
        self.x : str = "igvewgfiuewgfiuefefhfwuw"
        return a
    def __init__(self : A , a: int) -> int:
        self.n : int 
        self.m : int        
        return a
#total size of the A class is 24

class B(A):
    def __init__(self: A, a: int) -> int:
        self.b : int = 2
        self.a : A = A(2)
        return a
# total size of this class will come out to be 32
    
class C(B):
    def __init__(self: C) -> int:
        self.c : int = 3
        self.b : B = B(2)
        return 3
# total size of this class will come out to be 40