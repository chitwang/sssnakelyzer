def main() -> None:
    # Simple for loop with continue condition
    i : int = 0
    for i in range(5) :
        if i == 2:
            continue
        if i == 1:
            break
        print(i)
    
    # Complex for loop with continue condition
    for i in range(10):
        if i % 2 == 0:
            continue
        print(i)

    # Simple while loop with continue condition
    j: int = 0
    while j < 5:
        if j == 2:
            j += 1
            continue
        print(j)
        j += 1

    # Complex while loop with continue condition
    k: int = 0
    while k < 10:
        if k % 2 == 0:
            k += 1
            continue
        print(k)
        k += 1
    i : int = 0
    # Simple for loop with continue and break conditions
    print("Simple for loop with continue and break:")
    for i in range(10):
        if i == 2:
            continue
        elif i == 7:
            break
        print(i)
    
    # # Complex for loop with continue and break conditions
    print("\nComplex for loop with continue and break:")
    for i in range(10):
        if i % 2 == 0:
            continue
        elif i == 9:
            break
        print(i)

    # # Simple while loop with continue and break conditions
    j : int = 0
    k : int = 0
    print("\nSimple while loop with continue and break:")
    while j < 10:
        if j == 2:
            j += 1
            continue
        else :
            j = 1
            break
        print(j)
        j += 1

    # Complex while loop with continue and break conditions
    print("\nComplex while loop with continue and break:")
    while k < 10:
        if k % 2 == 0:
            k += 1
            continue
        elif k == 9:
            break
        print(k)
        k += 1
    
    # # # Invalid loop: for loop without iterable
    # # for i in 10:  # Error: 'int' object is not iterable
    # #     print(i)

    # # # Invalid loop: while loop with missing increment (but should compile)
    # # while j < 10:
    # #     print(j)

    # # Continue outside loop
    # # continue

    # # Break outside loop
    # # break

if __name__ == "__main__":
    main()
