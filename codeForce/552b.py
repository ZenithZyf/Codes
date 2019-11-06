n = input()
m = int(n)
digit = 0

for i in range(len(n)):
	if m > 9 * (10 ** i):
		digit += (i + 1) * 9 * (10 ** i)
		m -= 9 * (10 ** i)
	else:
		digit += (i + 1) * m

print(digit)

