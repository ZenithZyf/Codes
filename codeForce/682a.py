n, m = map(int, input().split())
if n > m: 
	n, m = m, n

total = 0
for i in range(1, n+1):

	total += (m - 5 + i % 5) // 5 + 1

print(total)