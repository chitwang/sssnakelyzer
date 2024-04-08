def main():
	i:int

	for i in range(10):
		# print(i)
		if i == 4:
			break

	i += 1
	while i < 10:
		print(i + 1)
		if i == 7:
			i += 2
			if 3:
				continue
		i += 1

	if False ^ True:
		print(123)
	
	a:list[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

	for i in range(2, 10):
		if i == 5:
			continue
		print(a[i]-1)

	num:int = 64 // 17
	print(num)
