def fib(n:int) -> int:
  if not n:
    return 0
  return n + fib(n-1)

def main():
  a:int = 2
  print(a ** 5)
  b:int = 3 + 4
  c:int = 1 * 4
  i:int
  for i in range(0, 10):
    a = b + c
  x:int = 49700
  print(fib(x))
  print((x * (x+1))/2)
  return

if __name__ == "__main__":
  main()
