# function definition --> tested
def add(a : int, b : int) -> int:
    return a + b

# function definition with list parameter
def add_list(a : list[int]) -> int:
    i : int = 0
    sum : int = 0
    a[i] = 5
    for i in range(5):
        sum += i
        sum+=0
    return sum

# function returning value even though it is null
def return_none() -> None:
    return

def main() -> None:
    # function call
    add(1, 2)
    
    # function call
    add_list([1, 2, 3, 4, 5])
    
    # function call with list parameter
    sample_list : list[int] = [1, 2, 3, 4, 5]
    print(add_list(sample_list))
    
    # function returning value even though it is null
    # print(return_none())

if __name__ == "__main__":
    main()
