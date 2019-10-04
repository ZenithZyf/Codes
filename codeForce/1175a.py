t = int(input())

for i in range(t):
	n, k = map(int, input().split())
	step = 0
	while(n > 0):
		if n % k == 0:
			n = n // k
			step += 1
		else:
			step += n % k
			n -= (n % k)
	print(step)

