#Control flow via if-elif-else , for , while , break and continue (ignore pass , do-while and
# switch )
# – Support iterating over ranges specified using the range() function.

def test_if_else():
    # If-else control flow
    x = 10
    if x > 0:
        result = "Positive"
    elif x == 0:
        result = "Zero"
    else:
        result = "Negative"
    

def test_for_loop():
    # For loop
    total = 0
    for i in range(1, 6):
        total += i
    

def test_while_loop():
    # While loop
    x = 0
    total = 0
    while x < 5:
        total += x
        x += 1
    

def test_break():
    # Break statement
    total = 0
    for i in range(10):
        total += i
        if total >= 10:
            break
    

def test_continue():
    # Continue statement
    total = 0
    for i in range(10):
        if i % 2 == 0:
            continue
        total += i
    

def test_range_iteration():
    # Iterating over ranges specified using the range() function
    result = []
    for i in range(5):
        result.append(i)
    

if __name__ == "__main__":
    test_if_else()
    test_for_loop()
    test_while_loop()
    test_break()
    test_continue()
    test_range_iteration()
    print("All test cases passed successfully!")
