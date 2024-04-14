def bubbleSort(array: list[str]) -> None:
  i: int = 0
  for i in range(len(array)):
    swapped: bool = False
    j:int = 0
    for j in range(0, len(array) - i - 1):
      if array[j] > array[j + 1]:
        temp: str = array[j]
        array[j] = array[j + 1]
        array[j + 1] = temp
        swapped = True
    if not swapped:
      break

def main():
  data: list[str] = ["f", "d", "t", "r", 'y', 'e']
  bubbleSort(data)

  # print('Sorted Array in Ascending Order:')
  i: int = 0
  for i in range(len(data)):
    print(data[i])
    # print(data[i])


if __name__ == "__main__":
  main()
