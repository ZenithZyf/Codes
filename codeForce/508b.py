n = input()
digit = [int(x) for x in n]
loc = 0
val = 9
flag = 0

for i in range(len(digit)):
	if digit[i] % 2 == 0:
		if digit[i] < digit[-1]:
			digit[i], digit[-1] = digit[-1], digit[i]
			flag = 1
			break
		else:
			loc = i

if flag == 1:
	print(''.join(map(str, digit)))
else:
	if digit[loc] % 2 == 0:
		digit[loc], digit[-1] = digit[-1], digit[loc]
		print(''.join(map(str, digit)))
	else:
		print(-1)