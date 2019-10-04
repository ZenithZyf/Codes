k, r = map(int, input().split())

left = k % 10

for i in range(1, 10):
	if (i * left) % 10 == 0 or (i * left) % 10 == r:
		print(i)
		break


