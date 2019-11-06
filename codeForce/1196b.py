q = int(input())
flag = []
ans = []

for i in range(q):
	n, k = map(int, input().split())
	a = list(map(int, input().split()))

	b = [x % 2 for x in a]
	cnt = sum(b)

	if cnt < k:
		flag.append(0)
	elif cnt % 2 != k % 2:
		flag.append(0)
	else:
		flag.append(1)
		c = [j + 1 for j, val in enumerate(b) if val == 1]
		temp = c[:k-1]
		temp.append(n)
		ans.append(temp)

printFlag = 0
for i in range(q):
	if flag[i] == 0:
		print('NO')
	else:
		print('YES')
		print(*ans[printFlag])
		printFlag += 1