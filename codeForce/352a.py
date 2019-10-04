n = int(input())
a = list(map(int, input().split()))

five = a.count(5)
zero = a.count(0)

if zero == 0:
	print(-1)
elif five < 9:
	print(0)
else:
	print('5' * ((five // 9) * 9) + '0' * zero)