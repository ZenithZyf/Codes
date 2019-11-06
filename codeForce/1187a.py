T = int(input())

for i in range(T):
	n, s, t = map(int, input().split())
	all = s + t - n
	print(max(s, t) - all + 1)