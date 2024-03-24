def a(b:int, c:bool,s:str, f:float, d : list[int]) -> None:
    t:int =0

# def a(b:int, c:str) -> None:
#     t:int =0

x: list[int] = [1,2,3]
# len([1])
s:str 
a(1,False, s, 4.3145, x)

class A:
    def __init__(self, b:int, c:bool,s:str, f:float, d : list[int]) -> None:
        self.x :int = b
        self.b : bool = c

obj : A = A(1,False, s, 4.3145, x)
