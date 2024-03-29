def main() -> None:
    x : bool = True
    y : bool = False

    # if x then print something else print something else
    if x:
        print("x is true")
    else:
        print("x is false")
    
    print("My name is krish")

def check_grade(score : int) -> int:
        j : int = 0
        while j < 10:
            if score >= 90:
                return 1
            elif score >= 80:
                return 2
            elif score >= 70:
                return 3
            elif score >= 60:
                return 4
            elif score >= 50:
                return 5
            elif score >= 40:
                return 6
            elif score >= 30:
                return 7
            else: 
                return 8
            j += 1

if __name__ == "__main__":
    main()
    print("main closed")
    score_check : int = check_grade(69)
    print(score_check)
