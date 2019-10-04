n = int(input())
numbers = [6, 8, 4, 2]

if n == 0:
	print(1)
else:
	print(numbers[n % 4])