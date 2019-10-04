n, k = map(int, input().split())

r = 2 * n
g = 5 * n
b = 8 * n

if r % k == 0:
	rb = r // k
else:
	rb = r // k + 1

if g % k == 0:
	gb = g // k
else:
	gb = g // k + 1

if b % k == 0:
	bb = b // k
else:
	bb = b // k + 1

print(rb + gb + bb)