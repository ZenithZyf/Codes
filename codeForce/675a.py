a, b, c = map(int, input().split())

if c == 0 and a == b:
	print('YES')
elif c == 0 and a != b:
	print('NO')
elif a == b:
	print('YES')
elif (b - a) % c == 0 and (b - a) // c > 0:
	print('YES')
else:
	print('NO')