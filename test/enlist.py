def process_strings(lst):
  result = []

  for s in lst:
    if s.startswith('[') and s.endswith(']'):
      # Remove '[' and ']' and call the function recursively
      inner_result = process_strings([s[1:-1]])
      result.extend(inner_result)
    else:
      result.append(s)

  return result

# Example usage:
input_list = ["[apple]", "orange", "[banana]", "grape", "[cherry]"]
output_list = process_strings(input_list)

print("Input List:", input_list)
print("Output List:", output_list)

# s = input()
# split_s = s.split()
