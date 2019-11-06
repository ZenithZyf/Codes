n, m, z = map(int, input().split())

cnt = 0
for i in range(z // m):
	if (i + 1) * m % n == 0:
		cnt += 1

print(cnt)