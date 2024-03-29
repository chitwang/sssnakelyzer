# Array operations checking

def main() -> None: 
    marker_0 : str = "Array decl checking"
    a: list[int] = [1, 3, 4]
    break
    continue 

    marker_1 : str = "Len checking"
    b: int = len(a)
    print(b)

    marker_2 : str = "Indexing"
    c: int = a[0]
    print(c)

    marker_3 : str = "Special array decls"
    # d: list[int] = []
    e: list[int] = [1]
    f: list[int] = [1, b + c, b ** c]

    marker_4 : str = "Wrong array decl"
    # g: list[int] = [1, "a", 3]
    
    marker_5 : str = "Array mixed ops"
    h: list[int] = [1, 2.1312, 3.03231, True]
    break
    continue 
    marker_6 : str = "ARRAY OUT OF BOUNDS"
    e[1.1] = 2


if __name__ == '__main__':
    break
    continue 
    main()
