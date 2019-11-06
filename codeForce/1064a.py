a = list(map(int, input().split()))

b = 2 * max(a) - sum(a) + 1

if b < 1:
	print(0)
else:
	print(b)