from time import time 				# import time function fro time module
def compute_average(n):
	"""Perform n appends to an empty list and return average time elapsed."""
	data = []
	start = time()
	for k in range(n):
		data.append(None)
	end = time()
	return (end - start) / n