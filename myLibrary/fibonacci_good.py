def fibonacci_good(n):
	"""Return pair of Fibonacci numbers, F(n) and F(n-1)"""
	if n <= 1:
		return(n, 0)
	else:
		(a, b) = fibonacci_good(n - 1)
		return(a+b, a)