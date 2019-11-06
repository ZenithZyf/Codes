n, m = map(int, input().split())

if n < m:
	output = -1        
else:
	i = (n + 1) // 2
	while i:
		if i % m == 0:
			output = i
			break
		i += 1

print(output)