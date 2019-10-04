q = int(input())

for i in range(q):
	n, a, b = map(int, input().split())
	res = 0
	if b > a * 2 or b == a * 2:
		res = n * a
	else:
		res = (n % 2) * a + (n // 2) * b
	print(res)