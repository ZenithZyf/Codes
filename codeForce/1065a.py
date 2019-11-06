t = int(input())

for i in range(t):
	s, a, b, c = map(int, input().split())
	if s < c:
		num = 0
	else:
		buy = s // c
		times = buy // a
		extra = b * times
		num = buy + extra

	print(num)