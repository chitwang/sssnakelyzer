def test_arithmetic_operators():
    # Arithmetic operators
    result_add = 5 + 3
    if result_add != 8:
        print("Addition failed")

    result_subtract = 10 - 4
    if result_subtract != 6:
        print("Subtraction failed")

    result_multiply = 6 * 2
    if result_multiply != 12:
        print("Multiplication failed")

    result_divide = 15 / 3
    if result_divide != 5.0:
        print("Division failed")

    result_floor_divide = 15 // 4
    if result_floor_divide != 3:
        print("Floor division failed")

    result_modulo = 15 % 4
    if result_modulo != 3:
        print("Modulo failed")

    result_power = 2 ** 3
    if result_power != 8:
        print("Exponentiation failed")

def test_relational_operators():
    # Relational operators
    result_equal = 5 == 5
    if not result_equal:
        print("Equality check failed")

    result_not_equal = 5 != 6
    if not result_not_equal:
        print("Inequality check failed")

    result_greater_than = 5 > 4
    if not result_greater_than:
        print("Greater than check failed")

    result_less_than = 5 < 6
    if not result_less_than:
        print("Less than check failed")

    result_greater_than_or_equal = 5 >= 5
    if not result_greater_than_or_equal:
        print("Greater than or equal check failed")

    result_less_than_or_equal = 5 <= 5
    if not result_less_than_or_equal:
        print("Less than or equal check failed")

def test_logical_operators():
    # Logical operators
    result_and = True and True
    if not result_and:
        print("AND operation failed")

    result_or = True or False
    if not result_or:
        print("OR operation failed")

    result_not = not False
    if not result_not:
        print("NOT operation failed")

def test_bitwise_operators():
    # Bitwise operators
    result_bitwise_and = 5 & 3
    if result_bitwise_and != 1:
        print("Bitwise AND failed")

    result_bitwise_or = 5 | 3
    if result_bitwise_or != 7:
        print("Bitwise OR failed")

    result_bitwise_xor = 5 ^ 3
    if result_bitwise_xor != 6:
        print("Bitwise XOR failed")

    result_bitwise_complement = ~5
    if result_bitwise_complement != -6:
        print("Bitwise complement failed")

    result_left_shift = 5 << 1
    if result_left_shift != 10:
        print("Left shift failed")

    result_right_shift = 5 >> 1
    if result_right_shift != 2:
        print("Right shift failed")

def test_assignment_operators():
    # Assignment operators
    a = 5
    a += 3
    if a != 8:
        print("Assignment addition failed")

    b = 10
    b -= 4
    if b != 6:
        print("Assignment subtraction failed")

    c = 6
    c *= 2
    if c != 12:
        print("Assignment multiplication failed")

    d = 15
    d /= 3
    if d != 5.0:
        print("Assignment division failed")

    e = 15
    e //= 4
    if e != 3:
        print("Assignment floor division failed")

    f = 15
    f %= 4
    if f != 3:
        print("Assignment modulo failed")

    g = 2
    g **= 3
    if g != 8:
        print("Assignment exponentiation failed")

    h = 5
    h &= 3
    if h != 1:
        print("Assignment bitwise AND failed")

    i = 5
    i |= 3
    if i != 7:
        print("Assignment bitwise OR failed")

    j = 5
    j ^= 3
    if j != 6:
        print("Assignment bitwise XOR failed")

    k = 5
    k <<= 1
    if k != 10:
        print("Assignment left shift failed")

    l = 5
    l >>= 1
    if l != 2:
        print("Assignment right shift failed")

def test_lists():
    # Lists
    my_list = [1, 2, 3, 4, 5]
    if len(my_list) != 5:
        print("Length check failed")

    if my_list[0] != 1:
        print("First element check failed")

    if my_list[-1] != 5:
        print("Last element check failed")

    if my_list[1:3] != [2, 3]:
        print("Slice check failed")

    if my_list[:3] != [1, 2, 3]:
        print("Slice check failed")

    if my_list[2:] != [3, 4, 5]:
        print("Slice check failed")

    my_list.append(6)
    if my_list != [1, 2, 3, 4, 5, 6]:
        print("Append operation failed")

if __name__ == "__main__":
    test_arithmetic_operators()
    test_relational_operators()
    test_logical_operators()
    test_bitwise_operators()
    test_assignment_operators()
    test_lists()
    print("All tests passed successfully!")
