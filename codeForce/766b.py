_ = input()
a = list(map(int, input().split()))

a.sort()
flag = 0

for i in range(len(a)-2):
	if a[i] + a[i + 1] > a[i + 2]:
		print('YES')
		flag = 1
		break

if flag == 0:
	print('NO')
