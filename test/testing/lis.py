class LIS_SOLVER:
  def __init__(self, a:list[int], dp:list[int]) -> None:
    self.arr:list[int] = a
    self.dp:list[int] = dp

  def rec(self, level:int) -> int:
    if level < 0:
      return 0
    if self.dp[level] != -1:
      return self.dp[level]
    ans:int = 1
    i:int
    for i in range(0, level):
      if self.arr[i] < self.arr[level]:
        if ans < 1 + self.dp[i]:
          ans = 1 + self.dp[i]
    
    self.dp[level] = ans
    return ans
  
  def printdp(self) -> None:
    h:int
    for h in range(len(self.dp)):
      print(self.dp[h])  


def main() -> None:
  a:list[int] = [1, 4, 2, 5, 9, 0, 1, 7, 5, 6]
  dp:list[int] = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  mysolver:LIS_SOLVER = LIS_SOLVER(a,dp)
  ans:int = 0
  i:int
  for i in range(len(a)):
    temp:int = mysolver.rec(i)
    if temp > ans:
      ans = temp
  print(ans)
  print("Dp array after LIS Algo")
  mysolver.printdp()

if __name__ == "__main__":
  main()
