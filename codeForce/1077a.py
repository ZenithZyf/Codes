t = int(input())

for i in range(t):
	a, b, k = map(int, input().split())
	if k % 2 == 0:
		pos = (k // 2) * a - (k // 2) * b
	else:
		pos = (k // 2 + 1) * a - (k // 2) * b
	print(pos)