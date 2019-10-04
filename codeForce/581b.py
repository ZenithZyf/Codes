n = int(input())
a = list(map(int, input().split()))
maxH = 0
add = []
add.append(0)

for i in range(n - 1):
	maxH = max(a[n - 1 - i], maxH)
	add.append(max(0, maxH + 1 - a[n - 2 - i]))

for i in range(n):
	print(add[n - 1 - i], end = " ")