n = int(input())

if n > 1:
	if n % 7 == 6:
		mi = (n // 7) * 2 + 1
	else:
		mi = (n // 7) * 2

	if (n - 2) % 7 == 6:
		ma = ((n - 2) // 7) * 2 + 3
	else:
		ma = ((n - 2) // 7) * 2 + 2
	print(mi, ma)
else:
	print(0, 1)