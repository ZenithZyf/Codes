n = int(input())

ds = [0] * (n + 1)
c = 3

for i in range(3, n + 1):
	ds[i] = c - ds[i - 1]
	c *= 3

if n <= 1:
	print(0)
else:
	print((c - ds[n]) % 1000000007)