n = int(input())
a = list(map(int, input().split()))

b = list(set(a))
b.sort()

if len(b) > 3:
	print(-1)
elif len(b) == 3:
	if b[2] - b[1] == b[1] - b[0]:
		print(b[2] - b[1])
	else:
		print(-1)
elif len(b) == 2:
	if (b[1] - b[0]) % 2:
		print(b[1] - b[0])
	else:
		print((b[1] - b[0]) // 2)
else:
	print(0)