def A() -> None:
    str1 : str = "apple"
    str2 : str = "banana"
    result : int = str1 == str2
    # Compare the strings using strcmp
# Check the result of the comparison
    if result == 0:
        print("The strings are equal.")
    elif result < 0:
        print("String1 comes before String2.")
    else:
        print("String1 comes after String2.")


if __name__ == "__main__":
    A()
