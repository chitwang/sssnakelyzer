# def main():
#   a:list[int] = [1, 2, 3, 69]
#   i:int = len(a)
#   a[i] = 2
#   if "Hello" < "hello":
#     print(1)
#   if "Hello" > "hello":
#     print(1)
#   if "Hello" >= "hello":
#     print(1)
#   if "Hello" <= "hello":
#     print(1)
#   if "Hello" == "hello":
#     print(1)
#   if "Hello" != "hello":
#     print(1)

# if __name__ == "__main__":
#   if 2 < 1:
#     main()

# a:int = 1
# b:int = 1
# c:int = 1
# d:int = 1

# a = b + c
# b = a - d
# c = b + c
# d = a - d

def foo(x: int) -> int:
    y:int = 5*x
    return y

def main():
    a:int = 4
    b:int = foo(a)

if __name__ == "__main__":
    main()
