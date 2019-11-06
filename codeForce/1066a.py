from math import ceil

t = int(input())

for i in range(t):
	L, v, l, r = map(int, input().split())

	n = L // v

	a = int(ceil(l / v))
	b = r // v

	print(n - (b - a + 1))