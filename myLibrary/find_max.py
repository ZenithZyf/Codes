def find_max(data):
	"""Return the maximum element from a nonempty Python list."""
	biggest = data[0]
	for val in data:
		if val > biggest:
			biggest = val
	return biggest