# def selectionSort(a):
#     k = len(a)
#     while k>1:
#         sortIndex = k-1
#         for i in range(k):
#             if a[i] > a[sortIndex]:
#                 a[i], a[sortIndex] = a[sortIndex], a[i]
#         k = k-1
#     return a

def selectionSort(a):
	"""
	sort the input list a from small to large
	"""
	for i in range(len(a)-1):
		for j in range(i+1,len(a)):
			if a[j]<a[i]:
				a[i], a[j] = a[j], a[i]
	return a


