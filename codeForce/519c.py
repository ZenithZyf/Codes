n, m = map(int, input().split())

cnt = 0
while(n > 1 or m > 1):
	if n == 0 or m == 0:
		break
		
	if n > m:
		n -= 2
		m -= 1
		cnt += 1
	else:
		m -= 2
		n -= 1
		cnt += 1

print(cnt)
