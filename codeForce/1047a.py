n = int(input())

if n == 3:
	a = 1
	b = 1
	c = 1
elif (n - 2) % 3 == 0:
	a = 1
	b = 2
	c = n - 3
else:
	a = 1
	b = 1
	c = n - 2

print(a, b, c)