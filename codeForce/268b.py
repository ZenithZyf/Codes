n = int(input())

push = n
for i in range(1, n):
	push += (n - i) * i

print(push)