def main() -> None:
    # Declare variables
    int_var1 : int = 10
    int_var2 : int = 5
    float_var1 : float = 2.5
    float_var2 : float = 3.14
    str_var1 : str = "World"
    str_var2 : str = "Hello"
    bool_var1 : bool = True 
    bool_var2 : bool = False
    list_var1 : list[int] = [1, 2, 3]
    list_var2 : list[int] = [4, 5, 6]
    x : int = 10 
    # Perform operations pairwise
    x = int_var1 + int_var2
    x = int_var1 - int_var2
    x = int_var1 * int_var2
    x = int_var1 / int_var2
    y:int = -2 ** float_var1
    y = not (1 + 2)
    # Float ops (with type casting)
    x = float_var1 + float_var2
    x = float_var1 - float_var2
    x = float_var1 * float_var2
    x = float_var1 / float_var2
    # bool with type casting
    x = bool_var1 and bool_var2
    x = bool_var1 or bool_var2
    x = not bool_var1
    # list stuff
    x = len(list_var1)
    x = len(list_var2)
    # invalid declarations
    # int_var1 :int = "Hello"
    # float_var1 : float = "World"
    # str_var1 : str = 10
    # bool_var1 : bool = 10
    # list_var1 : list[int] = 10

    # invalid operations
    # x = int_var1 + str_var1
    # x = int_var1 ** str_var1
    # x = int_var1 // str_var1
    # x = int_var1 % str_var1
    # x = int_var1 + list_var2

    # parantheses stuff
    x = (((((10 + 5) * (3.14 / 2.5)) ** 2) + (7 - 3)) / (2 ** 3))

    # unmatched parantheses
    # x = (((((10 + 5) * (3.14 / 2.5)) ** 2) + (7 - 3) / (2 ** 3))


if __name__ == '__main__':
    main()
