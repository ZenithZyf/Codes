n = int(input())

if n == 1:
	print(1)
	print(1)
elif n == 2:
	print(1)
	print(2)
elif n == 3:
	print(2)
	print(1, 3)
elif n == 4:
	print(4)
	print(2, 4, 1, 3)
else:
	print(n)
	odd = 1
	even = 2
	for i in range(n):
		if odd <= n:
			print(odd, end = " ")
			odd += 2
		elif even <= n:
			print(even, end = " ")
			even += 2