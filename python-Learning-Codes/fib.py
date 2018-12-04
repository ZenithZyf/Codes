def fib(n):
	"""
	this function calculates
	the nth number of Fibonacci
	"""
	if n == 2:
		return 1
	elif n == 1:
		return 1
	return fib(n-1)+fib(n-2)