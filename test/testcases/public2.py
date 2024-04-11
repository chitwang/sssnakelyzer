def compute_min(data: list[int]) -> int:
  min_value: int = 0
  i: int = 0
  
  for i in range(len(data)):
    print(i)
    print("dance")
    if min_value == 0:
      min_value = data[i]
      a:int = 4
    elif data[i] < min_value:
      min_value = data[i]
  return min_value 


def compute_avg(data: list[int]) -> int:
  avg_value: int = 0
  sum: int = 0
  i: int = 0
  for i in range(len(data)):
    sum += data[i]
  return sum / len(data)


def main():
  data: list[int] = [-2, 3, 2, 11, -9]
  min_value: int = compute_min(data)
  print('Minimum value: ')
  print(min_value)
  avg_value: int = compute_avg(data)
  print('Average value: ')
  print(avg_value)


if __name__ == "__main__":
  main()
