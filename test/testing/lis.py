def rec(a:list[int], dp:list[int], level:int) -> int:
  if level < 0:
    return 0
  if dp[level] != -1:
    return dp[level]
  ans:int = 1
  i:int
  for i in range(0, level):
    if a[i] < a[level]:
      if ans < 1 + dp[i]:
        ans = 1 + dp[i]
  
  dp[level] = ans
  return ans


def main() -> None:
  a:list[int] = [1, 4, 2, 5, 9, 0, 1, 7, 5, 6]
  dp:list[int] = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
  ans:int = 0
  i:int
  for i in range(len(a)):
    temp:int = rec(a, dp, i)
    if temp > ans:
      ans = temp

  print(ans)


if __name__ == "__main__":
  main()
