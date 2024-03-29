def main() -> None:
    x : bool = True
    y : bool = False

    # if x then print something else print something else
    if x:
        print("x is true")
    else:
        print("x is false")

    # if x and y then print something else print something else
    if x and y:
        print("x and y are true")
    else:
        print("x and y are false")
    
    # if x or y then print something else print something else
    if x or y:
        print("x or y is true")
    else:
        print("x or y is false")

    # if not x then print something else print something else
    if not x:
        print("x is false")
    else:
        print("x is true")

    # if some compound bool expr of x and y is true print something else print something else
    if x and y or not x:
        print("compound bool expr is true")
    else:
        print("compound bool expr is false")
    
    # if x+y > 20 print something, elif x + y > 10 print something else, else print something else
    i_x :int = 10
    i_y :int = 5
    if i_x + i_y > 20:
        print("sum is greater than 20")
    elif i_x + i_y > 10:
        print("sum is greater than 10")
    else:
        print("sum is less than 10")

    # if x is greater than y print something, elif x is less than y print something else, else print something else
    if i_x > i_y:
        print("x is greater than y")
    elif i_x < i_y:
        print("x is less than y")
    else:
        print("x is equal to y")
    
    # if x is not equal to y print something, else print something else
    if i_x != i_y:
        print("x is not equal to y")
    else:
        print("x is equal to y")
    
    # if x is equal to y + 5 print something, else print something else
    if i_x == i_y + 5:
        print("x is equal to y + 5")
    else:
        print("x is not equal to y + 5")
    
    # if length of a list is greater than 5 print something, else print something else
    list1 : list[int] = [1, 2, 3, 4, 5, 6]
    if len(list1) > 5:
        print("list1 has more than 5 elements")
    else:
        print("list1 has less than 5 elements")
    
    # length of a list + 3 is greater than 8 print something, else if it is greater than 5 print something else, else print something else
    if len(list1) + 3 > 8:
        print("list1 has more than 5 elements")
    elif len(list1) + 3 > 5:
        print("list1 has more than 2 elements")
    else:
        print("list1 has less than 2 elements")
    
    # Define two strings
    # string1 = "apple"
    # string2 = "banana"

    # # some if else comparisions on strings
    # if string1 == string2:
    #     print("The strings are equal.")
    # elif string1 < string2:
    #     print("String1 comes before String2.")
    # elif string1 > string2:
    #     print("String1 comes after String2.")
    # else:
    #     print("Invalid comparison.")

if __name__ == "__main__":
    main()
