n = int(input())
l = []

if n % 2:
	print(-1)
else:
	for i in range(n // 2):
		print((i + 1) * 2, end = ' ')
		print((i + 1) * 2 - 1, end = ' ')
		# print('%d %d', (i + 1) * 2, (i + 1) * 2 - 1)