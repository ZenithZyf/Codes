n, m = map(int, input().split())
x = m // n

if m % n:
	cnt = -1
else:
	if x == 1 or x % 2 == 0 or x % 3 == 0:
		if x == 1:
			cnt = 0
		else:
			cnt = 0
			while(x % 2 == 0):
				x /= 2
				cnt += 1
			while(x % 3 == 0):
				x /= 3
				cnt += 1
	else:
		cnt = -1

if x == 1:		
	print(cnt)
else:
	print(-1)