n = int(input())
bid = list(map(int, input().split()))
flag = 0

tep = bid[0]
while tep % 3 == 0:
	tep /= 3
while tep % 2 == 0:
	tep /= 2
remain = tep

for i in range(1, n):
	temp = bid[i]
	while temp % 3 == 0:
		temp /= 3
	while temp % 2 == 0:
		temp /= 2
	if temp != remain:
		print('NO')
		flag = 1
		break

if flag == 0:
	print('YES')