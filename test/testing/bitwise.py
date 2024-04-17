def bitwise_operations(a: int, b: int):
    # Bitwise AND
    result_and: int = a & b

    # Bitwise OR
    result_or: int = a | b

    # Bitwise XOR
    result_xor: int = a ^ b

    # Bitwise NOT (complement)
    result_not_a: int = ~a
    result_not_b: int = ~b

    # Bitwise Left Shift
    result_left_shift_a: int = a << 1
    result_left_shift_b: int = b << 1

    # Bitwise Right Shift
    result_right_shift_a: int = a >> 1
    result_right_shift_b: int = b >> 1
    
    return [result_and, result_or, result_xor, result_not_a, result_not_b, result_left_shift_a, result_left_shift_b, result_right_shift_a, result_right_shift_b]

def relational_operations(a: int, b: int):
    # Relational operations
    result_equal: bool = a == b
    # Not equal
    result_not_equal: bool = a != b
    # Greater than
    result_greater_than: bool = a > b
    # Less than
    result_less_than: bool = a < b
    # Greater than or equal
    result_greater_than_or_equal: bool = a >= b
    # Less than or equal
    result_less_than_or_equal: bool = a <= b

    return [result_equal, result_not_equal, result_greater_than, result_less_than, result_greater_than_or_equal, result_less_than_or_equal]

def arithmetic_operations(a: int, b: int) :

    # Arithmetic operations
    result_addition: int = a + b
    # Subtraction
    result_subtraction: int = a - b
    # Multiplication
    result_multiplication: int = a * b
    # Division
    result_division: int = a / b
    # Modulus
    result_modulus: int = a % b
    # Exponentiation
    result_exponentiation: int = a ** b
    # Floor division
    result_floor_division: int = a // b

    return [result_addition, result_subtraction, result_multiplication, result_division, result_modulus, result_exponentiation, result_floor_division]

def logical_operations(a: bool, b: bool) :
    # Logical AND
    result_and: bool = a and b
    # Logical OR
    result_or: bool = a or b
    # Logical NOT
    result_not_a: bool = not a
    result_not_b: bool = not b

    return [result_and, result_or, result_not_a, result_not_b]

# Example usage
def main():
    num1: int = 10
    num2: int = 5

    results_bitwise:list[int] = bitwise_operations(num1, num2)
    i:int = 0
    for i in range(len(results_bitwise)):
        print(results_bitwise[i])

    results_relational: list[bool] = relational_operations(num1, num2)
    for i in range(len(results_relational)):
        print(results_relational[i])


    results_arithmetic: list[int] = arithmetic_operations(num1, num2)
    for i in range(len(results_arithmetic)):
        print(results_arithmetic[i])

    results_logical: list[bool] = logical_operations(True, False)
    for i in range(len(results_logical)):
        print(results_logical[i])




if __name__ == "__main__":
    main()      
