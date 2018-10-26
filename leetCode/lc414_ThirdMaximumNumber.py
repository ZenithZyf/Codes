champion = [float('-inf'), float('-inf'), float('-inf')]
for n in nums:
	if n not in champion:
		if n > champion[0]:
			champion = [n,champion[0],champion[1]]
		elif n > champion[1]:
			champion = [champion[0],n,champion[1]]
		elif n > champion[2]:
			champion = [champion[0],champion[1],n]
if float('-inf') in champion:
	return max(nums)
else:
	return champion[2]