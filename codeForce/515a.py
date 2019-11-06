a, b, s = map(int, input().split())
a = abs(a)
b = abs(b)

if s < a + b:
	print('No')
elif (s - a - b) % 2 == 0:
	print('Yes')
else:
	print('No')