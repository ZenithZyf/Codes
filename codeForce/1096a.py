t = int(input())

for i in range(t):
	a, b = map(int, input().split())
	if a * 2 <= b:
		print(a, a * 2)