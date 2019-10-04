t = int(input())

for i in range(t):
	n = int(input())
	a = list(map(int, input().split()))

	b = [x % 3 for x in a]
	b1 = b.count(1)
	b2 = b.count(2)
	b0 = b.count(0)

	b12 = min(b1, b2)
	remain = max(b1, b2) - b12
	belse = remain // 3

	print(b0 + b12 + belse)