b = '00'
c = input()
flag = 0
a = b + c

# if len(a) == 1:
# 	if int(a) % 8 == 0:
# 		res = 8
# 		flag = 1
# elif len(a) == 2:
# 	if int(a) % 8 == 0:
# 		res = int(a)
# 		flag = 1
# 	elif int(a[1]) % 8 == 0:
# 		res = int(a[1])
# 		flag = 1
# 	elif int(a[0]) % 8 == 0:
# 		res = int(a[0])
# 		flag = 1
# else:
for i in range(len(a) - 2):
	if flag:
		break
	for j in range(i + 1, len(a) - 1):
		if flag:
			break
		for k in range(j + 1, len(a)):
			res = 100 * int(a[i]) + 10 * int(a[j]) + int(a[k])
			if res % 8 == 0:
				flag = 1
				break

if flag:
	print('YES')
	print(res)
else:
	print('NO')

