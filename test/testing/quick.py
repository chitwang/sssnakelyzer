def partition(array:list[int], low:int, high:int) -> int:
    pivot:int = array[high]
    i:int = low - 1
    j:int
    
    for j in range(low, high):
        if array[j] <= pivot:
            i = i + 1
            tmp:int = array[i]
            array[i] = array[j]
            array[j] = tmp
 
    temp:int = array[i+1]
    array[i+1] = array[high]
    array[high] = temp
 
    return i + 1
 
  
def quickSort(array:list[int], low:int, high:int) -> None:
    if low < high:
        pi:int = partition(array, low, high)
        quickSort(array, low, pi - 1)
        quickSort(array, pi + 1, high)


def main():
    data:list[int] = [1, 7, 4, 1, 10, 9, -2]
    print("Unsorted Array")
    size:int = len(data)
    i:int
    for i in range(size):
        print(data[i])
    
    quickSort(data, 0, size - 1)
    
    print('Sorted Array in Ascending Order:')
    for i in range(size):
        print(data[i])

if __name__ == '__main__':
    main()