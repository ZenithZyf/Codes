l, r = map(int, input().split())

if r - l < 2:
	print(-1)
else:
	if l % 2 == 0:
		print(l, l + 1, l + 2)
	elif r - l == 2:
		print(-1)
	else:
		print(l + 1, l + 2, l + 3)

