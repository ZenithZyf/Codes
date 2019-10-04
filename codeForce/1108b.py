n = int(input())
divisors = list(map(int, input().split()))

x = max(divisors)
div_x = set()

for i in range(n):
	if divisors[i] not in div_x:
		if x % divisors[i] == 0:
			div_x.add(divisors[i])
			divisors[i] = 0

y = max(divisors)

print(x, y)
