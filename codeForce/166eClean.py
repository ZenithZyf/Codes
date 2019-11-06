n = int(input())

ds = 0
c = 3

for i in range(3, n + 1):
	ds = c - ds
	c *= 3

if n <= 1:
	print(0)
else:
	print((c - ds) % 1000000007)