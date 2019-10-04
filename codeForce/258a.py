a = input()

b = a.find('0')
if b == -1:
	print(a[:-1])
else:
	print(a[:b] + a[b+1:])