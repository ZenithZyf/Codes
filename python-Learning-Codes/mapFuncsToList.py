def multiply(x):
	return (x+x)

def cube(x):
	return (x**3)

funcs = [multiply, cube]
for i in range(5):
	value = list(map(lambda x: x(i), funcs))
	print(value)