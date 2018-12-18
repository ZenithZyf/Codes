def count_Occurence(data,target):
	counter = 0
	for item in data:
		if item == target:
			counter += 1
	return counter