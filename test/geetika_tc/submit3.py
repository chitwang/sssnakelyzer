def _lis(arr, n, maximum):
    if n == 1:
        return 1
    maxEndingHere = 1
    for i in range(1, n):
        res = _lis(arr, i, maximum)
        if arr[i - 1] < arr[n - 1] and res + 1 > maxEndingHere:
            maxEndingHere = res + 1
    maximum[0] = max(maximum[0], maxEndingHere)
    return maxEndingHere


def lis(arr):
    n = len(arr)
    maximum = [1]  # Use a list to store the maximum value for reference
    _lis(arr, n, maximum)
    return maximum[0]


def find_max(arr):
    if not arr:
        return None
    max_num = arr[0]
    for num in arr:
        if num > max_num:
            max_num = num
    return max_num


def find_min(arr):
    if not arr:
        return None
    min_num = arr[0]
    for num in arr:
        if num < min_num:
            min_num = num
    return min_num


if __name__ == '__main__':
    arr:list[int] = [10, 22, 9, 33, 21, 50, 41, 60]
    n = len(arr)
    print("Length of lis is", lis(arr))
    print("Maximum number in the array:", find_max(arr))
    print("Minimum number in the array:", find_min(arr))
