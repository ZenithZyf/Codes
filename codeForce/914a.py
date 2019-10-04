from math import sqrt

n = int(input())
a = list(map(int, input().split()))

a.sort()

for i in range(n):
	if a[n - 1 - i] >= 0:
		b = sqrt(a[n - 1 - i])
		if int(b) ** 2 != a[n - 1 - i]:
			print(a[n - 1 - i])
			break
	else:
		print(a[n - 1 - i])
		break