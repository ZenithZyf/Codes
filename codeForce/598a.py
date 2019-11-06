from math import log, floor

t = int(input())

for i in range(t):
	n = int(input())

	a = floor(log(n, 2))

	sum1 = (1 + n) * n // 2
	sum2 = 2 ** (a + 1) - 1

	print(sum1 - 2 * sum2)