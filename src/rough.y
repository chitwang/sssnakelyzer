/* patterns: open_sequence_pattern 
    | pattern */

/* pattern: as_pattern
    | or_pattern

as_pattern: or_pattern KEY_AS pattern_capture_target 

or_pattern: closed_pattern
    | closed_pattern OP_BITWISE_OR or_pattern

closed_pattern: literal_pattern
    | capture_pattern
    | wildcard_pattern
    | value_pattern
    | group_pattern
    | sequence_pattern
    | mapping_pattern
    | class_pattern

literal_pattern: signed_number !('+' | '-') 
    | complex_number 
    | strings
    | KEY_NONE
    | KEY_TRUE
    | KEY_FALSE

literal_expr: signed_number !('+' | '-')
    | complex_number
    | strings
    | KEY_NONE 
    | KEY_TRUE
    | KEY_FALSE

complex_number: signed_real_number OP_ADD IMAGINARY_NUMBER 
    | signed_real_number OP_SUBTRACT IMAGINARY_NUMBER  

signed_number: INTEGER
    | OP_ADD INTEGER
    | OP_SUBTRACT INTEGER 

signed_real_number: FLOAT_NUMBER
    | OP_ADD FLOAT_NUMBER
    | OP_SUBTRACT FLOAT_NUMBER

capture_pattern: pattern_capture_target 

pattern_capture_target:
    | !"_" NAME !('.' | '(' | '=') 

wildcard_pattern: WILDCARD_UNDERSCORE

value_pattern:
    | attr !('.' | '(' | '=') 

attr: name_or_attr DELIM_DOT NAME 

name_or_attr: attr
    | NAME

group_pattern:
    | DELIM_LEFT_PAREN pattern DELIM_RIGHT_PAREN  */