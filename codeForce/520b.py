n, m = map(int, input().split())
count = 0

while m > n:
	if m % 2 == 0:
		count += 1
		m = m / 2
	else:
		count += 1
		m += 1

print(int(count+n-m))