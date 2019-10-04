n, m = map(int, input().split())
a = list(map(int, input().split()))
res = 0

for i in range(n):
	print((res + a[i]) // m)
	res = (res + a[i]) % m
