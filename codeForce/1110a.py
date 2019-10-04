b, k = map(int, input().split())
a = list(map(int, input().split()))

b = b % 2
c = [i % 2 for i in a]
d = []

for j in c[:-1]:
	d.append(b * j)

if (sum(d) + c[-1]) % 2 == 1:
	print('odd')
else:
	print('even')