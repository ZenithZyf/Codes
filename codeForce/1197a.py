T = int(input())

for i in range(T):
	n = int(input())
	a = list(map(int, input().split()))

	a.sort()
	if a[-2] == 1:
		print(0)
	else:
		print(min(a[-2] - 1, n - 2))