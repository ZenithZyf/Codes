t, s, x = map(int, input().split())
m = t
n = t + 1
flag = 0

if x < t:
	print('NO')
	flag = 1
elif x == t:
	print('YES')
	flag = 1
elif x == t + 1:
	print('NO')
	flag = 1

while x > n:
	m += s
	n += s
	if x == m or x == n:
		print('YES')
		flag = 1

if flag == 0:
	print('NO')