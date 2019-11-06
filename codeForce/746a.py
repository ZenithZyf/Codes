a = int(input())
b = int(input())
c = int(input())
flag = 0

for i in reversed(range(1, a + 1)):
	if 2 * i <= b and 4 * i <= c:
		print(7 * i)
		flag = 1
		break

if flag == 0:
	print(0)