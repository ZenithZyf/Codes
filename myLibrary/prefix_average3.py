def prefix_average3(S):
	"""Return list such that, for all j, A[j] equals average of S[0], ... , S[j]"""
	n = len(S)
	A = [0] * n
	total = 0
	for j in range(n):
		total += S[j]
		A[j] = total / (j+1)
	return A