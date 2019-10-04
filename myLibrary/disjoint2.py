def disjoint2(A, B, C):
	"""Return True if there is no element common to all three lists."""
	for a in A:
		for b in B:
			if a == b:
				for c in C:
					if a == c:
						return False
	return True