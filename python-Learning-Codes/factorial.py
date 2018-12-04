def factorial(n):
	"""
	this function calculates
	the factorial of n
	"""
	if n == 0:
		return 1
	return n*factorial(n-1)