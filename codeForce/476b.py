from math import factorial

def calc_arrangement(n, m):
    return(factorial(n) / factorial(n - m))

def calc_combination(n, m):
    return(calc_arrangement(n, m) / factorial(m))

str1 = list(input())
str2 = list(input())

n = 0
diff = 0

for i in range(len(str1)):
	if str1[i] == '+':
		diff += 1
	else:
		diff -= 1
	if str2[i] == '+':
		diff -= 1
	elif str2[i] == '-':
		diff += 1
	else:
		n += 1

if n == 0:
	if diff == 0:
		print(1.0)
	else:
		print(0.0)
elif n < abs(diff):
	print(0.0)
else:
	res = calc_combination(n, (n - diff) / 2) * (0.5 ** n)
	print(res)
