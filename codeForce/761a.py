a, b = map(int, input().split())

if a == b == 0:
	print('NO')
elif abs(a - b) > 1:
	print('NO')
else:
	print('YES')