def prefix_average2(S):
	"""Return list such that, for all j, A[j] equals average of S[0], ... , S[j]"""
	n = len(S)
	A = [0] * n
	for j in range(n):
		A[j] = sum(S[0:j+1]) / (j+1)
	return A