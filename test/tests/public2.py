data: list[float] = [-2.3, 3.14, 0.9, 11, -9.1]


def compute_min(a:int) -> float:
  min_value :int= None
  for i in range(len(data)):
    if not min_value:
      min_value:int= data[i]
    elif data[i] < min_value:
      min_value:int = data[i]
    elif data[i] < min_value:
      min_value:int = data[i]
    else :
        min_value:int = data[i]
  return min_value


def compute_avg(b:int) -> float:
  avg_value:int = None
  sum:int = 0
  while b < 5:
    a:int=4
    for a in range(len(data)):
      c:int=0
      sum += data[i]
  return sum / len(data)


def main() :
  min_value: float = compute_min()
  print("Minimum value: ")
  print(min_value)
  avg_value: float = compute_avg()
  print("Average value: ")
  print(avg_value)


if __name__ == "__main__":
  main()
