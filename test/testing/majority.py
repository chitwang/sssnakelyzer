def count_occurrences(arr: list[int], low: int, high: int, num: int) -> int:
    count: int = 0
    i: int
    for i in range(low, high):
        if arr[i] == num:
            count += 1
    return count

# Function to find the majority element using recursion


def find_majority_util(arr: list[int], low: int, high: int) -> int:
    # Base case: single element array
    if low == high:
        return arr[low]

    # Divide the array into left and right halves
    mid: int = (low + high) // 2
    left_majority: int = find_majority_util(arr, low, mid)
    right_majority: int = find_majority_util(arr, mid+1, high)

    # If left and right halves have the same majority element
    if left_majority == right_majority:
        return left_majority

    # Count the occurrences of the majority element in the entire array
    left_count: int = count_occurrences(arr, low, high + 1, left_majority)
    right_count: int = count_occurrences(arr, low, high+1, right_majority)

    # Return the element that occurs more than n/2 times
    if left_count > (high-low+1) // 2:
        return left_majority
    if right_count > (high-low+1) // 2:
        return right_majority

    # No majority element
    return -1

# Function to find the majority element


def find_majority(arr: list[int]) -> int:
    n: int = len(arr)
    majority: int = find_majority_util(arr, 0, n-1)
    if majority != -1:
        print(majority)
    else:
        print("No Majority Element")


def main():
    arr: list[int] = [1, 3, 3, 3, 2, 5, 6, 3, 7, 3, 3, 3, 8, 9, 3]
    find_majority(arr)


if __name__ == "__main__":
    main()
