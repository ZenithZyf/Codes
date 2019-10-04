from math import ceil

n, k = map(int, input().split())
a = []
good = 0

for i in range(n):
	b = int(input())
	if b in a:
		a.remove(b)
		good += 2
	else:
		a.append(b)

print(good + ceil(len(a) / 2))