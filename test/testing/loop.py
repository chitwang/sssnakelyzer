x:int = 1
y:int = 69
z:int = 420

def fact(n:int) -> int:
	if not n:
		print(not n)
		# print(~n)
		return 1
	
	if n < 3:
		return n
	
	return n * fact(n - 1)

def main():
	i:int

	# for i in range(10):
	# 	# print(i)
	# 	if i == 4:
	# 		break

	# i += 1
	# while i < 10:
	# 	print(i + 1)
	# 	if i == 7:
	# 		i += 2
	# 		if 3:
	# 			continue
	# 	i += 1

	# if False ^ True:
	# 	print(123)
	
	a:list[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

	# for i in range(2, len(a)):
	# 	if i == 5:
	# 		continue
	# 	print((a[i]-1) ** 3)
	# 	print(a[i]-1)

	print(fact(6))
	# num:int = 64 // 17
	# print(num)
    # print(i)

main()
