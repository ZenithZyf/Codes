from math import ceil
n = int(input())

if n < 6 or n % 2:
	print(0)
else:
	a = (n - 2) // 2
	print(ceil((a - 1) / 2))