n, k = map(int, input().split())
time = 0

for i in range(n):
	time += 5 * (i + 1)
	if time + k > 240:
		i = i - 1
		break

print(i + 1)