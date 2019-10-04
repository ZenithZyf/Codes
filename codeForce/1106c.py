n = int(input())
a = list(map(int, input().split()))
sum = 0
a.sort()

for i in range(n // 2):
	sum += (a[i] + a[n - i - 1]) ** 2
print(sum)
