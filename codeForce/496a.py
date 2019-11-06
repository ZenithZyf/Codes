n = int(input())
a = list(map(int, input().split()))
i = 0
z = a[2] - a[0]
y = a[1] - a[0]

while(i < n - 2):
	z = min(z, a[i + 2] - a[i])
	y = max(y, a[i + 1] - a[i])
	i += 1

y = max(y, a[i + 1] - a[i])
print(max(z, y))