def func(a: int) -> int:
    b: int = 0
    i: int
    for i in range(a):
        b += i
    return b

def func2(a: int, b: int) -> int:
    i: int
    sum: int = 0
    for i in range(a,b):
        sum += i
    return sum

def main():
    func(7)
    func2(-1, 99)
