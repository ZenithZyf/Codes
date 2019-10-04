n, a, b = map(int, input().split())

if b > 0:
	pos = (a + b) % n
	if pos == 0:
		pos = n
elif b == 0:
	pos = a
else:
	remain = abs(b) % n
	b = n - remain
	pos = (a + b) % n
	if pos == 0:
		pos = n

print(pos)
