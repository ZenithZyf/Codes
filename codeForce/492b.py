n, l = map(int, input().split())
p = [int(x) for x in input().split()]

p.sort()
r = max(p[0], l - p[n-1]) * 2

for i in range(n - 1):
	r = max(r, p[i+1] - p[i])

print(r / 2.0)