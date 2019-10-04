l, r, a = map(int, input().split())

if abs(l - r) > a:
	print(2 * (min(l, r) + a))
else:
	a_remain = a - abs(l - r)
	a_add = a_remain - a_remain % 2
	print(2 * max(l, r) + a_add)
