n, v = map(int, input().split())

fuel = n - v - 1
if fuel < 0:
	print(n - 1)
elif fuel == 0:
	print(v)
else:
	price = v + (fuel + 3) * (fuel) // 2
	print(price)